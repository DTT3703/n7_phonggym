# 🏋️‍♂️ HỆ THỐNG QUẢN LÝ PHÒNG GYM (n7_phonggym)

> **Dự án số hóa quy trình vận hành phòng Gym:** Giúp tối ưu hóa nguồn lực, quản lý hội viên, lịch tập PT, bảo trì thiết bị và theo dõi doanh thu theo thời gian thực.

---

## 👥 1. Phân Công Nhân Sự Dự Án

| Thành viên | Trách nhiệm & Phụ trách |
| :--- | :--- |
| **Nguyễn Tấn Đạt** | Tổng quan hệ thống, Quản lý Hệ thống (Admin/Chủ sở hữu) |
| **Lê Thanh Huy** | Quản lý Nhân viên, Lịch tập, Huấn luyện viên (PT) |
| **Dương Thanh Toàn** | Quản lý Hội viên, Gói tập & Dịch vụ |

---

## 🎯 2. Mục Đích Dự Án

Trong bối cảnh ngành thể hình phát triển mạnh mẽ, việc vận hành phòng gym bằng sổ sách hay Excel bộc lưu nhiều hạn chế (thất thoát doanh thu, khó kiểm soát hội viên, trùng lịch PT, thiếu báo cáo). Hệ thống này được xây dựng nhằm:
- **Số hóa toàn bộ quy trình vận hành** từ check-in đến báo cáo doanh thu.
- **Tối ưu hóa nguồn lực** và nâng cao trải nghiệm của hội viên.

---

## 🔐 3. Phân Quyền Hệ Thống (Access Levels)

1. **Chủ sở hữu / Admin hệ thống (Full Access):** Quản lý toàn bộ hệ thống, chi nhánh, nhân sự, cấu hình tham số và phê duyệt chính sách.
2. **Quản lý Chi nhánh (Branch Manager):** Quản lý nhân viên, hội viên, doanh thu chi nhánh và thiết bị.
3. **Nhân viên Lễ tân (Receptionist):** Check-in/out khách hàng, đăng ký gói tập, quản lý tủ đồ (Locker), bán lẻ dịch vụ/sản phẩm bổ sung.
4. **Huấn luyện viên cá nhân (PT):** Quản lý lịch tập 1-on-1, theo dõi chỉ số cơ thể (InBody), xây dựng giáo án, check-in ca dạy.
5. **Nhân viên Kỹ thuật & Bảo trì:** Quản lý máy móc, cơ sở vật chất, lên lịch bảo dưỡng và cập nhật trạng thái thiết bị.
6. **Kế toán / Tạp vụ:** Quản lý thu chi, hóa đơn, lương thưởng, vật tư vệ sinh và báo cáo tài chính.

---

## ⚙️ 4. Các Phân Hệ Chức Năng Chính

* **Phân hệ Quản lý Hội viên:** Hồ sơ hội viên, thẻ/gói tập, điểm danh (QR code/Thẻ từ/FaceID), quản lý tủ đồ (Locker).
* **Phân hệ Quản lý PT & Lịch tập:** Đặt lịch tập 1-on-1 (cảnh báo trùng lịch), theo dõi chỉ số InBody, xây dựng giáo án & dinh dưỡng, chấm công ca dạy.
* **Phân hệ Bán hàng & Dịch vụ:** Thanh toán hóa đơn, bán lẻ thực phẩm bổ sung (Whey, BCAA), nước uống, quản lý Voucher/Referral.
* **Phân hệ Quản lý Cơ sở vật chất:** Danh mục thiết bị (Series, hạn bảo hành), theo dõi trạng thái thiết bị, lịch bảo trì định kỳ.
* **Phân hệ Báo cáo & Thống kê:** Doanh thu (ngày/tháng/gói tập), KPI nhân viên & ca dạy PT, báo cáo hội viên (mới, gia hạn, churn rate).

---

