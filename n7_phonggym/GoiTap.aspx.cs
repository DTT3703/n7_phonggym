using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace n7_phonggym
{
    public partial class GoiTap : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDataGoiTap();
            }
        }

        private void LoadDataGoiTap()
        {
            // Dữ liệu mẫu minh họa tương ứng bảng GOI_TAP trong CSDL
            DataTable dt = new DataTable();
            dt.Columns.Add("ID_MGT", typeof(int));
            dt.Columns.Add("TenGoiTap", typeof(string));
            dt.Columns.Add("SoThang", typeof(int));
            dt.Columns.Add("SoLuotPT", typeof(int));
            dt.Columns.Add("SoLuotTuDo", typeof(int));
            dt.Columns.Add("MucGia", typeof(decimal));

            dt.Rows.Add(1, "Gói Tập Tự Do 1 Tháng", 1, 0, 30, 500000);
            dt.Rows.Add(2, "Gói Gym Classic 3 Tháng", 3, 2, 90, 1350000);
            dt.Rows.Add(3, "Gói VIP kèm PT 6 Tháng", 6, 24, 180, 6000000);
            dt.Rows.Add(4, "Gói Thể Hình 1 Năm", 12, 5, 365, 4800000);

            gvGoiTap.DataSource = dt;
            gvGoiTap.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            // Xử lý tìm kiếm gói tập ở đây
        }

        protected void btnSaveGoiTap_Click(object sender, EventArgs e)
        {
            // Lấy dữ liệu nhập vào từ Modal thêm gói tập
            if (!string.IsNullOrEmpty(txtTenGoiTap.Text))
            {
                string tenGoi = txtTenGoiTap.Text.Trim();
                int soThang = string.IsNullOrEmpty(txtSoThang.Text) ? 0 : Convert.ToInt32(txtSoThang.Text);
                int soLuotPT = string.IsNullOrEmpty(txtSoLuotPT.Text) ? 0 : Convert.ToInt32(txtSoLuotPT.Text);
                int soLuotTuDo = string.IsNullOrEmpty(txtSoLuotTuDo.Text) ? 0 : Convert.ToInt32(txtSoLuotTuDo.Text);
                decimal mucGia = string.IsNullOrEmpty(txtMucGia.Text) ? 0 : Convert.ToDecimal(txtMucGia.Text);

                // Thao tác chèn dữ liệu mới vào CSDL SQL Server (bảng GOI_TAP) tại đây

                // Nạp lại dữ liệu hiển thị lên GridView
                LoadDataGoiTap();
            }
        }
    }
}