using System;
using System.Web.UI;

namespace n7_phonggym
{
    public partial class CaiDatHeThong : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Nạp các tham số cài đặt hệ thống hiện tại
            }
        }

        protected void btnSaveSettings_Click(object sender, EventArgs e)
        {
            // Lấy dữ liệu cấu hình từ giao diện
            string tenGym = txtTenGym.Text.Trim();
            string hotline = txtHotline.Text.Trim();
            string diaChi = txtDiaChiGym.Text.Trim();
            string checkInType = ddlCheckInType.SelectedValue;
            string bankName = txtBankName.Text.Trim();
            string accountNumber = txtAccountNumber.Text.Trim();

            // Thao tác lưu/cập nhật thông tin cấu hình vào CSDL hoặc file cấu hình Web.config tại đây

            // Hiển thị thông báo lưu thành công
            pnlAlert.Visible = true;
            litMessage.Text = "Cập nhật các cài đặt hệ thống thành công!";
        }
    }
}