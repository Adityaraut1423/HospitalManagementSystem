<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
    // Auto-redirect if user is already logged in
    String admin = (String) session.getAttribute("admin");
    String doctor = (String) session.getAttribute("doctor");
    String user = (String) session.getAttribute("user");

    if (admin != null) {
        response.sendRedirect("admin-dashboard.jsp");
        return;
    } else if (doctor != null) {
        response.sendRedirect("doctor-dashboard.jsp");
        return;
    } else if (user != null) {
        response.sendRedirect("user-dashboard.jsp");
        return;
    }

    String errorMsg = request.getParameter("error");
    String successMsg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>User Registration | Hospital Portal</title>
  
  <!-- Modern Font Inter -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
  <!-- FontAwesome Icons -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

  <style>
    :root {
      --bg-gradient: linear-gradient(135deg, #0f172a 0%, #1e293b 50%, #0f172a 100%);
      --accent-blue: #0284c7;
      --accent-glow: rgba(2, 132, 199, 0.35);
      --card-bg: rgba(255, 255, 255, 0.96);
      --glass-border: rgba(255, 255, 255, 0.18);
      --text-main: #0f172a;
      --text-muted: #64748b;
    }

    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
      font-family: 'Plus Jakarta Sans', -apple-system, BlinkMacSystemFont, sans-serif;
    }

    body {
      background: var(--bg-gradient);
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      position: relative;
      overflow-x: hidden;
      padding: 24px 20px;
    }

    /* Ambient Background Light Orbs */
    .orb {
      position: absolute;
      border-radius: 50%;
      filter: blur(90px);
      z-index: 0;
      pointer-events: none;
    }
    .orb-1 {
      width: 400px;
      height: 400px;
      background: rgba(14, 165, 233, 0.22);
      top: -100px;
      left: -100px;
    }
    .orb-2 {
      width: 350px;
      height: 350px;
      background: rgba(99, 102, 241, 0.18);
      bottom: -80px;
      right: -80px;
    }

    .portal-wrapper {
      position: relative;
      z-index: 1;
      width: 100%;
      max-width: 440px;
    }

    /* Glassmorphic Container Card */
    .portal-card {
      background: var(--card-bg);
      backdrop-filter: blur(16px);
      border: 1px solid rgba(255, 255, 255, 0.8);
      border-radius: 24px;
      padding: 42px 36px 32px 36px;
      box-shadow: 
        0 20px 40px -15px rgba(0, 0, 0, 0.35),
        0 0 0 1px rgba(255, 255, 255, 0.1) inset;
      transition: transform 0.3s cubic-bezier(0.16, 1, 0.3, 1);
    }

    .brand-badge {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      padding: 6px 14px;
      background: rgba(2, 132, 199, 0.08);
      border: 1px solid rgba(2, 132, 199, 0.2);
      border-radius: 100px;
      color: var(--accent-blue);
      font-size: 0.78rem;
      font-weight: 700;
      letter-spacing: 0.5px;
      text-transform: uppercase;
      margin-bottom: 20px;
    }

    .brand-header h1 {
      color: var(--text-main);
      font-size: 1.65rem;
      font-weight: 800;
      letter-spacing: -0.03em;
      margin-bottom: 6px;
    }

    .brand-header p {
      color: var(--text-muted);
      font-size: 0.9rem;
      font-weight: 400;
      margin-bottom: 28px;
    }

    /* System Status Message / Alerts */
    .status-alert {
      padding: 12px 16px;
      border-radius: 12px;
      font-size: 0.85rem;
      font-weight: 500;
      margin-bottom: 22px;
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .alert-success {
      background: rgba(16, 185, 129, 0.1);
      border: 1px solid rgba(16, 185, 129, 0.25);
      color: #065f46;
    }

    .alert-error {
      background: rgba(239, 68, 68, 0.1);
      border: 1px solid rgba(239, 68, 68, 0.25);
      color: #991b1b;
    }

    /* Input Field Design */
    .form-group {
      position: relative;
      margin-bottom: 20px;
    }

    .input-wrapper {
      position: relative;
      display: flex;
      align-items: center;
    }

    .input-icon {
      position: absolute;
      left: 16px;
      color: #94a3b8;
      font-size: 1.05rem;
      transition: color 0.2s ease;
      pointer-events: none;
    }

    .custom-input {
      width: 100%;
      padding: 14px 16px 14px 48px;
      background: #f8fafc;
      border: 1.5px solid #e2e8f0;
      border-radius: 14px;
      font-size: 0.95rem;
      color: var(--text-main);
      font-weight: 500;
      outline: none;
      transition: all 0.25s cubic-bezier(0.16, 1, 0.3, 1);
    }

    .custom-input:focus {
      background: #ffffff;
      border-color: var(--accent-blue);
      box-shadow: 0 0 0 4px var(--accent-glow);
    }

    .custom-input:focus + .input-icon {
      color: var(--accent-blue);
    }

    /* Premium Submit Button */
    .submit-btn {
      width: 100%;
      padding: 14px;
      background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%);
      color: #ffffff;
      border: none;
      border-radius: 14px;
      font-size: 0.98rem;
      font-weight: 700;
      cursor: pointer;
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 10px;
      box-shadow: 0 8px 20px -4px var(--accent-glow);
      transition: all 0.25s ease;
      margin-top: 10px;
    }

    .submit-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 12px 25px -4px rgba(2, 132, 199, 0.5);
      background: linear-gradient(135deg, #0369a1 0%, #075985 100%);
    }

    .submit-btn:active {
      transform: translateY(0);
    }

    /* Footer Back to Login Link */
    .login-footer-link {
      margin-top: 24px;
      padding-top: 20px;
      border-top: 1px dashed #cbd5e1;
      text-align: center;
      font-size: 0.88rem;
      color: var(--text-muted);
    }

    .login-footer-link a {
      color: var(--accent-blue);
      text-decoration: none;
      font-weight: 700;
      margin-left: 4px;
    }

    .login-footer-link a:hover {
      text-decoration: underline;
    }

    .footer-note {
      text-align: center;
      margin-top: 18px;
      font-size: 0.82rem;
      color: #94a3b8;
    }

    .footer-note a {
      color: var(--text-muted);
      text-decoration: none;
      font-weight: 600;
    }
  </style>
