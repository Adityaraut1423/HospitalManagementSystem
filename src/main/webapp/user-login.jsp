<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Login | Hospital Management System</title>
    
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
            margin: 0;
        }

        .login-card {
            background: rgba(255, 255, 255, 0.98);
            border-radius: 16px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 420px;
            padding: 2.5rem 2rem;
            transition: transform 0.3s ease;
        }

        .brand-icon {
            width: 60px;
            height: 60px;
            background: #e0f2fe;
            color: #0284c7;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.75rem;
            margin: 0 auto 1.25rem;
        }

        .form-floating > .form-control {
            border-radius: 10px;
            border: 1px solid #cbd5e1;
        }

        .form-floating > .form-control:focus {
            border-color: #0284c7;
            box-shadow: 0 0 0 0.25rem rgba(2, 132, 199, 0.15);
        }

        .btn-primary-custom {
            background-color: #0284c7;
            border: none;
            border-radius: 10px;
            padding: 0.8rem;
            font-weight: 600;
            letter-spacing: 0.3px;
            transition: all 0.2s ease;
        }

        .btn-primary-custom:hover {
            background-color: #0369a1;
            transform: translateY(-1px);
        }

        .password-toggle {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #64748b;
            z-index: 10;
        }
    </style>
</head>
<body>

<div class="container px-3">
    <div class="login-card mx-auto">
        
        <!-- Header / Logo -->
        <div class="text-center">
            <div class="brand-icon">
                <i class="fa-solid fa-hospital-user"></i>
            </div>
            <h3 class="fw-bold text-dark mb-1">Welcome Back</h3>
            <p class="text-muted small mb-4">Log in to access your healthcare portal</p>
        </div>

        <!-- Dynamic Feedback Message -->
        <% 
            String msg = request.getParameter("msg");
            if (msg != null && !msg.trim().isEmpty()) { 
        %>
            <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center gap-2 py-2 mb-4" role="alert">
                <i class="fa-solid fa-circle-exclamation flex-shrink-0"></i>
                <div class="small fw-medium"><%= msg %></div>
                <button type="button" class="btn-close small" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>

        <!-- Login Form -->
        <form action="UserLoginServlet" method="post" class="needs-validation" novalidate>
            
            <!-- Email Input -->
            <div class="form-floating mb-3">
                <input type="email" class="form-control" id="email" name="email" placeholder="name@example.com" required>
                <label for="email"><i class="fa-regular fa-envelope me-2 text-muted"></i>Email Address</label>
            </div>

            <!-- Password Input -->
            <div class="form-floating mb-3 position-relative">
                <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
                <label for="password"><i class="fa-solid fa-lock me-2 text-muted"></i>Password</label>
                <i class="fa-regular fa-eye password-toggle" id="togglePassword"></i>
            </div>

            <!-- Options Row -->
            <div class="d-flex justify-content-between align-items-center mb-4 small">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="rememberMe">
                    <label class="form-check-label text-muted" for="rememberMe">Remember me</label>
                </div>
                <a href="forgot-password.jsp" class="text-decoration-none fw-semibold style-color">Forgot Password?</a>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn btn-primary-custom btn-primary w-100 mb-3">
                <i class="fa-solid fa-right-to-bracket me-2"></i>Log In
            </button>
        </form>

        <!-- Footer Navigation -->
        <div class="text-center mt-3 pt-3 border-top">
            <p class="small text-muted mb-0">Don't have an account? 
                <a href="user-register.jsp" class="text-decoration-none fw-semibold">Register here</a>
            </p>
            <div class="mt-3">
                <a href="index.html" class="small text-secondary text-decoration-none">
                    <i class="fa-solid fa-arrow-left me-1"></i>Back to Home
                </a>
            </div>
        </div>

    </div>
</div>

<!-- Bootstrap 5 Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Interactive Form Scripts -->
<script>
    // Password Visibility Toggle
    const togglePassword = document.querySelector('#togglePassword');
    const password = document.querySelector('#password');

    togglePassword.addEventListener('click', function () {
        const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
        password.setAttribute('type', type);
        this.classList.toggle('fa-eye');
        this.classList.toggle('fa-eye-slash');
    });
</script>

</body>
</html>