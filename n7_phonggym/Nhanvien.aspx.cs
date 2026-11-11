using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace n7_phonggym
{
    /// <summary>
    /// Cấu trúc CSDL n7_phongGym:
    ///   NHAN_VIEN (ID_MNV, HoTen, NgaySinh, GioiTinh, TrinhDo, ChuyenMon)
    ///     -> HUAN_LUYEN_VIEN (GiaBieuDay, HeSoHoaHong)
    ///          -> PT_CHUYEN_GIA (PhuCapVIP, HeSoKinhNghiem)
    ///   LK_LICH_TAP tham chiếu NHAN_VIEN (xóa nhân viên phải xóa lịch tập trước)
    /// </summary>
    public partial class NhanVien : Page
    {
        private const string ROLE_NV = "NV";
        private const string ROLE_HLV = "HLV";
        private const string ROLE_PT = "PT";

        // Chuỗi kết nối lấy từ Web.config (tên GymDBConnectionString)
        string connectionString = ConfigurationManager.ConnectionStrings["GymDBConnectionString"] != null
                                  ? ConfigurationManager.ConnectionStrings["GymDBConnectionString"].ConnectionString
                                  : @"Data Source=.\SQLEXPRESS;Initial Catalog=n7_phongGym;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDataNhanVien();
                LoadThongKe();
            }
        }

        // =====================================================================
        //  TIỆN ÍCH
        // =====================================================================
        private void ShowMessage(string text, bool ok)
        {
            lblMessage.Visible = true;
            lblMessage.CssClass = "alert " + (ok ? "alert-success" : "alert-danger") + " d-block";
            lblMessage.Text = HttpUtility.HtmlEncode(text);
        }

        // Lỗi trong modal: giữ modal mở để người dùng sửa
        private void ShowModalError(string text)
        {
            lblModalError.Visible = true;
            lblModalError.Text = HttpUtility.HtmlEncode(text);
            OpenModal();
        }

        // Mở modal sau khi trang tải xong (script này chạy trước khối <script> cuối trang,
        // nên phải đợi sự kiện load rồi mới gọi showNhanVienModal)
        private void OpenModal()
        {
            ClientScript.RegisterStartupScript(GetType(), "openModal",
                "window.addEventListener('load', function () { try { showNhanVienModal(); } catch (e) { console.error(e); } });", true);
        }

        private static SqlParameter P(string name, object value)
        {
            return new SqlParameter(name, value ?? DBNull.Value);
        }

        private static void Exec(SqlConnection con, SqlTransaction tx, string sql, params SqlParameter[] ps)
        {
            using (var cmd = new SqlCommand(sql, con, tx))
            {
                cmd.Parameters.AddRange(ps);
                cmd.ExecuteNonQuery();
            }
        }

        private static bool TryDecimal(string s, out decimal v)
        {
            return decimal.TryParse((s ?? "").Trim(), NumberStyles.Number, CultureInfo.InvariantCulture, out v);
        }

        private static string DecToText(object o)
        {
            return (o == null || o == DBNull.Value) ? "" : Convert.ToDecimal(o).ToString("0.##", CultureInfo.InvariantCulture);
        }

        private static string ErrorText(SqlException ex)
        {
            switch (ex.Number)
            {
                case 2627:
                case 2601: return "Dữ liệu bị trùng khoá chính.";
                case 547: return "Dữ liệu vi phạm ràng buộc (khoá ngoại hoặc điều kiện kiểm tra).";
                case 4060:
                case 18456:
                case -1:
                case 53: return "Không kết nối được CSDL. Kiểm tra lại GymDBConnectionString trong Web.config. Chi tiết: " + ex.Message;
                default: return "Lỗi cơ sở dữ liệu: " + ex.Message;
            }
        }

        // Dùng trong aspx để tô màu nhãn vai trò
        protected string BadgeClass(object vaiTro)
        {
            switch (Convert.ToString(vaiTro))
            {
                case "PT chuyên gia": return "bg-warning text-dark";
                case "Huấn luyện viên": return "bg-primary";
                default: return "bg-secondary";
            }
        }

        // =====================================================================
        //  XEM DANH SÁCH / TÌM KIẾM / LỌC / PHÂN TRANG
        // =====================================================================
        private string BuildListSql(bool boDau)
        {
            // boDau = true: tìm không phân biệt hoa/thường và dấu (gõ "dang quoc huy" vẫn ra "Đặng Quốc Huy")
            string collate = boDau ? " COLLATE Vietnamese_CI_AI" : "";

            var sql = new StringBuilder(@"
SELECT nv.ID_MNV, nv.HoTen, nv.NgaySinh, nv.GioiTinh, nv.TrinhDo, nv.ChuyenMon,
       h.GiaBieuDay, h.HeSoHoaHong, p.PhuCapVIP, p.HeSoKinhNghiem,
       CASE WHEN p.ID_MNV IS NOT NULL THEN N'PT chuyên gia'
            WHEN h.ID_MNV IS NOT NULL THEN N'Huấn luyện viên'
            ELSE N'Nhân viên' END AS VaiTro
FROM NHAN_VIEN nv
LEFT JOIN HUAN_LUYEN_VIEN h ON h.ID_MNV = nv.ID_MNV
LEFT JOIN PT_CHUYEN_GIA  p ON p.ID_MNV = nv.ID_MNV
WHERE (nv.HoTen" + collate + @" LIKE @K
    OR nv.ChuyenMon" + collate + @" LIKE @K
    OR nv.TrinhDo" + collate + @" LIKE @K)");

            switch (ddlLocVaiTro.SelectedValue)
            {
                case ROLE_NV: sql.Append(" AND h.ID_MNV IS NULL"); break;
                case ROLE_HLV: sql.Append(" AND h.ID_MNV IS NOT NULL AND p.ID_MNV IS NULL"); break;
                case ROLE_PT: sql.Append(" AND p.ID_MNV IS NOT NULL"); break;
            }
            sql.Append(" ORDER BY nv.ID_MNV");
            return sql.ToString();
        }

        private DataTable QueryList(bool boDau)
        {
            var dt = new DataTable();
            using (var con = new SqlConnection(connectionString))
            using (var da = new SqlDataAdapter(BuildListSql(boDau), con))
            {
                da.SelectCommand.Parameters.Add("@K", SqlDbType.NVarChar, 200).Value = "%" + txtSearch.Text.Trim() + "%";
                da.Fill(dt);
            }
            return dt;
        }

        private void LoadDataNhanVien()
        {
            DataTable dt;
            try
            {
                try
                {
                    dt = QueryList(true);   // thử tìm không dấu trước
                }
                catch (SqlException)
                {
                    dt = QueryList(false);  // collation không hỗ trợ -> tìm thường
                }
                gvNhanVien.DataSource = dt;
                gvNhanVien.DataBind();
            }
            catch (SqlException ex)
            {
                ShowMessage(ErrorText(ex), false);
            }
        }

        private void LoadThongKe()
        {
            const string sql = @"
SELECT (SELECT COUNT(*) FROM NHAN_VIEN),
       (SELECT COUNT(*) FROM HUAN_LUYEN_VIEN h WHERE NOT EXISTS (SELECT 1 FROM PT_CHUYEN_GIA p WHERE p.ID_MNV = h.ID_MNV)),
       (SELECT COUNT(*) FROM PT_CHUYEN_GIA)";
            try
            {
                using (var con = new SqlConnection(connectionString))
                using (var cmd = new SqlCommand(sql, con))
                {
                    con.Open();
                    using (var r = cmd.ExecuteReader())
                    {
                        if (r.Read())
                        {
                            int tong = r.GetInt32(0), hlv = r.GetInt32(1), pt = r.GetInt32(2);
                            lblTong.Text = tong.ToString();
                            lblHLV.Text = hlv.ToString();
                            lblPT.Text = pt.ToString();
                            lblKhac.Text = (tong - hlv - pt).ToString();
                        }
                    }
                }
            }
            catch (SqlException) { /* lỗi kết nối đã được báo ở LoadDataNhanVien */ }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            gvNhanVien.PageIndex = 0;
            LoadDataNhanVien();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlLocVaiTro.SelectedIndex = 0;
            gvNhanVien.PageIndex = 0;
            LoadDataNhanVien();
        }

        protected void ddlLocVaiTro_SelectedIndexChanged(object sender, EventArgs e)
        {
            gvNhanVien.PageIndex = 0;
            LoadDataNhanVien();
        }

        protected void gvNhanVien_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvNhanVien.PageIndex = e.NewPageIndex;
            LoadDataNhanVien();
        }

        protected void gvNhanVien_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id;
            if (!int.TryParse(Convert.ToString(e.CommandArgument), out id)) return;

            if (e.CommandName == "Sua") LoadForm(id);
            else if (e.CommandName == "Xoa") XoaNhanVien(id);
        }

        // =====================================================================
        //  MỞ FORM THÊM / SỬA
        // =====================================================================
        private void ClearForm()
        {
            hfID.Value = "";
            txtHoTen.Text = txtNgaySinh.Text = txtTrinhDo.Text = txtChuyenMon.Text = "";
            txtGiaBieuDay.Text = txtHeSoHoaHong.Text = txtPhuCapVIP.Text = txtHeSoKinhNghiem.Text = "";
            ddlGioiTinh.SelectedIndex = 0;
            ddlVaiTro.SelectedValue = ROLE_NV;
            lblModalError.Visible = false;
            lblModalTitle.Text = "Thêm Nhân Viên / Huấn Luyện Viên Mới";
            btnSaveNhanVien.Text = "Lưu Nhân Viên";
        }

        // Nút "Thêm Nhân Viên Mới"
        protected void btnMoThem_Click(object sender, EventArgs e)
        {
            ClearForm();
            OpenModal();
        }

        // Nút "Sửa" trong bảng
        private void LoadForm(int id)
        {
            const string sql = @"
SELECT nv.HoTen, nv.NgaySinh, nv.GioiTinh, nv.TrinhDo, nv.ChuyenMon,
       h.ID_MNV AS IsHLV, h.GiaBieuDay, h.HeSoHoaHong,
       p.ID_MNV AS IsPT, p.PhuCapVIP, p.HeSoKinhNghiem
FROM NHAN_VIEN nv
LEFT JOIN HUAN_LUYEN_VIEN h ON h.ID_MNV = nv.ID_MNV
LEFT JOIN PT_CHUYEN_GIA  p ON p.ID_MNV = nv.ID_MNV
WHERE nv.ID_MNV = @ID";
            try
            {
                var dt = new DataTable();
                using (var con = new SqlConnection(connectionString))
                using (var da = new SqlDataAdapter(sql, con))
                {
                    da.SelectCommand.Parameters.AddWithValue("@ID", id);
                    da.Fill(dt);
                }

                if (dt.Rows.Count == 0) { ShowMessage("Không tìm thấy nhân viên.", false); return; }
                DataRow r = dt.Rows[0];

                ClearForm();
                hfID.Value = id.ToString();
                txtHoTen.Text = Convert.ToString(r["HoTen"]);
                txtNgaySinh.Text = r["NgaySinh"] == DBNull.Value
                    ? "" : Convert.ToDateTime(r["NgaySinh"]).ToString("yyyy-MM-dd");

                string gt = Convert.ToString(r["GioiTinh"]);
                ddlGioiTinh.SelectedValue = ddlGioiTinh.Items.FindByValue(gt) != null ? gt : "Khác";
                txtTrinhDo.Text = Convert.ToString(r["TrinhDo"]);
                txtChuyenMon.Text = Convert.ToString(r["ChuyenMon"]);

                bool isPT = r["IsPT"] != DBNull.Value;
                bool isHLV = r["IsHLV"] != DBNull.Value;
                ddlVaiTro.SelectedValue = isPT ? ROLE_PT : (isHLV ? ROLE_HLV : ROLE_NV);
                txtGiaBieuDay.Text = DecToText(r["GiaBieuDay"]);
                txtHeSoHoaHong.Text = DecToText(r["HeSoHoaHong"]);
                txtPhuCapVIP.Text = DecToText(r["PhuCapVIP"]);
                txtHeSoKinhNghiem.Text = DecToText(r["HeSoKinhNghiem"]);

                lblModalTitle.Text = "Sửa Nhân Viên mã " + id;
                btnSaveNhanVien.Text = "Lưu Thay Đổi";
                OpenModal();
            }
            catch (SqlException ex)
            {
                ShowMessage(ErrorText(ex), false);
            }
            catch (Exception ex)
            {
                ShowMessage("Không mở được form sửa: " + ex.Message, false);
            }
        }

        // =====================================================================
        //  LƯU (THÊM MỚI HOẶC CẬP NHẬT)
        // =====================================================================
        protected void btnSaveNhanVien_Click(object sender, EventArgs e)
        {
            string hoTen = txtHoTen.Text.Trim();
            string trinhDo = txtTrinhDo.Text.Trim();
            string chuyenMon = txtChuyenMon.Text.Trim();
            string role = ddlVaiTro.SelectedValue;

            // ---- Kiểm tra dữ liệu ----
            if (hoTen.Length == 0) { ShowModalError("Vui lòng nhập họ tên."); return; }
            if (trinhDo.Length == 0) { ShowModalError("Vui lòng nhập trình độ."); return; }
            if (chuyenMon.Length == 0) { ShowModalError("Vui lòng nhập chuyên môn."); return; }

            DateTime ngaySinh;
            if (!DateTime.TryParseExact(txtNgaySinh.Text, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out ngaySinh))
            { ShowModalError("Ngày sinh không hợp lệ."); return; }
            if (ngaySinh > DateTime.Today) { ShowModalError("Ngày sinh không được ở tương lai."); return; }

            decimal giaBD = 0, heSoHH = 0, phuCap = 0, heSoKN = 0;
            if (role == ROLE_HLV || role == ROLE_PT)
            {
                if (!TryDecimal(txtGiaBieuDay.Text, out giaBD) || giaBD < 0) { ShowModalError("Giá biểu dạy phải là số >= 0."); return; }
                if (!TryDecimal(txtHeSoHoaHong.Text, out heSoHH) || heSoHH < 0 || heSoHH > 999.99m) { ShowModalError("Hệ số hoa hồng phải trong khoảng 0 – 999,99."); return; }
            }
            if (role == ROLE_PT)
            {
                if (!TryDecimal(txtPhuCapVIP.Text, out phuCap) || phuCap < 0) { ShowModalError("Phụ cấp VIP phải là số >= 0."); return; }
                if (!TryDecimal(txtHeSoKinhNghiem.Text, out heSoKN) || heSoKN < 0 || heSoKN > 999.99m) { ShowModalError("Hệ số kinh nghiệm phải trong khoảng 0 – 999,99."); return; }
            }

            bool isNew = string.IsNullOrEmpty(hfID.Value);

            // ---- Ghi CSDL trong một transaction ----
            try
            {
                using (var con = new SqlConnection(connectionString))
                {
                    con.Open();
                    using (var tx = con.BeginTransaction())
                    {
                        try
                        {
                            int id;
                            if (isNew)
                            {
                                // ID_MNV không phải IDENTITY nên tự cấp mã kế tiếp
                                using (var c = new SqlCommand("SELECT ISNULL(MAX(ID_MNV), 0) + 1 FROM NHAN_VIEN WITH (UPDLOCK, HOLDLOCK)", con, tx))
                                    id = Convert.ToInt32(c.ExecuteScalar());

                                Exec(con, tx,
                                    @"INSERT INTO NHAN_VIEN (ID_MNV, HoTen, NgaySinh, GioiTinh, TrinhDo, ChuyenMon)
                                      VALUES (@ID, @HoTen, @NgaySinh, @GioiTinh, @TrinhDo, @ChuyenMon)",
                                    P("@ID", id), P("@HoTen", hoTen), P("@NgaySinh", ngaySinh),
                                    P("@GioiTinh", ddlGioiTinh.SelectedValue), P("@TrinhDo", trinhDo), P("@ChuyenMon", chuyenMon));
                            }
                            else
                            {
                                id = int.Parse(hfID.Value);
                                Exec(con, tx,
                                    @"UPDATE NHAN_VIEN SET HoTen=@HoTen, NgaySinh=@NgaySinh, GioiTinh=@GioiTinh,
                                             TrinhDo=@TrinhDo, ChuyenMon=@ChuyenMon WHERE ID_MNV=@ID",
                                    P("@ID", id), P("@HoTen", hoTen), P("@NgaySinh", ngaySinh),
                                    P("@GioiTinh", ddlGioiTinh.SelectedValue), P("@TrinhDo", trinhDo), P("@ChuyenMon", chuyenMon));
                            }

                            // Vai trò: NV -> HLV -> PT chuyên gia
                            if (role == ROLE_NV)
                            {
                                Exec(con, tx, "DELETE FROM PT_CHUYEN_GIA WHERE ID_MNV=@ID", P("@ID", id));
                                Exec(con, tx, "DELETE FROM HUAN_LUYEN_VIEN WHERE ID_MNV=@ID", P("@ID", id));
                            }
                            else
                            {
                                Exec(con, tx,
                                    @"IF EXISTS (SELECT 1 FROM HUAN_LUYEN_VIEN WHERE ID_MNV=@ID)
                                          UPDATE HUAN_LUYEN_VIEN SET GiaBieuDay=@G, HeSoHoaHong=@H WHERE ID_MNV=@ID
                                      ELSE
                                          INSERT INTO HUAN_LUYEN_VIEN (ID_MNV, GiaBieuDay, HeSoHoaHong) VALUES (@ID, @G, @H)",
                                    P("@ID", id), P("@G", giaBD), P("@H", heSoHH));

                                if (role == ROLE_PT)
                                {
                                    Exec(con, tx,
                                        @"IF EXISTS (SELECT 1 FROM PT_CHUYEN_GIA WHERE ID_MNV=@ID)
                                              UPDATE PT_CHUYEN_GIA SET PhuCapVIP=@P, HeSoKinhNghiem=@K WHERE ID_MNV=@ID
                                          ELSE
                                              INSERT INTO PT_CHUYEN_GIA (ID_MNV, PhuCapVIP, HeSoKinhNghiem) VALUES (@ID, @P, @K)",
                                        P("@ID", id), P("@P", phuCap), P("@K", heSoKN));
                                }
                                else
                                {
                                    Exec(con, tx, "DELETE FROM PT_CHUYEN_GIA WHERE ID_MNV=@ID", P("@ID", id));
                                }
                            }

                            tx.Commit();
                            ShowMessage(isNew ? "Đã thêm nhân viên mã " + id + "." : "Đã cập nhật nhân viên mã " + id + ".", true);
                        }
                        catch
                        {
                            tx.Rollback();
                            throw;
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                ShowModalError(ErrorText(ex));
                return;
            }
            catch (Exception ex)
            {
                ShowModalError("Lỗi: " + ex.Message);
                return;
            }

            ClearForm();
            LoadDataNhanVien();
            LoadThongKe();
        }

        // =====================================================================
        //  XÓA (xóa cả lịch tập và bảng con để không vướng khoá ngoại)
        // =====================================================================
        private void XoaNhanVien(int id)
        {
            try
            {
                using (var con = new SqlConnection(connectionString))
                {
                    con.Open();
                    using (var tx = con.BeginTransaction())
                    {
                        try
                        {
                            Exec(con, tx, "DELETE FROM LK_LICH_TAP WHERE ID_MNV=@ID", P("@ID", id));
                            Exec(con, tx, "DELETE FROM PT_CHUYEN_GIA WHERE ID_MNV=@ID", P("@ID", id));
                            Exec(con, tx, "DELETE FROM HUAN_LUYEN_VIEN WHERE ID_MNV=@ID", P("@ID", id));
                            Exec(con, tx, "DELETE FROM NHAN_VIEN WHERE ID_MNV=@ID", P("@ID", id));
                            tx.Commit();
                        }
                        catch
                        {
                            tx.Rollback();
                            throw;
                        }
                    }
                }
                ShowMessage("Đã xóa nhân viên mã " + id + ".", true);
            }
            catch (SqlException ex)
            {
                ShowMessage(ErrorText(ex), false);
                return;
            }

            LoadDataNhanVien();
            // Xóa hết dòng của trang cuối thì lùi về trang trước
            if (gvNhanVien.Rows.Count == 0 && gvNhanVien.PageIndex > 0)
            {
                gvNhanVien.PageIndex--;
                LoadDataNhanVien();
            }
            LoadThongKe();
        }
    }
}