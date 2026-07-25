<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page import="com.dao.*, com.model.*" %>
<%@ page session="true" %>
<%
    // 1. Session Check (Admin / Billing Staff Security)
    String admin = (String) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }

    // 2. Fetch Billing History
    BillingDAO dao = new BillingDAO(DBConnect.getConn());
    List<Billing> bills = dao.getAllBills();
    
    // Calculate total revenue for summary header
    double totalRevenue = 0.0;
    if (bills != null) {
        for (Billing b : bills) {
            totalRevenue += b.getAmount();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Billing History | Hospital Financials</title>
    
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

        .stat-card {
            border-left: 4px solid #0284c7;
            background: #ffffff;
            border-radius: 10px;
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

        .badge-amount {
            background-color: #dcfce7;
            color: #15803d;
            border: 1px solid #86efac;
            font-weight: 600;
            font-size: 0.9rem;
            padding: 0.35em 0.75em;
            border-radius: 6px;
        }

        .badge-id {
            background-color: #f1f5f9;
            color: #475569;
            border: 1px solid #cbd5e1;
            font-weight: 600;
        }

        @media print {
            .page-header, .no-print {
                display: none !important;
            }
            .card-custom {
                box-shadow: none !important;
                border: 1px solid #ddd !important;
            }
        }
    </style>
</head>
<body>

<!-- Header Banner -->
<div class="page-header">
    <div class="container d-flex justify-content-between align-items-center">
        <div>
            <h2 class="fw-bold mb-1"><i class="fa-solid fa-receipt me-2 text-info"></i>Billing History & Ledger</h2>
            <p class="text-slate-300 mb-0 opacity-75 small">Track issued patient invoices, payment records, and total revenue</p>
        </div>
        <div class="d-flex gap-2">
            <a href="generate-bill.jsp" class="btn btn-success btn-sm px-3">
                <i class="fa-solid fa-plus me-1"></i> Generate New Bill
            </a>
            <a href="admin-dashboard.jsp" class="btn btn-outline-light btn-sm px-3">
                <i class="fa-solid fa-arrow-left me-1"></i> Dashboard
            </a>
        </div>
    </div>
</div>

<div class="container mb-5">

    <!-- Status Message Banner -->
    <% 
        String msg = request.getParameter("msg");
        if (msg != null && !msg.trim().isEmpty()) { 
    %>
        <div class="alert alert-info alert-dismissible fade show d-flex align-items-center gap-2 mb-4 no-print" role="alert">
            <i class="fa-solid fa-circle-info"></i>
            <div><%= msg %></div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>

    <!-- Summary Metrics Bar -->
    <div class="row g-3 mb-4 no-print">
        <div class="col-md-6 col-lg-4">
            <div class="card stat-card p-3 shadow-sm">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="text-muted small fw-bold text-uppercase">Total Invoices</span>
                        <h3 class="fw-bold text-dark mb-0"><%= bills != null ? bills.size() : 0 %></h3>
                    </div>
                    <div class="p-3 bg-primary-subtle text-primary rounded-circle">
                        <i class="fa-solid fa-file-invoice fa-lg"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-4">
            <div class="card stat-card p-3 shadow-sm" style="border-left-color: #16a34a;">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="text-muted small fw-bold text-uppercase">Total Billed Revenue</span>
                        <h3 class="fw-bold text-success mb-0">₹<%= String.format("%.2f", totalRevenue) %></h3>
                    </div>
                    <div class="p-3 bg-success-subtle text-success rounded-circle">
                        <i class="fa-solid fa-indian-rupee-sign fa-lg"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Table Card -->
    <div class="card card-custom p-4">
        
        <!-- Controls & Filter Bar -->
        <div class="row g-3 mb-4 align-items-center justify-content-between no-print">
            <div class="col-md-4">
                <div class="input-group">
                    <span class="input-group-text bg-light border-end-0 text-muted"><i class="fa-solid fa-magnifying-glass"></i></span>
                    <input type="text" id="searchInput" class="form-control bg-light border-start-0" placeholder="Search by patient name, invoice ID...">
                </div>
            </div>
            <div class="col-md-auto d-flex align-items-center gap-2">
                <button onclick="window.print()" class="btn btn-outline-secondary btn-sm px-3">
                    <i class="fa-solid fa-print me-1"></i> Print Summary
                </button>
            </div>
        </div>

        <!-- Invoices Table -->
        <div class="table-responsive">
            <table class="table table-custom align-middle mb-0" id="billsTable">
                <thead>
                    <tr>
                        <th scope="col" class="text-center" style="width: 100px;">Bill ID</th>
                        <th scope="col" style="width: 120px;">Patient ID</th>
                        <th scope="col">Patient Name</th>
                        <th scope="col">Billed Amount</th>
                        <th scope="col">Billing Date</th>
                        <th scope="col" class="text-center no-print" style="width: 120px;">Receipt</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        if (bills != null && !bills.isEmpty()) {
                            for (Billing b : bills) { 
                                String pName = (b.getPatientName() != null && !b.getPatientName().trim().isEmpty()) 
                                                ? b.getPatientName() 
                                                : "N/A";
                                String dateStr = b.getDate() != null ? b.getDate().toString() : "N/A";
                    %>
                        <tr>
                            <td class="text-center">
                                <span class="badge badge-id rounded-pill px-3 py-1">#<%= b.getId() %></span>
                            </td>
                            <td>
                                <span class="fw-semibold text-secondary">PID: <%= b.getPatientId() %></span>
                            </td>
                            <td>
                                <div class="fw-semibold text-dark">
                                    <i class="fa-solid fa-user me-2 text-muted small"></i><%= pName %>
                                </div>
                            </td>
                            <td>
                                <span class="badge badge-amount">
                                    ₹<%= String.format("%.2f", b.getAmount()) %>
                                </span>
                            </td>
                            <td>
                                <span class="text-dark fw-medium">
                                    <i class="fa-regular fa-calendar-check me-1 text-primary"></i><%= dateStr %>
                                </span>
                            </td>
                            <td class="text-center no-print">
                                <button onclick="window.print()" class="btn btn-sm btn-outline-primary" title="Print Invoice Receipt">
                                    <i class="fa-solid fa-receipt"></i>
                                </button>
                            </td>
                        </tr>
                    <% 
                            }
                        } else { 
                    %>
                        <tr>
                            <td colspan="6" class="text-center py-5 text-muted">
                                <i class="fa-regular fa-folder-open fa-2x mb-2 d-block"></i>
                                No billing records or invoices found in the database.
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

<!-- Real-time Live Search Filter -->
<script>
    document.getElementById('searchInput').addEventListener('keyup', function() {
        const value = this.value.toLowerCase();
        const rows = document.querySelectorAll('#billsTable tbody tr');

        rows.forEach(row => {
            const text = row.textContent.toLowerCase();
            row.style.display = text.includes(value) ? '' : 'none';
        });
    });
</script>

</body>
</html>