<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Max Super Speciality Hospital, Nagpur | Healthcare Excellence</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <style>
        :root {
            --primary-blue: #003366;
            --accent-blue: #0076be;
            --emergency-red: #d9534f;
            --light-bg: #f8f9fa;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #333;
        }

        /* Top Announcement Bar */
        .top-announcement {
            background-color: #002244;
            color: #fff;
            font-size: 0.85rem;
            padding: 6px 0;
        }

        /* Utility Header */
        .utility-header {
            font-size: 0.9rem;
            border-bottom: 1px solid #e9ecef;
        }

        /* Main Navigation */
        .navbar-brand {
            font-weight: 700;
            color: var(--primary-blue);
            font-size: 1.5rem;
        }

        .nav-link {
            font-weight: 600;
            color: #444 !important;
            margin: 0 5px;
        }

        .nav-link:hover {
            color: var(--accent-blue) !important;
        }

        /* Hero Banner */
        .hero-section {
            background: linear-gradient(135deg, rgba(0, 51, 102, 0.9) 0%, rgba(0, 118, 190, 0.8) 100%), 
                        url('https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?auto=format&fit=crop&w=1500&q=80') center/cover;
            color: #fff;
            padding: 80px 0 100px;
        }

        /* Quick Action Cards */
        .quick-actions {
            margin-top: -50px;
            position: relative;
            z-index: 10;
        }

        .action-card {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }

        .action-card:hover {
            transform: translateY(-5px);
        }

        /* Stats Section */
        .stat-box {
            border-right: 1px solid #dee2e6;
        }

        .stat-box:last-child {
            border-right: none;
        }

        /* Specialities Grid */
        .speciality-card {
            border: 1px solid #e9ecef;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .speciality-card:hover {
            border-color: var(--accent-blue);
            box-shadow: 0 4px 12px rgba(0, 118, 190, 0.15);
        }

        /* Emergency Floating Sidebar Widget */
        .emergency-badge {
            position: fixed;
            right: 0;
            top: 40%;
            background-color: var(--emergency-red);
            color: white;
            padding: 12px 8px;
            writing-mode: vertical-rl;
            text-orientation: mixed;
            border-radius: 8px 0 0 8px;
            font-weight: bold;
            z-index: 1000;
            box-shadow: -2px 2px 10px rgba(0,0,0,0.2);
            text-decoration: none;
        }

        /* Footer Styles */
        footer {
            background-color: #0b1e36;
            color: #a2b4c7;
            font-size: 0.9rem;
        }

        footer h6 {
            color: #fff;
            font-weight: 600;
            margin-bottom: 15px;
        }

        footer a {
            color: #a2b4c7;
            text-decoration: none;
        }

        footer a:hover {
            color: #fff;
        }
    </style>
