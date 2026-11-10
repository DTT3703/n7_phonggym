using System;
using System.Data;
using System.Web.UI;

namespace n7_phonggym
{
    public partial class LichTap : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDataLichTap();
            }
        }

        private void LoadDataLichTap()
        {
            // Dữ liệu mẫu minh họa liên kết bảng LK_LỊCH_TẬP, NHÂN_VIÊN và CHI_TIẾT_GÓI
            DataTable dt = new DataTable();
            dt.Columns.Add("ID_CTG", typeof(int));
            dt.Columns.Add("TenChiTietGoi", typeof(string));
            dt.Columns.Add("TenPT", typeof(string));
            dt.Columns.Add("NgayTap", typeof(DateTime));
            dt.Columns.Add("KhungGio", typeof(string));
            dt.Columns.Add("SoLuongHV", typeof(int));
            dt.Columns.Add("DanhGiaBuoi", typeof(string));

            dt.Rows.Add(101, "Chi tiết gói Gym VIP 1-on-1", "Phạm Văn D (PT)", new DateTime(2026, 11, 12), "08:00 - 09:30", 1, "Tập nhóm cơ ngực + tay sau");
            dt.Rows.Add(102, "Chi tiết gói PT Nhóm", "Trần Thị E (PT Chuyên Gia)", new DateTime(2026, 11, 12), "17:00 - 18:30", 3, "Bài tập Cardio đốt mỡ cao độ");
            dt.Rows.Add(103, "Chi tiết gói Gym Classic", "Nguyễn Văn F (PT)", new DateTime(2026, 11, 13), "19:00 - 20:30", 2, "Hướng dẫn kỹ thuật Squat và Deadlift");

            gvLichTap.DataSource = dt;
            gvLichTap.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            // Thao tác tìm kiếm lịch tập
        }

        protected void btnSaveLichTap_Click(object sender, EventArgs e)
        {
            // Lấy dữ liệu từ Modal đặt lịch
            if (!string.IsNullOrEmpty(txtID_CTG.Text) && !string.IsNullOrEmpty(txtID_MNV.Text))
            {
                int idCTG = Convert.ToInt32(txtID_CTG.Text);
                int idMNV = Convert.ToInt32(txtID_MNV.Text);
                string ngayTap = txtNgayTap.Text;
                string khungGio = ddlKhungGio.SelectedValue;
                int soLuongHV = Convert.ToInt32(txtSoLuongHV.Text);
                string danhGia = txtDanhGiaBuoi.Text.Trim();

                // Thực hiện câu lệnh INSERT vào bảng LK_LICH_TAP trong SQL Server tại đây

                // Load lại danh sách sau khi thêm thành công
                LoadDataLichTap();
            }
        }
    }
}