<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dao.*, com.model.*" %>
<%@ page session="true" %>
<%
    // 1. Session Authentication Check
    String admin = (String) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }

    // 2. Safe ID Validation (Prevents NumberFormatException)
    String idParam = request.getParameter("id");
    if (idParam == null || idParam.trim().isEmpty()) {
        response.sendRedirect("view-doctors.jsp");
        return;
    }

    int id = 0;
    try {
        id = Integer.parseInt(idParam.trim());
    } catch (NumberFormatException e) {
        response.sendRedirect("view-doctors.jsp");
        return;
    }

    // 3. Fetch Doctor Profile
    DoctorDAO dao = new DoctorDAO(DBConnect.getConn());
    Doctor d = dao.getDoctorById(id);

    if (d == null) {
        response.sendRedirect("view-doctors.jsp?msg=Doctor+not+found");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Doctor Timings | Admin Portal</title>
    
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

        .readonly-input {
            background-color: #f1f5f9 !important;
            color: #475569;
            cursor: not-allowed;
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
            <h2 class="fw-bold mb-1"><i class="fa-solid fa-user-pen me-2 text-info"></i>Edit Doctor Schedule</h2>
            <p class="text-slate-300 mb-0 opacity-75 small">Update consulting timings for registered medical specialists</p>
        </div>
        <div>
            <a href="view-doctors.jsp" class="btn btn-outline-light btn-sm px-3">
                <i class="fa-solid fa-arrow-left me-1"></i> Doctor Directory
            </a>
        </div>
    </div>
</div>

<div class="container mb-5">
    <div class="row justify-content-center">
        <div class="col-lg-7 col-md-9">

            <!-- Status Alert Banner -->
            <% 
                String msg = request.getParameter("msg");
                if (msg != null && !msg.trim().isEmpty()) { 
                    boolean isSuccess = msg.toLowerCase().contains("success");
            %>
                <div class="alert alert-<%= isSuccess ? "success" : "danger" %> alert-dismissible fade show d-flex align-items-center gap-2 mb-4" role="alert">
                    <i class="fa-solid fa-circle-info"></i>
                    <div><%= msg %></div>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>

            <div class="card card-custom p-4 p-md-5">
                <div class="d-flex align-items-center gap-3 mb-4 pb-3 border-bottom">
                    <div class="p-3 bg-primary-subtle text-primary rounded-circle">
                        <i class="fa-solid fa-user-doctor fa-xl"></i>
                    </div>
                    <div>
                        <h4 class="fw-bold mb-0 text-dark">Doctor Profile #<%= d.getId() %></h4>
                        <span class="text-muted small">Update available consulting hours below</span>
                    </div>
                </div>

                <form action="updateDoctor" method="post">
                    
                    <!-- Hidden Doctor ID -->
                    <input type="hidden" name="id" value="<%= d.getId() %>">

                    <!-- Doctor Full Name (Readonly) -->
                    <div class="mb-4">
                        <label for="doctorName" class="form-label">Doctor Name</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                            <input type="text" id="doctorName" class="form-control readonly-input" value="<%= d.getName() %>" readonly>
                        </div>
                    </div>

                    <!-- Medical Speciality (Readonly) -->
                    <div class="mb-4">
                        <label for="speciality" class="form-label">Medical Speciality</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-stethoscope"></i></span>
                            <input type="text" id="speciality" class="form-control readonly-input" value="<%= d.getSpeciality() %>" readonly>
                        </div>
                    </div>

                    <!-- Timings (Editable) -->
                    <div class="mb-4">
                        <label for="timings" class="form-label">Consulting Timings</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-regular fa-clock"></i></span>
                            <input type="text" id="timings" name="timings" class="form-control" value="<%= d.getTimings() %>" placeholder="Ex: 10AM - 2PM" required>
                        </div>
                        <div class="form-text small text-muted">Update available shifts (e.g., "10AM-2PM" or "4PM-8PM").</div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4 pt-2">
                        <a href="view-doctors.jsp" class="btn btn-light px-4 py-2 me-md-2 fw-semibold border">Cancel</a>
                        <button type="submit" class="btn btn-submit text-white px-4 py-2">
                            <i class="fa-solid fa-floppy-disk me-1"></i> Save Changes
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