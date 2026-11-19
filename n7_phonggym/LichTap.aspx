<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LichTap.aspx.cs" Inherits="n7_phonggym.LichTap" ResponseEncoding="utf-8" Culture="vi-VN" UICulture="vi-VN" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="vi">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Quản Lý Lịch Tập & PT - Admin Panel</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
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
        .stat-card {
            border: none;
            border-radius: 10px;
            transition: transform 0.15s ease;
        }
        .stat-card:hover {
            transform: translateY(-2px);
        }
        .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.4rem;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="d-flex">
            <!-- Sidebar -->
            <nav class="sidebar d-flex flex-column flex-shrink-0">
                <div class="brand-title">
                    <i class="bi bi-activity me-2"></i>Admin Panel
                </div>
                <ul class="nav nav-pills flex-column mb-auto mt-2">
                    <li class="nav-item">
                        <a href="WebForm1.aspx" class="nav-link"><i class="bi bi-speedometer2 me-2"></i>Tổng quan</a>
                    </li>
                    <li class="nav-item">
                        <a href="QuanLyHoiVien.aspx" class="nav-link"><i class="bi bi-people me-2"></i>Quản lý hội viên</a>
                    </li>
                    <li class="nav-item">
                        <a href="GoiTap.aspx" class="nav-link"><i class="bi bi-box-seam me-2"></i>Gói tập & Dịch vụ</a>
                    </li>
                    <li class="nav-item">
                        <a href="LichTap.aspx" class="nav-link active"><i class="bi bi-calendar-week me-2"></i>Lịch tập & PT</a>
                    </li>
                    <li class="nav-item">
                        <a href="Nhanvien.aspx" class="nav-link"><i class="bi bi-person-badge me-2"></i>Nhân viên</a>
                    </li>
                    <li class="nav-item">
                        <a href="Caidathethong.aspx" class="nav-link"><i class="bi bi-gear me-2"></i>Cài đặt hệ thống</a>
                    </li>
                </ul>
            </nav>

            <!-- Main Content -->
            <div class="w-100 d-flex flex-column min-vh-100">
                <header class="top-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 fw-bold">Quản Lý Lịch Tập & Huấn Luyện Viên (PT)</h5>
                    <span class="text-muted small"><i class="bi bi-clock me-1"></i><%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></span>
                </header>

                <main class="main-content flex-grow-1">
                    <asp:Panel ID="pnlThongBao" runat="server" Visible="false" CssClass="alert alert-dismissible fade show mb-4" role="alert">
                        <asp:Literal ID="litThongBao" runat="server"></asp:Literal>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </asp:Panel>

                    <!-- 4 Thẻ thống kê -->
                    <div class="row g-3 mb-4">
                        <div class="col-md-3 col-sm-6">
                            <div class="card stat-card shadow-sm h-100">
                                <div class="card-body d-flex align-items-center">
                                    <div class="stat-icon bg-primary bg-opacity-10 text-primary me-3">
                                        <i class="bi bi-calendar2-check"></i>
                                    </div>
                                    <div>
                                        <div class="text-muted small">Tổng buổi tập</div>
                                        <h4 class="mb-0 fw-bold"><asp:Literal ID="litTongBuoi" runat="server" Text="0" /></h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <div class="card stat-card shadow-sm h-100">
                                <div class="card-body d-flex align-items-center">
                                    <div class="stat-icon bg-success bg-opacity-10 text-success me-3">
                                        <i class="bi bi-person-workspace"></i>
                                    </div>
                                    <div>
                                        <div class="text-muted small">Đội ngũ PT</div>
                                        <h4 class="mb-0 fw-bold"><asp:Literal ID="litTongPT" runat="server" Text="0" /></h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <div class="card stat-card shadow-sm h-100">
                                <div class="card-body d-flex align-items-center">
                                    <div class="stat-icon bg-warning bg-opacity-10 text-warning me-3">
                                        <i class="bi bi-people-fill"></i>
                                    </div>
                                    <div>
                                        <div class="text-muted small">Tổng lượt học viên</div>
                                        <h4 class="mb-0 fw-bold"><asp:Literal ID="litTongHV" runat="server" Text="0" /></h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <div class="card stat-card shadow-sm h-100">
                                <div class="card-body d-flex align-items-center">
                                    <div class="stat-icon bg-info bg-opacity-10 text-info me-3">
                                        <i class="bi bi-award"></i>
                                    </div>
                                    <div>
                                        <div class="text-muted small">PT Chuyên gia VIP</div>
                                        <h4 class="mb-0 fw-bold"><asp:Literal ID="litPTChuyenGia" runat="server" Text="0" /></h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Thanh tìm kiếm & lọc -->
                    <div class="card shadow-sm mb-4">
                        <div class="card-body">
                            <div class="row g-2 align-items-end">
                                <div class="col-md-4">
                                    <label class="form-label small text-muted mb-1">Từ khóa</label>
                                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" Placeholder="Tên gói, khung giờ, nhận xét..."></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label small text-muted mb-1">Lọc theo PT</label>
                                    <asp:DropDownList ID="ddlFilterPT" runat="server" CssClass="form-select"></asp:DropDownList>
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label small text-muted mb-1">Ngày tập</label>
                                    <asp:TextBox ID="txtFilterNgay" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="col-md-3 d-flex gap-2 justify-content-md-end mt-3 mt-md-0">
                                    <asp:Button ID="btnSearch" runat="server" Text="Lọc" CssClass="btn btn-outline-primary" OnClick="btnSearch_Click" />
                                    <asp:Button ID="btnReset" runat="server" Text="Tất cả" CssClass="btn btn-outline-secondary" OnClick="btnReset_Click" />
                                    <button type="button" class="btn btn-success text-nowrap" onclick="moFormThem(); return false;">
                                        <i class="bi bi-plus-circle me-1"></i> Đặt Lịch Mới
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Bảng danh sách lịch tập -->
                    <div class="card shadow-sm">
                        <div class="card-header bg-white py-3">
                            <h6 class="card-title mb-0 fw-bold">
                                <i class="bi bi-calendar-check me-2 text-success"></i>Danh Sách Buổi Tập & Phân Công PT
                            </h6>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <asp:GridView ID="gvLichTap" runat="server" AutoGenerateColumns="False"
                                    CssClass="table table-hover align-middle mb-0" GridLines="None"
                                    DataKeyNames="ID_CTG,ID_MNV,NgayTap,KhungGio"
                                    OnRowCommand="gvLichTap_RowCommand">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Gói Tập / Lớp">
                                            <ItemTemplate>
                                                <div class="fw-semibold text-dark"><%# Eval("TenChiTietGoi") %></div>
                                                <small class="text-muted">Mã CT: #<%# Eval("ID_CTG") %> • <%# Eval("TenGoiTap") %></small>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Huấn Luyện Viên (PT)">
                                            <ItemTemplate>
                                                <div class="fw-semibold">
                                                    <%# Eval("TenPT") %>
                                                    <asp:Label ID="lblVIP" runat="server" Visible='<%# Convert.ToBoolean(Eval("LaChuyenGia")) %>'
                                                        CssClass="badge bg-warning text-dark ms-1">VIP</asp:Label>
                                                </div>
                                                <small class="text-muted"><%# Eval("ChuyenMon") %></small>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:BoundField DataField="NgayTap" HeaderText="Ngày Tập" DataFormatString="{0:dd/MM/yyyy}" />

                                        <asp:TemplateField HeaderText="Khung Giờ">
                                            <ItemTemplate>
                                                <span class="badge bg-light text-dark border">
                                                    <i class="bi bi-clock me-1 text-primary"></i><%# Eval("KhungGio") %>
                                                </span>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Sĩ Số">
                                            <ItemTemplate>
                                                <span class='<%# LayClassSiSo(Eval("SoLuongHV"), Eval("SoLuongHVToiDa")) %>'>
                                                    <%# Eval("SoLuongHV") %> / <%# Eval("SoLuongHVToiDa") %> HV
                                                </span>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:BoundField DataField="DanhGiaBuoi" HeaderText="Đánh Giá / Ghi Chú" />

                                        <asp:TemplateField HeaderText="Thao tác">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="btnEdit" runat="server" CommandName="SuaLich"
                                                    CommandArgument='<%# Container.DataItemIndex %>'
                                                    CausesValidation="false" CssClass="btn btn-sm btn-outline-primary me-1">
                                                    <i class="bi bi-pencil-square"></i> Sửa
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="XoaLich"
                                                    CommandArgument='<%# Container.DataItemIndex %>'
                                                    CausesValidation="false" CssClass="btn btn-sm btn-outline-danger"
                                                    OnClientClick="return confirm('Bạn có chắc chắn muốn xóa buổi tập này?');">
                                                    <i class="bi bi-trash"></i> Xóa
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="table-light" />
                                    <EmptyDataTemplate>
                                        <div class="text-center text-muted py-4">
                                            <i class="bi bi-calendar-x fs-3 d-block mb-2"></i>
                                            Chưa có lịch tập nào phù hợp.
                                        </div>
                                    </EmptyDataTemplate>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </main>

                <footer class="main-footer">
                    &copy; 2026 - Hệ thống quản lý phòng Gym (n7_phongGym).
                </footer>
            </div>
        </div>

        <!-- Modal Thêm / Sửa Lịch Tập -->
        <div class="modal fade" id="lichTapModal" tabindex="-1" aria-labelledby="lichTapModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title fw-bold" id="lichTapModalLabel">
                            <asp:Literal ID="litModalTitle" runat="server" Text="Đặt Lịch Tập Mới"></asp:Literal>
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <asp:HiddenField ID="hfMode" runat="server" ClientIDMode="Static" Value="ADD" />
                        <asp:HiddenField ID="hfOldCTG" runat="server" ClientIDMode="Static" />
                        <asp:HiddenField ID="hfOldMNV" runat="server" ClientIDMode="Static" />
                        <asp:HiddenField ID="hfOldNgay" runat="server" ClientIDMode="Static" />
                        <asp:HiddenField ID="hfOldGio" runat="server" ClientIDMode="Static" />

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Chi Tiết Gói Tập / Ca Lớp <span class="text-danger">*</span></label>
                            <asp:DropDownList ID="ddlChiTietGoi" runat="server" ClientIDMode="Static" CssClass="form-select"></asp:DropDownList>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Huấn Luyện Viên (PT) <span class="text-danger">*</span></label>
                            <asp:DropDownList ID="ddlPT" runat="server" ClientIDMode="Static" CssClass="form-select"></asp:DropDownList>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">Ngày Tập <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtNgayTap" runat="server" ClientIDMode="Static" TextMode="Date" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">Khung Giờ <span class="text-danger">*</span></label>
                                <asp:DropDownList ID="ddlKhungGio" runat="server" ClientIDMode="Static" CssClass="form-select">
                                    <asp:ListItem Text="06:00 - 07:30" Value="06:00 - 07:30"></asp:ListItem>
                                    <asp:ListItem Text="06:00 - 08:00" Value="06:00 - 08:00"></asp:ListItem>
                                    <asp:ListItem Text="08:00 - 09:30" Value="08:00 - 09:30"></asp:ListItem>
                                    <asp:ListItem Text="14:00 - 15:30" Value="14:00 - 15:30"></asp:ListItem>
                                    <asp:ListItem Text="16:00 - 18:00" Value="16:00 - 18:00"></asp:ListItem>
                                    <asp:ListItem Text="17:00 - 18:30" Value="17:00 - 18:30"></asp:ListItem>
                                    <asp:ListItem Text="18:00 - 20:00" Value="18:00 - 20:00"></asp:ListItem>
                                    <asp:ListItem Text="19:00 - 20:30" Value="19:00 - 20:30"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Số Lượng Hội Viên Tham Gia <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtSoLuongHV" runat="server" ClientIDMode="Static" TextMode="Number" min="0" CssClass="form-control" Text="1"></asp:TextBox>
                            <div class="form-text">Không vượt quá số lượng tối đa của chi tiết gói đã chọn.</div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Đánh Giá / Ghi Chú Buổi Tập</label>
                            <asp:TextBox ID="txtDanhGiaBuoi" runat="server" ClientIDMode="Static" TextMode="MultiLine" Rows="2" CssClass="form-control" Placeholder="Ví dụ: Tập Cardio + Ngực, hội viên tập trung..."></asp:TextBox>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        <asp:Button ID="btnSaveLichTap" runat="server" Text="Lưu Lịch Tập" CssClass="btn btn-success" OnClick="btnSaveLichTap_Click" />
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function showModal() {
            var el = document.getElementById('lichTapModal');
            if (el && window.bootstrap) {
                bootstrap.Modal.getOrCreateInstance(el).show();
            }
        }

        function moFormThem() {
            document.getElementById('hfMode').value = 'ADD';
            document.getElementById('hfOldCTG').value = '';
            document.getElementById('hfOldMNV').value = '';
            document.getElementById('hfOldNgay').value = '';
            document.getElementById('hfOldGio').value = '';

            var ddlGoi = document.getElementById('ddlChiTietGoi');
            if (ddlGoi && ddlGoi.options.length > 0) ddlGoi.selectedIndex = 0;

            var ddlPT = document.getElementById('ddlPT');
            if (ddlPT && ddlPT.options.length > 0) ddlPT.selectedIndex = 0;

            var today = new Date().toISOString().split('T')[0];
            document.getElementById('txtNgayTap').value = today;

            var ddlGio = document.getElementById('ddlKhungGio');
            if (ddlGio && ddlGio.options.length > 0) ddlGio.selectedIndex = 0;

            document.getElementById('txtSoLuongHV').value = '1';
            document.getElementById('txtDanhGiaBuoi').value = '';
            document.getElementById('lichTapModalLabel').innerText = 'Đặt Lịch Tập Mới';

            showModal();
        }
    </script>
</body>
</html>