## 🗄️ 5. Đặc Tả Cơ Sở Dữ Liệu (Database Schema)

### 📌 Danh Sách Các Bảng Chức Năng

#### 1. Bảng `HỘI_VIÊN`
* `ID_MHV` (INT, PK): Mã hội viên
* `HoTen` (NVARCHAR(100)): Họ tên hội viên
* `NgaySinh` (DATE): Ngày sinh
* `GioiTinh` (NVARCHAR(10)): Giới tính
* `DiaChi` (NVARCHAR(255)): Địa chỉ

#### 2. Bảng `GÓI_TẬP`
* `ID_MGT` (INT, PK): Mã gói tập
* `TenGoiTap` (NVARCHAR(100)): Tên gói tập
* `SoThang` (INT): Thời hạn gói (tháng)
* `SoLuotPT` (INT): Số lượt tập cùng PT
* `SoLuotTuDo` (INT): Số lượt tập tự do
* `MucGia` (DECIMAL(12,2)): Giá gói tập

#### 3. Bảng `CHI_TIẾT_GÓI`
* `ID_CTG` (INT, PK): Mã chi tiết gói
* `ID_MGT` (INT, FK): Mã gói tập
* `TenChiTietGoi` (NVARCHAR(100)): Tên chi tiết gói
* `SoLuongHVTốiDa` (INT): Số lượng hội viên tối đa

#### 4. Bảng `LK_ĐĂNG_KÝ`
* `ID_MHV` (INT, PK, FK): Mã hội viên
* `ID_CTG` (INT, PK, FK): Mã chi tiết gói
* `NgayKichHoat` (DATE): Ngày bắt đầu
* `NgayHetHan` (DATE): Ngày kết thúc
* `SoLuotConLai` (INT): Số lượt tập còn lại
* `TrangThai` (NVARCHAR(30)): Trạng thái đăng ký

#### 5. Bảng `NHÂN_VIÊN`
* `ID_MNV` (INT, PK): Mã nhân viên
* `HoTen` (NVARCHAR(100)): Họ tên nhân viên
* `NgaySinh` (DATE): Ngày sinh
* `GioiTinh` (NVARCHAR(10)): Giới tính
* `TrinhDo` (NVARCHAR(100)): Trình độ chuyên môn
* `ChuyenMon` (NVARCHAR(100)): Lĩnh vực chuyên môn

#### 6. Bảng `LK_LỊCH_TẬP`
* `ID_CTG` (INT, PK, FK): Mã chi tiết gói
* `ID_MNV` (INT, PK, FK): Mã nhân viên (PT)
* `NgayTap` (DATE, PK): Ngày tập
* `KhungGio` (NVARCHAR(50), PK): Khung giờ tập
* `SoLuongHV` (INT): Số lượng hội viên
* `DanhGiaBuoi` (NVARCHAR(500)): Đánh giá buổi tập

#### 7. Bảng `HUẤN_LUYỆN_VIÊN`
* `ID_MNV` (INT, PK, FK): Mã nhân viên (Kế thừa từ NHÂN_VIÊN)
* `GiaBieuDay` (DECIMAL(12,2)): Giá biểu dạy
* `HeSoHoaHong` (DECIMAL(5,2)): Hệ số hoa hồng

#### 8. Bảng `PT_CHUYÊN_GIA`
* `ID_MNV` (INT, PK, FK): Mã nhân viên (Kế thừa từ HUẤN_LUYỆN_VIÊN)
* `PhuCapVIP` (DECIMAL(12,2)): Phụ cấp VIP
* `HeSoKinhNghiem` (DECIMAL(5,2)): Hệ số kinh nghiệm

---

## 🛠️ Hướng Dẫn Cài Đặt & Chạy Dự Án

1. **Clone Repository:**
   ```bash
   git clone [https://github.com/DTT3703/n7_phonggym.git](https://github.com/DTT3703/n7_phonggym.git)
