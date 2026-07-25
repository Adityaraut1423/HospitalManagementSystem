<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dao.*,com.model.*" %>
<%@ page session="true" %>
<%
    // Session Check (Admin / Staff Security)
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
    <title>Add Patient | Hospital Management</title>
    
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

        .form-control, .form-select {
            border-radius: 10px;
            padding: 0.75rem 1rem;
            border: 1px solid #cbd5e1;
        }

        .form-control:focus, .form-select:focus {
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
            <h2 class="fw-bold mb-1"><i class="fa-solid fa-user-plus me-2 text-info"></i>Register New Patient</h2>
            <p class="text-slate-300 mb-0 opacity-75 small">Create a new patient medical record in the database</p>
        </div>
        <div>
            <a href="search-patient.jsp" class="btn btn-outline-light btn-sm px-3">
                <i class="fa-solid fa-arrow-left me-1"></i> Patient Directory
            </a>
        </div>
    </div>
</div>

<div class="container mb-5">
    <div class="row justify-content-center">
        <div class="col-lg-8 col-md-10">

            <!-- Status Alert Message -->
            <% 
                String msg = request.getParameter("msg");
                if (msg != null && !msg.trim().isEmpty()) { 
                    boolean isSuccess = msg.toLowerCase().contains("success");
            %>
                <div class="alert alert-<%= isSuccess ? "success" : "danger" %> alert-dismissible fade show d-flex align-items-center gap-2 mb-4" role="alert">
                    <i class="fa-solid fa-circle-check"></i>
                    <div><%= msg %></div>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>

            <div class="card card-custom p-4 p-md-5">
                <div class="d-flex align-items-center gap-3 mb-4 pb-3 border-bottom">
                    <div class="p-3 bg-primary-subtle text-primary rounded-circle">
                        <i class="fa-solid fa-hospital-user fa-xl"></i>
                    </div>
                    <div>
                        <h4 class="fw-bold mb-0 text-dark">Patient Profile Information</h4>
                        <span class="text-muted small">Please fill in accurate personal and contact details</span>
                    </div>
                </div>

                <form action="AddPatientServlet" method="post">
                    
                    <div class="row g-3">
                        <!-- Full Name -->
                        <div class="col-md-6 mb-3">
                            <label for="name" class="form-label">Full Name</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                                <input type="text" id="name" name="name" class="form-control" placeholder="Ex: Rahul Sharma" required>
                            </div>
                        </div>

                        <!-- Email Address -->
                        <div class="col-md-6 mb-3">
                            <label for="email" class="form-label">Email Address</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-envelope"></i></span>
                                <input type="email" id="email" name="email" class="form-control" placeholder="patient@example.com" required>
                            </div>
                        </div>

                        <!-- Age -->
                        <div class="col-md-4 mb-3">
                            <label for="age" class="form-label">Age</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-cake-candles"></i></span>
                                <input type="number" id="age" name="age" class="form-control" min="0" max="120" placeholder="Years" required>
                            </div>
                        </div>

                        <!-- Gender -->
                        <div class="col-md-4 mb-3">
                            <label for="gender" class="form-label">Gender</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-venus-mars"></i></span>
                                <select id="gender" name="gender" class="form-select" required>
                                    <option value="" disabled selected>-- Select --</option>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>
                        </div>

                        <!-- Phone Number -->
                        <div class="col-md-4 mb-3">
                            <label for="phone" class="form-label">Phone Number</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-phone"></i></span>
                                <input type="tel" id="phone" name="phone" class="form-control" placeholder="10-digit mobile" required>
                            </div>
                        </div>

                        <!-- Address -->
                        <div class="col-12 mb-4">
                            <label for="address" class="form-label">Residential Address</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fa-solid fa-location-dot"></i></span>
                                <textarea id="address" name="address" class="form-control" rows="3" placeholder="Enter full address details..." required></textarea>
                            </div>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="d-grid gap-2 d-md-flex justify-content-md-end pt-2">
                        <a href="search-patient.jsp" class="btn btn-light px-4 py-2 me-md-2 fw-semibold border">Cancel</a>
                        <button type="submit" class="btn btn-submit text-white px-4 py-2">
                            <i class="fa-solid fa-plus me-1"></i> Register Patient
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