using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace n7_phonggym
{
    public partial class QuanLyHoiVien : Page
    {
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

        // ===== HIỂN THỊ + TÌM KIẾM =====
        private void LoadData()
        {
            string kw = txtSearch.Text.Trim();
            string sql = "SELECT ID_MHV, HoTen, NgaySinh, GioiTinh, DiaChi FROM HOI_VIEN";
            if (kw.Length > 0)
                sql += " WHERE HoTen LIKE @kw OR CAST(ID_MHV AS NVARCHAR(20)) LIKE @kw";
            sql += " ORDER BY ID_MHV DESC";

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
                    gvHoiVien.DataSource = dt;
                    gvHoiVien.DataBind();
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
        protected void gvHoiVien_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "SuaHV" && e.CommandName != "XoaHV") return;

            int id;
            if (!int.TryParse(Convert.ToString(e.CommandArgument), out id)) return;

            if (e.CommandName == "SuaHV")
                SuaHoiVien(id);
            else
                XoaHoiVien(id);
        }

        private void SuaHoiVien(int id)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(ConnStr))
                using (SqlCommand cmd = new SqlCommand(
                    "SELECT HoTen, NgaySinh, GioiTinh, DiaChi FROM HOI_VIEN WHERE ID_MHV = @id", conn))
                {
                    cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;
                    conn.Open();
                    using (SqlDataReader r = cmd.ExecuteReader())
                    {
                        if (!r.Read())
                        {
                            ShowMessage("Không tìm thấy hội viên (có thể đã bị xóa).");
                            LoadData();
                            return;
                        }

                        hfID.Value = id.ToString();
                        txtHoTen.Text = r["HoTen"].ToString();
                        txtNgaySinh.Text = Convert.ToDateTime(r["NgaySinh"]).ToString("yyyy-MM-dd");
                        txtDiaChi.Text = r["DiaChi"].ToString();

                        ddlGioiTinh.ClearSelection();
                        ListItem gt = ddlGioiTinh.Items.FindByValue(r["GioiTinh"].ToString());
                        if (gt != null) gt.Selected = true;

                        litTitle.Text = "Sửa Thông Tin Hội Viên";
                    }
                }
                OpenModal();
            }
            catch (Exception ex)
            {
                ShowMessage("Lỗi khi đọc dữ liệu: " + ex.Message);
            }
        }

        private void XoaHoiVien(int id)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(ConnStr))
                {
                    conn.Open();

                    // Hội viên đang có gói đăng ký thì không cho xóa
                    using (SqlCommand check = new SqlCommand(
                        "SELECT COUNT(*) FROM LK_DANG_KY WHERE ID_MHV = @id", conn))
                    {
                        check.Parameters.Add("@id", SqlDbType.Int).Value = id;
                        int soDangKy = Convert.ToInt32(check.ExecuteScalar());
                        if (soDangKy > 0)
                        {
                            ShowMessage("Không thể xóa: hội viên này đang có " + soDangKy +
                                        " gói đăng ký. Hãy xử lý các đăng ký trước.");
                            return;
                        }
                    }

                    int rows;
                    using (SqlCommand cmd = new SqlCommand("DELETE FROM HOI_VIEN WHERE ID_MHV = @id", conn))
                    {
                        cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;
                        rows = cmd.ExecuteNonQuery();
                    }

                    ShowMessage(rows > 0 ? "Đã xóa hội viên." : "Không tìm thấy hội viên để xóa.");
                }
            }
            catch (SqlException ex)
            {
                ShowMessage(ex.Number == 547
                    ? "Không thể xóa: hội viên này đang có dữ liệu liên quan."
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
        protected void btnSave_Click(object sender, EventArgs e)
        {
            string hoTen = txtHoTen.Text.Trim();
            string diaChi = txtDiaChi.Text.Trim();
            string gioiTinh = ddlGioiTinh.SelectedValue;

            // Kiểm tra dữ liệu (các cột trong CSDL đều NOT NULL)
            string loi = null;
            DateTime ngaySinh = DateTime.MinValue;

            if (hoTen.Length == 0)
                loi = "Vui lòng nhập họ và tên.";
            else if (hoTen.Length > 100)
                loi = "Họ tên tối đa 100 ký tự.";
            else if (!DateTime.TryParseExact(txtNgaySinh.Text.Trim(), "yyyy-MM-dd",
                         CultureInfo.InvariantCulture, DateTimeStyles.None, out ngaySinh))
                loi = "Vui lòng chọn ngày sinh hợp lệ.";
            else if (ngaySinh > DateTime.Today || ngaySinh.Year < 1900)
                loi = "Ngày sinh không hợp lệ.";
            else if (diaChi.Length == 0)
                loi = "Vui lòng nhập địa chỉ.";
            else if (diaChi.Length > 255)
                loi = "Địa chỉ tối đa 255 ký tự.";

            if (loi != null)
            {
                ShowMessage(loi);
                OpenModal(); // giữ nguyên dữ liệu đang nhập
                return;
            }

            bool isEdit = !string.IsNullOrEmpty(hfID.Value);
            int idDaLuu = 0;
            string noiLuu = "";

            try
            {
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
                                using (SqlCommand cmd = new SqlCommand(
                                    "UPDATE HOI_VIEN SET HoTen=@ten, NgaySinh=@ns, GioiTinh=@gt, DiaChi=@dc " +
                                    "WHERE ID_MHV=@id", conn, tran))
                                {
                                    ThemThamSo(cmd, hoTen, ngaySinh, gioiTinh, diaChi);
                                    cmd.Parameters.Add("@id", SqlDbType.Int).Value = idDaLuu;
                                    rows = cmd.ExecuteNonQuery();
                                }
                            }
                            else
                            {
                                // ID_MHV không tự tăng -> lấy mã lớn nhất + 1
                                using (SqlCommand cmdMax = new SqlCommand(
                                    "SELECT ISNULL(MAX(ID_MHV), 0) + 1 FROM HOI_VIEN", conn, tran))
                                {
                                    idDaLuu = Convert.ToInt32(cmdMax.ExecuteScalar());
                                }

                                using (SqlCommand cmd = new SqlCommand(
                                    "INSERT INTO HOI_VIEN (ID_MHV, HoTen, NgaySinh, GioiTinh, DiaChi) " +
                                    "VALUES (@id, @ten, @ns, @gt, @dc)", conn, tran))
                                {
                                    ThemThamSo(cmd, hoTen, ngaySinh, gioiTinh, diaChi);
                                    cmd.Parameters.Add("@id", SqlDbType.Int).Value = idDaLuu;
                                    rows = cmd.ExecuteNonQuery();
                                }
                            }

                            if (rows != 1)
                            {
                                tran.Rollback();
                                ShowMessage(isEdit
                                    ? "Không lưu được: không tìm thấy hội viên mã " + idDaLuu + " trong CSDL."
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
                ShowMessage("Lỗi khi lưu vào SQL: " + ex.Message);
                OpenModal();
                return;
            }

            // Reset form
            hfID.Value = "";
            txtHoTen.Text = "";
            txtNgaySinh.Text = "";
            txtDiaChi.Text = "";
            ddlGioiTinh.SelectedIndex = 0;
            litTitle.Text = "Thêm Hội Viên Mới";

            // Đọc lại từ SQL để hiển thị đúng dữ liệu vừa lưu
            LoadData();
            ShowMessage((isEdit ? "Đã cập nhật" : "Đã thêm") + " hội viên mã " + idDaLuu +
                        " vào SQL Server [" + noiLuu + "].");
        }

        private static void ThemThamSo(SqlCommand cmd, string hoTen, DateTime ngaySinh,
                                       string gioiTinh, string diaChi)
        {
            cmd.Parameters.Add("@ten", SqlDbType.NVarChar, 100).Value = hoTen;
            cmd.Parameters.Add("@ns", SqlDbType.Date).Value = ngaySinh;
            cmd.Parameters.Add("@gt", SqlDbType.NVarChar, 10).Value = gioiTinh;
            cmd.Parameters.Add("@dc", SqlDbType.NVarChar, 255).Value = diaChi;
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