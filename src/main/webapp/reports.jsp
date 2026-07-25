<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.util.stream.Collectors, com.dao.*" %>
<%@ page session="true" %>
<%
    // 1. Session Check (Admin Security)
    String admin = (String) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }

    // 2. Fetch Report Analytics Data
    ReportDAO reportDao = new ReportDAO(DBConnect.getConn());
    Map<String, Double> monthlyRevenue = reportDao.getMonthlyRevenue();
    Map<String, Integer> appointmentsPerDoctor = reportDao.getAppointmentsPerDoctor();
    Map<String, Integer> patientDemographics = reportDao.getPatientDemographics();

    // 3. Prepare JS Data Strings Safely
    String revenueLabels = (monthlyRevenue != null && !monthlyRevenue.isEmpty())
        ? monthlyRevenue.keySet().stream().map(s -> "'" + s + "'").collect(Collectors.joining(",")) : "";
    String revenueData = (monthlyRevenue != null && !monthlyRevenue.isEmpty())
        ? monthlyRevenue.values().stream().map(String::valueOf).collect(Collectors.joining(",")) : "";

    String doctorLabels = (appointmentsPerDoctor != null && !appointmentsPerDoctor.isEmpty())
        ? appointmentsPerDoctor.keySet().stream().map(s -> "'" + s + "'").collect(Collectors.joining(",")) : "";
    String doctorData = (appointmentsPerDoctor != null && !appointmentsPerDoctor.isEmpty())
        ? appointmentsPerDoctor.values().stream().map(String::valueOf).collect(Collectors.joining(",")) : "";

    String patientLabels = (patientDemographics != null && !patientDemographics.isEmpty())
        ? patientDemographics.keySet().stream().map(s -> "'" + s + "'").collect(Collectors.joining(",")) : "";
    String patientData = (patientDemographics != null && !patientDemographics.isEmpty())
        ? patientDemographics.values().stream().map(String::valueOf).collect(Collectors.joining(",")) : "";

    // Quick metric aggregation
    double totalRevenue = (monthlyRevenue != null) ? monthlyRevenue.values().stream().mapToDouble(Double::doubleValue).sum() : 0.0;
    int totalAppointments = (appointmentsPerDoctor != null) ? appointmentsPerDoctor.values().stream().mapToInt(Integer::intValue).sum() : 0;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports & Analytics | Admin Portal</title>
    
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

        .chart-container {
            position: relative;
            min-height: 280px;
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
            <h2 class="fw-bold mb-1"><i class="fa-solid fa-chart-line me-2 text-info"></i>Reports & Analytics Dashboard</h2>
            <p class="text-slate-300 mb-0 opacity-75 small">Gain real-time insights into revenue, doctor workloads, and demographics</p>
        </div>
        <div class="d-flex gap-2 no-print">
            <a href="admin-dashboard.jsp" class="btn btn-outline-light btn-sm px-3">
                <i class="fa-solid fa-arrow-left me-1"></i> Dashboard
            </a>
        </div>
    </div>
</div>

<div class="container mb-5">

    <!-- Export & Action Controls Bar -->
    <div class="d-flex justify-content-between align-items-center mb-4 no-print">
        <h5 class="fw-bold text-dark mb-0"><i class="fa-solid fa-sliders me-2 text-primary"></i>Analytics Overview</h5>
        <div class="d-flex gap-2">
            <a href="ExportExcelServlet" class="btn btn-success btn-sm px-3 shadow-sm">
                <i class="fa-solid fa-file-excel me-1"></i> Export Excel
            </a>
            <a href="ExportPDFServlet" class="btn btn-danger btn-sm px-3 shadow-sm">
                <i class="fa-solid fa-file-pdf me-1"></i> Export PDF
            </a>
            <button onclick="window.print()" class="btn btn-outline-secondary btn-sm px-3 shadow-sm">
                <i class="fa-solid fa-print me-1"></i> Print
            </button>
        </div>
    </div>

    <!-- Summary Metric Cards -->
    <div class="row g-3 mb-4 no-print">
        <div class="col-md-6 col-lg-6">
            <div class="card stat-card p-3 shadow-sm" style="border-left-color: #0284c7;">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="text-muted small fw-bold text-uppercase">Total Gross Revenue</span>
                        <h3 class="fw-bold text-dark mb-0">₹<%= String.format("%.2f", totalRevenue) %></h3>
                    </div>
                    <div class="p-3 bg-primary-subtle text-primary rounded-circle">
                        <i class="fa-solid fa-indian-rupee-sign fa-lg"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-6">
            <div class="card stat-card p-3 shadow-sm" style="border-left-color: #10b981;">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="text-muted small fw-bold text-uppercase">Total Scheduled Appointments</span>
                        <h3 class="fw-bold text-success mb-0"><%= totalAppointments %></h3>
                    </div>
                    <div class="p-3 bg-success-subtle text-success rounded-circle">
                        <i class="fa-solid fa-calendar-check fa-lg"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Charts Row 1: Monthly Revenue & Doctor Appointments -->
    <div class="row g-4 mb-4">
        <div class="col-lg-6">
            <div class="card card-custom p-4 h-100">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="fw-bold text-dark mb-0"><i class="fa-solid fa-chart-column me-2 text-primary"></i>Monthly Revenue</h5>
                    <span class="badge bg-light text-muted border">Financial</span>
                </div>
                <div class="chart-container">
                    <canvas id="revenueChart"></canvas>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="card card-custom p-4 h-100">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="fw-bold text-dark mb-0"><i class="fa-solid fa-chart-pie me-2 text-info"></i>Appointments Per Doctor</h5>
                    <span class="badge bg-light text-muted border">Workload</span>
                </div>
                <div class="chart-container">
                    <canvas id="doctorChart"></canvas>
                </div>
            </div>
        </div>
    </div>

    <!-- Charts Row 2: Patient Demographics -->
    <div class="row g-4">
        <div class="col-lg-6">
            <div class="card card-custom p-4 h-100">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="fw-bold text-dark mb-0"><i class="fa-solid fa-users me-2 text-warning"></i>Patient Demographics</h5>
                    <span class="badge bg-light text-muted border">Gender Breakdown</span>
                </div>
                <div class="chart-container">
                    <canvas id="patientChart"></canvas>
                </div>
            </div>
        </div>
    </div>

</div>

<!-- Bootstrap 5 Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Chart.js Initialization Script -->
<script>
    // 1. Monthly Revenue Chart (Bar)
    const ctxRevenue = document.getElementById('revenueChart').getContext('2d');
    new Chart(ctxRevenue, {
        type: 'bar',
        data: {
            labels: [<%= revenueLabels %>],
            datasets: [{
                label: 'Revenue (₹)',
                data: [<%= revenueData %>],
                backgroundColor: 'rgba(2, 132, 199, 0.75)',
                borderColor: '#0284c7',
                borderWidth: 1.5,
                borderRadius: 6
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { display: false }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    grid: { color: '#f1f5f9' }
                },
                x: {
                    grid: { display: false }
                }
            }
        }
    });

    // 2. Appointments Per Doctor Chart (Pie)
    const ctxDoctor = document.getElementById('doctorChart').getContext('2d');
    new Chart(ctxDoctor, {
        type: 'pie',
        data: {
            labels: [<%= doctorLabels %>],
            datasets: [{
                data: [<%= doctorData %>],
                backgroundColor: ['#0284c7', '#10b981', '#f59e0b', '#ec4899', '#8b5cf6', '#64748b']
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { position: 'bottom' }
            }
        }
    });

    // 3. Patient Demographics Chart (Doughnut)
    const ctxPatient = document.getElementById('patientChart').getContext('2d');
    new Chart(ctxPatient, {
        type: 'doughnut',
        data: {
            labels: [<%= patientLabels %>],
            datasets: [{
                data: [<%= patientData %>],
                backgroundColor: ['#3b82f6', '#ec4899', '#f59e0b']
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { position: 'bottom' }
            }
        }
    });
</script>

</body>
</html>