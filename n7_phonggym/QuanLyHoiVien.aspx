<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuanLyHoiVien.aspx.cs" Inherits="n7_phonggym.QuanLyHoiVien" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="vi">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Quản Lý Hội Viên - Admin Panel</title>

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
                        <a href="QuanLyHoiVien.aspx" class="nav-link active">
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
                    <h5 class="mb-0 fw-bold">Quản Lý Hội Viên</h5>
                    <span class="text-muted small"><i class="bi bi-clock me-1"></i><%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></span>
                </header>

                <!-- Page Body Content -->
                <main class="main-content flex-grow-1">
                    <div class="row mb-4 align-items-center">
                        <div class="col-md-6">
                            <div class="input-group">
                                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" Placeholder="Tìm kiếm theo tên hoặc mã hội viên..."></asp:TextBox>
                                <asp:Button ID="btnSearch" runat="server" Text="Tìm kiếm" CssClass="btn btn-outline-secondary" OnClick="btnSearch_Click" />
                            </div>
                        </div>
                        <div class="col-md-6 text-end">
                            <button type="button" id="btnThemMoi" class="btn btn-primary" onclick="moFormThem(); return false;">
                                <i class="bi bi-person-plus-fill me-1"></i> Thêm hội viên mới
                            </button>
                        </div>
                    </div>

                    <!-- Bảng danh sách hội viên -->
                    <div class="card shadow-sm">
                        <div class="card-header bg-white py-3">
                            <h6 class="card-title mb-0 fw-bold"><i class="bi bi-people-fill me-2"></i>Danh Sách Hội Viên</h6>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <asp:GridView ID="gvHoiVien" runat="server" AutoGenerateColumns="False"
                                    CssClass="table table-hover align-middle mb-0" GridLines="None"
                                    DataKeyNames="ID_MHV" OnRowCommand="gvHoiVien_RowCommand">
                                    <Columns>
                                        <asp:BoundField DataField="ID_MHV" HeaderText="Mã HV" />
                                        <asp:BoundField DataField="HoTen" HeaderText="Họ và Tên" />
                                        <asp:BoundField DataField="NgaySinh" HeaderText="Ngày Sinh" DataFormatString="{0:dd/MM/yyyy}" />
                                        <asp:BoundField DataField="GioiTinh" HeaderText="Giới Tính" />
                                        <asp:BoundField DataField="DiaChi" HeaderText="Địa Chỉ" />
                                        <asp:TemplateField HeaderText="Thao tác">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkSua" runat="server" CommandName="SuaHV"
                                                    CommandArgument='<%# Eval("ID_MHV") %>'
                                                    CssClass="btn btn-sm btn-outline-primary me-1">
                                                    <i class="bi bi-pencil-square"></i> Sửa
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="lnkXoa" runat="server" CommandName="XoaHV"
                                                    CommandArgument='<%# Eval("ID_MHV") %>'
                                                    CssClass="btn btn-sm btn-outline-danger"
                                                    OnClientClick="return confirm('Bạn có chắc muốn xóa hội viên này?');">
                                                    <i class="bi bi-trash"></i> Xóa
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="table-light" />
                                    <EmptyDataTemplate>
                                        <div class="text-center text-muted py-4">Không có hội viên nào.</div>
                                    </EmptyDataTemplate>
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

        <!-- Modal Thêm / Sửa Hội Viên -->
        <div class="modal fade" id="addHoiVienModal" tabindex="-1" aria-labelledby="addHoiVienModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title fw-bold" id="addHoiVienModalLabel">
                            <asp:Literal ID="litTitle" runat="server" Text="Thêm Hội Viên Mới"></asp:Literal>
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <asp:HiddenField ID="hfID" runat="server" ClientIDMode="Static" />
                        <div class="mb-3">
                            <label class="form-label">Họ và Tên</label>
                            <asp:TextBox ID="txtHoTen" runat="server" ClientIDMode="Static" CssClass="form-control" Placeholder="Nhập họ và tên"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Ngày Sinh</label>
                            <asp:TextBox ID="txtNgaySinh" runat="server" ClientIDMode="Static" TextMode="Date" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Giới Tính</label>
                            <asp:DropDownList ID="ddlGioiTinh" runat="server" ClientIDMode="Static" CssClass="form-select">
                                <asp:ListItem Text="Nam" Value="Nam"></asp:ListItem>
                                <asp:ListItem Text="Nữ" Value="Nữ"></asp:ListItem>
                                <asp:ListItem Text="Khác" Value="Khác"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Địa Chỉ</label>
                            <asp:TextBox ID="txtDiaChi" runat="server" ClientIDMode="Static" CssClass="form-control" Placeholder="Nhập địa chỉ"></asp:TextBox>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        <asp:Button ID="btnSave" runat="server" Text="Lưu Hội Viên" CssClass="btn btn-success" OnClick="btnSave_Click" />
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Mở modal (dùng cho nút Thêm và cho nút Sửa từ code-behind)
        function showModal() {
            var el = document.getElementById('addHoiVienModal');
            if (el && window.bootstrap) {
                bootstrap.Modal.getOrCreateInstance(el).show();
            } else {
                alert('Không tải được Bootstrap. Hãy kiểm tra kết nối Internet.');
            }
        }

        function setVal(id, value) {
            var el = document.getElementById(id);
            if (el) el.value = value;
        }

        // Nút "Thêm hội viên mới"
        function moFormThem() {
            // Xóa dữ liệu cũ (nếu còn sót sau khi bấm Sửa)
            setVal('hfID', '');
            setVal('txtHoTen', '');
            setVal('txtNgaySinh', '');
            setVal('txtDiaChi', '');
            var gt = document.getElementById('ddlGioiTinh');
            if (gt) gt.selectedIndex = 0;

            var title = document.getElementById('addHoiVienModalLabel');
            if (title) title.innerText = 'Thêm Hội Viên Mới';

            showModal();
        }
    </script>
</body>
</html>