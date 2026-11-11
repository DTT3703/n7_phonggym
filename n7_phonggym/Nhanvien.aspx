<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NhanVien.aspx.cs" Inherits="n7_phonggym.NhanVien" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="vi">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Quản Lý Nhân Viên & PT - Admin Panel</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet" />

    <style>
        :root {
            --sidebar-bg: #10854d;
            --sidebar-hover: #0c6b3e;
            --sidebar-active: #0d6efd;
        }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f8f9fa; }
        .sidebar { width: 250px; background-color: var(--sidebar-bg); min-height: 100vh; color: #fff; }
        .sidebar .brand-title { font-size: 1.25rem; font-weight: bold; padding: 20px 15px; border-bottom: 1px solid rgba(255, 255, 255, 0.1); }
        .sidebar .nav-link { color: rgba(255, 255, 255, 0.85); padding: 12px 20px; margin: 4px 10px; border-radius: 6px; font-weight: 500; }
        .sidebar .nav-link:hover { color: #fff; background-color: var(--sidebar-hover); }
        .sidebar .nav-link.active { color: #fff; background-color: var(--sidebar-active); }
        .top-header { background-color: #fff; padding: 15px 30px; border-bottom: 1px solid #e9ecef; }
        .main-content { padding: 30px; }
        footer.main-footer { text-align: center; padding: 15px; color: #6c757d; font-size: 0.875rem; margin-top: auto; }
        .table th, .table td { white-space: nowrap; }
        .pager-grid td { text-align: center; padding: 12px; }
        .pager-grid a, .pager-grid span { display: inline-block; padding: 4px 10px; margin: 0 2px; border-radius: 4px; text-decoration: none; }
        .pager-grid a { color: #0d6efd; border: 1px solid #dee2e6; }
        .pager-grid span { background: #0d6efd; color: #fff; }
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
                        <a href="WebForm1.aspx" class="nav-link"><i class="bi bi-speedometer2 me-2"></i>Tổng quan</a>
                    </li>
                    <li class="nav-item">
                        <a href="QuanLyHoiVien.aspx" class="nav-link"><i class="bi bi-people me-2"></i>Quản lý hội viên</a>
                    </li>
                    <li class="nav-item">
                        <a href="GoiTap.aspx" class="nav-link"><i class="bi bi-box-seam me-2"></i>Gói tập & Dịch vụ</a>
                    </li>
                    <li class="nav-item">
                        <a href="LichTap.aspx" class="nav-link"><i class="bi bi-calendar-week me-2"></i>Lịch tập & PT</a>
                    </li>
                    <li class="nav-item">
                        <a href="NhanVien.aspx" class="nav-link active"><i class="bi bi-person-badge me-2"></i>Nhân viên</a>
                    </li>
                    <li class="nav-item">
                        <a href="CaiDatHeThong.aspx" class="nav-link"><i class="bi bi-gear me-2"></i>Cài đặt hệ thống</a>
                    </li>
                </ul>
            </nav>

            <!-- Main Content Container -->
            <div class="w-100 d-flex flex-column min-vh-100">
                <header class="top-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 fw-bold">Quản Lý Nhân Viên & Huấn Luyện Viên (PT)</h5>
                    <span class="text-muted small"><i class="bi bi-clock me-1"></i><%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></span>
                </header>

                <main class="main-content flex-grow-1">

                    <!-- Thông báo kết quả / lỗi -->
                    <asp:Label ID="lblMessage" runat="server" Visible="false" EnableViewState="false"></asp:Label>

                    <!-- Thống kê nhanh -->
                    <div class="row g-3 mb-4">
                        <div class="col-md-3">
                            <div class="card shadow-sm"><div class="card-body py-3">
                                <div class="text-muted small">Tổng nhân sự</div>
                                <div class="fs-4 fw-bold"><asp:Label ID="lblTong" runat="server" Text="0"></asp:Label></div>
                            </div></div>
                        </div>
                        <div class="col-md-3">
                            <div class="card shadow-sm"><div class="card-body py-3">
                                <div class="text-muted small">Huấn luyện viên</div>
                                <div class="fs-4 fw-bold text-primary"><asp:Label ID="lblHLV" runat="server" Text="0"></asp:Label></div>
                            </div></div>
                        </div>
                        <div class="col-md-3">
                            <div class="card shadow-sm"><div class="card-body py-3">
                                <div class="text-muted small">PT chuyên gia</div>
                                <div class="fs-4 fw-bold text-warning"><asp:Label ID="lblPT" runat="server" Text="0"></asp:Label></div>
                            </div></div>
                        </div>
                        <div class="col-md-3">
                            <div class="card shadow-sm"><div class="card-body py-3">
                                <div class="text-muted small">Nhân viên khác</div>
                                <div class="fs-4 fw-bold text-secondary"><asp:Label ID="lblKhac" runat="server" Text="0"></asp:Label></div>
                            </div></div>
                        </div>
                    </div>

                    <!-- Tìm kiếm, lọc, nút thêm -->
                    <asp:Panel ID="pnlTimKiem" runat="server" DefaultButton="btnSearch">
                        <div class="row mb-4 align-items-center">
                            <div class="col-md-8">
                                <div class="input-group">
                                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"
                                        placeholder="Tìm kiếm tên nhân viên, chuyên môn, trình độ..."></asp:TextBox>
                                    <asp:DropDownList ID="ddlLocVaiTro" runat="server" CssClass="form-select"
                                        style="max-width: 200px;" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlLocVaiTro_SelectedIndexChanged">
                                        <asp:ListItem Value="" Text="Tất cả vai trò"></asp:ListItem>
                                        <asp:ListItem Value="NV" Text="Nhân viên"></asp:ListItem>
                                        <asp:ListItem Value="HLV" Text="Huấn luyện viên"></asp:ListItem>
                                        <asp:ListItem Value="PT" Text="PT chuyên gia"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:Button ID="btnSearch" runat="server" Text="Tìm kiếm" CssClass="btn btn-outline-secondary"
                                        CausesValidation="false" OnClick="btnSearch_Click" />
                                    <asp:Button ID="btnReset" runat="server" Text="Xóa lọc" CssClass="btn btn-outline-secondary"
                                        CausesValidation="false" OnClick="btnReset_Click" />
                                </div>
                            </div>
                            <div class="col-md-4 text-end">
                                <asp:LinkButton ID="btnMoThem" runat="server" CssClass="btn btn-primary"
                                    CausesValidation="false" OnClick="btnMoThem_Click">
                                    <i class="bi bi-person-plus-fill me-1"></i> Thêm Nhân Viên Mới
                                </asp:LinkButton>
                            </div>
                        </div>
                    </asp:Panel>

                    <!-- Bảng danh sách Nhân viên -->
                    <div class="card shadow-sm">
                        <div class="card-header bg-white py-3">
                            <h6 class="card-title mb-0 fw-bold"><i class="bi bi-person-badge-fill me-2"></i>Danh Sách Nhân Viên & Huấn Luyện Viên</h6>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <asp:GridView ID="gvNhanVien" runat="server" AutoGenerateColumns="False"
                                    CssClass="table table-hover align-middle mb-0" GridLines="None"
                                    DataKeyNames="ID_MNV" AllowPaging="True" PageSize="10"
                                    OnPageIndexChanging="gvNhanVien_PageIndexChanging"
                                    OnRowCommand="gvNhanVien_RowCommand">
                                    <PagerStyle CssClass="pager-grid" />
                                    <EmptyDataTemplate>
                                        <div class="text-center text-muted py-4">Không có nhân viên nào phù hợp.</div>
                                    </EmptyDataTemplate>
                                    <Columns>
                                        <asp:BoundField DataField="ID_MNV" HeaderText="Mã NV" />
                                        <asp:BoundField DataField="HoTen" HeaderText="Họ và Tên" />
                                        <asp:BoundField DataField="NgaySinh" HeaderText="Ngày Sinh" DataFormatString="{0:dd/MM/yyyy}" />
                                        <asp:BoundField DataField="GioiTinh" HeaderText="Giới Tính" />
                                        <asp:BoundField DataField="TrinhDo" HeaderText="Trình Độ" />
                                        <asp:BoundField DataField="ChuyenMon" HeaderText="Chuyên Môn" />
                                        <asp:TemplateField HeaderText="Vai Trò">
                                            <ItemTemplate>
                                                <span class='badge <%# BadgeClass(Eval("VaiTro")) %>'><%# Eval("VaiTro") %></span>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="GiaBieuDay" HeaderText="Giá Biểu Dạy" DataFormatString="{0:N0} VNĐ" NullDisplayText="-" />
                                        <asp:BoundField DataField="HeSoHoaHong" HeaderText="Hệ Số HH" DataFormatString="{0:0.##}" NullDisplayText="-" />
                                        <asp:BoundField DataField="PhuCapVIP" HeaderText="Phụ Cấp VIP" DataFormatString="{0:N0} VNĐ" NullDisplayText="-" />
                                        <asp:BoundField DataField="HeSoKinhNghiem" HeaderText="Hệ Số KN" DataFormatString="{0:0.##}" NullDisplayText="-" />
                                        <asp:TemplateField HeaderText="Thao tác">
                                            <ItemTemplate>
                                                <asp:LinkButton runat="server" CssClass="btn btn-sm btn-outline-primary me-1"
                                                    CommandName="Sua" CommandArgument='<%# Eval("ID_MNV") %>' CausesValidation="false">
                                                    <i class="bi bi-pencil-square"></i> Sửa
                                                </asp:LinkButton>
                                                <asp:LinkButton runat="server" CssClass="btn btn-sm btn-outline-danger"
                                                    CommandName="Xoa" CommandArgument='<%# Eval("ID_MNV") %>' CausesValidation="false"
                                                    OnClientClick="return confirm('Xóa nhân viên này? Toàn bộ lịch tập và thông tin HLV/PT liên quan cũng sẽ bị xóa.');">
                                                    <i class="bi bi-trash"></i> Xóa
                                                </asp:LinkButton>
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

        <!-- Modal Thêm / Sửa Nhân Viên -->
        <div class="modal fade" id="addNhanVienModal" tabindex="-1" aria-labelledby="addNhanVienModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title fw-bold" id="addNhanVienModalLabel">
                            <asp:Label ID="lblModalTitle" runat="server" Text="Thêm Nhân Viên / Huấn Luyện Viên Mới"></asp:Label>
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <asp:Label ID="lblModalError" runat="server" Visible="false" CssClass="alert alert-danger d-block"></asp:Label>
                        <asp:HiddenField ID="hfID" runat="server" />

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Họ và Tên</label>
                                <asp:TextBox ID="txtHoTen" runat="server" CssClass="form-control" placeholder="Nguyễn Văn A" MaxLength="100"></asp:TextBox>
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
                                    <asp:ListItem Text="Khác" Value="Khác"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Trình Độ</label>
                                <asp:TextBox ID="txtTrinhDo" runat="server" CssClass="form-control" placeholder="Cử nhân ĐH Thể Dục Thể Thao" MaxLength="100"></asp:TextBox>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Chuyên Môn / Lĩnh Vực</label>
                                <asp:TextBox ID="txtChuyenMon" runat="server" CssClass="form-control" placeholder="Tăng cơ giảm mỡ, Gym, Yoga, Lễ tân..." MaxLength="100"></asp:TextBox>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Vai Trò</label>
                                <asp:DropDownList ID="ddlVaiTro" runat="server" CssClass="form-select">
                                    <asp:ListItem Text="Nhân viên (lễ tân, vệ sinh, ...)" Value="NV"></asp:ListItem>
                                    <asp:ListItem Text="Huấn luyện viên" Value="HLV"></asp:ListItem>
                                    <asp:ListItem Text="PT chuyên gia" Value="PT"></asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <div id="boxHLV" class="col-12">
                                <hr />
                                <h6 class="fw-bold text-success mb-3"><i class="bi bi-award me-1"></i>Thông tin Huấn Luyện Viên</h6>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Giá Biểu Dạy (đ/buổi)</label>
                                        <asp:TextBox ID="txtGiaBieuDay" runat="server" TextMode="Number" CssClass="form-control" placeholder="300000" step="any" min="0"></asp:TextBox>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Hệ Số Hoa Hồng</label>
                                        <asp:TextBox ID="txtHeSoHoaHong" runat="server" TextMode="Number" CssClass="form-control" placeholder="0.15" step="any" min="0"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div id="boxPT" class="col-12">
                                <h6 class="fw-bold text-warning mb-3"><i class="bi bi-star me-1"></i>Thông tin PT Chuyên Gia</h6>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Phụ Cấp VIP (đ)</label>
                                        <asp:TextBox ID="txtPhuCapVIP" runat="server" TextMode="Number" CssClass="form-control" placeholder="2000000" step="any" min="0"></asp:TextBox>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Hệ Số Kinh Nghiệm</label>
                                        <asp:TextBox ID="txtHeSoKinhNghiem" runat="server" TextMode="Number" CssClass="form-control" placeholder="1.5" step="any" min="0"></asp:TextBox>
                                    </div>
                                </div>
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Tìm theo hậu tố ID để không phụ thuộc cách ASP.NET sinh ClientID
        function getEl(suffix) {
            return document.querySelector('[id$="' + suffix + '"]');
        }

        // Ẩn/hiện các ô nhập theo vai trò đang chọn
        function applyRole() {
            var ddl = getEl('ddlVaiTro');
            var boxHLV = document.getElementById('boxHLV');
            var boxPT = document.getElementById('boxPT');
            if (!ddl || !boxHLV || !boxPT) return;
            var role = ddl.value;
            boxHLV.style.display = (role === 'HLV' || role === 'PT') ? '' : 'none';
            boxPT.style.display = (role === 'PT') ? '' : 'none';
        }

        // Được server gọi sau khi bấm Thêm / Sửa (hoặc khi lưu bị lỗi)
        function showNhanVienModal() {
            try { applyRole(); } catch (e) { console.error(e); }
            var el = document.getElementById('addNhanVienModal');
            if (!el || typeof bootstrap === 'undefined') {
                console.error('Không mở được modal: thiếu phần tử modal hoặc Bootstrap JS chưa tải.');
                return;
            }
            bootstrap.Modal.getOrCreateInstance(el).show();
        }

        window.addEventListener('load', function () {
            var ddl = getEl('ddlVaiTro');
            if (ddl) ddl.addEventListener('change', applyRole);
            applyRole();
        });
    </script>
</body>
</html>