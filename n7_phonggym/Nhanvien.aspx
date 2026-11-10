<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NhanVien.aspx.cs" Inherits="n7_phonggym.NhanVien" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="vi">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Quản Lý Nhân Viên & PT - Admin Panel</title>
    
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
                        <a href="NhanVien.aspx" class="nav-link active">
                            <i class="bi bi-person-badge me-2"></i>Nhân viên
                        </a>
                    </li>
                    <li class="nav-item">
    <a href="CaiDatHeThong.aspx" class="nav-link">
        <i class="bi bi-gear me-2"></i>Cài đặt hệ thống
    </a>
</li>
                </ul>
            </nav>

            <!-- Main Content Container -->
            <div class="w-100 d-flex flex-column min-vh-100">
                <!-- Top Header -->
                <header class="top-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 fw-bold">Quản Lý Nhân Viên & Huấn Luyện Viên (PT)</h5>
                    <span class="text-muted small"><i class="bi bi-clock me-1"></i><%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></span>
                </header>

                <!-- Page Body Content -->
                <main class="main-content flex-grow-1">
                    <div class="row mb-4 align-items-center">
                        <div class="col-md-6">
                            <div class="input-group">
                                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" Placeholder="Tìm kiếm tên nhân viên, chuyên môn..."></asp:TextBox>
                                <asp:Button ID="btnSearch" runat="server" Text="Tìm kiếm" CssClass="btn btn-outline-secondary" OnClick="btnSearch_Click" />
                            </div>
                        </div>
                        <div class="col-md-6 text-end">
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addNhanVienModal">
                                <i class="bi bi-person-plus-fill me-1"></i> Thêm Nhân Viên Mới
                            </button>
                        </div>
                    </div>

                    <!-- Bảng danh sách Nhân viên -->
                    <div class="card shadow-sm">
                        <div class="card-header bg-white py-3">
                            <h6 class="card-title mb-0 fw-bold"><i class="bi bi-person-badge-fill me-2"></i>Danh Sách Nhân Viên & Huấn Luyện Viên</h6>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <asp:GridView ID="gvNhanVien" runat="server" AutoGenerateColumns="False" CssClass="table table-hover align-middle mb-0" GridLines="None">
                                    <Columns>
                                        <asp:BoundField DataField="ID_MNV" HeaderText="Mã NV" />
                                        <asp:BoundField DataField="HoTen" HeaderText="Họ và Tên" />
                                        <asp:BoundField DataField="NgaySinh" HeaderText="Ngày Sinh" DataFormatString="{0:dd/MM/yyyy}" />
                                        <asp:BoundField DataField="GioiTinh" HeaderText="Giới Tính" />
                                        <asp:BoundField DataField="TrinhDo" HeaderText="Trình Độ" />
                                        <asp:BoundField DataField="ChuyenMon" HeaderText="Chuyên Môn" />
                                        <asp:BoundField DataField="GiaBieuDay" HeaderText="Giá Biểu Dạy" DataFormatString="{0:N0} VNĐ" NullDisplayText="Không có" />
                                        <asp:BoundField DataField="PhuCapVIP" HeaderText="Phụ Cấp VIP" DataFormatString="{0:N0} VNĐ" NullDisplayText="Không có" />
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

        <!-- Modal Thêm Nhân Viên -->
        <div class="modal fade" id="addNhanVienModal" tabindex="-1" aria-labelledby="addNhanVienModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title fw-bold" id="addNhanVienModalLabel">Thêm Nhân Viên / Huấn Luyện Viên Mới</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <!-- Thông tin chung NHAN_VIEN -->
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Họ và Tên</label>
                                <asp:TextBox ID="txtHoTen" runat="server" CssClass="form-control" Placeholder="Nguyễn Văn A"></asp:TextBox>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Ngày Sinh</label>
                                <asp:TextBox ID="txtNgaySinh" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Giới Tính</label>
                                <asp:DropDownList ID="ddlGioiTinh" runat="server" CssClass="form-select">
                                    <asp:ListItem Text="Nam" Value="Nam"></asp:ListItem>
                                    <asp:ListItem Text="Nữ" Value="Nữ"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Trình Độ</label>
                                <asp:TextBox ID="txtTrinhDo" runat="server" CssClass="form-control" Placeholder="Cử nhân ĐH Thể Dục Thể Thao"></asp:TextBox>
                            </div>
                            <div class="col-md-12 mb-3">
                                <label class="form-label">Chuyên Môn / Lĩnh Vực</label>
                                <asp:TextBox ID="txtChuyenMon" runat="server" CssClass="form-control" Placeholder="Tăng cơ giảm mỡ, Gym, Yoga, Lễ tân..."></asp:TextBox>
                            </div>

                            <hr />
                            <h6 class="fw-bold text-success mb-3"><i class="bi bi-award me-1"></i>Dành riêng cho Huấn Luyện Viên / PT Chuyên Gia</h6>
                            
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Giá Biểu Dạy (đ/buổi)</label>
                                <asp:TextBox ID="txtGiaBieuDay" runat="server" TextMode="Number" CssClass="form-control" Placeholder="300000"></asp:TextBox>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Hệ Số Hoa Hồng</label>
                                <asp:TextBox ID="txtHeSoHoaHong" runat="server" CssClass="form-control" Placeholder="0.15"></asp:TextBox>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Phụ Cấp VIP (nếu là PT Chuyên Gia)</label>
                                <asp:TextBox ID="txtPhuCapVIP" runat="server" TextMode="Number" CssClass="form-control" Placeholder="2000000"></asp:TextBox>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Hệ Số Kinh Nghiệm</label>
                                <asp:TextBox ID="txtHeSoKinhNghiem" runat="server" CssClass="form-control" Placeholder="1.5"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        <asp:Button ID="btnSaveNhanVien" runat="server" Text="Lưu Nhân Viên" CssClass="btn btn-success" OnClick="btnSaveNhanVien_Click" />
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/bootstrap.bundle.min.js"></script>
</body>
</html>