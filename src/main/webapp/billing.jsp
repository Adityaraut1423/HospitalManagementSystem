<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.dao.*, com.model.*" %>
<%@ page session="true" %>
<%
    // Session Check (Admin / Billing Staff Security)
    String admin = (String) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }

    PatientDAO patientDAO = new PatientDAO(DBConnect.getConn());
    List<Patient> patients = patientDAO.getAllPatients();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Generate Patient Bill | Hospital Billing</title>
    
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

        .readonly-input {
            background-color: #f1f5f9 !important;
            color: #475569;
            cursor: not-allowed;
        }
    </style>
</head>
<body>

<!-- Header Banner -->
<div class="page-header">
    <div class="container d-flex justify-content-between align-items-center">
        <div>
            <h2 class="fw-bold mb-1"><i class="fa-solid fa-file-invoice-dollar me-2 text-info"></i>Generate Patient Invoice</h2>
            <p class="text-slate-300 mb-0 opacity-75 small">Issue billing statements for medical consultations, procedures, and care</p>
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
        <div class="col-lg-7 col-md-9">

            <!-- Status Alert Message -->
            <% 
                String msg = request.getParameter("msg");
                if (msg != null && !msg.trim().isEmpty()) { 
                    boolean isSuccess = msg.toLowerCase().contains("success");
            %>
                <div class="alert alert-<%= isSuccess ? "success" : "info" %> alert-dismissible fade show d-flex align-items-center gap-2 mb-4" role="alert">
                    <i class="fa-solid fa-circle-info"></i>
                    <div><%= msg %></div>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>

            <div class="card card-custom p-4 p-md-5">
                <div class="d-flex align-items-center gap-3 mb-4 pb-3 border-bottom">
                    <div class="p-3 bg-primary-subtle text-primary rounded-circle">
                        <i class="fa-solid fa-receipt fa-xl"></i>
                    </div>
                    <div>
                        <h4 class="fw-bold mb-0 text-dark">Billing Details</h4>
                        <span class="text-muted small">Select a registered patient and specify the final amount</span>
                    </div>
                </div>

                <form action="GenerateBillServlet" method="post">
                    
                    <!-- Patient Selection -->
                    <div class="mb-4">
                        <label for="patientId" class="form-label">Select Patient Record</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-hospital-user"></i></span>
                            <select name="patientId" id="patientId" class="form-select" required onchange="setPatientName()">
                                <option value="" disabled selected>-- Select Patient --</option>
                                <% 
                                    if (patients != null && !patients.isEmpty()) {
                                        for (Patient p : patients) { 
                                            String pName = p.getName() != null ? p.getName() : "Unknown";
                                            String phone = p.getPhone() != null ? p.getPhone() : "No Phone";
                                %>
                                    <option value="<%= p.getId() %>" data-name="<%= p.getName() %>">
                                        #<%= p.getId() %> - <%= pName %> (<%= phone %>)
                                    </option>
                                <% 
                                        }
                                    } 
                                %>
                            </select>
                        </div>
                    </div>

                    <!-- Patient Name (Auto-filled) -->
                    <div class="mb-4">
                        <label for="patientName" class="form-label">Confirmed Patient Name</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-id-card"></i></span>
                            <input type="text" name="patientName" id="patientName" class="form-control readonly-input" placeholder="Select a patient above..." readonly required>
                        </div>
                    </div>

                    <!-- Billing Amount -->
                    <div class="mb-4">
                        <label for="amount" class="form-label">Total Payable Amount (₹)</label>
                        <div class="input-group">
                            <span class="input-group-text fw-bold">₹</span>
                            <input type="number" name="amount" id="amount" class="form-control" placeholder="0.00" required step="0.01" min="0">
                        </div>
                    </div>

                    <!-- Submit & Cancel Buttons -->
                    <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4 pt-2">
                        <a href="admin-dashboard.jsp" class="btn btn-light px-4 py-2 me-md-2 fw-semibold border">Cancel</a>
                        <button type="submit" class="btn btn-submit text-white px-4 py-2">
                            <i class="fa-solid fa-file-circle-plus me-1"></i> Issue Invoice
                        </button>
                    </div>

                </form>
            </div>

        </div>
    </div>
</div>

<!-- JavaScript for Patient Name Mapping -->
<script>
function setPatientName() {
    var select = document.getElementById("patientId");
    var selectedOption = select.options[select.selectedIndex];
    var name = selectedOption.getAttribute("data-name");
    
    document.getElementById("patientName").value = name ? name : "";
}
</script>

<!-- Bootstrap 5 Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>