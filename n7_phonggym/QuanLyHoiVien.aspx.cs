using System;
using System.Data;
using System.Web.UI;

namespace n7_phonggym
{
    public partial class QuanLyHoiVien : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
            }
        }

        private void LoadData()
        {
            // Dữ liệu mẫu minh họa bảng HOI_VIEN
            DataTable dt = new DataTable();
            dt.Columns.Add("ID_MHV", typeof(int));
            dt.Columns.Add("HoTen", typeof(string));
            dt.Columns.Add("NgaySinh", typeof(DateTime));
            dt.Columns.Add("GioiTinh", typeof(string));
            dt.Columns.Add("DiaChi", typeof(string));

            dt.Rows.Add(1, "Nguyễn Văn A", new DateTime(1995, 5, 20), "Nam", "Quận 1, TP.HCM");
            dt.Rows.Add(2, "Trần Thị B", new DateTime(1998, 8, 15), "Nữ", "Quận 3, TP.HCM");
            dt.Rows.Add(3, "Lê Văn C", new DateTime(2000, 12, 10), "Nam", "Quận 7, TP.HCM");

            gvHoiVien.DataSource = dt;
            gvHoiVien.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            // Xử lý tìm kiếm hội viên
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            // Xử lý thêm mới hội viên vào CSDL SQL Server
            string hoTen = txtHoTen.Text;
            string ngaySinh = txtNgaySinh.Text;
            string gioiTinh = ddlGioiTinh.SelectedValue;
            string diaChi = txtDiaChi.Text;

            // Đóng modal và tải lại dữ liệu sau khi lưu
            LoadData();
        }
    }
}