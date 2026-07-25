<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.dao.*, com.model.*" %>
<%@ page session="true" %>
<%
    // 1. Session Check (Admin Security)
    String admin = (String) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }

    // 2. Fetch Doctors List
    DoctorDAO dao = new DoctorDAO(DBConnect.getConn());
    List<Doctor> list = dao.getAllDoctors();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor Directory | Hospital Management</title>
    
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
            margin-bottom: 2rem;
            border-bottom: 4px solid #0284c7;
        }

        .card-custom {
            background: #ffffff;
            border: none;
            border-radius: 14px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
        }

        .table-custom thead {
            background-color: #f1f5f9;
            color: #475569;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.78rem;
            letter-spacing: 0.5px;
        }

        .table-custom tbody tr {
            transition: all 0.2s ease;
        }

        .table-custom tbody tr:hover {
            background-color: #f8fafc;
        }

        .doctor-avatar {
            width: 40px;
            height: 40px;
            background-color: #e0f2fe;
            color: #0284c7;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 1rem;
        }

        .badge-specialty {
            background-color: #f0f9ff;
            color: #0369a1;
            border: 1px solid #bae6fd;
            font-weight: 500;
            padding: 0.35em 0.75em;
            border-radius: 6px;
        }

        .badge-timing {
            background-color: #f8fafc;
            color: #475569;
            border: 1px solid #e2e8f0;
            font-weight: 500;
            padding: 0.35em 0.75em;
            border-radius: 6px;
        }

        .btn-action {
            padding: 0.35rem 0.65rem;
            font-size: 0.85rem;
            border-radius: 6px;
            transition: all 0.2s ease;
        }

        .btn-action:hover {
            transform: translateY(-1px);
        }
    </style>
</head>
<body>

<!-- Header Banner -->
<div class="page-header">
    <div class="container d-flex justify-content-between align-items-center">
        <div>
            <h2 class="fw-bold mb-1"><i class="fa-solid fa-user-doctor me-2 text-info"></i>Doctor Directory</h2>
            <p class="text-slate-300 mb-0 opacity-75 small">Manage hospital medical specialists, schedules, and profiles</p>
        </div>
        <div class="d-flex gap-2">
            <a href="add-doctor.jsp" class="btn btn-success btn-sm px-3">
                <i class="fa-solid fa-plus me-1"></i> Add Doctor
            </a>
            <a href="admin-dashboard.jsp" class="btn btn-outline-light btn-sm px-3">
                <i class="fa-solid fa-arrow-left me-1"></i> Dashboard
            </a>
        </div>
    </div>
</div>

<div class="container mb-5">

    <!-- Status Alert Message -->
    <% 
        String msg = request.getParameter("msg");
        if (msg != null && !msg.trim().isEmpty()) { 
    %>
        <div class="alert alert-info alert-dismissible fade show d-flex align-items-center gap-2 mb-4" role="alert">
            <i class="fa-solid fa-circle-info"></i>
            <div><%= msg %></div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>

    <div class="card card-custom p-4">
        
        <!-- Controls Bar -->
        <div class="row g-3 mb-4 align-items-center justify-content-between">
            <div class="col-md-4">
                <div class="input-group">
                    <span class="input-group-text bg-light border-end-0 text-muted"><i class="fa-solid fa-magnifying-glass"></i></span>
                    <input type="text" id="searchInput" class="form-control bg-light border-start-0" placeholder="Search by name or specialty...">
                </div>
            </div>
            <div class="col-md-auto text-muted small">
                Total Doctors Listed: <span class="fw-bold text-dark"><%= (list != null) ? list.size() : 0 %></span>
            </div>
        </div>

        <!-- Doctors Table -->
        <div class="table-responsive">
            <table class="table table-custom align-middle mb-0" id="doctorsTable">
                <thead>
                    <tr>
                        <th scope="col" class="text-center" style="width: 70px;">ID</th>
                        <th scope="col">Doctor Name</th>
                        <th scope="col">Specialty</th>
                        <th scope="col">Available Timings</th>
                        <th scope="col" class="text-center" style="width: 180px;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        if (list != null && !list.isEmpty()) {
                            for (Doctor d : list) { 
                                String rawName = d.getName() != null ? d.getName() : "Unknown Doctor";
                                // Ensure display name is formatted cleanly with "Dr."
                                String doctorName = rawName.toLowerCase().startsWith("dr.") ? rawName : "Dr. " + rawName;
                                String specialty = d.getSpeciality() != null ? d.getSpeciality() : "General Practitioner";
                                String timings = d.getTimings() != null ? d.getTimings() : "N/A";
                    %>
                        <tr>
                            <td class="text-center fw-bold text-secondary">#<%= d.getId() %></td>
                            <td>
                                <div class="d-flex align-items-center gap-3">
                                    <div class="doctor-avatar">
                                        <i class="fa-solid fa-stethoscope"></i>
                                    </div>
                                    <div>
                                        <div class="fw-semibold text-dark"><%= doctorName %></div>
                                        <div class="small text-muted">Hospital Staff Specialist</div>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <span class="badge badge-specialty">
                                    <i class="fa-solid fa-heart-pulse me-1"></i><%= specialty %>
                                </span>
                            </td>
                            <td>
                                <span class="badge badge-timing">
                                    <i class="fa-regular fa-clock me-1 text-primary"></i><%= timings %>
                                </span>
                            </td>
                            <td class="text-center">
                                <div class="d-flex justify-content-center gap-2">
                                    <a href="edit-doctor.jsp?id=<%= d.getId() %>" class="btn btn-sm btn-outline-primary btn-action" title="Edit Doctor Profile">
                                        <i class="fa-solid fa-pen-to-square"></i> Edit
                                    </a>
                                    <a href="deleteDoctor?id=<%= d.getId() %>" 
                                       class="btn btn-sm btn-outline-danger btn-action" 
                                       onclick="return confirm('Are you sure you want to delete <%= doctorName %> from the directory?');" 
                                       title="Delete Doctor Profile">
                                        <i class="fa-solid fa-trash-can"></i> Delete
                                    </a>
                                </div>
                            </td>
                        </tr>
                    <% 
                            }
                        } else { 
                    %>
                        <tr>
                            <td colspan="5" class="text-center py-5 text-muted">
                                <i class="fa-regular fa-folder-open fa-2x mb-2 d-block"></i>
                                No doctor records found in the database.
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

    </div>
</div>

<!-- Bootstrap 5 Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Search Filter Script -->
<script>
    document.getElementById('searchInput').addEventListener('keyup', function() {
        const value = this.value.toLowerCase();
        const rows = document.querySelectorAll('#doctorsTable tbody tr');

        rows.forEach(row => {
            const text = row.textContent.toLowerCase();
            row.style.display = text.includes(value) ? '' : 'none';
        });
    });
</script>

</body>
</html>