<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="n7_phonggym.WebForm1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="vi">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Hệ Thống Quản Trị - Phòng Gym Admin Panel</title>

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

        /* Sidebar Styling */
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

        .status-badge {
            font-size: 0.875rem;
            color: #495057;
        }

        .status-dot {
            height: 10px;
            width: 10px;
            background-color: #198754;
            border-radius: 50%;
            display: inline-block;
            margin-left: 5px;
            animation: pulse 1.6s infinite;
        }

        @keyframes pulse {
            0% { box-shadow: 0 0 0 0 rgba(25, 135, 84, .6); }
            70% { box-shadow: 0 0 0 8px rgba(25, 135, 84, 0); }
            100% { box-shadow: 0 0 0 0 rgba(25, 135, 84, 0); }
        }

        .main-content {
            padding: 30px;
        }

        .card-stat {
            border: none;
            border-radius: 10px;
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
        }

        footer.main-footer {
            text-align: center;
            padding: 15px;
            color: #6c757d;
            font-size: 0.875rem;
            margin-top: auto;
        }

        /* Banner giới thiệu phòng gym */
        .gym-banner {
            position: relative;
            border-radius: 14px;
            overflow: hidden;
            min-height: 260px;
            display: flex;
            align-items: center;
            color: #fff;
            background-color: #0b3d25;
            background-image:
                linear-gradient(90deg, rgba(8, 40, 25, .88) 0%, rgba(8, 40, 25, .55) 55%, rgba(8, 40, 25, .15) 100%),
                url('https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&w=1600&q=80');
            background-size: cover;
            background-position: center;
            box-shadow: 0 .5rem 1rem rgba(0, 0, 0, .15);
        }

        .gym-banner .banner-inner {
            padding: 32px 40px;
            max-width: 680px;
        }

        .gym-banner h2 {
            font-weight: 800;
            letter-spacing: .5px;
        }

        .banner-chip {
            display: inline-block;
            background: rgba(255, 255, 255, .15);
            border: 1px solid rgba(255, 255, 255, .3);
            border-radius: 50px;
            padding: 4px 14px;
            margin: 0 8px 8px 0;
            font-size: .85rem;
            backdrop-filter: blur(4px);
        }

        /* Charts */
        .chart-box {
            position: relative;
            height: 280px;
        }

        .live-badge {
            font-size: .75rem;
            background: #dc3545;
            color: #fff;
            border-radius: 4px;
            padding: 2px 8px;
            animation: blink 1.2s infinite;
        }

        @keyframes blink {
            50% { opacity: .45; }
        }

        .value-bump {
            animation: bump .5s;
        }

        @keyframes bump {
            30% { transform: scale(1.12); color: #0d6efd; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" onsubmit="return false;">
        <div class="d-flex">
            <!-- Sidebar Navigation -->
            <nav class="sidebar d-flex flex-column flex-shrink-0">
                <div class="brand-title">
                    <i class="bi bi-activity me-2"></i>Admin Panel
                </div>

                <ul class="nav nav-pills flex-column mb-auto mt-2">
                    <li class="nav-item">
                        <a href="#" class="nav-link active">
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
                        <a href="CaiDatHeThong.aspx" class="nav-link">
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
                            <li><a class="dropdown-item" href="#"><i class="bi bi-gear me-2"></i>Cài đặt</a></li>
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
                    <div class="status-badge d-flex align-items-center">
                        <span>Hệ thống hoạt động ổn định</span>
                        <span class="status-dot ms-2"></span>
                    </div>
                    <div>
                        <span class="text-muted me-2"><i class="bi bi-clock me-1"></i><span id="liveClock"><%= DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") %></span></span>
                    </div>
                </header>

                <!-- Page Body Content -->
                <main class="main-content flex-grow-1">

                    <!-- Banner giới thiệu -->
                    <section class="gym-banner mb-4">
                        <div class="banner-inner">
                            <span class="banner-chip"><i class="bi bi-clock-history me-1"></i>Mở cửa 24/7</span>
                            <span class="banner-chip"><i class="bi bi-trophy me-1"></i>Huấn luyện viên chuyên nghiệp</span>
                            <h2 class="display-6 mb-2">Phòng Gym N7 – Rèn luyện sức khỏe, bứt phá giới hạn</h2>
                            <p class="mb-3 fs-6">
                                Hệ thống máy tập hiện đại, không gian rộng rãi, thoáng mát cùng đội ngũ PT tận tâm.
                                Đa dạng gói tập từ tự do đến PT 1-on-1, phù hợp mọi mục tiêu của bạn.
                            </p>
                            <button type="button" class="btn btn-light fw-semibold" data-bs-toggle="modal" data-bs-target="#modalDangKy">
                                <i class="bi bi-person-plus me-1"></i>Đăng ký hội viên ngay
                            </button>
                        </div>
                    </section>

                    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-2 pb-3 mb-4 border-bottom">
                        <h1 class="h2">Bảng điều khiển Quản lý Phòng Gym</h1>
                        <button type="button" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#modalDangKy">
                            <i class="bi bi-plus-circle me-1"></i>Đăng ký hội viên mới
                        </button>
                    </div>

                    <!-- Thống kê tổng quan (Cards) -->
                    <div class="row g-3 mb-4">
                        <div class="col-md-3">
                            <div class="card card-stat bg-white p-3 border-start border-4 border-primary">
                                <div class="text-muted small text-uppercase">Tổng hội viên</div>
                                <div class="fs-4 fw-bold text-dark" id="statTotal">1,248</div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card card-stat bg-white p-3 border-start border-4 border-success">
                                <div class="text-muted small text-uppercase">Doanh thu tháng</div>
                                <div class="fs-4 fw-bold text-dark" id="statRevenue">12,500,000 VNĐ</div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card card-stat bg-white p-3 border-start border-4 border-warning">
                                <div class="text-muted small text-uppercase">Lượt tập trong ngày</div>
                                <div class="fs-4 fw-bold text-dark" id="statSessions">86</div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card card-stat bg-white p-3 border-start border-4 border-info">
                                <div class="text-muted small text-uppercase">Gói sắp hết hạn</div>
                                <div class="fs-4 fw-bold text-dark" id="statExpiring">14</div>
                            </div>
                        </div>
                    </div>

                    <!-- Biểu đồ cập nhật liên tục -->
                    <div class="row g-3 mb-4">
                        <div class="col-lg-7">
                            <div class="card shadow-sm h-100">
                                <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                                    <h5 class="card-title mb-0 fw-bold"><i class="bi bi-graph-up-arrow me-2"></i>Số người đang tập (thời gian thực)</h5>
                                    <span class="live-badge">● LIVE 24/7</span>
                                </div>
                                <div class="card-body">
                                    <div class="chart-box"><canvas id="chartLive"></canvas></div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-5">
                            <div class="card shadow-sm h-100">
                                <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                                    <h5 class="card-title mb-0 fw-bold"><i class="bi bi-bar-chart me-2"></i>Lượt tập theo giờ trong ngày</h5>
                                    <span class="live-badge">● LIVE</span>
                                </div>
                                <div class="card-body">
                                    <div class="chart-box"><canvas id="chartHourly"></canvas></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Danh sách Đăng ký Gói tập gần đây -->
                    <div class="card shadow-sm">
                        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                            <h5 class="card-title mb-0 fw-bold"><i class="bi bi-list-check me-2"></i>Danh sách Đăng ký Gói tập gần đây</h5>
                            <span class="text-muted small" id="tableCount"></span>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-hover align-middle mb-0">
                                    <thead class="table-light">
                                        <tr>
                                            <th>Mã HV</th>
                                            <th>Họ tên Hội viên</th>
                                            <th>Số điện thoại</th>
                                            <th>Tên Gói tập</th>
                                            <th>Ngày kích hoạt</th>
                                            <th>Ngày hết hạn</th>
                                            <th>Trạng thái</th>
                                            <th class="text-end">Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody id="memberTableBody">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </main>

                <!-- Footer -->
                <footer class="main-footer">
                    &copy; 2026 - Giao diện quản trị Admin WebForms.
                </footer>
            </div>
        </div>

        <!-- Modal Đăng ký hội viên mới -->
        <div class="modal fade" id="modalDangKy" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title"><i class="bi bi-person-plus me-2"></i>Đăng ký hội viên mới</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Đóng"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label fw-semibold" for="inpName">Họ tên hội viên <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="inpName" maxlength="60" placeholder="Nhập họ và tên" />
                            <div class="invalid-feedback">Vui lòng nhập họ tên.</div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold" for="inpPhone">Số điện thoại <span class="text-danger">*</span></label>
                            <input type="tel" class="form-control" id="inpPhone" maxlength="11" placeholder="VD: 0912345678" />
                            <div class="invalid-feedback">Số điện thoại không hợp lệ (10 số, bắt đầu bằng 0).</div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold" for="selPackage">Gói tập <span class="text-danger">*</span></label>
                            <select class="form-select" id="selPackage"></select>
                        </div>
                        <div class="row g-3">
                            <div class="col-6">
                                <label class="form-label fw-semibold" for="inpStart">Ngày kích hoạt</label>
                                <input type="date" class="form-control" id="inpStart" />
                            </div>
                            <div class="col-6">
                                <label class="form-label fw-semibold" for="inpEnd">Ngày hết hạn (tự tính)</label>
                                <input type="text" class="form-control" id="inpEnd" readonly />
                            </div>
                        </div>
                        <div class="alert alert-success mt-3 mb-0 d-flex justify-content-between align-items-center">
                            <span>Thành tiền:</span>
                            <strong id="lblPrice">0 VNĐ</strong>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="button" class="btn btn-primary" id="btnSave"><i class="bi bi-check-circle me-1"></i>Lưu đăng ký</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Toast thông báo -->
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
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>

    <script>
    (function () {
        'use strict';

        /* ===================== CẤU HÌNH & DỮ LIỆU ===================== */
        var KEY_MEMBERS = 'gym_members_v1';
        var KEY_DAY = 'gym_day_v1';

        // Số liệu nền (hội viên cũ không hiển thị trong bảng gần đây)
        var BASE_MEMBERS = 1245;          // + 3 hội viên mẫu = 1,248
        var BASE_REVENUE = 12500000;      // doanh thu nền của tháng
        var BASE_EXPIRING = 14;           // số gói sắp hết hạn nền
        var BASE_SESSIONS = 86;           // lượt tập nền trong ngày
        var EXPIRING_DAYS = 7;            // còn <= 7 ngày là "sắp hết hạn"
        var MAX_ROWS = 10;                // số dòng hiển thị tối đa

        var PACKAGES = [
            { name: 'Gói Tập Tự Do 1 Tháng',  months: 1,  days: 0,  price: 500000 },
            { name: 'Gói Tập 3 Tháng',         months: 3,  days: 0,  price: 1300000 },
            { name: 'Gói Gym VIP 6 Tháng',     months: 6,  days: 0,  price: 3000000 },
            { name: 'Gói Tập 12 Tháng',        months: 12, days: 0,  price: 4500000 },
            { name: 'Gói PT 1-on-1 12 Buổi',   months: 0,  days: 30, price: 2400000 }
        ];

        var SEED = [
            { id: 'HV001', name: 'Nguyễn Văn A', phone: '', pkg: 'Gói Gym VIP 6 Tháng',   start: '2026-11-01', end: '2027-05-01', price: 3000000, seed: true, created: 1 },
            { id: 'HV002', name: 'Trần Thị B',   phone: '', pkg: 'Gói PT 1-on-1 12 Buổi', start: '2026-11-05', end: '2026-12-05', price: 2400000, seed: true, created: 2 },
            { id: 'HV003', name: 'Lê Văn C',     phone: '', pkg: 'Gói Tập Tự Do 1 Tháng', start: '2026-10-01', end: '2026-11-01', price: 500000,  seed: true, created: 3 }
        ];

        /* ===================== TIỆN ÍCH ===================== */
        function $(id) { return document.getElementById(id); }
        function pad(n) { return n < 10 ? '0' + n : '' + n; }
        function toISO(d) { return d.getFullYear() + '-' + pad(d.getMonth() + 1) + '-' + pad(d.getDate()); }
        function fromISO(s) { var p = s.split('-'); return new Date(+p[0], +p[1] - 1, +p[2]); }
        function fmtDate(iso) { var p = iso.split('-'); return p[2] + '/' + p[1] + '/' + p[0]; }
        function fmtMoney(n) { return n.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','); }
        function esc(s) {
            return String(s).replace(/[&<>"']/g, function (c) {
                return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c];
            });
        }
        function todayMidnight() { var d = new Date(); d.setHours(0, 0, 0, 0); return d; }
        function findPkg(name) { return PACKAGES.filter(function (p) { return p.name === name; })[0]; }

        function calcEnd(startISO, pkg) {
            var d = fromISO(startISO);
            if (pkg.months) {
                var day = d.getDate();
                d.setMonth(d.getMonth() + pkg.months);
                if (d.getDate() !== day) { d.setDate(0); } // tránh tràn tháng (31/01 + 1 tháng)
            }
            if (pkg.days) { d.setDate(d.getDate() + pkg.days); }
            return toISO(d);
        }

        function daysLeft(endISO) {
            return Math.round((fromISO(endISO) - todayMidnight()) / 86400000);
        }

        function statusOf(m) {
            var left = daysLeft(m.end);
            if (left < 0) return { cls: 'bg-danger', text: 'Hết hạn' };
            if (left <= EXPIRING_DAYS) return { cls: 'bg-warning text-dark', text: 'Sắp hết hạn' };
            return { cls: 'bg-success', text: 'Đang hiệu lực' };
        }

        /* ===================== LƯU TRỮ (localStorage) ===================== */
        function loadMembers() {
            try {
                var raw = localStorage.getItem(KEY_MEMBERS);
                if (raw) return JSON.parse(raw);
            } catch (e) { }
            return SEED.slice();
        }
        function saveMembers() {
            try { localStorage.setItem(KEY_MEMBERS, JSON.stringify(members)); } catch (e) { }
        }

        var members = loadMembers();

        /* ===================== THỐNG KÊ ===================== */
        function setStat(id, text) {
            var el = $(id);
            if (el.textContent !== text) {
                el.textContent = text;
                el.classList.remove('value-bump');
                void el.offsetWidth;
                el.classList.add('value-bump');
            }
        }

        function renderStats() {
            var now = new Date();
            var revenue = BASE_REVENUE, expiring = BASE_EXPIRING;
            members.forEach(function (m) {
                if (m.seed) return;
                var s = fromISO(m.start);
                if (s.getFullYear() === now.getFullYear() && s.getMonth() === now.getMonth()) revenue += m.price;
                var left = daysLeft(m.end);
                if (left >= 0 && left <= EXPIRING_DAYS) expiring++;
            });
            setStat('statTotal', fmtMoney(BASE_MEMBERS + members.length));
            setStat('statRevenue', fmtMoney(revenue) + ' VNĐ');
            setStat('statSessions', fmtMoney(dayData.sessions));
            setStat('statExpiring', fmtMoney(expiring));
        }

        /* ===================== BẢNG DANH SÁCH ===================== */
        function renderTable() {
            var sorted = members.slice().sort(function (a, b) { return b.created - a.created; });
            var rows = sorted.slice(0, MAX_ROWS).map(function (m) {
                var st = statusOf(m);
                return '<tr>' +
                    '<td>' + esc(m.id) + '</td>' +
                    '<td>' + esc(m.name) + '</td>' +
                    '<td>' + (m.phone ? esc(m.phone) : '<span class="text-muted">—</span>') + '</td>' +
                    '<td>' + esc(m.pkg) + '</td>' +
                    '<td>' + fmtDate(m.start) + '</td>' +
                    '<td>' + fmtDate(m.end) + '</td>' +
                    '<td><span class="badge ' + st.cls + '">' + st.text + '</span></td>' +
                    '<td class="text-end"><button type="button" class="btn btn-sm btn-outline-danger" data-del="' + esc(m.id) + '" title="Xóa"><i class="bi bi-trash"></i></button></td>' +
                    '</tr>';
            });
            $('memberTableBody').innerHTML = rows.join('') ||
                '<tr><td colspan="8" class="text-center text-muted py-4">Chưa có đăng ký nào.</td></tr>';
            $('tableCount').textContent = 'Hiển thị ' + Math.min(MAX_ROWS, sorted.length) + '/' + sorted.length + ' đăng ký';
        }

        $('memberTableBody').addEventListener('click', function (e) {
            var btn = e.target.closest('[data-del]');
            if (!btn) return;
            var id = btn.getAttribute('data-del');
            if (!confirm('Xóa đăng ký ' + id + '?')) return;
            members = members.filter(function (m) { return m.id !== id; });
            saveMembers();
            renderTable();
            renderStats();
            toast('Đã xóa đăng ký ' + id, 'secondary');
        });

        /* ===================== FORM ĐĂNG KÝ ===================== */
        var modalEl = $('modalDangKy');
        var modal = new bootstrap.Modal(modalEl);
        var toastObj = new bootstrap.Toast($('appToast'), { delay: 3500 });

        function toast(msg, color) {
            var t = $('appToast');
            t.className = 'toast align-items-center border-0 text-bg-' + (color || 'success');
            $('toastMsg').textContent = msg;
            toastObj.show();
        }

        PACKAGES.forEach(function (p) {
            var o = document.createElement('option');
            o.value = p.name;
            o.textContent = p.name + ' – ' + fmtMoney(p.price) + ' VNĐ';
            $('selPackage').appendChild(o);
        });

        function updatePreview() {
            var pkg = findPkg($('selPackage').value);
            var start = $('inpStart').value;
            if (!pkg) return;
            $('lblPrice').textContent = fmtMoney(pkg.price) + ' VNĐ';
            $('inpEnd').value = start ? fmtDate(calcEnd(start, pkg)) : '';
        }

        $('selPackage').addEventListener('change', updatePreview);
        $('inpStart').addEventListener('change', updatePreview);

        modalEl.addEventListener('show.bs.modal', function () {
            $('inpName').value = '';
            $('inpPhone').value = '';
            $('selPackage').selectedIndex = 0;
            $('inpStart').value = toISO(new Date());
            $('inpName').classList.remove('is-invalid');
            $('inpPhone').classList.remove('is-invalid');
            updatePreview();
        });
        modalEl.addEventListener('shown.bs.modal', function () { $('inpName').focus(); });

        function nextId() {
            var max = 0;
            members.forEach(function (m) {
                var n = parseInt(String(m.id).replace(/\D/g, ''), 10);
                if (n > max) max = n;
            });
            return 'HV' + (max + 1 < 1000 ? ('00' + (max + 1)).slice(-3) : (max + 1));
        }

        function saveMember() {
            var name = $('inpName').value.trim().replace(/\s+/g, ' ');
            var phone = $('inpPhone').value.trim();
            var pkg = findPkg($('selPackage').value);
            var start = $('inpStart').value;
            var ok = true;

            $('inpName').classList.toggle('is-invalid', !name);
            if (!name) ok = false;

            var phoneOk = /^0\d{9}$/.test(phone);
            $('inpPhone').classList.toggle('is-invalid', !phoneOk);
            if (!phoneOk) ok = false;

            if (!start) { $('inpStart').value = start = toISO(new Date()); }
            if (!ok || !pkg) return;

            var m = {
                id: nextId(),
                name: name,
                phone: phone,
                pkg: pkg.name,
                start: start,
                end: calcEnd(start, pkg),
                price: pkg.price,
                seed: false,
                created: Date.now()
            };
            members.push(m);
            saveMembers();
            renderTable();
            renderStats();
            modal.hide();
            toast('Đăng ký thành công: ' + m.id + ' – ' + m.name);
        }

        $('btnSave').addEventListener('click', saveMember);
        modalEl.addEventListener('keydown', function (e) {
            if (e.key === 'Enter' && e.target.tagName !== 'BUTTON') { e.preventDefault(); saveMember(); }
        });

        /* ===================== DỮ LIỆU LƯỢT TẬP TRONG NGÀY ===================== */
        var HOUR_WEIGHTS = [0, 0, 0, 0, 0, 1, 4, 8, 9, 6, 4, 4, 5, 4, 3, 4, 6, 9, 10, 8, 5, 3, 1, 0];

        function initDay() {
            var today = toISO(new Date());
            try {
                var raw = JSON.parse(localStorage.getItem(KEY_DAY) || 'null');
                if (raw && raw.date === today && raw.hours && raw.hours.length === 24) {
                    raw.sessions = raw.hours.reduce(function (a, b) { return a + b; }, 0);
                    return raw;
                }
            } catch (e) { }

            var cur = new Date().getHours();
            var hours = [];
            var totalW = 0, h;
            for (h = 0; h <= cur; h++) totalW += HOUR_WEIGHTS[h];
            for (h = 0; h < 24; h++) hours[h] = 0;
            if (totalW === 0) {
                hours[cur] = BASE_SESSIONS;
            } else {
                var sum = 0;
                for (h = 0; h <= cur; h++) { hours[h] = Math.round(BASE_SESSIONS * HOUR_WEIGHTS[h] / totalW); sum += hours[h]; }
                hours[cur] += BASE_SESSIONS - sum;
                if (hours[cur] < 0) hours[cur] = 0;
            }
            return { date: today, hours: hours, sessions: BASE_SESSIONS };
        }

        var dayData = initDay();
        function saveDay() { try { localStorage.setItem(KEY_DAY, JSON.stringify(dayData)); } catch (e) { } }

        /* ===================== BIỂU ĐỒ ===================== */
        var LIVE_POINTS = 30;
        var occupancy = 28;
        var liveLabels = [], liveValues = [];

        function timeLabel(d) { return pad(d.getHours()) + ':' + pad(d.getMinutes()) + ':' + pad(d.getSeconds()); }
        function nextOccupancy() {
            occupancy += Math.round((Math.random() - 0.47) * 4);
            occupancy = Math.max(8, Math.min(60, occupancy));
            return occupancy;
        }

        for (var i = LIVE_POINTS - 1; i >= 0; i--) {
            liveLabels.push(timeLabel(new Date(Date.now() - i * 2000)));
            liveValues.push(nextOccupancy());
        }

        var chartLive = new Chart($('chartLive'), {
            type: 'line',
            data: {
                labels: liveLabels,
                datasets: [{
                    label: 'Người đang tập',
                    data: liveValues,
                    borderColor: '#10854d',
                    backgroundColor: 'rgba(16,133,77,.15)',
                    fill: true,
                    tension: 0.35,
                    pointRadius: 2
                }]
            },
            options: {
                maintainAspectRatio: false,
                animation: { duration: 400 },
                plugins: { legend: { display: false } },
                scales: {
                    y: { beginAtZero: true, suggestedMax: 70, title: { display: true, text: 'Người' } },
                    x: { ticks: { maxTicksLimit: 6 } }
                }
            }
        });

        function hourColors() {
            var cur = new Date().getHours();
            return dayData.hours.map(function (_, h) { return h === cur ? '#0d6efd' : 'rgba(16,133,77,.7)'; });
        }

        var hourLabels = [];
        for (var hh = 0; hh < 24; hh++) hourLabels.push(hh + 'h');

        var chartHourly = new Chart($('chartHourly'), {
            type: 'bar',
            data: {
                labels: hourLabels,
                datasets: [{ label: 'Lượt tập', data: dayData.hours.slice(), backgroundColor: hourColors(), borderRadius: 3 }]
            },
            options: {
                maintainAspectRatio: false,
                animation: { duration: 400 },
                plugins: { legend: { display: false } },
                scales: {
                    y: { beginAtZero: true, title: { display: true, text: 'Lượt' } },
                    x: { ticks: { maxTicksLimit: 12 } }
                }
            }
        });

        /* ===================== CẬP NHẬT LIÊN TỤC ===================== */
        function tickClock() {
            var d = new Date();
            $('liveClock').textContent = pad(d.getDate()) + '/' + pad(d.getMonth() + 1) + '/' + d.getFullYear() +
                ' ' + pad(d.getHours()) + ':' + pad(d.getMinutes()) + ':' + pad(d.getSeconds());
        }

        function tickLive() {
            // Sang ngày mới thì đặt lại số liệu trong ngày
            if (dayData.date !== toISO(new Date())) {
                dayData = { date: toISO(new Date()), hours: new Array(24).fill(0), sessions: 0 };
            }

            // Biểu đồ đường: thêm điểm mới, bỏ điểm cũ
            liveLabels.push(timeLabel(new Date()));
            liveValues.push(nextOccupancy());
            if (liveLabels.length > LIVE_POINTS) { liveLabels.shift(); liveValues.shift(); }
            chartLive.update();

            // Mô phỏng lượt check-in mới
            if (Math.random() < 0.45) {
                var h = new Date().getHours();
                dayData.hours[h] += 1;
                dayData.sessions += 1;
                saveDay();
                chartHourly.data.datasets[0].data = dayData.hours.slice();
                chartHourly.data.datasets[0].backgroundColor = hourColors();
                chartHourly.update();
                renderStats();
            }
        }

        setInterval(tickClock, 1000);
        setInterval(tickLive, 2000);
        // Làm mới trạng thái gói tập (hết hạn / sắp hết hạn) mỗi phút
        setInterval(function () { renderTable(); renderStats(); }, 60000);

        /* ===================== KHỞI TẠO ===================== */
        renderTable();
        renderStats();
        saveDay();
    })();
    </script>
</body>
</html>