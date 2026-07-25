<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.Connection, com.dao.*, com.model.*" %>
<%@ page session="true" %>
<%
    // 1. Session Authentication Check
    String admin = (String) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }

    // 2. Fetch analytics safely
    Map<String, Double> monthlyRevenue = new HashMap<>();
    Map<String, Integer> patientDemographics = new HashMap<>();

    Connection conn = null;
    try {
        conn = com.dao.DBConnect.getConn();
        ReportDAO reportDao = new ReportDAO(conn);
        monthlyRevenue = reportDao.getMonthlyRevenue();
        patientDemographics = reportDao.getPatientDemographics();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (conn != null) {
            try {
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    // 3. Format Monthly Revenue for JavaScript (Safely Escaped)
    String revenueLabels = "";
    String revenueData = "";
    if (monthlyRevenue != null && !monthlyRevenue.isEmpty()) {
        revenueLabels = monthlyRevenue.keySet().stream()
                               .map(s -> "'" + s.replace("'", "\\'") + "'")
                               .reduce((a, b) -> a + "," + b).orElse("");
        revenueData = monthlyRevenue.values().stream()
                             .map(String::valueOf)
                             .reduce((a, b) -> a + "," + b).orElse("");
    } else {
        revenueLabels = "'No Data'";
        revenueData = "0";
    }

    // 4. Format Demographics for JavaScript (Safely Escaped)
    String demographicLabels = "";
    String demographicData = "";
    if (patientDemographics != null && !patientDemographics.isEmpty()) {
        demographicLabels = patientDemographics.keySet().stream()
                                   .map(s -> "'" + s.replace("'", "\\'") + "'")
                                   .reduce((a, b) -> a + "," + b).orElse("");
        demographicData = patientDemographics.values().stream()
                                 .map(String::valueOf)
                                 .reduce((a, b) -> a + "," + b).orElse("");
    } else {
        demographicLabels = "'No Data'";
        demographicData = "0";
    }

    double totalRevenueVal = (monthlyRevenue != null) ? monthlyRevenue.values().stream().mapToDouble(Double::doubleValue).sum() : 0.0;
    int totalPatientsVal = (patientDemographics != null) ? patientDemographics.values().stream().mapToInt(Integer::intValue).sum() : 0;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | Hospital Management</title>
    
    <!-- Chart.js Modern CDN -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>
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
            border-radius: 12px;
            transition: transform 0.2s ease;
        }

        .stat-card:hover {
            transform: translateY(-2px);
        }

        .action-card-btn {
            display: flex;
            align-items: center;
            gap: 0.85rem;
            padding: 1rem 1.25rem;
            background-color: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            color: #334155;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.2s ease;
        }

        .action-card-btn:hover {
            border-color: #0284c7;
            background-color: #f0f9ff;
            color: #0284c7;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(2, 132, 199, 0.08);
        }

        .action-icon {
            width: 42px;
            height: 42px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1rem;
            flex-shrink: 0;
        }

        .chart-container {
            position: relative;
            min-height: 300px;
            width: 100%;
        }
    </style>
</head>
<body>

<!-- Header Banner -->
<div class="page-header">
    <div class="container d-flex justify-content-between align-items-center">
        <div>
            <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-3 py-1 mb-2 rounded-pill small">Admin Portal</span>
            <h2 class="fw-bold mb-1"><i class="fa-solid fa-user-shield me-2 text-info"></i>Welcome, <%= admin %></h2>
            <p class="text-slate-300 mb-0 opacity-75 small">Hospital operations, appointments, and performance overview</p>
        </div>
        <div class="d-flex align-items-center gap-2">
            <a href="reports.jsp" class="btn btn-outline-light btn-sm px-3">
                <i class="fa-solid fa-chart-line me-1"></i> Full Analytics
            </a>
            <a href="LogoutServlet" class="btn btn-danger btn-sm px-3">
                <i class="fa-solid fa-right-from-bracket me-1"></i> Logout
            </a>
        </div>
    </div>
</div>

<div class="container mb-5">

    <!-- Top Key Metrics Cards -->
    <div class="row g-3 mb-4">
        <div class="col-md-6 col-lg-6">
            <div class="card stat-card p-3 shadow-sm" style="border-left-color: #0284c7;">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="text-muted small fw-bold text-uppercase">Total Patients Recorded</span>
                        <h3 class="fw-bold text-dark mb-0"><%= totalPatientsVal %></h3>
                    </div>
                    <div class="p-3 bg-primary-subtle text-primary rounded-circle">
                        <i class="fa-solid fa-hospital-user fa-lg"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-6 col-lg-6">
            <div class="card stat-card p-3 shadow-sm" style="border-left-color: #10b981;">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="text-muted small fw-bold text-uppercase">Gross Billed Revenue</span>
                        <h3 class="fw-bold text-success mb-0">₹<%= String.format("%.2f", totalRevenueVal) %></h3>
                    </div>
                    <div class="p-3 bg-success-subtle text-success rounded-circle">
                        <i class="fa-solid fa-indian-rupee-sign fa-lg"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Actions Grid -->
    <div class="card card-custom p-4 mb-4">
        <h5 class="fw-bold text-dark mb-3"><i class="fa-solid fa-bolt me-2 text-warning"></i>Quick Management Tools</h5>
        
        <div class="row g-3">
            <!-- Medical Staff -->
            <div class="col-md-6 col-lg-3">
                <a href="add-doctor.jsp" class="action-card-btn shadow-sm">
                    <div class="action-icon bg-success-subtle text-success">
                        <i class="fa-solid fa-user-plus"></i>
                    </div>
                    <div>
                        <div class="text-dark">Add Doctor</div>
                        <div class="small text-muted fw-normal">Register specialist</div>
                    </div>
                </a>
            </div>

            <div class="col-md-6 col-lg-3">
                <a href="view-doctors.jsp" class="action-card-btn shadow-sm">
                    <div class="action-icon bg-primary-subtle text-primary">
                        <i class="fa-solid fa-user-doctor"></i>
                    </div>
                    <div>
                        <div class="text-dark">See All Doctors</div>
                        <div class="small text-muted fw-normal">Directory & timing</div>
                    </div>
                </a>
            </div>

            <!-- Patient Services -->
            <div class="col-md-6 col-lg-3">
                <a href="add-patient.jsp" class="action-card-btn shadow-sm">
                    <div class="action-icon bg-success-subtle text-success">
                        <i class="fa-solid fa-hospital-user"></i>
                    </div>
                    <div>
                        <div class="text-dark">Add Patient</div>
                        <div class="small text-muted fw-normal">New profile</div>
                    </div>
                </a>
            </div>

            <div class="col-md-6 col-lg-3">
                <a href="search-patient.jsp" class="action-card-btn shadow-sm">
                    <div class="action-icon bg-info-subtle text-info">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </div>
                    <div>
                        <div class="text-dark">Search Patients</div>
                        <div class="small text-muted fw-normal">Find records</div>
                    </div>
                </a>
            </div>

            <!-- Appointments & Billing -->
            <div class="col-md-6 col-lg-3">
                <a href="see-all-appointment.jsp" class="action-card-btn shadow-sm">
                    <div class="action-icon bg-warning-subtle text-warning">
                        <i class="fa-solid fa-calendar-check"></i>
                    </div>
                    <div>
                        <div class="text-dark">All Appointments</div>
                        <div class="small text-muted fw-normal">Schedule & confirm</div>
                    </div>
                </a>
            </div>

            <div class="col-md-6 col-lg-3">
                <a href="generate-bill.jsp" class="action-card-btn shadow-sm">
                    <div class="action-icon bg-info-subtle text-info">
                        <i class="fa-solid fa-file-invoice-dollar"></i>
                    </div>
                    <div>
                        <div class="text-dark">Generate Bill</div>
                        <div class="small text-muted fw-normal">Issue invoice</div>
                    </div>
                </a>
            </div>

            <div class="col-md-6 col-lg-3">
                <a href="billing-history.jsp" class="action-card-btn shadow-sm">
                    <div class="action-icon bg-secondary-subtle text-secondary">
                        <i class="fa-solid fa-receipt"></i>
                    </div>
                    <div>
                        <div class="text-dark">Billing History</div>
                        <div class="small text-muted fw-normal">Invoices & revenue</div>
                    </div>
                </a>
            </div>

            <div class="col-md-6 col-lg-3">
                <a href="send-confirm-email.jsp" class="action-card-btn shadow-sm">
                    <div class="action-icon bg-dark-subtle text-dark">
                        <i class="fa-solid fa-paper-plane"></i>
                    </div>
                    <div>
                        <div class="text-dark">Send Email</div>
                        <div class="small text-muted fw-normal">Confirmation alerts</div>
                    </div>
                </a>
            </div>

            <!-- User Management -->
            <div class="col-md-6 col-lg-3">
                <a href="view-users.jsp" class="action-card-btn shadow-sm">
                    <div class="action-icon bg-primary-subtle text-primary">
                        <i class="fa-solid fa-users-gear"></i>
                    </div>
                    <div>
                        <div class="text-dark">All Users</div>
                        <div class="small text-muted fw-normal">System accounts & roles</div>
                    </div>
                </a>
            </div>
        </div>
    </div>

    <!-- Live Analytics Charts -->
    <div class="row g-4">
        <div class="col-lg-6">
            <div class="card card-custom p-4 h-100">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="fw-bold text-dark mb-0"><i class="fa-solid fa-users me-2 text-primary"></i>Patient Demographics</h5>
                    <span class="badge bg-light text-muted border">Gender Ratio</span>
                </div>
                <div class="chart-container">
                    <canvas id="patientsChart"></canvas>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="card card-custom p-4 h-100">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="fw-bold text-dark mb-0"><i class="fa-solid fa-chart-line me-2 text-success"></i>Revenue Growth</h5>
                    <span class="badge bg-light text-muted border">Monthly Trend</span>
                </div>
                <div class="chart-container">
                    <canvas id="revenueChart"></canvas>
                </div>
            </div>
        </div>
    </div>

</div>

<!-- Bootstrap 5 Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Chart Initialization Script -->
<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Patient Demographics Chart (Bar Chart)
        const ctx1 = document.getElementById('patientsChart').getContext('2d');
        new Chart(ctx1, {
            type: 'bar',
            data: {
                labels: [<%= demographicLabels %>],
                datasets: [{
                    label: 'Total Patients',
                    data: [<%= demographicData %>],
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
                    legend: { display: false },
                    tooltip: {
                        padding: 10,
                        cornerRadius: 6
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: { color: '#f1f5f9' },
                        ticks: { precision: 0 }
                    },
                    x: {
                        grid: { display: false }
                    }
                }
            }
        });

        // Revenue Growth Chart (Line Chart)
        const ctx2 = document.getElementById('revenueChart').getContext('2d');
        new Chart(ctx2, {
            type: 'line',
            data: {
                labels: [<%= revenueLabels %>],
                datasets: [{
                    label: 'Revenue (₹)',
                    data: [<%= revenueData %>],
                    backgroundColor: 'rgba(16, 185, 129, 0.15)',
                    borderColor: '#10b981',
                    borderWidth: 2.5,
                    pointBackgroundColor: '#10b981',
                    pointHoverRadius: 6,
                    fill: true,
                    tension: 0.35
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false },
                    tooltip: {
                        padding: 10,
                        cornerRadius: 6,
                        callbacks: {
                            label: function(context) {
                                return ' Revenue: ₹' + context.parsed.y.toLocaleString('en-IN');
                            }
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: { color: '#f1f5f9' },
                        ticks: {
                            callback: function(value) {
                                return '₹' + value;
                            }
                        }
                    },
                    x: {
                        grid: { display: false }
                    }
                }
            }
        });
    });
</script>

</body>
</html>