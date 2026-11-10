using System;
using System.Data;
using System.Web.UI;

namespace n7_phonggym
{
    public partial class NhanVien : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDataNhanVien();
            }
        }

        private void LoadDataNhanVien()
        {
            // Dữ liệu mẫu kết hợp giữa 3 bảng: NHAN_VIEN, HUAN_LUYEN_VIEN và PT_CHUYEN_GIA
            DataTable dt = new DataTable();
            dt.Columns.Add("ID_MNV", typeof(int));
            dt.Columns.Add("HoTen", typeof(string));
            dt.Columns.Add("NgaySinh", typeof(DateTime));
            dt.Columns.Add("GioiTinh", typeof(string));
            dt.Columns.Add("TrinhDo", typeof(string));
            dt.Columns.Add("ChuyenMon", typeof(string));
            dt.Columns.Add("GiaBieuDay", typeof(decimal));
            dt.Columns.Add("PhuCapVIP", typeof(decimal));

            dt.Rows.Add(1, "Nguyễn Văn Lễ Tân", new DateTime(1997, 3, 10), "Nam", "Cao Đẳng", "Lễ Tân & Chăm sóc KH", DBNull.Value, DBNull.Value);
            dt.Rows.Add(2, "Phạm Văn D", new DateTime(1994, 7, 22), "Nam", "Đại Học TDTT", "Huấn Luyện Viên Gym", 300000, DBNull.Value);
            dt.Rows.Add(3, "Trần Thị E", new DateTime(1991, 11, 05), "Nữ", "Chứng chỉ PT Quốc Tế", "PT Chuyên Gia / Fitness", 500000, 2000000);

            gvNhanVien.DataSource = dt;
            gvNhanVien.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            // Xử lý tìm kiếm nhân viên
        }

        protected void btnSaveNhanVien_Click(object sender, EventArgs e)
        {
            // Lấy thông tin từ form thêm nhân viên
            if (!string.IsNullOrEmpty(txtHoTen.Text))
            {
                string hoTen = txtHoTen.Text.Trim();
                string ngaySinh = txtNgaySinh.Text;
                string gioiTinh = ddlGioiTinh.SelectedValue;
                string trinhDo = txtTrinhDo.Text.Trim();
                string chuyenMon = txtChuyenMon.Text.Trim();

                // Thao tác chèn vào bảng NHAN_VIEN (và HUAN_LUYEN_VIEN / PT_CHUYEN_GIA nếu có dữ liệu giá biểu dạy) trong CSDL SQL Server ở đây

                // Load lại dữ liệu hiển thị
                LoadDataNhanVien();
            }
        }
    }
}