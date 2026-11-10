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

        /* User Profile Footer in Sidebar */
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
        }

        /* Content Area */
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
    </style>
</head>
<body>
    <form id="form1" runat="server">
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

                <!-- Dropdown Profile ở dưới góc trái -->
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
                        <span class="text-muted me-2"><i class="bi bi-clock me-1"></i><%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></span>
                    </div>
                </header>

                <!-- Page Body Content -->
                <main class="main-content flex-grow-1">
                    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-2 pb-3 mb-4 border-bottom">
                        <h1 class="h2">Bảng điều khiển Quản lý Phòng Gym</h1>
                        <button type="button" class="btn btn-sm btn-primary">
                            <i class="bi bi-plus-circle me-1"></i>Đăng ký hội viên mới
                        </button>
                    </div>

                    <!-- Thống kê tổng quan (Cards) -->
                    <div class="row g-3 mb-4">
                        <div class="col-md-3">
                            <div class="card card-stat bg-white p-3 border-start border-4 border-primary">
                                <div class="text-muted small text-uppercase">Tổng hội viên</div>
                                <div class="fs-4 fw-bold text-dark">1,248</div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card card-stat bg-white p-3 border-start border-4 border-success">
                                <div class="text-muted small text-uppercase">Doanh thu tháng</div>
                                <div class="fs-4 fw-bold text-dark">12,500,000 VNĐ</div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card card-stat bg-white p-3 border-start border-4 border-warning">
                                <div class="text-muted small text-uppercase">Lượt tập trong ngày</div>
                                <div class="fs-4 fw-bold text-dark">86</div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card card-stat bg-white p-3 border-start border-4 border-info">
                                <div class="text-muted small text-uppercase">Gói sắp hết hạn</div>
                                <div class="fs-4 fw-bold text-dark">14</div>
                            </div>
                        </div>
                    </div>

                    <!-- Danh sách Đăng ký Gói tập gần đây -->
                    <div class="card shadow-sm">
                        <div class="card-header bg-white py-3">
                            <h5 class="card-title mb-0 fw-bold"><i class="bi bi-list-check me-2"></i>Danh sách Đăng ký Gói tập gần đây</h5>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-hover align-middle mb-0">
                                    <thead class="table-light">
                                        <tr>
                                            <th>Mã HV</th>
                                            <th>Họ tên Hội viên</th>
                                            <th>Tên Gói tập</th>
                                            <th>Ngày kích hoạt</th>
                                            <th>Ngày hết hạn</th>
                                            <th>Trạng thái</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>HV001</td>
                                            <td>Nguyễn Văn A</td>
                                            <td>Gói Gym VIP 6 Tháng</td>
                                            <td>01/11/2026</td>
                                            <td>01/05/2027</td>
                                            <td><span class="badge bg-success">Đang hiệu lực</span></td>
                                        </tr>
                                        <tr>
                                            <td>HV002</td>
                                            <td>Trần Thị B</td>
                                            <td>Gói PT 1-on-1 12 Buổi</td>
                                            <td>05/11/2026</td>
                                            <td>05/12/2026</td>
                                            <td><span class="badge bg-success">Đang hiệu lực</span></td>
                                        </tr>
                                        <tr>
                                            <td>HV003</td>
                                            <td>Lê Văn C</td>
                                            <td>Gói Tập Tự Do 1 Tháng</td>
                                            <td>01/10/2026</td>
                                            <td>01/11/2026</td>
                                            <td><span class="badge bg-danger">Hết hạn</span></td>
                                        </tr>
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
    </form>

    <!-- Bootstrap 5 JavaScript Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/bootstrap.bundle.min.js"></script>
</body>
</html>