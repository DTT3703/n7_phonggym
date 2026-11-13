<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CaiDatHeThong.aspx.cs" Inherits="n7_phonggym.CaiDatHeThong" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="vi">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Cài Đặt Hệ Thống - Phòng Gym Admin Panel</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet" />

    <style>
        :root {
            --sidebar-bg: #10854d;
            --sidebar-hover: #0c6b3e;
            --sidebar-active: #0d6efd;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
        }

        /* Sidebar Styling đồng bộ với WebForm1.aspx */
        .sidebar {
            width: 250px;
            background-color: var(--sidebar-bg);
            min-height: 100vh;
            color: #fff;
            transition: all 0.3s;
        }

        .sidebar .brand-title {
            font-size: 1.25rem;
            font-weight: bold;
            padding: 20px 15px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .sidebar .nav-link {
            color: rgba(255, 255, 255, 0.85);
            padding: 12px 20px;
            margin: 4px 10px;
            border-radius: 6px;
            font-weight: 500;
        }

        .sidebar .nav-link:hover {
            color: #fff;
            background-color: var(--sidebar-hover);
        }

        .sidebar .nav-link.active {
            color: #fff;
            background-color: var(--sidebar-active);
        }

        .sidebar-footer {
            margin-top: auto;
            padding: 15px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }

        /* Top Header */
        .top-header {
            background-color: #fff;
            padding: 15px 30px;
            border-bottom: 1px solid #e9ecef;
        }

        .main-content {
            padding: 30px;
        }

        .logo-preview-box {
            width: 110px;
            height: 110px;
            border: 2px dashed #ced4da;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            background-color: #f8f9fa;
            flex-shrink: 0;
        }

        .logo-preview-box img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        footer.main-footer {
            text-align: center;
            padding: 15px;
            color: #6c757d;
            font-size: 0.875rem;
            margin-top: auto;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" onsubmit="return false;">
        <div class="d-flex">
            <!-- Sidebar Navigation -->
            <nav class="sidebar d-flex flex-column flex-shrink-0">
                <div class="brand-title d-flex align-items-center">
                    <i class="bi bi-activity me-2"></i>Admin Panel
                </div>

                <ul class="nav nav-pills flex-column mb-auto mt-2">
                    <li class="nav-item">
                        <a href="WebForm1.aspx" class="nav-link">
                            <i class="bi bi-speedometer2 me-2"></i>Tổng quan
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="QuanLyHoiVien.aspx" class="nav-link">
                            <i class="bi bi-people me-2"></i>Quản lý hội viên
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="GoiTap.aspx" class="nav-link">
                            <i class="bi bi-box-seam me-2"></i>Gói tập & Dịch vụ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="LichTap.aspx" class="nav-link">
                            <i class="bi bi-calendar-week me-2"></i>Lịch tập & PT
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="Nhanvien.aspx" class="nav-link">
                            <i class="bi bi-person-badge me-2"></i>Nhân viên
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="CaiDatHeThong.aspx" class="nav-link active">
                            <i class="bi bi-gear me-2"></i>Cài đặt hệ thống
                        </a>
                    </li>
                </ul>

                <!-- Dropdown Profile -->
                <div class="sidebar-footer">
                    <div class="dropdown">
                        <a href="#" class="d-flex align-items-center text-white text-decoration-none dropdown-toggle" id="dropdownUser" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-person-circle fs-4 me-2"></i>
                            <strong>Administrator</strong>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-dark text-small shadow" aria-labelledby="dropdownUser">
                            <li><a class="dropdown-item" href="#"><i class="bi bi-person me-2"></i>Hồ sơ</a></li>
                            <li><a class="dropdown-item" href="CaiDatHeThong.aspx"><i class="bi bi-gear me-2"></i>Cài đặt</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="#"><i class="bi bi-box-arrow-right me-2"></i>Đăng xuất</a></li>
                        </ul>
                    </div>
                </div>
            </nav>

            <!-- Main Content Container -->
            <div class="w-100 d-flex flex-column min-vh-100">
                <!-- Top Header -->
                <header class="top-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 fw-bold">Cài Đặt & Cấu Hình Hệ Thống</h5>
                    <span class="text-muted small"><i class="bi bi-clock me-1"></i><span id="liveClock"><%= DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") %></span></span>
                </header>

                <!-- Page Body Content -->
                <main class="main-content flex-grow-1">
                    <!-- Nav Tabs -->
                    <ul class="nav nav-tabs mb-4" id="settingTabs" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active fw-semibold" id="info-tab" data-bs-toggle="tab" data-bs-target="#info-tab-pane" type="button" role="tab">
                                <i class="bi bi-building me-1"></i> Thông Tin Phòng Gym
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link fw-semibold" id="payment-tab" data-bs-toggle="tab" data-bs-target="#payment-tab-pane" type="button" role="tab">
                                <i class="bi bi-credit-card me-1"></i> Cổng Thanh Toán QR
                            </button>
                        </li>
                    </ul>

                    <div class="tab-content" id="settingTabsContent">
                        <!-- Tab 1: Thông tin phòng Gym -->
                        <div class="tab-pane fade show active" id="info-tab-pane" role="tabpanel">
                            <!-- Card 1: Cấu hình thông tin cơ sở & Upload Logo -->
                            <div class="card shadow-sm border-0 mb-4">
                                <div class="card-body p-4">
                                    <h6 class="fw-bold mb-3 text-success">
                                        <i class="bi bi-info-circle me-1"></i> Cấu hình thông tin cơ sở
                                    </h6>

                                    <!-- Upload Logo -->
                                    <div class="d-flex flex-wrap align-items-center gap-4 mb-4 pb-3 border-bottom">
                                        <div class="logo-preview-box">
                                            <img id="imgLogoPreview" src="data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='110' height='110'><rect width='100%' height='100%' fill='%2310854d'/><text x='50%' y='54%' font-size='22' font-family='Arial' font-weight='bold' fill='white' text-anchor='middle'>N7 GYM</text></svg>" alt="Logo Phòng Gym" />
                                        </div>
                                        <div>
                                            <label class="form-label fw-semibold mb-1" for="inpLogo">Logo & Ảnh đại diện cơ sở</label>
                                            <p class="text-muted small mb-2">Hiển thị trên phiếu thu, hóa đơn in và trang chủ (JPG, PNG, WEBP - Tối đa 2MB).</p>
                                            <div class="d-flex align-items-center gap-2">
                                                <input type="file" id="inpLogo" class="form-control form-control-sm" accept=".jpg,.jpeg,.png,.webp" />
                                                <button type="button" id="btnResetLogo" class="btn btn-sm btn-outline-secondary">Mặc định</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Thông tin chi tiết -->
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label class="form-label" for="txtTenGym">Tên Phòng Gym / Chi Nhánh</label>
                                            <input type="text" id="txtTenGym" class="form-control" value="Hệ Thống Phòng Gym N7 Fitness" />
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label" for="txtHotline">Số Điện Thoại Hotline</label>
                                            <input type="text" id="txtHotline" class="form-control" value="1900 6789" />
                                        </div>
                                        <div class="col-md-12">
                                            <label class="form-label" for="txtDiaChiGym">Địa Chỉ Chi Nhánh</label>
                                            <input type="text" id="txtDiaChiGym" class="form-control" value="123 Đường Số 7, Phường Linh Trung, TP. Thủ Đức, TP.HCM" />
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label" for="txtGioMoCua">Giờ Mở Cửa</label>
                                            <input type="text" id="txtGioMoCua" class="form-control" value="05:30 - 21:30" />
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label" for="txtEmailGym">Email Liên Hệ</label>
                                            <input type="email" id="txtEmailGym" class="form-control" value="contact@n7fitness.com" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Card 2: Cấu hình ngày nghỉ / lễ -->
                            <div class="card shadow-sm border-0">
                                <div class="card-body p-4">
                                    <div class="mb-3">
                                        <h6 class="fw-bold mb-1 text-success">
                                            <i class="bi bi-calendar-x me-1"></i> Cấu hình ngày nghỉ / lễ & Bảo trì
                                        </h6>
                                        <small class="text-muted">Danh sách ngày phòng gym đóng cửa để khóa đặt lịch tập & PT vào những ngày này.</small>
                                    </div>

                                    <!-- Form thêm ngày nghỉ -->
                                    <div class="row g-2 align-items-end mb-4 bg-light p-3 rounded border">
                                        <div class="col-md-3">
                                            <label class="form-label small fw-semibold" for="txtNgayNghi">Chọn ngày nghỉ</label>
                                            <input type="date" id="txtNgayNghi" class="form-control" />
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label small fw-semibold" for="txtLyDoNghi">Lý do / Ghi chú ngày lễ</label>
                                            <input type="text" id="txtLyDoNghi" class="form-control" placeholder="VD: Nghỉ lễ Quốc Khánh 2/9, Bảo trì thiết bị..." />
                                        </div>
                                        <div class="col-md-3">
                                            <button type="button" id="btnThemNgayNghi" class="btn btn-outline-success w-100 fw-semibold">
                                                <i class="bi bi-plus-circle me-1"></i>Thêm Ngày Nghỉ
                                            </button>
                                        </div>
                                    </div>

                                    <!-- Bảng danh sách ngày nghỉ -->
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-hover align-middle mb-0">
                                            <thead class="table-light">
                                                <tr>
                                                    <th style="width: 180px;">Ngày Nghỉ</th>
                                                    <th>Lý Do / Sự Kiện</th>
                                                    <th style="width: 110px;" class="text-center">Thao Tác</th>
                                                </tr>
                                            </thead>
                                            <tbody id="holidayTableBody">
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Tab 2: Cổng thanh toán QR -->
                        <div class="tab-pane fade" id="payment-tab-pane" role="tabpanel">
                            <div class="card shadow-sm border-0">
                                <div class="card-body p-4">
                                    <h6 class="fw-bold mb-3 text-success">
                                        <i class="bi bi-qr-code-scan me-1"></i> Cấu hình thanh toán VietQR / Ngân hàng
                                    </h6>
                                    <div class="row g-4 align-items-center">
                                        <div class="col-md-8">
                                            <div class="row g-3">
                                                <div class="col-md-6">
                                                    <label class="form-label" for="selBankCode">Ngân Hàng thụ hưởng</label>
                                                    <select id="selBankCode" class="form-select">
                                                        <option value="MB">MBBank (Ngân hàng Quân Đội)</option>
                                                        <option value="VCB">Vietcombank (Ngoại Thương)</option>
                                                        <option value="TCB">Techcombank (Kỹ Thương)</option>
                                                        <option value="ACB">ACB (Á Châu)</option>
                                                        <option value="BIDV">BIDV (Đầu tư & Phát triển)</option>
                                                        <option value="VPB">VPBank (Việt Nam Thịnh Vượng)</option>
                                                    </select>
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="form-label" for="txtAccountNumber">Số Tài Khoản</label>
                                                    <input type="text" id="txtAccountNumber" class="form-control" value="999988887777" />
                                                </div>
                                                <div class="col-md-12">
                                                    <label class="form-label" for="txtAccountName">Tên Chủ Tài Khoản (Không dấu)</label>
                                                    <input type="text" id="txtAccountName" class="form-control text-uppercase" value="CTY TNHH PHONG GYM N7" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4 text-center">
                                            <div class="p-3 border rounded bg-light">
                                                <div class="small fw-semibold text-muted mb-2">Xem trước mã VietQR</div>
                                                <img id="imgVietQR" src="" alt="Mã VietQR" class="img-fluid rounded border bg-white p-1" style="max-height: 190px;" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Nút Lưu Cài Đặt (Đã đồng bộ tiếng Việt) -->
                    <div class="mt-4 d-flex justify-content-end gap-2">
                        <button type="button" id="btnRestoreDefault" class="btn btn-outline-secondary px-3 py-2">
                            Khôi phục mặc định
                        </button>
                        <button type="button" id="btnSaveSettings" class="btn btn-success px-4 py-2 fw-semibold">
                            <i class="bi bi-check2-circle me-1"></i>Lưu Cấu Hình Hệ Thống
                        </button>
                    </div>
                </main>

                <footer class="main-footer">
                    © 2026 - Giao diện quản trị Admin WebForms.
                </footer>
            </div>
        </div>

        <!-- Toast thông báo giống WebForm1.aspx -->
        <div class="toast-container position-fixed bottom-0 end-0 p-3">
            <div id="appToast" class="toast align-items-center text-bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="d-flex">
                    <div class="toast-body" id="toastMsg"></div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Đóng"></button>
                </div>
            </div>
        </div>
    </form>

    <!-- Bootstrap 5 JavaScript Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        (function () {
            'use strict';

            var KEY_SETTINGS = 'gym_settings_v1';
            var DEFAULT_LOGO = "data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='110' height='110'><rect width='100%' height='100%' fill='%2310854d'/><text x='50%' y='54%' font-size='22' font-family='Arial' font-weight='bold' fill='white' text-anchor='middle'>N7 GYM</text></svg>";

            var DEFAULT_SETTINGS = {
                tenGym: 'Hệ Thống Phòng Gym N7 Fitness',
                hotline: '1900 6789',
                diaChi: '123 Đường Số 7, Phường Linh Trung, TP. Thủ Đức, TP.HCM',
                gioMoCua: '05:30 - 21:30',
                email: 'contact@n7fitness.com',
                logo: DEFAULT_LOGO,
                bankCode: 'MB',
                accountNumber: '999988887777',
                accountName: 'CTY TNHH PHONG GYM N7',
                holidays: [
                    { date: '2026-09-02', reason: 'Nghỉ lễ Quốc Khánh 2/9' }
                ]
            };

            function $(id) { return document.getElementById(id); }
            function pad(n) { return n < 10 ? '0' + n : '' + n; }
            function fmtDate(iso) { var p = iso.split('-'); return p[2] + '/' + p[1] + '/' + p[0]; }
            function esc(s) {
                return String(s).replace(/[&<>"']/g, function (c) {
                    return {
                        '&': '&', '<': '<', '>': '>', '"': '"', "'": ''' }[c];
            });
            }

            var toastObj = new bootstrap.Toast($('appToast'), { delay: 3000 });
            function toast(msg, color) {
                var t = $('appToast');
                t.className = 'toast align-items-center border-0 text-bg-' + (color || 'success');
                $('toastMsg').textContent = msg;
                toastObj.show();
            }

            function loadSettings() {
                try {
                    var raw = localStorage.getItem(KEY_SETTINGS);
                    if (raw) {
                        var parsed = JSON.parse(raw);
                        return Object.assign({}, DEFAULT_SETTINGS, parsed);
                    }
                } catch (e) { }
                return JSON.parse(JSON.stringify(DEFAULT_SETTINGS));
            }

            function saveSettingsToStorage(data) {
                try {
                    localStorage.setItem(KEY_SETTINGS, JSON.stringify(data));
                    return true;
                } catch (e) {
                    toast('Dung lượng ảnh quá lớn, không thể lưu vào trình duyệt!', 'danger');
                    return false;
                }
            }

            var settings = loadSettings();

            /* ===================== HIỂN THỊ DỮ LIỆU ===================== */
            function renderForm() {
                $('txtTenGym').value = settings.tenGym;
                $('txtHotline').value = settings.hotline;
                $('txtDiaChiGym').value = settings.diaChi;
                $('txtGioMoCua').value = settings.gioMoCua;
                $('txtEmailGym').value = settings.email;
                $('imgLogoPreview').src = settings.logo || DEFAULT_LOGO;

                $('selBankCode').value = settings.bankCode || 'MB';
                $('txtAccountNumber').value = settings.accountNumber;
                $('txtAccountName').value = settings.accountName;

                updateVietQR();
                renderHolidays();
            }

            function updateVietQR() {
                var bank = $('selBankCode').value || 'MB';
                var accNo = encodeURIComponent($('txtAccountNumber').value.trim() || '999988887777');
                var accName = encodeURIComponent($('txtAccountName').value.trim() || 'PHONG GYM N7');
                $('imgVietQR').src = 'https://img.vietqr.io/image/' + bank + '-' + accNo + '-compact2.png?accountName=' + accName;
            }

            function renderHolidays() {
                var list = (settings.holidays || []).slice().sort(function (a, b) {
                    return a.date.localeCompare(b.date);
                });

                if (list.length === 0) {
                    $('holidayTableBody').innerHTML = '<tr><td colspan="3" class="text-center text-muted py-3">Hiện chưa có ngày nghỉ/lễ nào được thiết lập.</td></tr>';
                    return;
                }

                $('holidayTableBody').innerHTML = list.map(function (h) {
                    return '<tr>' +
                        '<td><span class="badge bg-danger-subtle text-danger border border-danger-subtle px-2 py-1 fs-6">' +
                        '<i class="bi bi-calendar-event me-1"></i>' + fmtDate(h.date) + '</span></td>' +
                        '<td>' + esc(h.reason) + '</td>' +
                        '<td class="text-center"><button type="button" class="btn btn-sm btn-outline-danger" data-del-date="' + esc(h.date) + '">' +
                        '<i class="bi bi-trash"></i> Xóa</button></td>' +
                        '</tr>';
                }).join('');
            }

            /* ===================== SỰ KIỆN UPLOAD LOGO ===================== */
            $('inpLogo').addEventListener('change', function () {
                var file = this.files && this.files[0];
                if (!file) return;
                if (file.size > 2 * 1024 * 1024) {
                    toast('Dung lượng ảnh vượt quá 2MB. Vui lòng chọn ảnh nhẹ hơn!', 'warning');
                    this.value = '';
                    return;
                }
                var reader = new FileReader();
                reader.onload = function (e) {
                    settings.logo = e.target.result;
                    $('imgLogoPreview').src = settings.logo;
                };
                reader.readAsDataURL(file);
            });

            $('btnResetLogo').addEventListener('click', function () {
                settings.logo = DEFAULT_LOGO;
                $('imgLogoPreview').src = DEFAULT_LOGO;
                $('inpLogo').value = '';
            });

            /* ===================== SỰ KIỆN NGÀY NGHỈ / LỄ ===================== */
            $('btnThemNgayNghi').addEventListener('click', function () {
                var dateVal = $('txtNgayNghi').value;
                var reasonVal = $('txtLyDoNghi').value.trim() || 'Nghỉ lễ / Bảo trì định kỳ';

                if (!dateVal) {
                    toast('Vui lòng chọn ngày nghỉ hợp lệ!', 'warning');
                    return;
                }

                var exists = settings.holidays.some(function (h) { return h.date === dateVal; });
                if (exists) {
                    toast('Ngày ' + fmtDate(dateVal) + ' đã có trong danh sách ngày nghỉ!', 'warning');
                    return;
                }

                settings.holidays.push({ date: dateVal, reason: reasonVal });
                saveSettingsToStorage(settings);

                $('txtNgayNghi').value = '';
                $('txtLyDoNghi').value = '';
                renderHolidays();
                toast('Đã thêm ngày nghỉ ' + fmtDate(dateVal));
            });

            $('holidayTableBody').addEventListener('click', function (e) {
                var btn = e.target.closest('[data-del-date]');
                if (!btn) return;
                var dateStr = btn.getAttribute('data-del-date');
                if (!confirm('Xóa ngày nghỉ ' + fmtDate(dateStr) + '?')) return;

                settings.holidays = settings.holidays.filter(function (h) { return h.date !== dateStr; });
                saveSettingsToStorage(settings);
                renderHolidays();
                toast('Đã xóa ngày nghỉ ' + fmtDate(dateStr), 'secondary');
            });

            /* ===================== LƯU TOÀN BỘ CẤU HÌNH ===================== */
            $('selBankCode').addEventListener('change', updateVietQR);
            $('txtAccountNumber').addEventListener('input', updateVietQR);
            $('txtAccountName').addEventListener('input', updateVietQR);

            $('btnSaveSettings').addEventListener('click', function () {
                var tenGym = $('txtTenGym').value.trim();
                if (!tenGym) {
                    toast('Tên phòng gym không được để trống!', 'warning');
                    $('txtTenGym').focus();
                    return;
                }

                settings.tenGym = tenGym;
                settings.hotline = $('txtHotline').value.trim();
                settings.diaChi = $('txtDiaChiGym').value.trim();
                settings.gioMoCua = $('txtGioMoCua').value.trim();
                settings.email = $('txtEmailGym').value.trim();
                settings.bankCode = $('selBankCode').value;
                settings.accountNumber = $('txtAccountNumber').value.trim();
                settings.accountName = $('txtAccountName').value.trim().toUpperCase();

                if (saveSettingsToStorage(settings)) {
                    toast('Đã lưu cấu hình hệ thống thành công!');
                }
            });

            $('btnRestoreDefault').addEventListener('click', function () {
                if (!confirm('Khôi phục toàn bộ cài đặt về mặc định ban đầu?')) return;
                settings = JSON.parse(JSON.stringify(DEFAULT_SETTINGS));
                saveSettingsToStorage(settings);
                renderForm();
                toast('Đã khôi phục cấu hình mặc định!', 'secondary');
            });

            /* ===================== ĐỒNG HỒ & KHỞI TẠO ===================== */
            setInterval(function () {
                var d = new Date();
                $('liveClock').textContent = pad(d.getDate()) + '/' + pad(d.getMonth() + 1) + '/' + d.getFullYear() +
                    ' ' + pad(d.getHours()) + ':' + pad(d.getMinutes()) + ':' + pad(d.getSeconds());
            }, 1000);

            renderForm();
        })();
    </script>
</body>
</html>