</head>
<body>

    <!-- Emergency Widget -->
    <a href="tel:+919268880303" class="emergency-badge">
        <i class="fa-solid fa-phone me-1"></i> 24/7 EMERGENCY
    </a>

    <!-- Top Announcement Bar -->
    <div class="top-announcement text-center">
        <span><i class="fa-solid fa-bullhorn me-2"></i> Introducing the New State-of-the-art Tower at Nanavati Max Hospital | Max Hospital Mohali Upgraded</span>
    </div>

    <!-- Utility Header -->
    <div class="utility-header py-2 bg-light d-none d-lg-block">
        <div class="container d-flex justify-content-between align-items-center">
            <div>
                <a href="user-login.jsp" class="me-3 text-dark text-decoration-none"><i class="fa-solid fa-file-medical text-primary me-1"></i> My Reports</a>
                <a href="#about" class="me-3 text-dark text-decoration-none">Research & Academics</a>
                <a href="#contact" class="text-dark text-decoration-none">CSR & Investors</a>
            </div>
            <div class="d-flex align-items-center">
                <a href="https://wa.me/919268880303" class="me-3 text-success text-decoration-none fw-bold"><i class="fa-brands fa-whatsapp me-1"></i> WhatsApp Us</a>
                <a href="tel:+919268880303" class="text-primary text-decoration-none fw-bold"><i class="fa-solid fa-phone me-1"></i> +91 926 888 0303</a>
            </div>
        </div>
    </div>

    <!-- Main Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-white sticky-top shadow-sm">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center" href="index.html">
                <i class="fa-solid fa-hospital-user text-primary me-2 fs-2"></i>
                <div>
                    <div class="lh-1">MAX HEALTHCARE</div>
                    <small class="fs-6 text-muted font-monospace">NAGPUR</small>
                </div>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item"><a class="nav-link" href="#about">About Hospital</a></li>
                    <li class="nav-item"><a class="nav-link" href="#specialities">Specialities</a></li>
                    <li class="nav-item"><a class="nav-link" href="#doctors">Find Doctor</a></li>
                    <li class="nav-item me-2"><a class="btn btn-outline-primary btn-sm px-3" href="user-login.jsp">Patient Portal</a></li>
                    <li class="nav-item"><a class="btn btn-primary btn-sm px-3" href="admin-login.jsp">Admin Portal</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section text-center text-md-start">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <span class="badge bg-danger px-3 py-2 mb-3 fs-6">NABH & JCI ACCREDITED</span>
                    <h1 class="display-4 fw-bold mb-3">Max Super Speciality Hospital, Nagpur</h1>
                    <p class="lead mb-4">A premier 200-bedded tertiary care multi-speciality hospital delivering world-class clinical outcomes through advanced technology and compassionate care.</p>
                    <div class="d-flex flex-wrap gap-2 justify-content-center justify-content-md-start">
                        <a href="tel:+919268880303" class="btn btn-light btn-lg fw-bold"><i class="fa-solid fa-phone me-2 text-primary"></i> Call +91 926 888 0303</a>
                        <a href="user-login.jsp" class="btn btn-outline-light btn-lg fw-bold"><i class="fa-solid fa-calendar-check me-2"></i> Book Appointment</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Quick Action Bar -->
    <div class="container quick-actions">
        <div class="row g-3">
            <div class="col-md-4">
                <div class="action-card p-4 text-center">
                    <i class="fa-solid fa-user-doctor text-primary fs-1 mb-2"></i>
                    <h5>Find a Doctor</h5>
                    <p class="text-muted small">Consult top specialists across 38+ clinical disciplines.</p>
                    <a href="user-login.jsp" class="btn btn-sm btn-outline-primary">Search Doctors</a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="action-card p-4 text-center">
                    <i class="fa-solid fa-calendar-alt text-primary fs-1 mb-2"></i>
                    <h5>Book Appointment</h5>
                    <p class="text-muted small">Quick online scheduling with your preferred clinician.</p>
                    <a href="user-login.jsp" class="btn btn-sm btn-primary">Book Now</a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="action-card p-4 text-center">
                    <i class="fa-solid fa-truck-medical text-danger fs-1 mb-2"></i>
                    <h5>24x7 Emergency Care</h5>
                    <p class="text-muted small">Immediate trauma & critical care ambulance dispatch.</p>
                    <a href="tel:+919268880303" class="btn btn-sm btn-danger">Emergency Call</a>
                </div>
            </div>
        </div>
    </div>

    <!-- About Section -->
    <section id="about" class="py-5 mt-4">
        <div class="container">
            <div class="row align-items-center g-4">
                <div class="col-lg-6">
                    <h6 class="text-primary text-uppercase fw-bold">About Our Hospital</h6>
                    <h2 class="fw-bold mb-3">Redefining Healthcare Excellence in Vidarbha</h2>
                    <p class="text-muted">Max Super Speciality Hospital, Nagpur (a unit of Alexis Multispeciality Hospital Pvt. Ltd.), is a multidisciplinary 200-bedded tertiary care hospital providing comprehensive medical care across all medical specialities.</p>
                    <p class="text-muted">Our experts have treated over 34 lakh patients across 38 specialities including Cardiac Sciences, Neurosciences, Onco Sciences, Nephrology, and Joint Replacement.</p>
                    
                    <div class="d-flex align-items-center gap-3 p-3 bg-light rounded mt-3">
                        <i class="fa-solid fa-location-dot fs-2 text-danger"></i>
                        <div>
                            <h6 class="mb-0 fw-bold">Hospital Address</h6>
                            <small class="text-muted">232, Mankapur, Koradi Rd, Byramji Town, Nagpur, Maharashtra 440030</small>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-6">
                    <!-- Key Statistics Grid -->
                    <div class="row g-3 text-center bg-light p-4 rounded shadow-sm">
                        <div class="col-6 stat-box py-3">
                            <h2 class="fw-bold text-primary mb-0">200+</h2>
                            <span class="text-muted small">Beds Facility</span>
                        </div>
                        <div class="col-6 stat-box py-3">
                            <h2 class="fw-bold text-primary mb-0">800+</h2>
                            <span class="text-muted small">Trained Medical Staff</span>
                        </div>
                        <div class="col-6 stat-box py-3">
                            <h2 class="fw-bold text-primary mb-0">200+</h2>
                            <span class="text-muted small">Eminent Doctors</span>
                        </div>
                        <div class="col-6 stat-box py-3">
                            <h2 class="fw-bold text-primary mb-0">38+</h2>
                            <span class="text-muted small">Medical Specialities</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Specialities Section -->
    <section id="specialities" class="py-5 bg-light">
        <div class="container">
            <div class="text-center mb-5">
                <h6 class="text-primary text-uppercase fw-bold">Centres of Excellence</h6>
                <h2 class="fw-bold">Specialities & Procedures</h2>
            </div>
            
            <div class="row g-3">
                <div class="col-md-4 col-sm-6">
                    <div class="speciality-card p-3 bg-white text-center">
                        <i class="fa-solid fa-heart-pulse text-danger fs-2 mb-2"></i>
                        <h6 class="fw-bold mb-1">Cardiac Sciences</h6>
                        <p class="text-muted small mb-0">Angioplasty, CABG, Valve Surgery</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6">
                    <div class="speciality-card p-3 bg-white text-center">
                        <i class="fa-solid fa-ribbon text-primary fs-2 mb-2"></i>
                        <h6 class="fw-bold mb-1">Cancer Care / Oncology</h6>
                        <p class="text-muted small mb-0">Surgical, Medical & Radiation</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6">
                    <div class="speciality-card p-3 bg-white text-center">
                        <i class="fa-solid fa-brain text-info fs-2 mb-2"></i>
                        <h6 class="fw-bold mb-1">Neurosciences</h6>
                        <p class="text-muted small mb-0">Neurosurgery & Stroke Care</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6">
                    <div class="speciality-card p-3 bg-white text-center">
                        <i class="fa-solid fa-kidneys text-warning fs-2 mb-2"></i>
                        <h6 class="fw-bold mb-1">Kidney Transplant & Nephrology</h6>
                        <p class="text-muted small mb-0">Dialysis & Renal Surgery</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6">
                    <div class="speciality-card p-3 bg-white text-center">
                        <i class="fa-solid fa-bone text-secondary fs-2 mb-2"></i>
                        <h6 class="fw-bold mb-1">Orthopaedics & Joints</h6>
                        <p class="text-muted small mb-0">Robotic Knee Replacement</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6">
                    <div class="speciality-card p-3 bg-white text-center">
                        <i class="fa-solid fa-capsules text-success fs-2 mb-2"></i>
                        <h6 class="fw-bold mb-1">Gastroenterology & Liver</h6>
                        <p class="text-muted small mb-0">Endoscopy & Transplant Care</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="pt-5 pb-3">
        <div class="container">
            <div class="row g-4 mb-4">
                <div class="col-lg-3 col-md-6">
                    <h5 class="text-white mb-3">Max Healthcare Nagpur</h5>
                    <p class="small">Dedicated to clinical excellence, patient care, and state-of-the-art technology.</p>
                    <p class="small mb-1"><i class="fa-solid fa-phone me-2"></i> Emergency: +91 926 888 0303</p>
                    <p class="small"><i class="fa-solid fa-envelope me-2"></i> contact@maxhealthcare.com</p>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h6>For Patients</h6>
                    <ul class="list-unstyled">
                        <li><a href="user-login.jsp">Find a Doctor</a></li>
                        <li><a href="user-login.jsp">Book an Appointment</a></li>
                        <li><a href="user-login.jsp">My Health Reports</a></li>
                        <li><a href="#specialities">Centres of Excellence</a></li>
                    </ul>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h6>Our Hospitals</h6>
                    <ul class="list-unstyled">
                        <li><a href="#">Max Hospital, Saket, Delhi</a></li>
                        <li><a href="#">BLK-Max Hospital, Delhi</a></li>
                        <li><a href="#">Max Hospital, Mohali</a></li>
                        <li><a href="#">Max Hospital, Nagpur</a></li>
                    </ul>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h6>Portals & Access</h6>
                    <a href="admin-login.jsp" class="btn btn-outline-light btn-sm w-100 mb-2">Administrator Login</a>
                    <a href="user-login.jsp" class="btn btn-primary btn-sm w-100">Patient Dashboard</a>
                </div>
            </div>
            
            <hr class="border-secondary">
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-center small">
                <p class="mb-0">&copy; 2026 Max Healthcare. All rights reserved.</p>
                <div>
                    <a href="#" class="me-3">Disclaimer</a>
                    <a href="#" class="me-3">Privacy Policy</a>
                    <a href="#">Terms & Conditions</a>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>