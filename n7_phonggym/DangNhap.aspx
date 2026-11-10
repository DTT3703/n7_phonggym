<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DangNhap.aspx.cs" Inherits="n7_phonggym.DangNhap" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="vi">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Đăng Nhập - Hệ Thống Quản Lý Phòng Gym</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet" />

    <style>
        :root {
            --primary-color: #10854d;
            --primary-hover: #0c6b3e;
        }

        body {
            background: linear-gradient(135deg, #e8f5e9 0%, #c8e6c9 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .login-card {
            border: none;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: 100%;
            max-width: 420px;
        }

        .login-header {
            background-color: var(--primary-color);
            color: #ffffff;
            padding: 30px 20px;
            text-align: center;
        }

        .login-header i {
            font-size: 2.5rem;
            margin-bottom: 8px;
        }

        .btn-custom {
            background-color: var(--primary-color);
            color: #ffffff;
            font-weight: 600;
            padding: 10px;
            border-radius: 8px;
            transition: all 0.3s;
        }

        .btn-custom:hover {
            background-color: var(--primary-hover);
            color: #ffffff;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(16, 133, 77, 0.25);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="card login-card">
            <!-- Header Card -->
            <div class="login-header">
                <i class="bi bi-activity"></i>
                <h4 class="fw-bold mb-1">QUẢN LÝ PHÒNG GYM</h4>
                <p class="small mb-0 opacity-75">Đăng nhập hệ thống quản trị</p>
            </div>

            <!-- Body Card -->
            <div class="card-body p-4 bg-white">
                <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="alert alert-danger py-2 small mb-3">
                    <asp:Literal ID="litMessage" runat="server"></asp:Literal>
                </asp:Panel>

                <!-- Tên đăng nhập -->
                <div class="mb-3">
                    <label class="form-label text-secondary fw-semibold small">Tên đăng nhập / Email</label>
                    <div class="input-group">
                        <span class="input-group-text bg-light text-muted"><i class="bi bi-person"></i></span>
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" Placeholder="Nhập tên đăng nhập"></asp:TextBox>
                    </div>
                </div>

                <!-- Mật khẩu -->
                <div class="mb-3">
                    <label class="form-label text-secondary fw-semibold small">Mật khẩu</label>
                    <div class="input-group">
                        <span class="input-group-text bg-light text-muted"><i class="bi bi-lock"></i></span>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" Placeholder="Nhập mật khẩu"></asp:TextBox>
                    </div>
                </div>

                <!-- Ghi nhớ & Quên mật khẩu -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div class="form-check">
                        <asp:CheckBox ID="chkRemember" runat="server" CssClass="form-check-input" />
                        <label class="form-check-label small text-secondary" for="chkRemember">Ghi nhớ đăng nhập</label>
                    </div>
                    <a href="#" class="small text-decoration-none text-success">Quên mật khẩu?</a>
                </div>

                <!-- Nút đăng nhập -->
                <asp:Button ID="btnLogin" runat="server" Text="ĐĂNG NHẬP" CssClass="btn btn-custom w-100 mb-3" OnClick="btnLogin_Click" />

                <!-- Footer thông tin thêm -->
                <div class="text-center mt-3">
                    <p class="small text-muted mb-0">Chưa có tài khoản? <a href="#" class="text-success fw-bold text-decoration-none">Liên hệ Admin</a></p>
                </div>
            </div>
        </div>
    </form>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/bootstrap.bundle.min.js"></script>
</body>
</html>