<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CaiDatHeThong.aspx.cs" Inherits="n7_phonggym.CaiDatHeThong" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="vi">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Cài Đặt Hệ Thống - Admin Panel</title>
    
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

        .sidebar {
            width: 250px;
            background-color: var(--sidebar-bg);
            min-height: 100vh;
            color: #fff;
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

        .top-header {
            background-color: #fff;
            padding: 15px 30px;
            border-bottom: 1px solid #e9ecef;
        }

        .main-content {
            padding: 30px;
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
                        <a href="NhanVien.aspx" class="nav-link">
                            <i class="bi bi-person-badge me-2"></i>Nhân viên
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="CaiDatHeThong.aspx" class="nav-link active">
                            <i class="bi bi-gear me-2"></i>Cài đặt hệ thống
                        </a>
                    </li>
                </ul>
            </nav>

            <!-- Main Content Container -->
            <div class="w-100 d-flex flex-column min-vh-100">
                <!-- Top Header -->
                <header class="top-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 fw-bold">Cài Đặt & Cấu Hình Hệ Thống</h5>
                    <span class="text-muted small"><i class="bi bi-clock me-1"></i><%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></span>
                </header>

                <!-- Page Body Content -->
                <main class="main-content flex-grow-1">
                    <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show mb-4">
                        <asp:Literal ID="litMessage" runat="server"></asp:Literal>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </asp:Panel>

                    <!-- Nav Tabs cho từng mục Cài đặt -->
                    <ul class="nav nav-tabs mb-4" id="settingTabs" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active fw-semibold" id="info-tab" data-bs-toggle="tab" data-bs-target="#info-tab-pane" type="button" role="tab">
                                <i class="bi bi-building me-1"></i> Thông Tin Phòng Gym
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link fw-semibold" id="hardware-tab" data-bs-toggle="tab" data-bs-target="#hardware-tab-pane" type="button" role="tab">
                                <i class="bi bi-qr-code-scan me-1"></i> Tích Hợp Phần Cứng Check-in
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
                            <div class="card shadow-sm border-0">
                                <div class="card-body p-4">
                                    <h6 class="fw-bold mb-3 text-success">Cấu hình thông tin cơ sở</h6>
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label class="form-label">Tên Phòng Gym / Chi Nhánh</label>
                                            <asp:TextBox ID="txtTenGym" runat="server" CssClass="form-control" Text="Hệ Thống Phòng Gym N7 Fitness"></asp:TextBox>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Số Điện Thoại Hotline</label>
                                            <asp:TextBox ID="txtHotline" runat="server" CssClass="form-control" Text="1900 6789"></asp:TextBox>
                                        </div>
                                        <div class="col-md-12">
                                            <label class="form-label">Địa Chỉ Chi Nhánh</label>
                                            <asp:TextBox ID="txtDiaChiGym" runat="server" CssClass="form-control" Text="123 Đường Số 7, Phường Linh Trung, TP. Thủ Đức, TP.HCM"></asp:TextBox>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Giờ Mở Cửa</label>
                                            <asp:TextBox ID="txtGioMoCua" runat="server" CssClass="form-control" Text="05:30 - 21:30"></asp:TextBox>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Email Liên Hệ</label>
                                            <asp:TextBox ID="txtEmailGym" runat="server" CssClass="form-control" Text="contact@n7fitness.com"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Tab 2: Tích hợp phần cứng -->
                        <div class="tab-pane fade" id="hardware-tab-pane" role="tabpanel">
                            <div class="card shadow-sm border-0">
                                <div class="card-body p-4">
                                    <h6 class="fw-bold mb-3 text-success">Cấu hình thiết bị điểm danh (Check-in/Check-out)</h6>
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label class="form-label">Hình thức điểm danh chính</label>
                                            <asp:DropDownList ID="ddlCheckInType" runat="server" CssClass="form-select">
                                                <asp:ListItem Text="Mã QR Code" Value="QR"></asp:ListItem>
                                                <asp:ListItem Text="Nhận diện khuôn mặt (FaceID)" Value="FaceID"></asp:ListItem>
                                                <asp:ListItem Text="Thẻ Từ RFID" Value="RFID"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Địa chỉ IP Máy Quét / Barrier</label>
                                            <asp:TextBox ID="txtIPDevice" runat="server" CssClass="form-control" Text="192.168.1.200"></asp:TextBox>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="form-check form-switch mt-2">
                                                <asp:CheckBox ID="chkAutoLockers" runat="server" CssClass="form-check-input" Checked="true" />
                                                <label class="form-check-label fw-semibold" for="chkAutoLockers">Tự động gán tủ đồ (Locker) khi check-in thành công</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Tab 3: Cổng thanh toán -->
                        <div class="tab-pane fade" id="payment-tab-pane" role="tabpanel">
                            <div class="card shadow-sm border-0">
                                <div class="card-body p-4">
                                    <h6 class="fw-bold mb-3 text-success">Cấu hình thanh toán VietQR / Ngân hàng</h6>
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label class="form-label">Tên Ngân Hàng thụ hưởng</label>
                                            <asp:TextBox ID="txtBankName" runat="server" CssClass="form-control" Text="MBBank (Ngân hàng Quân Đội)"></asp:TextBox>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Số Tài Khoản</label>
                                            <asp:TextBox ID="txtAccountNumber" runat="server" CssClass="form-control" Text="999988887777"></asp:TextBox>
                                        </div>
                                        <div class="col-md-12">
                                            <label class="form-label">Tên Chủ Tài Khoản</label>
                                            <asp:TextBox ID="txtAccountName" runat="server" CssClass="form-control" Text="CTY TNHH PHONG GYM N7"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Nút Lưu Cài Đặt -->
                    <div class="mt-4 text-end">
                        <asp:Button ID="btnSaveSettings" runat="server" Text="Lưu Cấu Hình System" CssClass="btn btn-success px-4 py-2 fw-semibold" OnClick="btnSaveSettings_Click" />
                    </div>
                </main>

                <footer class="main-footer">
                    &copy; 2026 - Giao diện quản trị Admin WebForms.
                </footer>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/bootstrap.bundle.min.js"></script>
</body>
</html>