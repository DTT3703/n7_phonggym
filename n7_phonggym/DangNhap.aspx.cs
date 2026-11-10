using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace n7_phonggym
{
    public partial class DangNhap : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            // Kiểm tra thông tin đăng nhập mẫu
            if (username == "admin" && password == "123456")
            {
                // Đăng nhập thành công -> Chuyển hướng sang trang quản trị WebForm1.aspx
                Response.Redirect("WebForm1.aspx");
            }
            else
            {
                // Đăng nhập thất bại -> Hiển thị thông báo lỗi trên giao diện
                pnlAlert.Visible = true;
                litMessage.Text = "Tên đăng nhập hoặc mật khẩu không chính xác!";
            }
        }
    }
}