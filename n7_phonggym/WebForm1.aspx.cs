using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Web.Services;

namespace n7_phonggym
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        // Giá trị trạng thái - trùng với CHECK constraint của bảng LK_DANG_KY
        private const string TT_HIEU_LUC = "Đang hiệu lực";
        private const string TT_HET_HAN = "Hết hạn";
        private const string TT_DA_HUY = "Đã hủy";
        private const string TT_SAP_HET = "Sắp hết hạn";   // chỉ dùng để hiển thị
        private const int NGAY_SAP_HET_HAN = 7;            // còn <= 7 ngày là "sắp hết hạn"
        private const int SO_DONG_HIEN_THI = 10;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        // Lấy các đăng ký gói tập gần đây từ SQL cho bảng trên trang
        [WebMethod]
        public static RegistrationList GetRecentRegistrations()
        {
            RegistrationList result = new RegistrationList();
            result.Rows = new List<RegRow>();

            const string sql = @"
DECLARE @today date = CAST(GETDATE() AS date);
SELECT TOP (@Top)
    hv.ID_MHV,
    hv.HoTen,
    gt.TenGoiTap,
    ct.TenChiTietGoi,
    dk.NgayKichHoat,
    dk.NgayHetHan,
    DATEDIFF(DAY, @today, dk.NgayHetHan) AS ConNgay,
    CASE
        WHEN dk.TrangThai = @DaHuy THEN @DaHuy
        WHEN dk.TrangThai = @HetHan OR dk.NgayHetHan < @today THEN @HetHan
        WHEN dk.NgayHetHan <= DATEADD(DAY, @Canh, @today) THEN @SapHet
        ELSE @HieuLuc
    END AS TrangThaiHienThi
FROM LK_DANG_KY dk
JOIN HOI_VIEN hv ON hv.ID_MHV = dk.ID_MHV
JOIN CHI_TIET_DANG_KI ct ON ct.ID_CTG = dk.ID_CTG
JOIN GOI_TAP gt ON gt.ID_MGT = ct.ID_MGT
ORDER BY dk.NgayKichHoat DESC, hv.ID_MHV DESC;";

            try
            {
                using (SqlConnection conn = OpenConnection())
                {
                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.Add("@Top", SqlDbType.Int).Value = SO_DONG_HIEN_THI;
                        cmd.Parameters.Add("@HieuLuc", SqlDbType.NVarChar, 30).Value = TT_HIEU_LUC;
                        cmd.Parameters.Add("@HetHan", SqlDbType.NVarChar, 30).Value = TT_HET_HAN;
                        cmd.Parameters.Add("@DaHuy", SqlDbType.NVarChar, 30).Value = TT_DA_HUY;
                        cmd.Parameters.Add("@SapHet", SqlDbType.NVarChar, 30).Value = TT_SAP_HET;
                        cmd.Parameters.Add("@Canh", SqlDbType.Int).Value = NGAY_SAP_HET_HAN;

                        using (SqlDataReader rd = cmd.ExecuteReader())
                        {
                            while (rd.Read())
                            {
                                RegRow r = new RegRow();
                                r.MaHV = "HV" + rd.GetInt32(0).ToString(CultureInfo.InvariantCulture);
                                r.HoTen = rd.GetString(1);
                                r.TenGoi = rd.GetString(2);
                                r.TenChiTiet = rd.GetString(3);
                                r.NgayKichHoat = rd.GetDateTime(4).ToString("dd/MM/yyyy", CultureInfo.InvariantCulture);
                                r.NgayHetHan = rd.GetDateTime(5).ToString("dd/MM/yyyy", CultureInfo.InvariantCulture);
                                r.ConNgay = rd.GetInt32(6);
                                r.TrangThai = rd.GetString(7);
                                result.Rows.Add(r);
                            }
                        }
                    }

                    using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM LK_DANG_KY", conn))
                    {
                        result.Total = Convert.ToInt32(cmd.ExecuteScalar());
                    }
                }
                result.Ok = true;
            }
            catch (Exception ex)
            {
                result.Ok = false;
                result.Message = "Không đọc được CSDL: " + ex.Message;
            }
            return result;
        }

        private static SqlConnection OpenConnection()
        {
            // Ưu tiên chuỗi kết nối tên "n7_phongGym" trong Web.config, nếu không có thì dùng mặc định
            ConnectionStringSettings cs = ConfigurationManager.ConnectionStrings["n7_phongGym"];
            string str = (cs != null)
                ? cs.ConnectionString
                : @"Data Source=.\SQLEXPRESS;Initial Catalog=n7_phongGym;Integrated Security=True";
            SqlConnection conn = new SqlConnection(str);
            conn.Open();
            return conn;
        }
    }

    public class RegistrationList
    {
        public bool Ok { get; set; }
        public string Message { get; set; }
        public int Total { get; set; }
        public List<RegRow> Rows { get; set; }
    }

    public class RegRow
    {
        public string MaHV { get; set; }
        public string HoTen { get; set; }
        public string TenGoi { get; set; }
        public string TenChiTiet { get; set; }
        public string NgayKichHoat { get; set; }
        public string NgayHetHan { get; set; }
        public int ConNgay { get; set; }
        public string TrangThai { get; set; }
    }
}
