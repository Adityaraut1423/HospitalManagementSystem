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
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Appointments | Admin Portal</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts (Inter) -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f8fafc; color: #334155; }
        .page-header { background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%); color: #ffffff; padding: 2.2rem 0; margin-bottom: 2rem; border-bottom: 4px solid #0284c7; }
        .card-custom { background: #ffffff; border: none; border-radius: 16px; box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05); }
        .table-custom th { background-color: #f8fafc; color: #475569; font-weight: 600; font-size: 0.85rem; text-transform: uppercase; padding: 1rem; border-bottom: 2px solid #e2e8f0; }
        .table-custom td { padding: 1rem; vertical-align: middle; font-size: 0.92rem; }
        .status-select { border-radius: 8px; font-size: 0.85rem; font-weight: 500; padding: 0.35rem 0.6rem; border: 1px solid #cbd5e1; }
        .btn-update { background-color: #0284c7; border-color: #0284c7; color: #ffffff; border-radius: 8px; padding: 0.35rem 0.75rem; font-size: 0.85rem; }
        .btn-update:hover { background-color: #0369a1; color: #ffffff; }
    </style>
</head>
<body>

<!-- Header Banner -->
<div class="page-header">
    <div class="container d-flex justify-content-between align-items-center">
        <div>
            <h2 class="fw-bold mb-1"><i class="fa-solid fa-calendar-check me-2 text-info"></i>Appointment Directory</h2>
            <p class="text-slate-300 mb-0 opacity-75 small">Manage patient bookings, update statuses, and generate PDF invoices</p>
        </div>
        <div>
            <a href="admin-dashboard.jsp" class="btn btn-outline-light btn-sm px-3">
                <i class="fa-solid fa-arrow-left me-1"></i> Dashboard
            </a>
        </div>
    </div>
</div>

<div class="container mb-5">

    <!-- Status Alert Banner -->
    <% 
        String msg = request.getParameter("msg");
        if (msg != null && !msg.trim().isEmpty()) { 
            boolean isSuccess = msg.toLowerCase().contains("success") || msg.toLowerCase().contains("updated");
    %>
        <div class="alert alert-<%= isSuccess ? "success" : "danger" %> alert-dismissible fade show d-flex align-items-center gap-2 mb-4" role="alert">
            <i class="fa-solid fa-circle-info"></i>
            <div><%= msg %></div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>

    <div class="card card-custom p-4">
        <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
            <h5 class="fw-bold text-dark mb-0"><i class="fa-solid fa-list me-2 text-primary"></i>All Booked Appointments</h5>
            <a href="send-confirm-email.jsp" class="btn btn-dark btn-sm px-3 rounded-pill">
                <i class="fa-solid fa-paper-plane me-1"></i> Send Manual Email
            </a>
        </div>

        <div class="table-responsive">
            <table class="table table-hover table-custom align-middle mb-0">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Patient Name</th>
                        <th>Appointment Date</th>
                        <th>Doctor ID</th>
                        <th>Current Status</th>
                        <th>Update Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        boolean hasRecords = false;
                        try (Connection conn = DBConnect.getConn()) {
                            // Query exact columns matching schema
                            String sql = "SELECT * FROM appointment ORDER BY id DESC";
                            PreparedStatement ps = conn.prepareStatement(sql);
                            ResultSet rs = ps.executeQuery();

                            while (rs.next()) {
                                hasRecords = true;
                                int apptId = rs.getInt("id");
                                String patientName = rs.getString("patient_name");
                                Date apptDate = rs.getDate("appointment_date");
                                int doctorId = rs.getInt("doctor_id");
                                String currentStatus = rs.getString("status");
                                if (currentStatus == null) currentStatus = "Pending";

                                // Dynamic Status Badge Color
                                String badgeClass = "bg-warning-subtle text-warning border-warning-subtle";
                                if ("Confirmed".equalsIgnoreCase(currentStatus)) {
                                    badgeClass = "bg-info-subtle text-info border-info-subtle";
                                } else if ("Completed".equalsIgnoreCase(currentStatus)) {
                                    badgeClass = "bg-success-subtle text-success border-success-subtle";
                                }
                    %>
                        <tr>
                            <td class="fw-bold text-secondary">#<%= apptId %></td>
                            <td>
                                <div class="fw-semibold text-dark"><%= patientName != null ? patientName : "N/A" %></div>
                                <div class="small text-muted">Patient ID: <%= rs.getInt("patient_id") %></div>
                            </td>
                            <td>
                                <div class="small fw-medium"><i class="fa-regular fa-calendar me-1 text-primary"></i><%= apptDate != null ? apptDate.toString() : "Not Scheduled" %></div>
                            </td>
                            <td>
                                <span class="badge bg-light text-dark border px-2 py-1"><i class="fa-solid fa-user-doctor text-primary me-1"></i>Doctor ID: <%= doctorId %></span>
                            </td>
                            <td>
                                <span class="badge border px-3 py-1 rounded-pill <%= badgeClass %>"><%= currentStatus %></span>
                            </td>
                            <td>
                                <!-- Status Update Form -->
                                <form action="UpdateAppointmentStatusServlet" method="post" class="d-flex align-items-center gap-1">
                                    <input type="hidden" name="id" value="<%= apptId %>">
                                    <select name="status" class="form-select status-select shadow-sm" style="width: 125px;">
                                        <option value="Pending" <%= "Pending".equalsIgnoreCase(currentStatus) ? "selected" : "" %>>Pending</option>
                                        <option value="Confirmed" <%= "Confirmed".equalsIgnoreCase(currentStatus) ? "selected" : "" %>>Confirmed</option>
                                        <option value="Completed" <%= "Completed".equalsIgnoreCase(currentStatus) ? "selected" : "" %>>Completed</option>
                                    </select>
                                    <button type="submit" class="btn btn-update shadow-sm" title="Save Status">
                                        <i class="fa-solid fa-check"></i>
                                    </button>
                                </form>
                            </td>
                            <td>
                                <div class="d-flex align-items-center gap-2">
                                    <!-- PDF Export Button -->
                                    <a href="ExportPDFServlet?appointmentId=<%= apptId %>" class="btn btn-outline-danger btn-sm rounded-2" title="Download PDF Receipt">
                                        <i class="fa-solid fa-file-pdf me-1"></i> PDF
                                    </a>
                                </div>
                            </td>
                        </tr>
                    <%
                            }
                            if (!hasRecords) {
                    %>
                        <tr>
                            <td colspan="7" class="text-center py-5 text-muted">
                                <i class="fa-solid fa-calendar-xmark fa-2x mb-3 text-secondary d-block"></i>
                                No appointments found in the system.
                            </td>
                        </tr>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>