<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login | Hospital Management System</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts (Inter) -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #334155;
            margin: 0;
            padding: 1rem;
        }

        .login-card {
            background: #ffffff;
            border: none;
            border-radius: 16px;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.2), 0 8px 10px -6px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: 100%;
            max-width: 400px;
        }

        .login-header {
            background-color: #f8fafc;
            border-bottom: 1px solid #f1f5f9;
            padding: 2rem 1.5rem 1.25rem;
            text-align: center;
        }

        .brand-icon {
            width: 52px;
            height: 52px;
            background-color: #e0f2fe;
            color: #0284c7;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.4rem;
            margin-bottom: 0.75rem;
        }

        .form-label {
            font-weight: 600;
            font-size: 0.88rem;
            color: #475569;
            margin-bottom: 0.4rem;
        }

        /* Unified Input Container (Fixes Focus Outline Bug) */
        .custom-input-group {
            display: flex;
            align-items: center;
            border: 1px solid #cbd5e1;
            border-radius: 10px;
            background-color: #ffffff;
            overflow: hidden;
            transition: all 0.2s ease-in-out;
        }

        .custom-input-group:focus-within {
            border-color: #0284c7;
            box-shadow: 0 0 0 0.25rem rgba(2, 132, 199, 0.15);
        }

        .custom-input-group .input-icon {
            padding: 0.75rem 1rem;
            background-color: #f8fafc;
            color: #64748b;
            border-right: 1px solid #cbd5e1;
            display: flex;
            align-items: center;
            justify-content: center;
            min-width: 46px;
        }

        .custom-input-group .form-control-custom {
            border: none;
            outline: none;
            box-shadow: none;
            padding: 0.75rem 1rem;
            width: 100%;
            font-size: 0.95rem;
            color: #1e293b;
            background: transparent;
        }

        .custom-input-group .form-control-custom::placeholder {
            color: #94a3b8;
        }

        .btn-login {
            background-color: #0284c7;
            border: none;
            border-radius: 10px;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            font-size: 0.95rem;
            transition: all 0.2s ease;
        }

        .btn-login:hover {
            background-color: #0369a1;
            transform: translateY(-1px);
        }

        .footer-link {
            color: #64748b;
            text-decoration: none;
            font-size: 0.85rem;
            font-weight: 500;
            transition: color 0.2s ease;
        }

        .footer-link:hover {
            color: #0284c7;
        }
    </style>
</head>
<body>

<div class="card login-card">
    
    <!-- Header -->
    <div class="login-header">
        <div class="brand-icon shadow-sm">
            <i class="fa-solid fa-hospital"></i>
        </div>
        <h4 class="fw-bold text-dark mb-1">Admin Portal</h4>
        <span class="text-muted small">Hospital Management System</span>
    </div>

    <!-- Body -->
    <div class="card-body p-4">

        <!-- Error Alert (Strict Conditional: Renders ONLY when a non-empty message exists) -->
        <% 
            String errorMsg = (String) request.getAttribute("msg");
            if (errorMsg == null || errorMsg.trim().isEmpty()) {
                errorMsg = request.getParameter("msg");
            }
            if (errorMsg != null && !errorMsg.trim().isEmpty()) { 
        %>
            <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center gap-2 mb-4 py-2 px-3" role="alert">
                <i class="fa-solid fa-circle-exclamation"></i>
                <div class="small fw-medium"><%= errorMsg %></div>
                <button type="button" class="btn-close small py-2 px-3" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>

        <form action="AdminLoginServlet" method="post">
            
            <!-- Username Input -->
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <div class="custom-input-group">
                    <span class="input-icon"><i class="fa-solid fa-user"></i></span>
                    <input type="text" id="username" name="username" class="form-control-custom" placeholder="Enter username" required autocomplete="username">
                </div>
            </div>

            <!-- Password Input -->
            <div class="mb-4">
                <label for="password" class="form-label">Password</label>
                <div class="custom-input-group">
                    <span class="input-icon"><i class="fa-solid fa-lock"></i></span>
                    <input type="password" id="password" name="password" class="form-control-custom" placeholder="Enter password" required autocomplete="current-password">
                </div>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn btn-login btn-primary w-100 text-white mb-2">
                <i class="fa-solid fa-right-to-bracket me-1"></i> Sign In
            </button>

        </form>
    </div>

    <!-- Footer -->
    <div class="card-footer bg-light border-top-0 text-center py-3">
        <a href="index.html" class="footer-link">
            <i class="fa-solid fa-arrow-left me-1"></i> Back to Main Site
        </a>
    </div>

</div>

<!-- Bootstrap 5 Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>