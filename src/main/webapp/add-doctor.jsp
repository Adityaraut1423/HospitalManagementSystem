<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
    // Session Check (Admin Security)
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
    <title>Add Doctor | Admin Portal</title>
    
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
            <h2 class="fw-bold mb-1"><i class="fa-solid fa-user-plus me-2 text-info"></i>Add New Doctor</h2>
            <p class="text-slate-300 mb-0 opacity-75 small">Register a new medical specialist to the hospital system</p>
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
                    <i class="fa-solid fa-circle-check"></i>
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
                        <h4 class="fw-bold mb-0 text-dark">Doctor Profile Details</h4>
                        <span class="text-muted small">All fields are required to register a doctor</span>
                    </div>
                </div>

                <form action="AddDoctorServlet" method="post">
                    
                    <!-- Doctor Name -->
                    <div class="mb-4">
                        <label for="doctorName" class="form-label">Doctor Full Name</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                            <input type="text" id="doctorName" name="name" class="form-control" placeholder="Ex: Anil Raut or Dr. Smith" required>
                        </div>
                        <div class="form-text small text-muted">"Dr." prefix will be attached automatically if omitted.</div>
                    </div>

                    <!-- Speciality -->
                    <div class="mb-4">
                        <label for="speciality" class="form-label">Medical Speciality</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-stethoscope"></i></span>
                            <select id="speciality" name="speciality" class="form-select" required>
                                <option value="" disabled selected>-- Select Speciality --</option>
                                <option value="Cardiologist">Cardiologist (Heart Specialist)</option>
                                <option value="Dermatologist">Dermatologist (Skin Specialist)</option>
                                <option value="Orthopedic">Orthopedic (Bone & Joint Specialist)</option>
                                <option value="Gynecologist">Gynecologist</option>
                                <option value="Neurologist">Neurologist (Brain & Nerve Specialist)</option>
                                <option value="Pediatrician">Pediatrician (Child Specialist)</option>
                                <option value="ENT Specialist">ENT Specialist (Ear, Nose, Throat)</option>
                                <option value="General Physician">General Physician</option>
                            </select>
                        </div>
                    </div>

                    <!-- Timings -->
                    <div class="mb-4">
                        <label for="timings" class="form-label">Available Consulting Timings</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-regular fa-clock"></i></span>
                            <input type="text" id="timings" name="timings" class="form-control" placeholder="Ex: 8AM-12PM or 2PM-6PM" required>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4 pt-2">
                        <a href="view-doctors.jsp" class="btn btn-light px-4 py-2 me-md-2 fw-semibold border">Cancel</a>
                        <button type="submit" class="btn btn-submit text-white px-4 py-2">
                            <i class="fa-solid fa-plus me-1"></i> Add Doctor
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