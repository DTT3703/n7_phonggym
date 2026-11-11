<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GoiTap.aspx.cs" Inherits="n7_phonggym.GoiTap" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="vi">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Quản Lý Gói Tập & Dịch Vụ - Admin Panel</title>

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

        /* Ảnh gói tập */
        .goi-img {
            width: 56px;
            height: 56px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid #dee2e6;
        }

        .goi-noimg {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 56px;
            height: 56px;
            border-radius: 8px;
            background: #f1f3f5;
            color: #adb5bd;
            font-size: 1.4rem;
        }

        .preview-img {
            max-width: 100%;
            max-height: 160px;
            object-fit: contain;
            border-radius: 8px;
            border: 1px solid #dee2e6;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
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
                        <a href="GoiTap.aspx" class="nav-link active">
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
                    <h5 class="mb-0 fw-bold">Quản Lý Gói Tập & Dịch Vụ</h5>
                    <span class="text-muted small"><i class="bi bi-clock me-1"></i><%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></span>
                </header>

                <!-- Page Body Content -->
                <main class="main-content flex-grow-1">
                    <div class="row mb-4 align-items-center">
                        <div class="col-md-6">
                            <div class="input-group">
                                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" Placeholder="Tìm kiếm theo tên hoặc mã gói tập..."></asp:TextBox>
                                <asp:Button ID="btnSearch" runat="server" Text="Tìm kiếm" CssClass="btn btn-outline-secondary" OnClick="btnSearch_Click" />
                            </div>
                        </div>
                        <div class="col-md-6 text-end">
                            <button type="button" id="btnThemMoi" class="btn btn-success" onclick="moFormThem(); return false;">
                                <i class="bi bi-plus-circle me-1"></i> Thêm Gói Tập Mới
                            </button>
                        </div>
                    </div>

                    <!-- Bảng danh sách gói tập -->
                    <div class="card shadow-sm">
                        <div class="card-header bg-white py-3">
                            <h6 class="card-title mb-0 fw-bold"><i class="bi bi-card-checklist me-2"></i>Danh Sách Gói Tập Phổ Biến</h6>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <asp:GridView ID="gvGoiTap" runat="server" AutoGenerateColumns="False"
                                    CssClass="table table-hover align-middle mb-0" GridLines="None"
                                    DataKeyNames="ID_MGT" OnRowCommand="gvGoiTap_RowCommand">
                                    <Columns>
                                        <asp:BoundField DataField="ID_MGT" HeaderText="Mã Gói" />
                                        <asp:TemplateField HeaderText="Hình ảnh">
                                            <ItemTemplate>
                                                <asp:Image ID="imgAnh" runat="server" CssClass="goi-img"
                                                    ImageUrl='<%# LayUrlAnh(Eval("HinhAnh")) %>'
                                                    Visible='<%# CoAnh(Eval("HinhAnh")) %>' />
                                                <asp:PlaceHolder ID="phKhongAnh" runat="server" Visible='<%# !CoAnh(Eval("HinhAnh")) %>'>
                                                    <span class="goi-noimg"><i class="bi bi-image"></i></span>
                                                </asp:PlaceHolder>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="TenGoiTap" HeaderText="Tên Gói Tập" />
                                        <asp:BoundField DataField="SoThang" HeaderText="Thời Hạn (Tháng)" />
                                        <asp:BoundField DataField="SoLuotPT" HeaderText="Lượt PT" />
                                        <asp:BoundField DataField="SoLuotTuDo" HeaderText="Lượt Tập Tự Do" />
                                        <asp:BoundField DataField="MucGia" HeaderText="Mức Giá (VNĐ)" DataFormatString="{0:N0}" />
                                        <asp:TemplateField HeaderText="Thao tác">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkSua" runat="server" CommandName="SuaGT"
                                                    CommandArgument='<%# Eval("ID_MGT") %>'
                                                    CssClass="btn btn-sm btn-outline-primary me-1">
                                                    <i class="bi bi-pencil-square"></i> Sửa
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="lnkXoa" runat="server" CommandName="XoaGT"
                                                    CommandArgument='<%# Eval("ID_MGT") %>'
                                                    CssClass="btn btn-sm btn-outline-danger"
                                                    OnClientClick="return confirm('Bạn có chắc muốn xóa gói tập này?');">
                                                    <i class="bi bi-trash"></i> Xóa
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="table-light" />
                                    <EmptyDataTemplate>
                                        <div class="text-center text-muted py-4">Không có gói tập nào.</div>
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

        <!-- Modal Thêm / Sửa Gói Tập -->
        <div class="modal fade" id="addGoiTapModal" tabindex="-1" aria-labelledby="addGoiTapModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title fw-bold" id="addGoiTapModalLabel">
                            <asp:Literal ID="litTitle" runat="server" Text="Thêm Gói Tập Mới"></asp:Literal>
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <asp:HiddenField ID="hfID" runat="server" ClientIDMode="Static" />
                        <div class="mb-3">
                            <label class="form-label">Tên Gói Tập / Sản Phẩm</label>
                            <asp:TextBox ID="txtTenGoiTap" runat="server" ClientIDMode="Static" CssClass="form-control" Placeholder="Ví dụ: Gói Tập VIP 6 Tháng, Whey Protein 2kg..."></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Số Tháng</label>
                            <asp:TextBox ID="txtSoThang" runat="server" ClientIDMode="Static" TextMode="Number" CssClass="form-control" Placeholder="6"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Số Lượt PT Kèm</label>
                            <asp:TextBox ID="txtSoLuotPT" runat="server" ClientIDMode="Static" TextMode="Number" CssClass="form-control" Placeholder="12"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Số Lượt Tập Tự Do</label>
                            <asp:TextBox ID="txtSoLuotTuDo" runat="server" ClientIDMode="Static" TextMode="Number" CssClass="form-control" Placeholder="999"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Mức Giá (VNĐ)</label>
                            <asp:TextBox ID="txtMucGia" runat="server" ClientIDMode="Static" TextMode="Number" step="any" CssClass="form-control" Placeholder="5000000"></asp:TextBox>
                        </div>

                        <!-- Hình ảnh (không bắt buộc) -->
                        <div class="mb-3">
                            <label class="form-label">Hình ảnh <span class="text-muted small">(không bắt buộc)</span></label>

                            <!-- Ảnh hiện tại (chỉ hiện khi đang sửa gói đã có ảnh) -->
                            <div id="khuAnhHienTai" runat="server" ClientIDMode="Static" style="display:none" class="mb-2">
                                <asp:Image ID="imgHienTai" runat="server" ClientIDMode="Static" CssClass="preview-img d-block mb-2" />
                                <div class="form-check">
                                    <asp:CheckBox ID="chkXoaAnh" runat="server" ClientIDMode="Static" />
                                    <label class="form-check-label" for="chkXoaAnh">Xóa ảnh hiện tại</label>
                                </div>
                            </div>

                            <asp:FileUpload ID="fuAnh" runat="server" ClientIDMode="Static" CssClass="form-control" accept=".jpg,.jpeg,.png,.gif,.webp" onchange="xemTruocAnh(this)" />
                            <div class="form-text">JPG, PNG, GIF hoặc WEBP, tối đa 2 MB. Nếu sửa mà không chọn ảnh mới thì giữ nguyên ảnh cũ.</div>
                            <img id="anhMoiPreview" class="preview-img mt-2" style="display:none" alt="Xem trước" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        <asp:Button ID="btnSaveGoiTap" runat="server" Text="Lưu Gói Tập" CssClass="btn btn-success" OnClick="btnSaveGoiTap_Click" />
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Mở modal (dùng cho nút Thêm và cho nút Sửa từ code-behind)
        function showModal() {
            var el = document.getElementById('addGoiTapModal');
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

        // Xem trước ảnh vừa chọn
        function xemTruocAnh(input) {
            var img = document.getElementById('anhMoiPreview');
            if (!img) return;
            if (input.files && input.files[0]) {
                var f = input.files[0];
                if (f.size > 2 * 1024 * 1024) {
                    alert('Ảnh vượt quá 2 MB. Vui lòng chọn ảnh nhỏ hơn.');
                    input.value = '';
                    img.style.display = 'none';
                    return;
                }
                var reader = new FileReader();
                reader.onload = function (e) {
                    img.src = e.target.result;
                    img.style.display = 'block';
                };
                reader.readAsDataURL(f);
            } else {
                img.style.display = 'none';
            }
        }

        // Nút "Thêm Gói Tập Mới"
        function moFormThem() {
            // Xóa dữ liệu cũ (nếu còn sót sau khi bấm Sửa)
            setVal('hfID', '');
            setVal('txtTenGoiTap', '');
            setVal('txtSoThang', '');
            setVal('txtSoLuotPT', '');
            setVal('txtSoLuotTuDo', '');
            setVal('txtMucGia', '');

            // Reset phần ảnh
            setVal('fuAnh', '');
            var pv = document.getElementById('anhMoiPreview');
            if (pv) pv.style.display = 'none';
            var cur = document.getElementById('khuAnhHienTai');
            if (cur) cur.style.display = 'none';
            var chk = document.getElementById('chkXoaAnh');
            if (chk) chk.checked = false;

            var title = document.getElementById('addGoiTapModalLabel');
            if (title) title.innerText = 'Thêm Gói Tập Mới';

            showModal();
        }
    </script>
</body>
</html>