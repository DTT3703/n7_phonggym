using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace n7_phonggym
{
    public partial class LichTap : System.Web.UI.Page
    {
        private const string ConnName = "DefaultConnection";
        private const string FallbackConn = @"Data Source=MAY28GD3\SQLEXPRESS;Initial Catalog=n7_phongGym;Integrated Security=True";

        private string ConnStr
        {
            get
            {
                // Ưu tiên chuỗi trong Web.config, nếu không có thì dùng chuỗi dự phòng
                ConnectionStringSettings cs = ConfigurationManager.ConnectionStrings[ConnName];
                return cs != null ? cs.ConnectionString : FallbackConn;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDataLichTap();
            }
        }

        // ===== Hiển thị danh sách (có tìm kiếm) =====
        private void LoadDataLichTap()
        {
            string sql = @"
                SELECT lt.ID_CTG, ctg.TenChiTietGoi, lt.ID_MNV, nv.HoTen AS TenPT,
                       lt.NgayTap, lt.KhungGio, lt.SoLuongHV, lt.DanhGiaBuoi
                FROM LK_LICH_TAP lt
                LEFT JOIN CHI_TIET_DANG_KI ctg ON lt.ID_CTG = ctg.ID_CTG
                LEFT JOIN NHAN_VIEN nv ON lt.ID_MNV = nv.ID_MNV
                WHERE (@kw = '' OR lt.KhungGio LIKE @like OR nv.HoTen LIKE @like OR ctg.TenChiTietGoi LIKE @like)
                ORDER BY lt.NgayTap DESC, lt.KhungGio";

            string kw = txtSearch.Text.Trim();

            using (SqlConnection conn = new SqlConnection(ConnStr))
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@kw", kw);
                cmd.Parameters.AddWithValue("@like", "%" + kw + "%");
                DataTable dt = new DataTable();
                new SqlDataAdapter(cmd).Fill(dt);
                gvLichTap.DataSource = dt;
                gvLichTap.DataBind();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadDataLichTap();
        }

        // ===== Thêm mới =====
        protected void btnSaveLichTap_Click(object sender, EventArgs e)
        {
            int idCTG, idMNV, soLuong;
            DateTime ngay;

            if (!int.TryParse(txtID_CTG.Text, out idCTG) || !int.TryParse(txtID_MNV.Text, out idMNV)
                || !int.TryParse(txtSoLuongHV.Text, out soLuong)
                || !DateTime.TryParseExact(txtNgayTap.Text, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out ngay))
            {
                Alert("Vui lòng nhập đầy đủ và đúng định dạng các trường.");
                OpenModal("addLichTapModal");
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(ConnStr))
                using (SqlCommand cmd = new SqlCommand(
                    @"INSERT INTO LK_LICH_TAP (ID_CTG, ID_MNV, NgayTap, KhungGio, SoLuongHV, DanhGiaBuoi)
                      VALUES (@ID_CTG, @ID_MNV, @NgayTap, @KhungGio, @SoLuongHV, @DanhGiaBuoi)", conn))
                {
                    cmd.Parameters.AddWithValue("@ID_CTG", idCTG);
                    cmd.Parameters.AddWithValue("@ID_MNV", idMNV);
                    cmd.Parameters.Add("@NgayTap", SqlDbType.Date).Value = ngay;
                    cmd.Parameters.AddWithValue("@KhungGio", ddlKhungGio.SelectedValue);
                    cmd.Parameters.AddWithValue("@SoLuongHV", soLuong);
                    cmd.Parameters.AddWithValue("@DanhGiaBuoi", txtDanhGiaBuoi.Text.Trim());
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            catch (SqlException ex)
            {
                Alert(ThongBaoLoi(ex));
                OpenModal("addLichTapModal");
                return;
            }

            txtID_CTG.Text = txtID_MNV.Text = txtNgayTap.Text = txtDanhGiaBuoi.Text = "";
            txtSoLuongHV.Text = "1";
            LoadDataLichTap();
            Alert("Đã thêm lịch tập mới!");
        }

        // ===== Bấm nút Sửa / Xóa trên từng dòng =====
        protected void gvLichTap_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "SuaLich" && e.CommandName != "XoaLich") return;

            // Lấy khóa kép của dòng được bấm
            GridViewRow row = (GridViewRow)((Control)e.CommandSource).NamingContainer;
            DataKey key = gvLichTap.DataKeys[row.RowIndex];

            int idCTG = Convert.ToInt32(key["ID_CTG"]);
            int idMNV = Convert.ToInt32(key["ID_MNV"]);
            DateTime ngay = Convert.ToDateTime(key["NgayTap"]);
            string gio = Convert.ToString(key["KhungGio"]);

            if (e.CommandName == "SuaLich")
                MoFormSua(idCTG, idMNV, ngay, gio);
            else
                XoaLich(idCTG, idMNV, ngay, gio);
        }

        // ----- Sửa: nạp dữ liệu vào modal -----
        private void MoFormSua(int idCTG, int idMNV, DateTime ngay, string gio)
        {
            using (SqlConnection conn = new SqlConnection(ConnStr))
            using (SqlCommand cmd = new SqlCommand(
                @"SELECT ID_CTG, ID_MNV, NgayTap, KhungGio, SoLuongHV, DanhGiaBuoi
                  FROM LK_LICH_TAP
                  WHERE ID_CTG = @ID_CTG AND ID_MNV = @ID_MNV AND NgayTap = @NgayTap AND KhungGio = @KhungGio", conn))
            {
                cmd.Parameters.AddWithValue("@ID_CTG", idCTG);
                cmd.Parameters.AddWithValue("@ID_MNV", idMNV);
                cmd.Parameters.Add("@NgayTap", SqlDbType.Date).Value = ngay;
                cmd.Parameters.AddWithValue("@KhungGio", gio);
                conn.Open();

                using (SqlDataReader rd = cmd.ExecuteReader())
                {
                    if (!rd.Read())
                    {
                        Alert("Không tìm thấy buổi tập này (có thể đã bị xóa).");
                        return;
                    }

                    string ngayStr = Convert.ToDateTime(rd["NgayTap"]).ToString("yyyy-MM-dd");
                    string gioStr = rd["KhungGio"].ToString();

                    // Lưu khóa gốc để UPDATE đúng dòng
                    hfOldCTG.Value = rd["ID_CTG"].ToString();
                    hfOldMNV.Value = rd["ID_MNV"].ToString();
                    hfOldNgay.Value = ngayStr;
                    hfOldGio.Value = gioStr;

                    txtEditID_CTG.Text = rd["ID_CTG"].ToString();
                    txtEditID_MNV.Text = rd["ID_MNV"].ToString();
                    txtEditNgayTap.Text = ngayStr;
                    txtEditSoLuongHV.Text = rd["SoLuongHV"].ToString();
                    txtEditDanhGiaBuoi.Text = rd["DanhGiaBuoi"].ToString();

                    // Chọn khung giờ; nếu chưa có trong danh sách thì thêm vào
                    ddlEditKhungGio.ClearSelection();
                    ListItem item = ddlEditKhungGio.Items.FindByValue(gioStr);
                    if (item == null)
                    {
                        item = new ListItem(gioStr, gioStr);
                        ddlEditKhungGio.Items.Add(item);
                    }
                    item.Selected = true;
                }
            }

            OpenModal("editLichTapModal");
        }

        // ----- Sửa: bấm nút Cập Nhật -----
        protected void btnUpdateLichTap_Click(object sender, EventArgs e)
        {
            int oCTG, oMNV, nCTG, nMNV, soLuong;
            DateTime oNgay, nNgay;

            if (!int.TryParse(hfOldCTG.Value, out oCTG) || !int.TryParse(hfOldMNV.Value, out oMNV)
                || !DateTime.TryParseExact(hfOldNgay.Value, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out oNgay))
            {
                Alert("Không xác định được buổi tập cần sửa. Vui lòng bấm Sửa lại.");
                return;
            }

            if (!int.TryParse(txtEditID_CTG.Text, out nCTG) || !int.TryParse(txtEditID_MNV.Text, out nMNV)
                || !int.TryParse(txtEditSoLuongHV.Text, out soLuong)
                || !DateTime.TryParseExact(txtEditNgayTap.Text, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out nNgay))
            {
                Alert("Vui lòng nhập đầy đủ và đúng định dạng các trường.");
                OpenModal("editLichTapModal");
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(ConnStr))
                using (SqlCommand cmd = new SqlCommand(
                    @"UPDATE LK_LICH_TAP
                      SET ID_CTG = @nCTG, ID_MNV = @nMNV, NgayTap = @nNgay, KhungGio = @nGio,
                          SoLuongHV = @SoLuongHV, DanhGiaBuoi = @DanhGiaBuoi
                      WHERE ID_CTG = @oCTG AND ID_MNV = @oMNV AND NgayTap = @oNgay AND KhungGio = @oGio", conn))
                {
                    cmd.Parameters.AddWithValue("@nCTG", nCTG);
                    cmd.Parameters.AddWithValue("@nMNV", nMNV);
                    cmd.Parameters.Add("@nNgay", SqlDbType.Date).Value = nNgay;
                    cmd.Parameters.AddWithValue("@nGio", ddlEditKhungGio.SelectedValue);
                    cmd.Parameters.AddWithValue("@SoLuongHV", soLuong);
                    cmd.Parameters.AddWithValue("@DanhGiaBuoi", txtEditDanhGiaBuoi.Text.Trim());

                    cmd.Parameters.AddWithValue("@oCTG", oCTG);
                    cmd.Parameters.AddWithValue("@oMNV", oMNV);
                    cmd.Parameters.Add("@oNgay", SqlDbType.Date).Value = oNgay;
                    cmd.Parameters.AddWithValue("@oGio", hfOldGio.Value);

                    conn.Open();
                    int n = cmd.ExecuteNonQuery();
                    if (n == 0)
                    {
                        Alert("Không tìm thấy buổi tập để cập nhật (có thể đã bị xóa).");
                        LoadDataLichTap();
                        return;
                    }
                }
            }
            catch (SqlException ex)
            {
                Alert(ThongBaoLoi(ex));
                OpenModal("editLichTapModal");
                return;
            }

            LoadDataLichTap();
            Alert("Cập nhật lịch tập thành công!");
        }

        // ----- Xóa -----
        private void XoaLich(int idCTG, int idMNV, DateTime ngay, string gio)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(ConnStr))
                using (SqlCommand cmd = new SqlCommand(
                    @"DELETE FROM LK_LICH_TAP
                      WHERE ID_CTG = @ID_CTG AND ID_MNV = @ID_MNV AND NgayTap = @NgayTap AND KhungGio = @KhungGio", conn))
                {
                    cmd.Parameters.AddWithValue("@ID_CTG", idCTG);
                    cmd.Parameters.AddWithValue("@ID_MNV", idMNV);
                    cmd.Parameters.Add("@NgayTap", SqlDbType.Date).Value = ngay;
                    cmd.Parameters.AddWithValue("@KhungGio", gio);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            catch (SqlException ex)
            {
                Alert(ThongBaoLoi(ex));
                return;
            }

            LoadDataLichTap();
            Alert("Đã xóa buổi tập!");
        }

        // ===== Tiện ích =====
        private string ThongBaoLoi(SqlException ex)
        {
            if (ex.Number == 2627 || ex.Number == 2601)
                return "Buổi tập này đã tồn tại (trùng Mã gói, PT, Ngày tập và Khung giờ).";
            if (ex.Number == 547)
                return "Mã chi tiết gói hoặc mã PT không tồn tại, hoặc dữ liệu đang được liên kết.";
            return "Lỗi cơ sở dữ liệu: " + ex.Message;
        }

        private void Alert(string msg)
        {
            string safe = msg.Replace("\\", "\\\\").Replace("'", "\\'").Replace("\r", " ").Replace("\n", " ");
            ScriptManager.RegisterStartupScript(this, GetType(), "alert" + Guid.NewGuid().ToString("N"),
                "window.addEventListener('load', function () { alert('" + safe + "'); });", true);
        }

        // Bootstrap được nạp sau </form> nên phải đợi sự kiện load
        private void OpenModal(string modalId)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "open_" + modalId,
                "window.addEventListener('load', function () {" +
                "  new bootstrap.Modal(document.getElementById('" + modalId + "')).show();" +
                "});", true);
        }
    }
}
