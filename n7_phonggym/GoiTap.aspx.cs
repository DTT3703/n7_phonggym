using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace n7_phonggym
{
    public partial class GoiTap : Page
    {
        // Thư mục lưu ảnh (tương đối so với thư mục gốc website)
        private const string ThuMucAnh = "Uploads/GoiTap/";
        private const int AnhToiDaByte = 2 * 1024 * 1024; // 2 MB
        private static readonly string[] DuoiChoPhep = { ".jpg", ".jpeg", ".png", ".gif", ".webp" };

        // Ưu tiên chuỗi kết nối "n7_phongGym" trong Web.config, nếu không có thì dùng SQL Express mặc định
        private static string ConnStr
        {
            get
            {
                ConnectionStringSettings cs = ConfigurationManager.ConnectionStrings["n7_phongGym"];
                if (cs != null && !string.IsNullOrWhiteSpace(cs.ConnectionString))
                    return cs.ConnectionString;
                return @"Data Source=.\SQLEXPRESS;Initial Catalog=n7_phongGym;Integrated Security=True";
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
            }
        }

        // ===== HÀM HỖ TRỢ HIỂN THỊ ẢNH TRONG GRIDVIEW =====
        protected bool CoAnh(object hinhAnh)
        {
            return !string.IsNullOrWhiteSpace(Convert.ToString(hinhAnh));
        }

        protected string LayUrlAnh(object hinhAnh)
        {
            string p = Convert.ToString(hinhAnh);
            return string.IsNullOrWhiteSpace(p) ? "" : ResolveUrl("~/" + p);
        }

        // ===== HIỂN THỊ + TÌM KIẾM =====
        private void LoadData()
        {
            string kw = txtSearch.Text.Trim();
            string sql = "SELECT ID_MGT, TenGoiTap, SoThang, SoLuotPT, SoLuotTuDo, MucGia, HinhAnh FROM GOI_TAP";
            if (kw.Length > 0)
                sql += " WHERE TenGoiTap LIKE @kw OR CAST(ID_MGT AS NVARCHAR(20)) LIKE @kw";
            sql += " ORDER BY ID_MGT DESC";

            try
            {
                using (SqlConnection conn = new SqlConnection(ConnStr))
                using (SqlDataAdapter da = new SqlDataAdapter(sql, conn))
                {
                    if (kw.Length > 0)
                    {
                        string safe = kw.Replace("[", "[[]").Replace("%", "[%]").Replace("_", "[_]");
                        da.SelectCommand.Parameters.Add("@kw", SqlDbType.NVarChar, 200).Value = "%" + safe + "%";
                    }
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvGoiTap.DataSource = dt;
                    gvGoiTap.DataBind();
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Không kết nối được CSDL: " + ex.Message);
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadData();
        }

        // ===== NÚT SỬA / XÓA =====
        protected void gvGoiTap_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "SuaGT" && e.CommandName != "XoaGT") return;

            int id;
            if (!int.TryParse(Convert.ToString(e.CommandArgument), out id)) return;

            if (e.CommandName == "SuaGT")
                SuaGoiTap(id);
            else
                XoaGoiTap(id);
        }

        private void SuaGoiTap(int id)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(ConnStr))
                using (SqlCommand cmd = new SqlCommand(
                    "SELECT TenGoiTap, SoThang, SoLuotPT, SoLuotTuDo, MucGia, HinhAnh FROM GOI_TAP WHERE ID_MGT = @id", conn))
                {
                    cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;
                    conn.Open();
                    using (SqlDataReader r = cmd.ExecuteReader())
                    {
                        if (!r.Read())
                        {
                            ShowMessage("Không tìm thấy gói tập (có thể đã bị xóa).");
                            LoadData();
                            return;
                        }

                        hfID.Value = id.ToString();
                        txtTenGoiTap.Text = r["TenGoiTap"].ToString();
                        txtSoThang.Text = Convert.ToInt32(r["SoThang"]).ToString(CultureInfo.InvariantCulture);
                        txtSoLuotPT.Text = Convert.ToInt32(r["SoLuotPT"]).ToString(CultureInfo.InvariantCulture);
                        txtSoLuotTuDo.Text = Convert.ToInt32(r["SoLuotTuDo"]).ToString(CultureInfo.InvariantCulture);
                        txtMucGia.Text = Convert.ToDecimal(r["MucGia"]).ToString("0.##", CultureInfo.InvariantCulture);

                        // Ảnh hiện tại
                        chkXoaAnh.Checked = false;
                        HienAnhHienTai(Convert.ToString(r["HinhAnh"]));

                        litTitle.Text = "Sửa Thông Tin Gói Tập";
                    }
                }
                OpenModal();
            }
            catch (Exception ex)
            {
                ShowMessage("Lỗi khi đọc dữ liệu: " + ex.Message);
            }
        }

        // Hiện / ẩn khu vực ảnh hiện tại trong modal
        private void HienAnhHienTai(string duongDan)
        {
            if (string.IsNullOrWhiteSpace(duongDan))
            {
                khuAnhHienTai.Style["display"] = "none";
                imgHienTai.ImageUrl = "";
            }
            else
            {
                imgHienTai.ImageUrl = ResolveUrl("~/" + duongDan);
                khuAnhHienTai.Style["display"] = "block";
            }
        }

        private void XoaGoiTap(int id)
        {
            string anhCanXoa = null;
            try
            {
                using (SqlConnection conn = new SqlConnection(ConnStr))
                {
                    conn.Open();

                    // Gói đã có chi tiết đăng ký thì không cho xóa
                    using (SqlCommand check = new SqlCommand(
                        "SELECT COUNT(*) FROM CHI_TIET_DANG_KI WHERE ID_MGT = @id", conn))
                    {
                        check.Parameters.Add("@id", SqlDbType.Int).Value = id;
                        int soChiTiet = Convert.ToInt32(check.ExecuteScalar());
                        if (soChiTiet > 0)
                        {
                            ShowMessage("Không thể xóa: gói tập này đang có " + soChiTiet +
                                        " chi tiết đăng ký. Hãy xử lý các chi tiết đó trước.");
                            return;
                        }
                    }

                    // Lấy đường dẫn ảnh để xóa file sau khi xóa dòng
                    using (SqlCommand getImg = new SqlCommand(
                        "SELECT HinhAnh FROM GOI_TAP WHERE ID_MGT = @id", conn))
                    {
                        getImg.Parameters.Add("@id", SqlDbType.Int).Value = id;
                        object o = getImg.ExecuteScalar();
                        if (o != null && o != DBNull.Value) anhCanXoa = o.ToString();
                    }

                    int rows;
                    using (SqlCommand cmd = new SqlCommand("DELETE FROM GOI_TAP WHERE ID_MGT = @id", conn))
                    {
                        cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;
                        rows = cmd.ExecuteNonQuery();
                    }

                    if (rows > 0)
                    {
                        XoaFileAnh(anhCanXoa);
                        ShowMessage("Đã xóa gói tập.");
                    }
                    else
                    {
                        ShowMessage("Không tìm thấy gói tập để xóa.");
                    }
                }
            }
            catch (SqlException ex)
            {
                ShowMessage(ex.Number == 547
                    ? "Không thể xóa: gói tập này đang có dữ liệu liên quan."
                    : "Lỗi khi xóa: " + ex.Message);
            }
            catch (Exception ex)
            {
                ShowMessage("Lỗi khi xóa: " + ex.Message);
            }
            finally
            {
                LoadData();
            }
        }

        // ===== LƯU (THÊM MỚI hoặc CẬP NHẬT) VÀO SQL SERVER =====
        protected void btnSaveGoiTap_Click(object sender, EventArgs e)
        {
            string ten = txtTenGoiTap.Text.Trim();
            int soThang = 0, soLuotPT = 0, soLuotTuDo = 0;
            decimal mucGia = 0;
            string duoiAnh = null;

            // Kiểm tra dữ liệu theo các ràng buộc CHECK của bảng GOI_TAP
            string loi = null;

            if (ten.Length == 0)
                loi = "Vui lòng nhập tên gói tập.";
            else if (ten.Length > 100)
                loi = "Tên gói tập tối đa 100 ký tự.";
            else if (!int.TryParse(txtSoThang.Text.Trim(), NumberStyles.Integer, CultureInfo.InvariantCulture, out soThang) || soThang <= 0)
                loi = "Số tháng phải là số nguyên lớn hơn 0.";
            else if (!int.TryParse(txtSoLuotPT.Text.Trim(), NumberStyles.Integer, CultureInfo.InvariantCulture, out soLuotPT) || soLuotPT < 0)
                loi = "Số lượt PT phải là số nguyên từ 0 trở lên.";
            else if (!int.TryParse(txtSoLuotTuDo.Text.Trim(), NumberStyles.Integer, CultureInfo.InvariantCulture, out soLuotTuDo) || soLuotTuDo < 0)
                loi = "Số lượt tập tự do phải là số nguyên từ 0 trở lên.";
            else if (!decimal.TryParse(txtMucGia.Text.Trim(), NumberStyles.Number, CultureInfo.InvariantCulture, out mucGia) || mucGia < 0)
                loi = "Mức giá phải là số từ 0 trở lên.";
            else if (mucGia > 9999999999m)
                loi = "Mức giá quá lớn (tối đa 9.999.999.999).";
            else
                loi = KiemTraAnh(out duoiAnh); // chỉ kiểm tra khi có chọn ảnh

            if (loi != null)
            {
                ShowMessage(loi);
                OpenModal(); // giữ nguyên dữ liệu đang nhập (ảnh đã chọn phải chọn lại)
                return;
            }

            bool isEdit = !string.IsNullOrEmpty(hfID.Value);
            bool coAnhMoi = fuAnh.HasFile;
            int idDaLuu = 0;
            string noiLuu = "";
            string anhMoi = null;      // đường dẫn ảnh mới (nếu có)
            string anhCuCanXoa = null; // ảnh cũ cần xóa sau khi lưu thành công

            try
            {
                // Lưu file ảnh mới lên đĩa trước (nếu có)
                if (coAnhMoi)
                    anhMoi = LuuFileAnh(duoiAnh);

                using (SqlConnection conn = new SqlConnection(ConnStr))
                {
                    conn.Open();
                    noiLuu = conn.DataSource + " / " + conn.Database;

                    using (SqlTransaction tran = conn.BeginTransaction(IsolationLevel.Serializable))
                    {
                        try
                        {
                            int rows;

                            if (isEdit)
                            {
                                idDaLuu = Convert.ToInt32(hfID.Value);

                                // Quyết định cách xử lý cột HinhAnh
                                bool xoaAnh = chkXoaAnh.Checked && !coAnhMoi;
                                bool capNhatAnh = coAnhMoi || xoaAnh;

                                if (capNhatAnh)
                                {
                                    using (SqlCommand getImg = new SqlCommand(
                                        "SELECT HinhAnh FROM GOI_TAP WHERE ID_MGT = @id", conn, tran))
                                    {
                                        getImg.Parameters.Add("@id", SqlDbType.Int).Value = idDaLuu;
                                        object o = getImg.ExecuteScalar();
                                        if (o != null && o != DBNull.Value) anhCuCanXoa = o.ToString();
                                    }
                                }

                                string sql = "UPDATE GOI_TAP SET TenGoiTap=@ten, SoThang=@thang, SoLuotPT=@pt, " +
                                             "SoLuotTuDo=@tudo, MucGia=@gia" +
                                             (capNhatAnh ? ", HinhAnh=@anh" : "") +
                                             " WHERE ID_MGT=@id";

                                using (SqlCommand cmd = new SqlCommand(sql, conn, tran))
                                {
                                    ThemThamSo(cmd, ten, soThang, soLuotPT, soLuotTuDo, mucGia);
                                    cmd.Parameters.Add("@id", SqlDbType.Int).Value = idDaLuu;
                                    if (capNhatAnh)
                                        cmd.Parameters.Add("@anh", SqlDbType.NVarChar, 255).Value =
                                            (object)anhMoi ?? DBNull.Value;
                                    rows = cmd.ExecuteNonQuery();
                                }
                            }
                            else
                            {
                                // ID_MGT không tự tăng -> lấy mã lớn nhất + 1
                                using (SqlCommand cmdMax = new SqlCommand(
                                    "SELECT ISNULL(MAX(ID_MGT), 0) + 1 FROM GOI_TAP", conn, tran))
                                {
                                    idDaLuu = Convert.ToInt32(cmdMax.ExecuteScalar());
                                }

                                using (SqlCommand cmd = new SqlCommand(
                                    "INSERT INTO GOI_TAP (ID_MGT, TenGoiTap, SoThang, SoLuotPT, SoLuotTuDo, MucGia, HinhAnh) " +
                                    "VALUES (@id, @ten, @thang, @pt, @tudo, @gia, @anh)", conn, tran))
                                {
                                    ThemThamSo(cmd, ten, soThang, soLuotPT, soLuotTuDo, mucGia);
                                    cmd.Parameters.Add("@id", SqlDbType.Int).Value = idDaLuu;
                                    cmd.Parameters.Add("@anh", SqlDbType.NVarChar, 255).Value =
                                        (object)anhMoi ?? DBNull.Value;
                                    rows = cmd.ExecuteNonQuery();
                                }
                            }

                            if (rows != 1)
                            {
                                tran.Rollback();
                                XoaFileAnh(anhMoi); // dọn file vừa lưu vì DB không ghi
                                ShowMessage(isEdit
                                    ? "Không lưu được: không tìm thấy gói tập mã " + idDaLuu + " trong CSDL."
                                    : "Không lưu được: SQL Server không ghi dòng nào.");
                                OpenModal();
                                return;
                            }

                            tran.Commit(); // chỉ khi tới đây dữ liệu mới thực sự nằm trong SQL
                        }
                        catch
                        {
                            tran.Rollback();
                            throw;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                XoaFileAnh(anhMoi); // lỗi -> không để lại file mồ côi
                ShowMessage("Lỗi khi lưu vào SQL: " + ex.Message);
                OpenModal();
                return;
            }

            // Lưu thành công -> xóa file ảnh cũ (nếu đã bị thay/xóa)
            XoaFileAnh(anhCuCanXoa);

            // Reset form
            hfID.Value = "";
            txtTenGoiTap.Text = "";
            txtSoThang.Text = "";
            txtSoLuotPT.Text = "";
            txtSoLuotTuDo.Text = "";
            txtMucGia.Text = "";
            chkXoaAnh.Checked = false;
            HienAnhHienTai(null);
            litTitle.Text = "Thêm Gói Tập Mới";

            // Đọc lại từ SQL để hiển thị đúng dữ liệu vừa lưu
            LoadData();
            ShowMessage((isEdit ? "Đã cập nhật" : "Đã thêm") + " gói tập mã " + idDaLuu +
                        " vào SQL Server [" + noiLuu + "].");
        }

        private static void ThemThamSo(SqlCommand cmd, string ten, int soThang, int soLuotPT,
                                       int soLuotTuDo, decimal mucGia)
        {
            cmd.Parameters.Add("@ten", SqlDbType.NVarChar, 100).Value = ten;
            cmd.Parameters.Add("@thang", SqlDbType.Int).Value = soThang;
            cmd.Parameters.Add("@pt", SqlDbType.Int).Value = soLuotPT;
            cmd.Parameters.Add("@tudo", SqlDbType.Int).Value = soLuotTuDo;

            SqlParameter pGia = cmd.Parameters.Add("@gia", SqlDbType.Decimal);
            pGia.Precision = 12;
            pGia.Scale = 2;
            pGia.Value = mucGia;
        }

        // ===== XỬ LÝ ẢNH =====

        // Kiểm tra ảnh được chọn. Trả về null nếu hợp lệ hoặc không chọn ảnh.
        private string KiemTraAnh(out string duoi)
        {
            duoi = null;
            if (!fuAnh.HasFile) return null;

            if (fuAnh.PostedFile.ContentLength > AnhToiDaByte)
                return "Ảnh vượt quá 2 MB. Vui lòng chọn ảnh nhỏ hơn.";

            duoi = Path.GetExtension(fuAnh.FileName).ToLowerInvariant();
            if (Array.IndexOf(DuoiChoPhep, duoi) < 0)
                return "Chỉ chấp nhận ảnh JPG, PNG, GIF hoặc WEBP.";

            if (!NoiDungKhopDinhDang(fuAnh.FileBytes, duoi))
                return "File được chọn không phải là ảnh hợp lệ.";

            return null;
        }

        // Kiểm tra "chữ ký" đầu file để chắc chắn đó là ảnh thật
        private static bool NoiDungKhopDinhDang(byte[] b, string duoi)
        {
            if (b == null || b.Length < 12) return false;

            switch (duoi)
            {
                case ".jpg":
                case ".jpeg":
                    return b[0] == 0xFF && b[1] == 0xD8 && b[2] == 0xFF;
                case ".png":
                    return b[0] == 0x89 && b[1] == 0x50 && b[2] == 0x4E && b[3] == 0x47;
                case ".gif":
                    return b[0] == 0x47 && b[1] == 0x49 && b[2] == 0x46 && b[3] == 0x38;
                case ".webp":
                    return b[0] == 0x52 && b[1] == 0x49 && b[2] == 0x46 && b[3] == 0x46 &&
                           b[8] == 0x57 && b[9] == 0x45 && b[10] == 0x42 && b[11] == 0x50;
                default:
                    return false;
            }
        }

        // Lưu file lên đĩa, trả về đường dẫn tương đối để lưu vào SQL (vd: Uploads/GoiTap/abc.jpg)
        private string LuuFileAnh(string duoi)
        {
            string thuMuc = Server.MapPath("~/" + ThuMucAnh);
            if (!Directory.Exists(thuMuc))
                Directory.CreateDirectory(thuMuc);

            string tenFile = Guid.NewGuid().ToString("N") + duoi;
            fuAnh.SaveAs(Path.Combine(thuMuc, tenFile));
            return ThuMucAnh + tenFile;
        }

        // Xóa file ảnh (chỉ xóa file nằm trong thư mục Uploads/GoiTap, lỗi thì bỏ qua)
        private void XoaFileAnh(string duongDan)
        {
            if (string.IsNullOrWhiteSpace(duongDan)) return;
            try
            {
                string thuMuc = Path.GetFullPath(Server.MapPath("~/" + ThuMucAnh));
                string file = Path.GetFullPath(Server.MapPath("~/" + duongDan));
                if (file.StartsWith(thuMuc, StringComparison.OrdinalIgnoreCase) && File.Exists(file))
                    File.Delete(file);
            }
            catch
            {
                // Không xóa được file thì bỏ qua, không ảnh hưởng dữ liệu
            }
        }

        // Mở modal SAU KHI trang tải xong (để Bootstrap và hàm showModal đã sẵn sàng)
        private void OpenModal()
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "openModal",
                "window.addEventListener('load', function () { showModal(); });", true);
        }

        private void ShowMessage(string msg)
        {
            string safe = msg.Replace("\\", "\\\\").Replace("'", "\\'")
                             .Replace("\r", " ").Replace("\n", " ");
            ScriptManager.RegisterStartupScript(this, GetType(), "msg" + Guid.NewGuid(),
                "window.addEventListener('load', function () { alert('" + safe + "'); });", true);
        }
    }
}