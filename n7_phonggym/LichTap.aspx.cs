using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace n7_phonggym
{
    public partial class LichTap : System.Web.UI.Page
    {
        private string GetConnStr()
        {
            var cs = ConfigurationManager.ConnectionStrings["n7_phongGymConn"];
            if (cs != null && !string.IsNullOrWhiteSpace(cs.ConnectionString))
                return cs.ConnectionString;

            return @"Data Source=.\SQLEXPRESS;Initial Catalog=n7_phongGym;Integrated Security=True";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDropdowns();
                LoadThongKe();
                LoadDataLichTap();
            }
        }

        private void HienThongBao(string noiDung, string loaiAlert = "success")
        {
            pnlThongBao.Visible = true;
            pnlThongBao.CssClass = $"alert alert-{loaiAlert} alert-dismissible fade show mb-4";
            litThongBao.Text = noiDung;
        }

        private void LoadDropdowns()
        {
            using (SqlConnection conn = new SqlConnection(GetConnStr()))
            {
                conn.Open();

                string sqlGoi = @"
                    SELECT c.ID_CTG, 
                           c.TenChiTietGoi + N' (' + g.TenGoiTap + N' - Tối đa ' + CAST(c.SoLuongHVToiDa AS NVARCHAR(10)) + N' HV)' AS HienThi
                    FROM CHI_TIET_DANG_KI c
                    INNER JOIN GOI_TAP g ON c.ID_MGT = g.ID_MGT
                    ORDER BY c.ID_CTG";
                using (SqlDataAdapter daGoi = new SqlDataAdapter(sqlGoi, conn))
                {
                    DataTable dtGoi = new DataTable();
                    daGoi.Fill(dtGoi);
                    ddlChiTietGoi.DataSource = dtGoi;
                    ddlChiTietGoi.DataTextField = "HienThi";
                    ddlChiTietGoi.DataValueField = "ID_CTG";
                    ddlChiTietGoi.DataBind();
                }

                string sqlPT = @"
                    SELECT h.ID_MNV,
                           nv.HoTen + N' - ' + nv.ChuyenMon + 
                           CASE WHEN cg.ID_MNV IS NOT NULL THEN N' ★ [PT Chuyên Gia]' ELSE N'' END AS TenPT
                    FROM HUAN_LUYEN_VIEN h
                    INNER JOIN NHAN_VIEN nv ON h.ID_MNV = nv.ID_MNV
                    LEFT JOIN PT_CHUYEN_GIA cg ON h.ID_MNV = cg.ID_MNV
                    ORDER BY nv.HoTen";
                using (SqlDataAdapter daPT = new SqlDataAdapter(sqlPT, conn))
                {
                    DataTable dtPT = new DataTable();
                    daPT.Fill(dtPT);

                    ddlPT.DataSource = dtPT;
                    ddlPT.DataTextField = "TenPT";
                    ddlPT.DataValueField = "ID_MNV";
                    ddlPT.DataBind();

                    ddlFilterPT.DataSource = dtPT;
                    ddlFilterPT.DataTextField = "TenPT";
                    ddlFilterPT.DataValueField = "ID_MNV";
                    ddlFilterPT.DataBind();
                    ddlFilterPT.Items.Insert(0, new ListItem("-- Tất cả PT --", "0"));
                }
            }
        }

        private void LoadThongKe()
        {
            using (SqlConnection conn = new SqlConnection(GetConnStr()))
            {
                string sql = @"
                    SELECT 
                        (SELECT COUNT(*) FROM LK_LICH_TAP) AS TongBuoi,
                        (SELECT COUNT(*) FROM HUAN_LUYEN_VIEN) AS TongPT,
                        (SELECT ISNULL(SUM(SoLuongHV), 0) FROM LK_LICH_TAP) AS TongHV,
                        (SELECT COUNT(*) FROM PT_CHUYEN_GIA) AS TongPTVIP";
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    conn.Open();
                    using (SqlDataReader rd = cmd.ExecuteReader())
                    {
                        if (rd.Read())
                        {
                            litTongBuoi.Text = rd["TongBuoi"].ToString();
                            litTongPT.Text = rd["TongPT"].ToString();
                            litTongHV.Text = rd["TongHV"].ToString();
                            litPTChuyenGia.Text = rd["TongPTVIP"].ToString();
                        }
                    }
                }
            }
        }

        private void LoadDataLichTap()
        {
            string kw = txtSearch.Text.Trim();
            int filterPT = int.Parse(ddlFilterPT.SelectedValue ?? "0");
            DateTime parsedFilterNgay;
            bool coLocNgay = DateTime.TryParse(txtFilterNgay.Text.Trim(), out parsedFilterNgay);

            using (SqlConnection conn = new SqlConnection(GetConnStr()))
            {
                string sql = @"
                    SELECT lt.ID_CTG, lt.ID_MNV, lt.NgayTap, lt.KhungGio, lt.SoLuongHV, lt.DanhGiaBuoi,
                           ct.TenChiTietGoi, ct.SoLuongHVToiDa,
                           gt.TenGoiTap,
                           nv.HoTen AS TenPT, nv.ChuyenMon,
                           CASE WHEN cg.ID_MNV IS NOT NULL THEN 1 ELSE 0 END AS LaChuyenGia
                    FROM LK_LICH_TAP lt
                    INNER JOIN CHI_TIET_DANG_KI ct ON lt.ID_CTG = ct.ID_CTG
                    INNER JOIN GOI_TAP gt ON ct.ID_MGT = gt.ID_MGT
                    INNER JOIN NHAN_VIEN nv ON lt.ID_MNV = nv.ID_MNV
                    LEFT JOIN PT_CHUYEN_GIA cg ON lt.ID_MNV = cg.ID_MNV
                    WHERE (@kw = N'' OR ct.TenChiTietGoi LIKE @like OR gt.TenGoiTap LIKE @like 
                           OR nv.HoTen LIKE @like OR lt.KhungGio LIKE @like OR lt.DanhGiaBuoi LIKE @like)
                      AND (@idPT = 0 OR lt.ID_MNV = @idPT)
                      AND (@coNgay = 0 OR lt.NgayTap = @ngay)
                    ORDER BY lt.NgayTap DESC, lt.KhungGio ASC";

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@kw", kw);
                    cmd.Parameters.AddWithValue("@like", "%" + kw + "%");
                    cmd.Parameters.AddWithValue("@idPT", filterPT);
                    cmd.Parameters.AddWithValue("@coNgay", coLocNgay ? 1 : 0);
                    cmd.Parameters.Add("@ngay", SqlDbType.Date).Value = coLocNgay ? (object)parsedFilterNgay.Date : DBNull.Value;

                    DataTable dt = new DataTable();
                    new SqlDataAdapter(cmd).Fill(dt);
                    gvLichTap.DataSource = dt;
                    gvLichTap.DataBind();
                }
            }
        }

        protected string LayClassSiSo(object soHienTaiObj, object soToiDaObj)
        {
            int hienTai = Convert.ToInt32(soHienTaiObj);
            int toiDa = Convert.ToInt32(soToiDaObj);
            if (hienTai >= toiDa) return "badge bg-danger";
            if (hienTai >= toiDa * 0.8) return "badge bg-warning text-dark";
            return "badge bg-success bg-opacity-75";
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            pnlThongBao.Visible = false;
            LoadDataLichTap();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlFilterPT.SelectedIndex = 0;
            txtFilterNgay.Text = "";
            pnlThongBao.Visible = false;
            LoadDataLichTap();
        }

        protected void btnSaveLichTap_Click(object sender, EventArgs e)
        {
            int idCTG = int.Parse(ddlChiTietGoi.SelectedValue);
            int idMNV = int.Parse(ddlPT.SelectedValue);
            string khungGio = ddlKhungGio.SelectedValue;
            string danhGia = txtDanhGiaBuoi.Text.Trim();

            DateTime ngayTap;
            if (!DateTime.TryParse(txtNgayTap.Text, out ngayTap))
            {
                HienThongBao("Vui lòng chọn ngày tập hợp lệ!", "danger");
                return;
            }

            int soLuongHV;
            if (!int.TryParse(txtSoLuongHV.Text, out soLuongHV) || soLuongHV < 0)
            {
                HienThongBao("Số lượng hội viên phải lớn hơn hoặc bằng 0!", "danger");
                return;
            }

            string mode = hfMode.Value;

            using (SqlConnection conn = new SqlConnection(GetConnStr()))
            {
                conn.Open();

                using (SqlCommand cmdMax = new SqlCommand("SELECT SoLuongHVToiDa FROM CHI_TIET_DANG_KI WHERE ID_CTG = @ctg", conn))
                {
                    cmdMax.Parameters.AddWithValue("@ctg", idCTG);
                    int toiDa = Convert.ToInt32(cmdMax.ExecuteScalar());
                    if (soLuongHV > toiDa)
                    {
                        HienThongBao($"Lớp này chỉ cho phép tối đa <b>{toiDa}</b> hội viên (bạn đang nhập {soLuongHV}).", "warning");
                        return;
                    }
                }

                if (mode == "ADD")
                {
                    string sqlCheckPT = @"SELECT COUNT(*) FROM LK_LICH_TAP 
                                          WHERE ID_MNV = @mnv AND NgayTap = @ngay AND KhungGio = @gio";
                    using (SqlCommand cmdChk = new SqlCommand(sqlCheckPT, conn))
                    {
                        cmdChk.Parameters.AddWithValue("@mnv", idMNV);
                        cmdChk.Parameters.Add("@ngay", SqlDbType.Date).Value = ngayTap.Date;
                        cmdChk.Parameters.AddWithValue("@gio", khungGio);
                        if (Convert.ToInt32(cmdChk.ExecuteScalar()) > 0)
                        {
                            HienThongBao("Huấn luyện viên này đã có lịch dạy vào khung giờ đó rồi!", "warning");
                            return;
                        }
                    }

                    string sqlInsert = @"INSERT INTO LK_LICH_TAP (ID_CTG, ID_MNV, NgayTap, KhungGio, SoLuongHV, DanhGiaBuoi)
                                         VALUES (@ctg, @mnv, @ngay, @gio, @sl, @dg)";
                    using (SqlCommand cmdIns = new SqlCommand(sqlInsert, conn))
                    {
                        cmdIns.Parameters.AddWithValue("@ctg", idCTG);
                        cmdIns.Parameters.AddWithValue("@mnv", idMNV);
                        cmdIns.Parameters.Add("@ngay", SqlDbType.Date).Value = ngayTap.Date;
                        cmdIns.Parameters.AddWithValue("@gio", khungGio);
                        cmdIns.Parameters.AddWithValue("@sl", soLuongHV);
                        cmdIns.Parameters.AddWithValue("@dg", danhGia);
                        cmdIns.ExecuteNonQuery();
                    }

                    HienThongBao("Đặt lịch tập mới thành công!", "success");
                }
                else if (mode == "EDIT")
                {
                    int oldCTG = int.Parse(hfOldCTG.Value);
                    int oldMNV = int.Parse(hfOldMNV.Value);
                    DateTime oldNgay = DateTime.Parse(hfOldNgay.Value);
                    string oldGio = hfOldGio.Value;

                    string sqlCheckEdit = @"
                        SELECT COUNT(*) FROM LK_LICH_TAP 
                        WHERE ID_MNV = @mnv AND NgayTap = @ngay AND KhungGio = @gio
                          AND NOT (ID_CTG = @oldCtg AND ID_MNV = @oldMnv AND NgayTap = @oldNgay AND KhungGio = @oldGio)";
                    using (SqlCommand cmdChk = new SqlCommand(sqlCheckEdit, conn))
                    {
                        cmdChk.Parameters.AddWithValue("@mnv", idMNV);
                        cmdChk.Parameters.Add("@ngay", SqlDbType.Date).Value = ngayTap.Date;
                        cmdChk.Parameters.AddWithValue("@gio", khungGio);
                        cmdChk.Parameters.AddWithValue("@oldCtg", oldCTG);
                        cmdChk.Parameters.AddWithValue("@oldMnv", oldMNV);
                        cmdChk.Parameters.Add("@oldNgay", SqlDbType.Date).Value = oldNgay.Date;
                        cmdChk.Parameters.AddWithValue("@oldGio", oldGio);

                        if (Convert.ToInt32(cmdChk.ExecuteScalar()) > 0)
                        {
                            HienThongBao("Trùng lịch dạy của Huấn luyện viên ở khung giờ mới chọn!", "warning");
                            return;
                        }
                    }

                    string sqlUpdate = @"
                        UPDATE LK_LICH_TAP
                        SET ID_CTG = @ctg, ID_MNV = @mnv, NgayTap = @ngay, KhungGio = @gio,
                            SoLuongHV = @sl, DanhGiaBuoi = @dg
                        WHERE ID_CTG = @oldCtg AND ID_MNV = @oldMnv AND NgayTap = @oldNgay AND KhungGio = @oldGio";
                    using (SqlCommand cmdUpd = new SqlCommand(sqlUpdate, conn))
                    {
                        cmdUpd.Parameters.AddWithValue("@ctg", idCTG);
                        cmdUpd.Parameters.AddWithValue("@mnv", idMNV);
                        cmdUpd.Parameters.Add("@ngay", SqlDbType.Date).Value = ngayTap.Date;
                        cmdUpd.Parameters.AddWithValue("@gio", khungGio);
                        cmdUpd.Parameters.AddWithValue("@sl", soLuongHV);
                        cmdUpd.Parameters.AddWithValue("@dg", danhGia);

                        cmdUpd.Parameters.AddWithValue("@oldCtg", oldCTG);
                        cmdUpd.Parameters.AddWithValue("@oldMnv", oldMNV);
                        cmdUpd.Parameters.Add("@oldNgay", SqlDbType.Date).Value = oldNgay.Date;
                        cmdUpd.Parameters.AddWithValue("@oldGio", oldGio);
                        cmdUpd.ExecuteNonQuery();
                    }

                    HienThongBao("Cập nhật lịch tập thành công!", "success");
                }
            }

            LoadThongKe();
            LoadDataLichTap();
        }

        protected void gvLichTap_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            DataKey key = gvLichTap.DataKeys[index];

            int idCTG = Convert.ToInt32(key["ID_CTG"]);
            int idMNV = Convert.ToInt32(key["ID_MNV"]);
            DateTime ngayTap = Convert.ToDateTime(key["NgayTap"]);
            string khungGio = key["KhungGio"].ToString();

            if (e.CommandName == "SuaLich")
            {
                using (SqlConnection conn = new SqlConnection(GetConnStr()))
                {
                    string sql = @"SELECT * FROM LK_LICH_TAP 
                                   WHERE ID_CTG = @ctg AND ID_MNV = @mnv AND NgayTap = @ngay AND KhungGio = @gio";
                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@ctg", idCTG);
                        cmd.Parameters.AddWithValue("@mnv", idMNV);
                        cmd.Parameters.Add("@ngay", SqlDbType.Date).Value = ngayTap.Date;
                        cmd.Parameters.AddWithValue("@gio", khungGio);

                        conn.Open();
                        using (SqlDataReader rd = cmd.ExecuteReader())
                        {
                            if (rd.Read())
                            {
                                hfMode.Value = "EDIT";
                                hfOldCTG.Value = idCTG.ToString();
                                hfOldMNV.Value = idMNV.ToString();
                                hfOldNgay.Value = ngayTap.ToString("yyyy-MM-dd");
                                hfOldGio.Value = khungGio;

                                ddlChiTietGoi.SelectedValue = idCTG.ToString();
                                ddlPT.SelectedValue = idMNV.ToString();
                                txtNgayTap.Text = ngayTap.ToString("yyyy-MM-dd");

                                if (ddlKhungGio.Items.FindByValue(khungGio) == null)
                                    ddlKhungGio.Items.Add(new ListItem(khungGio, khungGio));
                                ddlKhungGio.SelectedValue = khungGio;

                                txtSoLuongHV.Text = rd["SoLuongHV"].ToString();
                                txtDanhGiaBuoi.Text = rd["DanhGiaBuoi"].ToString();
                                litModalTitle.Text = "Cập Nhật Lịch Tập";

                                ClientScript.RegisterStartupScript(this.GetType(), "OpenEditModal", "showModal();", true);
                            }
                        }
                    }
                }
            }
            else if (e.CommandName == "XoaLich")
            {
                using (SqlConnection conn = new SqlConnection(GetConnStr()))
                {
                    string sqlDel = @"DELETE FROM LK_LICH_TAP 
                                      WHERE ID_CTG = @ctg AND ID_MNV = @mnv AND NgayTap = @ngay AND KhungGio = @gio";
                    using (SqlCommand cmd = new SqlCommand(sqlDel, conn))
                    {
                        cmd.Parameters.AddWithValue("@ctg", idCTG);
                        cmd.Parameters.AddWithValue("@mnv", idMNV);
                        cmd.Parameters.Add("@ngay", SqlDbType.Date).Value = ngayTap.Date;
                        cmd.Parameters.AddWithValue("@gio", khungGio);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                HienThongBao("Đã xóa buổi tập khỏi lịch!", "info");
                LoadThongKe();
                LoadDataLichTap();
            }
        }
    }
}