</head>
<body>

  <!-- Ambient background Orbs -->
  <div class="orb orb-1"></div>
  <div class="orb orb-2"></div>

  <div class="portal-wrapper">
    <div class="portal-card">
      
      <!-- Brand Tag -->
      <div class="brand-badge">
        <i class="fa-solid fa-hospital-user"></i> Patient Portal
      </div>

      <div class="brand-header">
        <h1>User Registration</h1>
        <p>Create an account to manage records and appointments</p>
      </div>

      <!-- Alert Dynamic Messaging -->
      <% if (successMsg != null && !successMsg.isEmpty()) { %>
        <div class="status-alert alert-success">
          <i class="fa-solid fa-circle-check"></i> <%= successMsg %>
        </div>
      <% } %>

      <% if (errorMsg != null && !errorMsg.isEmpty()) { %>
        <div class="status-alert alert-error">
          <i class="fa-solid fa-circle-exclamation"></i> <%= errorMsg %>
        </div>
      <% } %>

      <!-- Registration Form -->
      <form action="UserRegisterServlet" method="POST">
        
        <!-- Name Field -->
        <div class="form-group">
          <div class="input-wrapper">
            <input type="text" name="name" class="custom-input" placeholder="Full Name" required autocomplete="name">
            <i class="fa-solid fa-user input-icon"></i>
          </div>
        </div>

        <!-- Email Field -->
        <div class="form-group">
          <div class="input-wrapper">
            <input type="email" name="email" class="custom-input" placeholder="Email Address" required autocomplete="email">
            <i class="fa-solid fa-envelope input-icon"></i>
          </div>
        </div>

        <!-- Mobile Field -->
        <div class="form-group">
          <div class="input-wrapper">
            <input type="tel" name="mobile" class="custom-input" placeholder="Mobile Number" required autocomplete="tel">
            <i class="fa-solid fa-phone input-icon"></i>
          </div>
        </div>

        <!-- Password Field -->
        <div class="form-group">
          <div class="input-wrapper">
            <input type="password" name="password" class="custom-input" placeholder="Password" required autocomplete="new-password">
            <i class="fa-solid fa-lock input-icon"></i>
          </div>
        </div>

        <!-- Submit Button -->
        <button type="submit" class="submit-btn">
          <span>Create Account</span>
          <i class="fa-solid fa-arrow-right"></i>
        </button>

      </form>

      <!-- Back to Login CTA -->
      <div class="login-footer-link">
        Already have an account? <a href="index.jsp">Sign in here</a>
      </div>

      <div class="footer-note">
        Need assistance? <a href="#">Contact IT Helpdesk</a>
      </div>

    </div>
  </div>

</body>
</html>