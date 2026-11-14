using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;

namespace n7_phonggym
{
    public partial class DangNhap : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Đã đăng nhập rồi thì chuyển thẳng vào trang Tổng quan
                if (Session["ID_TK"] != null)
                {
                    Response.Redirect("WebForm1.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                    return;
                }

                // Tự điền lại tên đăng nhập nếu có cookie "ghi nhớ đăng nhập"
                HttpCookie cookie = Request.Cookies["RememberLogin"];
                if (cookie != null && cookie.Values["TenDangNhap"] != null)
                {
                    txtUsername.Text = cookie.Values["TenDangNhap"];
                    chkRemember.Checked = true;
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string tenDangNhap = txtUsername.Text.Trim();
            string matKhau = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(tenDangNhap) || string.IsNullOrEmpty(matKhau))
            {
                ShowError("Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu.");
                return;
            }

            string query = @"SELECT ID_TK, TenDangNhap, VaiTro, ID_MNV, TrangThai
                             FROM TAI_KHOAN
                             WHERE TenDangNhap = @TenDangNhap AND MatKhau = @MatKhau";

            try
            {
                // Đổi "GymConnectionString" cho khớp với tên trong Web.config của bạn
                ConnectionStringSettings setting = ConfigurationManager.ConnectionStrings["GymConnectionString"];
                if (setting == null)
                {
                    ShowError("Chưa cấu hình chuỗi kết nối 'GymConnectionString' trong Web.config.");
                    return;
                }

                using (SqlConnection conn = new SqlConnection(setting.ConnectionString))
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@TenDangNhap", tenDangNhap);
                    cmd.Parameters.AddWithValue("@MatKhau", matKhau);

                    conn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        // SAI tên đăng nhập hoặc mật khẩu -> báo lỗi, ở lại trang
                        if (!reader.Read())
                        {
                            ShowError("Tên đăng nhập hoặc mật khẩu không đúng.");
                            return;
                        }

                        bool trangThai = reader["TrangThai"] != DBNull.Value
                                         && Convert.ToBoolean(reader["TrangThai"]);
                        if (!trangThai)
                        {
                            ShowError("Tài khoản đã bị khóa. Vui lòng liên hệ Admin.");
                            return;
                        }

                        // Lưu thông tin đăng nhập vào Session
                        Session["ID_TK"] = reader["ID_TK"];
                        Session["TenDangNhap"] = reader["TenDangNhap"].ToString();
                        Session["VaiTro"] = reader["VaiTro"].ToString();
                        Session["ID_MNV"] = reader["ID_MNV"] == DBNull.Value ? null : reader["ID_MNV"];
                    }
                }
            }
            catch (Exception ex)
            {
                ShowError("Lỗi kết nối cơ sở dữ liệu: " + ex.Message);
                return;
            }

            // Ghi nhớ đăng nhập bằng cookie (30 ngày)
            if (chkRemember.Checked)
            {
                HttpCookie cookie = new HttpCookie("RememberLogin");
                cookie.Values["TenDangNhap"] = tenDangNhap;
                cookie.Expires = DateTime.Now.AddDays(30);
                Response.Cookies.Add(cookie);
            }
            else
            {
                Response.Cookies.Add(new HttpCookie("RememberLogin") { Expires = DateTime.Now.AddDays(-1) });
            }

            // ĐÚNG -> chuyển tới trang Tổng quan
            Response.Redirect("WebForm1.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }

        private void ShowError(string message)
        {
            litMessage.Text = Server.HtmlEncode(message);
            pnlAlert.Visible = true;
        }
    }
}
