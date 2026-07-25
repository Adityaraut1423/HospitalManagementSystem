<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.dao.*" %>
<%@ page session="true" %>
<%
    // 1. Session Authentication Check
    String admin = (String) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }

    String appointmentIdParam = request.getParameter("appointmentId");
    int appointmentId = 0;
    String patientName = "";
    int patientId = 0;
    int doctorId = 0;

    if (appointmentIdParam != null && !appointmentIdParam.trim().isEmpty()) {
        try (Connection conn = DBConnect.getConn()) {
            appointmentId = Integer.parseInt(appointmentIdParam.trim());
            String sql = "SELECT * FROM appointment WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, appointmentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                patientId = rs.getInt("patient_id");
                patientName = rs.getString("patient_name");
                doctorId = rs.getInt("doctor_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Generate Patient Bill | Admin Portal</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f8fafc; color: #334155; }
        .page-header { background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%); color: #ffffff; padding: 2.2rem 0; margin-bottom: 2.5rem; border-bottom: 4px solid #0284c7; }
        .card-custom { background: #ffffff; border: none; border-radius: 16px; box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05); }
        .form-label { font-weight: 600; font-size: 0.88rem; color: #475569; }
        .form-control { border-radius: 10px; padding: 0.75rem 1rem; border: 1px solid #cbd5e1; }
        .form-control:focus { border-color: #0284c7; box-shadow: 0 0 0 0.25rem rgba(2, 132, 199, 0.15); }
        .btn-submit { background-color: #0284c7; border-color: #0284c7; border-radius: 10px; padding: 0.75rem 1.5rem; font-weight: 600; color: #fff; }
        .btn-submit:hover { background-color: #0369a1; color: #fff; }
    </style>
</head>
<body>

<!-- Header Banner -->
<div class="page-header">
    <div class="container d-flex justify-content-between align-items-center">
        <div>
            <h2 class="fw-bold mb-1"><i class="fa-solid fa-file-invoice-dollar me-2 text-info"></i>Generate Patient Invoice</h2>
            <p class="text-slate-300 mb-0 opacity-75 small">Issue billing receipts and medical charges</p>
        </div>
        <div>
            <a href="admin-dashboard.jsp" class="btn btn-outline-light btn-sm px-3">
                <i class="fa-solid fa-arrow-left me-1"></i> Dashboard
            </a>
        </div>
    </div>
</div>

<div class="container mb-5">
    <div class="row justify-content-center">
        <div class="col-lg-6 col-md-8">

            <div class="card card-custom p-4 p-md-5">
                <h4 class="fw-bold text-dark mb-4 pb-2 border-bottom">
                    <i class="fa-solid fa-receipt me-2 text-primary"></i>Billing Details
                </h4>

                <form action="BillingServlet" method="post">
                    
                    <!-- Appointment ID -->
                    <div class="mb-3">
                        <label class="form-label">Appointment ID</label>
                        <input type="number" name="appointmentId" class="form-control" value="<%= appointmentId > 0 ? appointmentId : "" %>" required placeholder="Enter Appointment ID">
                    </div>

                    <!-- Patient ID -->
                    <div class="mb-3">
                        <label class="form-label">Patient ID</label>
                        <input type="number" name="patientId" class="form-control" value="<%= patientId > 0 ? patientId : "" %>" required placeholder="Enter Patient ID">
                    </div>

                    <!-- Patient Name -->
                    <div class="mb-3">
                        <label class="form-label">Patient Name</label>
                        <input type="text" name="patientName" class="form-control" value="<%= patientName != null ? patientName : "" %>" required placeholder="Enter Patient Name">
                    </div>

                    <!-- Billing Amount -->
                    <div class="mb-4">
                        <label class="form-label">Total Amount (₹)</label>
                        <div class="input-group">
                            <span class="input-group-text">₹</span>
                            <input type="number" step="0.01" name="amount" class="form-control" required placeholder="e.g. 1500.00">
                        </div>
                    </div>

                    <!-- Submit Button -->
                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-submit shadow-sm">
                            <i class="fa-solid fa-floppy-disk me-1"></i> Issue Bill & Save
                        </button>
                    </div>

                </form>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>