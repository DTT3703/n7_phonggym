<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LichTap.aspx.cs" Inherits="n7_phonggym.LichTap" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="vi">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Quản Lý Lịch Tập & PT - Admin Panel</title>
    
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
                        <a href="LichTap.aspx" class="nav-link active">
                            <i class="bi bi-calendar-week me-2"></i>Lịch tập & PT
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="Nhanvien.aspx" class="nav-link">
                            <i class="bi bi-person-badge me-2"></i>Nhân viên
                        </a>
                    </li>
                    <li class="nav-item">
    <a href="Caidathethong.aspx" class="nav-link">
        <i class="bi bi-gear me-2"></i>Cài đặt hệ thống
    </a>
</li>
                </ul>
            </nav>

            <!-- Main Content Container -->
            <div class="w-100 d-flex flex-column min-vh-100">
                <!-- Top Header -->
                <header class="top-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 fw-bold">Quản Lý Lịch Tập & PT</h5>
                    <span class="text-muted small"><i class="bi bi-clock me-1"></i><%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></span>
                </header>

                <!-- Page Body Content -->
                <main class="main-content flex-grow-1">
                    <div class="row mb-4 align-items-center">
                        <div class="col-md-6">
                            <div class="input-group">
                                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" Placeholder="Tìm kiếm theo khung giờ, PT..."></asp:TextBox>
                                <asp:Button ID="btnSearch" runat="server" Text="Tìm kiếm" CssClass="btn btn-outline-secondary" OnClick="btnSearch_Click" />
                            </div>
                        </div>
                        <div class="col-md-6 text-end">
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addLichTapModal">
                                <i class="bi bi-calendar-plus me-1"></i> Đặt Lịch Tập Mới
                            </button>
                        </div>
                    </div>

                    <!-- Bảng danh sách Lịch tập -->
                    <div class="card shadow-sm">
                        <div class="card-header bg-white py-3">
                            <h6 class="card-title mb-0 fw-bold"><i class="bi bi-calendar-check me-2"></i>Danh Sách Buổi Tập Đã Đặt (LK_LỊCH_TẬP)</h6>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <asp:GridView ID="gvLichTap" runat="server" AutoGenerateColumns="False" CssClass="table table-hover align-middle mb-0" GridLines="None">
                                    <Columns>
                                        <asp:BoundField DataField="ID_CTG" HeaderText="Mã CT Gói" />
                                        <asp:BoundField DataField="TenChiTietGoi" HeaderText="Chi Tiết Gói Tập" />
                                        <asp:BoundField DataField="TenPT" HeaderText="Huấn Luyện Viên (PT)" />
                                        <asp:BoundField DataField="NgayTap" HeaderText="Ngày Tập" DataFormatString="{0:dd/MM/yyyy}" />
                                        <asp:BoundField DataField="KhungGio" HeaderText="Khung Giờ" />
                                        <asp:BoundField DataField="SoLuongHV" HeaderText="Số HV" />
                                        <asp:BoundField DataField="DanhGiaBuoi" HeaderText="Đánh Giá / Nhận Xét" />
                                        <asp:TemplateField HeaderText="Thao tác">
                                            <ItemTemplate>
                                                <button type="button" class="btn btn-sm btn-outline-primary me-1"><i class="bi bi-pencil-square"></i> Sửa</button>
                                                <button type="button" class="btn btn-sm btn-outline-danger"><i class="bi bi-trash"></i> Xóa</button>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="table-light" />
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </main>

                <footer class="main-footer">
                    &copy; 2026 - Giao diện quản trị Admin WebForms.
                </footer>
            </div>
        </div>

        <!-- Modal Thêm Lịch Tập -->
        <div class="modal fade" id="addLichTapModal" tabindex="-1" aria-labelledby="addLichTapModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title fw-bold" id="addLichTapModalLabel">Đặt Lịch Tập Mới</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Mã Chi Tiết Gói (ID_CTG)</label>
                            <asp:TextBox ID="txtID_CTG" runat="server" TextMode="Number" CssClass="form-control" Placeholder="Nhập ID chi tiết gói"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Mã Nhân Viên / PT (ID_MNV)</label>
                            <asp:TextBox ID="txtID_MNV" runat="server" TextMode="Number" CssClass="form-control" Placeholder="Nhập ID PT"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Ngày Tập</label>
                            <asp:TextBox ID="txtNgayTap" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Khung Giờ</label>
                            <asp:DropDownList ID="ddlKhungGio" runat="server" CssClass="form-select">
                                <asp:ListItem Text="06:00 - 07:30" Value="06:00 - 07:30"></asp:ListItem>
                                <asp:ListItem Text="08:00 - 09:30" Value="08:00 - 09:30"></asp:ListItem>
                                <asp:ListItem Text="14:00 - 15:30" Value="14:00 - 15:30"></asp:ListItem>
                                <asp:ListItem Text="17:00 - 18:30" Value="17:00 - 18:30"></asp:ListItem>
                                <asp:ListItem Text="19:00 - 20:30" Value="19:00 - 20:30"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Số Lượng Hội Viên Tham Gia</label>
                            <asp:TextBox ID="txtSoLuongHV" runat="server" TextMode="Number" CssClass="form-control" Text="1"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Ghi Chú / Đánh Giá Buổi Tập</label>
                            <asp:TextBox ID="txtDanhGiaBuoi" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control" Placeholder="Ví dụ: Tập Cardio + Ngực"></asp:TextBox>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        <asp:Button ID="btnSaveLichTap" runat="server" Text="Lưu Lịch Tập" CssClass="btn btn-primary" OnClick="btnSaveLichTap_Click" />
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/bootstrap.bundle.min.js"></script>
</body>
</html>