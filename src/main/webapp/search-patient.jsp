<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.dao.*" %>
<%@ page session="true" %>
<%
    String admin = (String) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }

    String searchQuery = request.getParameter("query");
    boolean isSearching = (searchQuery != null && !searchQuery.trim().isEmpty());
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Medical History | Admin Portal</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f8fafc; color: #334155; }
        .page-header { background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%); color: #fff; padding: 2rem 0; margin-bottom: 2rem; border-bottom: 4px solid #0284c7; }
        
        /* Medical Timeline Styling */
        .timeline { position: relative; border-left: 3px solid #cbd5e1; margin: 2rem 0 2rem 1.5rem; padding-left: 1.5rem; }
        .timeline-item { position: relative; margin-bottom: 2rem; }
        .timeline-icon { position: absolute; left: -2.35rem; top: 0; width: 32px; height: 32px; border-radius: 50%; background: #0284c7; color: #fff; display: flex; align-items: center; justify-content: center; font-size: 0.85rem; }
        .timeline-card { background: #fff; border-radius: 12px; padding: 1.25rem; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05); border: 1px solid #e2e8f0; }
    </style>
</head>
<body>

<div class="page-header">
    <div class="container d-flex justify-content-between align-items-center">
        <div>
            <h2 class="fw-bold mb-1"><i class="fa-solid fa-notes-medical me-2 text-info"></i>Patient Medical History</h2>
            <p class="text-slate-300 mb-0 opacity-75 small">Search patient records, assigned doctors, and past visits</p>
        </div>
        <a href="admin-dashboard.jsp" class="btn btn-outline-light btn-sm px-3"><i class="fa-solid fa-arrow-left me-1"></i> Dashboard</a>
    </div>
</div>

<div class="container mb-5">
    <!-- Search Bar -->
    <div class="row justify-content-center mb-4">
        <div class="col-md-8">
            <form action="search-patient.jsp" method="get" class="d-flex gap-2">
                <input type="text" name="query" class="form-control form-control-lg shadow-sm" placeholder="Enter Patient Name or ID..." value="<%= isSearching ? searchQuery : "" %>">
                <button type="submit" class="btn btn-primary px-4 fw-semibold shadow-sm"><i class="fa-solid fa-magnifying-glass me-1"></i> Search</button>
            </form>
        </div>
    </div>

    <!-- Results Section -->
    <div class="row justify-content-center">
        <div class="col-md-9">
            <h5 class="fw-bold mb-3">
                <i class="fa-solid fa-clock-rotate-left me-2 text-primary"></i>
                <%= isSearching ? "Medical History for \"" + searchQuery + "\"" : "All Patient Medical Records" %>
            </h5>

            <div class="timeline">
                <%
                    boolean found = false;
                    try (Connection conn = DBConnect.getConn()) {
                        String sql;
                        PreparedStatement ps;

                        if (isSearching) {
                            sql = "SELECT a.id, a.patient_id, a.patient_name AS direct_patient_name, " +
                                  "a.doctor_id, a.appointment_date, a.status, " +
                                  "COALESCE(a.patient_name, p.name) AS resolved_patient_name, " +
                                  "d.name AS doctor_name " +
                                  "FROM appointment a " +
                                  "LEFT JOIN patient p ON a.patient_id = p.id " +
                                  "LEFT JOIN doctor d ON a.doctor_id = d.id " +
                                  "WHERE a.patient_name LIKE ? OR p.name LIKE ? OR a.patient_id = ? " +
                                  "ORDER BY a.id DESC";

                            ps = conn.prepareStatement(sql);
                            ps.setString(1, "%" + searchQuery.trim() + "%");
                            ps.setString(2, "%" + searchQuery.trim() + "%");

                            int searchId = -1;
                            try { searchId = Integer.parseInt(searchQuery.trim()); } catch (Exception ignored) {}
                            ps.setInt(3, searchId);

                        } else {
                            sql = "SELECT a.id, a.patient_id, a.patient_name AS direct_patient_name, " +
                                  "a.doctor_id, a.appointment_date, a.status, " +
                                  "COALESCE(a.patient_name, p.name) AS resolved_patient_name, " +
                                  "d.name AS doctor_name " +
                                  "FROM appointment a " +
                                  "LEFT JOIN patient p ON a.patient_id = p.id " +
                                  "LEFT JOIN doctor d ON a.doctor_id = d.id " +
                                  "ORDER BY a.id DESC";
                            ps = conn.prepareStatement(sql);
                        }

                        ResultSet rs = ps.executeQuery();

                        while (rs.next()) {
                            found = true;
                            int apptId = rs.getInt("id");
                            String pName = rs.getString("resolved_patient_name");
                            if (pName == null || pName.trim().isEmpty()) pName = "Patient #" + rs.getInt("patient_id");
                            
                            String docName = rs.getString("doctor_name");
                            if (docName == null || docName.trim().isEmpty()) docName = "Doctor ID: " + rs.getInt("doctor_id");

                            Date apptDate = rs.getDate("appointment_date");
                            String status = rs.getString("status");
                            if (status == null) status = "Pending";

                            String badgeColor = "Pending".equalsIgnoreCase(status) ? "bg-warning text-dark" : 
                                               "Completed".equalsIgnoreCase(status) ? "bg-success" : "bg-info";
                %>
                    <div class="timeline-item">
                        <div class="timeline-icon"><i class="fa-solid fa-calendar-check"></i></div>
                        <div class="timeline-card">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <span class="badge <%= badgeColor %>"><%= status %></span>
                                <span class="text-muted small"><i class="fa-solid fa-hashtag me-1"></i>Appt #<%= apptId %></span>
                            </div>
                            
                            <h6 class="fw-bold text-dark mb-1">
                                <i class="fa-solid fa-user-doctor text-primary me-2"></i>Assigned Doctor: <%= docName %>
                            </h6>
                            
                            <p class="text-muted small mb-1">
                                <i class="fa-solid fa-user me-1"></i>Patient: <strong><%= pName %></strong> (Patient ID: <%= rs.getInt("patient_id") %>)
                            </p>
                            
                            <p class="text-muted small mb-2">
                                <i class="fa-regular fa-calendar me-1"></i>Visit Date: <strong><%= apptDate != null ? apptDate.toString() : "N/A" %></strong>
                            </p>
                            
                            <div class="p-2 bg-light rounded border d-flex justify-content-between align-items-center mt-2">
                                <span class="small text-muted"><i class="fa-solid fa-file-invoice-dollar me-1"></i>Billing & Status: Billed</span>
                                <a href="ExportPDFServlet?appointmentId=<%= apptId %>" class="btn btn-outline-danger btn-sm">
                                    <i class="fa-solid fa-file-pdf me-1"></i>Download Receipt
                                </a>
                            </div>
                        </div>
                    </div>
                <%
                        }
                        if (!found) {
                %>
                    <div class="alert alert-warning text-center my-4 py-3">
                        <i class="fa-solid fa-circle-exclamation me-1"></i> No medical records or appointments found <%= isSearching ? "matching \"" + searchQuery + "\"" : "in the system" %>.
                    </div>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                %>
                    <div class="alert alert-danger text-center">
                        An error occurred while fetching medical records. Please check database connectivity.
                    </div>
                <%
                    }
                %>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>