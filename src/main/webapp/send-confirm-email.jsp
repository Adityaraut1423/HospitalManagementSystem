<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="java.util.*" %>
<%
    // 1. Session Check (Admin Security)
    String admin = (String) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Send Email Confirmation | Admin Portal</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts (Inter) -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8fafc;
            color: #334155;
        }

        .page-header {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            color: #ffffff;
            padding: 2.2rem 0;
            margin-bottom: 2.5rem;
            border-bottom: 4px solid #0284c7;
        }

        .card-custom {
            background: #ffffff;
            border: none;
            border-radius: 16px;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05), 0 8px 10px -6px rgba(0, 0, 0, 0.01);
        }

        .form-label {
            font-weight: 600;
            font-size: 0.88rem;
            color: #475569;
        }

        .form-control {
            border-radius: 10px;
            padding: 0.75rem 1rem;
            border: 1px solid #cbd5e1;
        }

        .form-control:focus {
            border-color: #0284c7;
            box-shadow: 0 0 0 0.25rem rgba(2, 132, 199, 0.15);
        }

        .input-group-text {
            border-radius: 10px 0 0 10px;
            background-color: #f8fafc;
            color: #64748b;
            border: 1px solid #cbd5e1;
        }

        .btn-submit {
            background-color: #0284c7;
            border-color: #0284c7;
            border-radius: 10px;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            transition: all 0.2s ease;
        }

        .btn-submit:hover {
            background-color: #0369a1;
            border-color: #0369a1;
            transform: translateY(-1px);
        }
    </style>
</head>
<body>

<!-- Header Banner -->
<div class="page-header">
    <div class="container d-flex justify-content-between align-items-center">
        <div>
            <h2 class="fw-bold mb-1"><i class="fa-solid fa-paper-plane me-2 text-info"></i>Manual Email Notification</h2>
            <p class="text-slate-300 mb-0 opacity-75 small">Dispatch appointment confirmation emails directly to patients</p>
        </div>
        <div>
            <a href="see-all-appointment.jsp" class="btn btn-outline-light btn-sm px-3">
                <i class="fa-solid fa-arrow-left me-1"></i> All Appointments
            </a>
        </div>
    </div>
</div>

<div class="container mb-5">
    <div class="row justify-content-center">
        <div class="col-lg-6 col-md-8">

            <!-- Status Alert Message (Supports request attribute & URL parameters) -->
            <% 
                String msg = (String) request.getAttribute("msg");
                if (msg == null) {
                    msg = request.getParameter("msg");
                }

                if (msg != null && !msg.trim().isEmpty()) { 
                    boolean isSuccess = msg.toLowerCase().contains("sent") || msg.toLowerCase().contains("success");
            %>
                <div class="alert alert-<%= isSuccess ? "success" : "warning" %> alert-dismissible fade show d-flex align-items-center gap-2 mb-4" role="alert">
                    <i class="fa-solid fa-circle-info"></i>
                    <div><%= msg %></div>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>

            <div class="card card-custom p-4 p-md-5">
                <div class="d-flex align-items-center gap-3 mb-4 pb-3 border-bottom">
                    <div class="p-3 bg-primary-subtle text-primary rounded-circle">
                        <i class="fa-solid fa-envelope-circle-check fa-xl"></i>
                    </div>
                    <div>
                        <h4 class="fw-bold mb-0 text-dark">Send Confirmation</h4>
                        <span class="text-muted small">Triggers automated SMTP email to patient's address</span>
                    </div>
                </div>

                <form action="SendConfirmEmailServlet" method="post">
                    
                    <!-- Appointment ID Input -->
                    <div class="mb-4">
                        <label for="appointmentId" class="form-label">Appointment ID</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-hashtag"></i></span>
                            <input type="number" id="appointmentId" name="appointmentId" class="form-control" placeholder="Ex: 17" min="1" required>
                        </div>
                        <div class="form-text small text-muted">
                            Enter the unique Appointment ID from the appointment table.
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4 pt-2">
                        <a href="see-all-appointment.jsp" class="btn btn-light px-4 py-2 me-md-2 fw-semibold border">Cancel</a>
                        <button type="submit" class="btn btn-submit text-white px-4 py-2">
                            <i class="fa-solid fa-paper-plane me-1"></i> Send Email
                        </button>
                    </div>

                </form>
            </div>

        </div>
    </div>
</div>

<!-- Bootstrap 5 Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>