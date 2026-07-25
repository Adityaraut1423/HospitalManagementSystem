<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Aadi Hospital, Nagpur | Super Speciality & Research Centre</title>
    
    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome 6.5 Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts (Plus Jakarta Sans) -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary-navy: #070f1e;
            --secondary-navy: #0f172a;
            --brand-blue: #0284c7;
            --brand-cyan: #38bdf8;
            --emergency-red: #dc2626;
            --text-dark: #0f172a;
            --text-muted: #64748b;
            --card-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
            --card-shadow-hover: 0 20px 40px rgba(2, 132, 199, 0.15);
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            color: var(--text-dark);
            background-color: #ffffff;
            overflow-x: hidden;
        }

        /* Premium Top Announcement Bar */
        .announcement-bar {
            background: linear-gradient(90deg, #070f1e 0%, #0f172a 50%, #070f1e 100%);
            color: #ffffff;
            font-size: 0.82rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
            position: relative;
            z-index: 1060;
        }

        .announcement-badge {
            background: rgba(2, 132, 199, 0.15);
            border: 1px solid rgba(56, 189, 248, 0.35);
            color: var(--brand-cyan);
            font-size: 0.70rem;
            font-weight: 700;
            padding: 4px 12px;
            border-radius: 20px;
            letter-spacing: 0.6px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            text-transform: uppercase;
        }

        .pulse-dot {
            width: 6px;
            height: 6px;
            background-color: var(--brand-cyan);
            border-radius: 50%;
            box-shadow: 0 0 8px var(--brand-cyan);
            animation: pulse 1.8s infinite;
        }

        @keyframes pulse {
            0% {
                transform: scale(0.95);
                box-shadow: 0 0 0 0 rgba(56, 189, 248, 0.7);
            }
            70% {
                transform: scale(1);
                box-shadow: 0 0 0 6px rgba(56, 189, 248, 0);
            }
            100% {
                transform: scale(0.95);
                box-shadow: 0 0 0 0 rgba(56, 189, 248, 0);
            }
        }

        .announcement-text {
            font-weight: 500;
            color: #cbd5e1;
            font-size: 0.84rem;
            letter-spacing: 0.2px;
        }

        .top-helpline-link {
            color: #e2e8f0;
            text-decoration: none;
            font-size: 0.8rem;
            padding: 4px 14px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.12);
            border-radius: 20px;
            transition: all 0.25s ease;
        }

        .top-helpline-link:hover {
            color: #ffffff;
            background: rgba(2, 132, 199, 0.25);
            border-color: rgba(56, 189, 248, 0.5);
            transform: translateY(-1px);
        }

        .utility-header {
            background-color: #f8fafc;
            font-size: 0.85rem;
            border-bottom: 1px solid #e2e8f0;
        }

        .navbar-brand-logo {
            font-weight: 800;
            color: var(--primary-navy);
            font-size: 1.5rem;
            letter-spacing: -0.5px;
        }

        .nav-link {
            font-weight: 600;
            color: #334155 !important;
            font-size: 0.95rem;
            padding: 0.5rem 0.8rem !important;
        }

        .nav-link:hover {
            color: var(--brand-blue) !important;
        }

        .floating-emergency {
            position: fixed;
            right: 0;
            top: 32%;
            background-color: var(--emergency-red);
            color: #fff;
            padding: 14px 10px;
            writing-mode: vertical-rl;
            text-orientation: mixed;
            border-radius: 10px 0 0 10px;
            font-weight: 800;
            z-index: 1050;
            box-shadow: -3px 3px 15px rgba(220, 38, 38, 0.4);
            text-decoration: none;
            letter-spacing: 1px;
            transition: all 0.3s ease;
        }

        .floating-emergency:hover {
            color: #fff;
            background-color: #b91c1c;
            padding-right: 16px;
        }

        .hero-banner {
            background: linear-gradient(135deg, rgba(7, 15, 30, 0.92) 0%, rgba(2, 132, 199, 0.85) 100%), 
                        url('https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?auto=format&fit=crop&w=1600&q=80') center/cover no-repeat;
            color: #ffffff;
            padding: 100px 0 130px;
        }

        .search-box-container {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.25);
            border-radius: 16px;
            padding: 14px;
        }

        .quick-action-wrapper {
            margin-top: -65px;
            position: relative;
            z-index: 20;
        }

        .action-card {
            background: #ffffff;
            border-radius: 18px;
            padding: 28px 20px;
            box-shadow: var(--card-shadow);
            border: 1px solid #f1f5f9;
            transition: all 0.3s ease;
            height: 100%;
        }

        .action-card:hover {
            transform: translateY(-6px);
            box-shadow: var(--card-shadow-hover);
            border-color: var(--brand-blue);
        }

        .action-icon {
            width: 60px;
            height: 60px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.6rem;
            margin: 0 auto 16px;
        }

        .stat-card {
            background-color: #f8fafc;
            border-radius: 14px;
            padding: 24px;
            text-align: center;
            border: 1px solid #e2e8f0;
        }

        .doctor-card {
            background: #ffffff;
            border-radius: 18px;
            border: 1px solid #e2e8f0;
            overflow: hidden;
            transition: all 0.3s ease;
            box-shadow: var(--card-shadow);
            height: 100%;
        }

        .doctor-card:hover {
            transform: translateY(-6px);
            box-shadow: var(--card-shadow-hover);
            border-color: var(--brand-blue);
        }

        .doctor-img-container {
            position: relative;
            height: 260px;
            background-color: #e2e8f0;
            overflow: hidden;
        }

        .doctor-img-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            object-position: top;
            transition: transform 0.5s ease;
        }

        .doctor-card:hover .doctor-img-container img {
            transform: scale(1.05);
        }

        .exp-badge {
            position: absolute;
            bottom: 12px;
            right: 12px;
            background: rgba(7, 15, 30, 0.88);
            color: #ffffff;
            backdrop-filter: blur(6px);
            padding: 6px 12px;
            border-radius: 8px;
            font-size: 0.78rem;
            font-weight: 700;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .speciality-card {
            background: #ffffff;
            border-radius: 16px;
            border: 1px solid #e2e8f0;
            padding: 26px;
            transition: all 0.3s ease;
            text-align: center;
            height: 100%;
        }

        .speciality-card:hover {
            border-color: var(--brand-blue);
            transform: translateY(-4px);
            box-shadow: var(--card-shadow);
        }

        .directory-section {
            background-color: #f8fafc;
            border-top: 1px solid #e2e8f0;
            border-bottom: 1px solid #e2e8f0;
        }

        .directory-link {
            color: #475569;
            text-decoration: none;
            font-size: 0.85rem;
            display: block;
            padding: 5px 0;
            transition: color 0.2s;
        }

        .directory-link:hover {
            color: var(--brand-blue);
        }

        footer {
            background-color: var(--primary-navy);
            color: #94a3b8;
            font-size: 0.88rem;
        }

        footer h6 {
            color: #ffffff;
            font-weight: 700;
            margin-bottom: 18px;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            font-size: 0.82rem;
        }

        footer ul li {
            margin-bottom: 8px;
        }

        footer a {
            color: #cbd5e1;
            text-decoration: none;
            transition: color 0.2s;
        }

        footer a:hover {
            color: #ffffff;
        }

        .disclaimer-box {
            background-color: rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            padding: 16px;
            font-size: 0.78rem;
            line-height: 1.5;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
    </style>
</head>
<body>

    <!-- Floating 24/7 Emergency Sidebar Trigger -->
    <a href="tel:+919268880303" class="floating-emergency">
        <i class="fa-solid fa-phone-volume mb-2"></i> 24x7 EMERGENCY & AMBULANCE
    </a>

    <!-- Premium Announcement & Emergency Ticker Bar -->
    <div class="announcement-bar py-2">
        <div class="container d-flex justify-content-between align-items-center">
            <div class="d-flex align-items-center gap-2 text-truncate">
                <span class="announcement-badge">
                    <span class="pulse-dot"></span> NEW FACILITY
                </span>
                <span class="announcement-text text-truncate">
                    Introducing the New Robotic Surgical Tower & Advanced Organ Transplant Unit at Aadi Hospital, Nagpur
                </span>
            </div>

            <div class="d-none d-md-flex align-items-center gap-2 ms-3 text-nowrap">
                <a href="tel:+919268880303" class="top-helpline-link">
                    <i class="fa-solid fa-headset text-info me-1"></i> 24/7 Emergency Helpline: <strong>+91 926 888 0303</strong>
                </a>
            </div>
        </div>
    </div>

    <!-- Utility Header Bar -->
    <div class="utility-header py-2 d-none d-lg-block">
        <div class="container d-flex justify-content-between align-items-center">
            <div class="d-flex align-items-center gap-4">
                <a href="user-login.jsp" class="text-dark text-decoration-none"><i class="fa-solid fa-file-invoice text-primary me-1"></i> My Health Reports</a>
                <a href="#investors" class="text-dark text-decoration-none"><i class="fa-solid fa-chart-pie text-primary me-1"></i> Investor Relations</a>
                <a href="#blogs" class="text-dark text-decoration-none"><i class="fa-solid fa-newspaper text-primary me-1"></i> Health Blogs</a>
            </div>
            <div class="d-flex align-items-center gap-3">
                <a href="https://wa.me/919268880303" class="text-success text-decoration-none fw-bold"><i class="fa-brands fa-whatsapp me-1"></i> WhatsApp Us (24/7)</a>
            </div>
        </div>
    </div>

    <!-- Main Navigation Header -->
    <nav class="navbar navbar-expand-lg navbar-light bg-white sticky-top shadow-sm py-3">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center" href="index.jsp">
                <div class="p-2 bg-primary-subtle text-primary rounded-3 me-2">
                    <i class="fa-solid fa-hospital fs-3"></i>
                </div>
                <div>
                    <div class="navbar-brand-logo">AADI HOSPITAL</div>
                    <div class="text-muted fw-semibold" style="font-size: 0.72rem; letter-spacing: 1px;">SUPER SPECIALITY & RESEARCH CENTRE, NAGPUR</div>
                </div>
            </a>
            
            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#mainNavbar">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="mainNavbar">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item"><a class="nav-link" href="#about">About Hospital</a></li>
                    <li class="nav-item"><a class="nav-link" href="#specialities">Specialities</a></li>
                    <li class="nav-item"><a class="nav-link" href="#doctors">Eminent Doctors</a></li>
                    <li class="nav-item"><a class="nav-link" href="#treatments">Procedures</a></li>
                    <li class="nav-item me-2"><a href="user-login.jsp" class="btn btn-outline-primary btn-sm px-3 py-2 fw-semibold">Patient Login</a></li>
                    <li class="nav-item"><a href="admin-login.jsp" class="btn btn-primary btn-sm px-3 py-2 fw-semibold">Admin Portal</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-banner">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <div class="d-inline-flex align-items-center gap-2 bg-white bg-opacity-10 border border-white border-opacity-25 px-3 py-1 rounded-pill mb-3">
                        <i class="fa-solid fa-award text-warning"></i>
                        <span class="small fw-semibold">NABH & JCI ACCREDITED MULTISPECIALITY HOSPITAL</span>
                    </div>
                    <h1 class="display-4 fw-extrabold mb-3 lh-sm">Redefining Healthcare Excellence in Vidarbha</h1>
                    <p class="lead opacity-90 mb-4">A premier 250+ bedded tertiary care super speciality hospital in Nagpur. Combining compassionate medical care with cutting-edge robotic, laparoscopic, and organ transplant technologies.</p>
                    
                    <!-- Search Widget -->
                    <div class="search-box-container mb-4">
                        <form action="user-login.jsp" method="get" class="row g-2">
                            <div class="col-md-8">
                                <div class="input-group">
                                    <span class="input-group-text bg-white border-0"><i class="fa-solid fa-magnifying-glass text-muted"></i></span>
                                    <input type="text" class="form-control border-0 py-2" placeholder="Search for Doctors, Specialities, or Treatments...">
                                </div>
                            </div>
                            <div class="col-md-4">
                                <button type="submit" class="btn btn-warning w-100 py-2 fw-bold"><i class="fa-solid fa-calendar-check me-1"></i> Search & Book</button>
                            </div>
                        </form>
                    </div>

                    <div class="d-flex flex-wrap gap-3 align-items-center">
                        <a href="tel:+919268880303" class="btn btn-light btn-lg fw-bold px-4 py-2 text-primary">
                            <i class="fa-solid fa-phone me-2"></i> Call Us: +91 926 888 0303
                        </a>
                        <span class="text-white opacity-75">OR</span>
                        <a href="user-login.jsp" class="btn btn-outline-light btn-lg fw-bold px-4 py-2">
                            <i class="fa-solid fa-user-plus me-2"></i> Register New Patient
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Quick Actions Bar -->
    <div class="container quick-action-wrapper">
        <div class="row g-3">
            <div class="col-md-3 col-sm-6">
                <div class="action-card text-center">
                    <div class="action-icon bg-primary-subtle text-primary">
                        <i class="fa-solid fa-user-doctor"></i>
                    </div>
                    <h5 class="fw-bold mb-2">Find a Doctor</h5>
                    <p class="text-muted small mb-3">Consult eminent specialists across 38+ clinical disciplines.</p>
                    <a href="user-login.jsp" class="btn btn-sm btn-outline-primary fw-semibold px-3">Search Directory</a>
                </div>
            </div>
            
            <div class="col-md-3 col-sm-6">
                <div class="action-card text-center">
                    <div class="action-icon bg-success-subtle text-success">
                        <i class="fa-solid fa-calendar-check"></i>
                    </div>
                    <h5 class="fw-bold mb-2">Book Appointment</h5>
                    <p class="text-muted small mb-3">Schedule OPD consultations with instant confirmation.</p>
                    <a href="book-appointment.jsp" class="btn btn-sm btn-success fw-semibold px-3 text-white">Book Online</a>
                </div>
            </div>

            <div class="col-md-3 col-sm-6">
                <div class="action-card text-center">
                    <div class="action-icon bg-info-subtle text-info">
                        <i class="fa-solid fa-file-medical"></i>
                    </div>
                    <h5 class="fw-bold mb-2">My Reports & Scans</h5>
                    <p class="text-muted small mb-3">View pathology lab reports and radiology results.</p>
                    <a href="user-login.jsp" class="btn btn-sm btn-outline-info fw-semibold px-3">Access Records</a>
                </div>
            </div>

            <div class="col-md-3 col-sm-6">
                <div class="action-card text-center">
                    <div class="action-icon bg-danger-subtle text-danger">
                        <i class="fa-solid fa-truck-medical"></i>
                    </div>
                    <h5 class="fw-bold mb-2">24x7 Emergency Care</h5>
                    <p class="text-muted small mb-3">Advanced Trauma & ICU Critical Care unit dispatch.</p>
                    <a href="tel:+919268880303" class="btn btn-sm btn-danger fw-semibold px-3">Emergency Call</a>
                </div>
            </div>
        </div>
    </div>

    <!-- About Aadi Hospital Section -->
    <section id="about" class="py-5 my-4">
        <div class="container py-3">
            <div class="row align-items-center g-5">
                <div class="col-lg-6">
                    <span class="text-primary fw-bold text-uppercase tracking-wider small">About Aadi Hospital</span>
                    <h2 class="fw-bold display-6 mb-3">Pioneering Clinical Care & Medical Innovation</h2>
                    <p class="text-muted leading-relaxed">Aadi Hospital, Nagpur, is a multidisciplinary 250+ bedded tertiary care hospital offering comprehensive medical care across all specialities. Our team of doctors, trained staff, and modern infrastructure ensure high quality patient care.</p>
                    <p class="text-muted leading-relaxed">Our specialists have treated over 35 lakh patients across 38 medical disciplines, including Cardiac Sciences, Oncology, Neurosciences, Nephrology, and Joint Replacement.</p>

                    <div class="p-3 bg-light rounded-3 border d-flex align-items-center gap-3 mt-4">
                        <i class="fa-solid fa-location-dot fs-2 text-danger"></i>
                        <div>
                            <h6 class="fw-bold mb-1">Aadi Hospital Campus Address</h6>
                            <p class="text-muted small mb-0">232, Mankapur, Koradi Rd, Byramji Town, Nagpur, Maharashtra 440030</p>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <!-- Key Statistics Grid -->
                    <div class="row g-3">
                        <div class="col-6">
                            <div class="stat-card">
                                <h2 class="display-5 fw-extrabold text-primary mb-0">250+</h2>
                                <span class="fw-semibold text-muted small">In-patient Beds Facility</span>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="stat-card">
                                <h2 class="display-5 fw-extrabold text-primary mb-0">900+</h2>
                                <span class="fw-semibold text-muted small">Trained Healthcare Staff</span>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="stat-card">
                                <h2 class="display-5 fw-extrabold text-primary mb-0">200+</h2>
                                <span class="fw-semibold text-muted small">Eminent Specialist Doctors</span>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="stat-card">
                                <h2 class="display-5 fw-extrabold text-primary mb-0">38+</h2>
                                <span class="fw-semibold text-muted small">Medical Specialities</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Eminent Medical Experts Section -->
    <section id="doctors" class="py-5 bg-light">
        <div class="container py-3">
            <div class="d-flex justify-content-between align-items-end mb-5">
                <div>
                    <span class="text-primary fw-bold text-uppercase small">Medical Experts</span>
                    <h2 class="fw-bold display-6 mb-0">Meet Our Chief Specialists</h2>
                </div>
                <a href="user-login.jsp" class="btn btn-outline-primary btn-sm fw-semibold">View All Doctors</a>
            </div>

            <div class="row g-4">
                <!-- Doctor Card 1: Dr. Rajesh Sharma -->
                <div class="col-lg-3 col-md-6">
                    <div class="doctor-card">
                        <div class="doctor-img-container">
                            <img src="https://images.pexels.com/photos/5327585/pexels-photo-5327585.jpeg?auto=compress&cs=tinysrgb&w=600" 
                                 alt="Dr. Rajesh Sharma"
                                 onerror="this.onerror=null; this.src='https://ui-avatars.com/api/?name=Rajesh+Sharma&background=0284c7&color=fff&size=500';">
                            <span class="exp-badge"><i class="fa-solid fa-award me-1 text-warning"></i> 22+ Yrs Exp</span>
                        </div>
                        <div class="p-4">
                            <span class="badge bg-danger-subtle text-danger mb-2">Cardiology</span>
                            <h5 class="fw-bold text-dark mb-1">Dr. Anuja Sharma</h5>
                            <p class="text-muted small mb-2">Chief Interventional Cardiologist</p>
                            <p class="text-muted fs-7 mb-3"><i class="fa-solid fa-graduation-cap text-primary me-1"></i> MBBS, MD, DM (Cardiology)</p>
                            <a href="book-appointment.jsp" class="btn btn-sm btn-outline-primary w-100 fw-semibold">Book Consultation</a>
                        </div>
                    </div>
                </div>

                <!-- Doctor Card 2: Dr. Ananya Deshmukh -->
                <div class="col-lg-3 col-md-6">
                    <div class="doctor-card">
                        <div class="doctor-img-container">
                            <img src="https://images.pexels.com/photos/5215024/pexels-photo-5215024.jpeg?auto=compress&cs=tinysrgb&w=600" 
                                 alt="Dr. Ananya Deshmukh"
                                 onerror="this.onerror=null; this.src='https://ui-avatars.com/api/?name=Ananya+Deshmukh&background=0284c7&color=fff&size=500';">
                            <span class="exp-badge"><i class="fa-solid fa-award me-1 text-warning"></i> 18+ Yrs Exp</span>
                        </div>
                        <div class="p-4">
                            <span class="badge bg-primary-subtle text-primary mb-2">Oncology</span>
                            <h5 class="fw-bold text-dark mb-1">Dr. Ananya Shah</h5>
                            <p class="text-muted small mb-2">Senior Surgical Oncologist</p>
                            <p class="text-muted fs-7 mb-3"><i class="fa-solid fa-graduation-cap text-primary me-1"></i> MBBS, MS, MCh (Surgical Onco)</p>
                            <a href="book-appointment.jsp" class="btn btn-sm btn-outline-primary w-100 fw-semibold">Book Consultation</a>
                        </div>
                    </div>
                </div>

                <!-- Doctor Card 3: Dr. Vikram Patel -->
                <div class="col-lg-3 col-md-6">
                    <div class="doctor-card">
                        <div class="doctor-img-container">
                            <img src="https://images.pexels.com/photos/6129681/pexels-photo-6129681.jpeg?auto=compress&cs=tinysrgb&w=600" 
                                 alt="Dr. Vikram Patel"
                                 onerror="this.onerror=null; this.src='https://ui-avatars.com/api/?name=Vikram+Patel&background=0284c7&color=fff&size=500';">
                            <span class="exp-badge"><i class="fa-solid fa-award me-1 text-warning"></i> 20+ Yrs Exp</span>
                        </div>
                        <div class="p-4">
                            <span class="badge bg-info-subtle text-info mb-2">Neurosciences</span>
                            <h5 class="fw-bold text-dark mb-1">Dr. Vikram Patel</h5>
                            <p class="text-muted small mb-2">Lead Neurosurgeon & Spine Expert</p>
                            <p class="text-muted fs-7 mb-3"><i class="fa-solid fa-graduation-cap text-primary me-1"></i> MBBS, MS, MCh (Neurosurgery)</p>
                            <a href="book-appointment.jsp" class="btn btn-sm btn-outline-primary w-100 fw-semibold">Book Consultation</a>
                        </div>
                    </div>
                </div>

                <!-- Doctor Card 4: Dr. Sunita Kulkarni -->
                <div class="col-lg-3 col-md-6">
                    <div class="doctor-card">
                        <div class="doctor-img-container">
                            <img src="https://images.pexels.com/photos/8460159/pexels-photo-8460159.jpeg?auto=compress&cs=tinysrgb&w=600" 
                                 alt="Dr. Sunita Kulkarni"
                                 onerror="this.onerror=null; this.src='https://ui-avatars.com/api/?name=Sunita+Kulkarni&background=0284c7&color=fff&size=500';">
                            <span class="exp-badge"><i class="fa-solid fa-award me-1 text-warning"></i> 15+ Yrs Exp</span>
                        </div>
                        <div class="p-4">
                            <span class="badge bg-warning-subtle text-warning mb-2">Orthopaedics</span>
                            <h5 class="fw-bold text-dark mb-1">Dr. Saurabh Kulkarni</h5>
                            <p class="text-muted small mb-2">Robotic Joint Replacement Specialist</p>
                            <p class="text-muted fs-7 mb-3"><i class="fa-solid fa-graduation-cap text-primary me-1"></i> MBBS, MS (Orthopaedics), FRCS</p>
                            <a href="book-appointment.jsp" class="btn btn-sm btn-outline-primary w-100 fw-semibold">Book Consultation</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Specialities Section -->
    <section id="specialities" class="py-5">
        <div class="container py-3">
            <div class="text-center max-w-2xl mx-auto mb-5">
                <span class="text-primary fw-bold text-uppercase small">Centres of Excellence</span>
                <h2 class="fw-bold display-6">Specialities & Advanced Care Units</h2>
                <p class="text-muted">Equipped with robotic technology, modern ICUs, and specialized surgical suites.</p>
            </div>

            <div class="row g-4">
                <div class="col-lg-4 col-md-6">
                    <div class="speciality-card">
                        <div class="action-icon bg-danger-subtle text-danger">
                            <i class="fa-solid fa-heart-pulse"></i>
                        </div>
                        <h5 class="fw-bold mb-2">Cardiac Sciences</h5>
                        <p class="text-muted small mb-3">Angioplasty, Coronary Artery Bypass Grafting (CABG), Robotic Heart Surgery, and Valvular Repair.</p>
                        <a href="user-login.jsp" class="text-primary text-decoration-none fw-semibold small">Explore Cardiology <i class="fa-solid fa-arrow-right ms-1"></i></a>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6">
                    <div class="speciality-card">
                        <div class="action-icon bg-primary-subtle text-primary">
                            <i class="fa-solid fa-ribbon"></i>
                        </div>
                        <h5 class="fw-bold mb-2">Cancer Care / Oncology</h5>
                        <p class="text-muted small mb-3">Surgical, Medical, and Radiation Oncology, CAR T-Cell Therapy, Chemotherapy, and HIPEC.</p>
                        <a href="user-login.jsp" class="text-primary text-decoration-none fw-semibold small">Explore Oncology <i class="fa-solid fa-arrow-right ms-1"></i></a>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6">
                    <div class="speciality-card">
                        <div class="action-icon bg-info-subtle text-info">
                            <i class="fa-solid fa-brain"></i>
                        </div>
                        <h5 class="fw-bold mb-2">Neurosciences</h5>
                        <p class="text-muted small mb-3">Brain Tumor Surgery, Complex Spine Reconstruction, Stroke Intervention, and Neurological Care.</p>
                        <a href="user-login.jsp" class="text-primary text-decoration-none fw-semibold small">Explore Neurosciences <i class="fa-solid fa-arrow-right ms-1"></i></a>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6">
                    <div class="speciality-card">
                        <div class="action-icon bg-warning-subtle text-warning">
                            <i class="fa-solid fa-id-card"></i>
                        </div>
                        <h5 class="fw-bold mb-2">Liver & Kidney Transplant</h5>
                        <p class="text-muted small mb-3">Living and deceased donor renal transplantation, biliary reconstruction, and dialysis unit.</p>
                        <a href="user-login.jsp" class="text-primary text-decoration-none fw-semibold small">Explore Transplants <i class="fa-solid fa-arrow-right ms-1"></i></a>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6">
                    <div class="speciality-card">
                        <div class="action-icon bg-secondary-subtle text-secondary">
                            <i class="fa-solid fa-bone"></i>
                        </div>
                        <h5 class="fw-bold mb-2">Orthopaedics & Joint Replacement</h5>
                        <p class="text-muted small mb-3">Robotic Knee and Hip Replacement, Sports Injury Arthroscopy, and Complex Trauma Care.</p>
                        <a href="user-login.jsp" class="text-primary text-decoration-none fw-semibold small">Explore Orthopaedics <i class="fa-solid fa-arrow-right ms-1"></i></a>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6">
                    <div class="speciality-card">
                        <div class="action-icon bg-success-subtle text-success">
                            <i class="fa-solid fa-capsules"></i>
                        </div>
                        <h5 class="fw-bold mb-2">Gastroenterology & Laparoscopy</h5>
                        <p class="text-muted small mb-3">Advanced Endoscopy, Bariatric Weight Loss Surgery, and Minimal Access Laparoscopic Procedures.</p>
                        <a href="user-login.jsp" class="text-primary text-decoration-none fw-semibold small">Explore Gastroenterology <i class="fa-solid fa-arrow-right ms-1"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Patient Testimonials Section -->
    <section class="py-5 bg-light">
        <div class="container py-3">
            <div class="text-center mb-5">
                <span class="text-primary fw-bold text-uppercase small">Patient Stories</span>
                <h2 class="fw-bold display-6">What Our Patients Say About Aadi Hospital</h2>
            </div>

            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card border-0 shadow-sm rounded-4 p-4 h-100">
                        <div class="text-warning mb-3">
                            <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>
                        </div>
                        <p class="text-muted small leading-relaxed mb-4">"The cardiac care team at Aadi Hospital saved my father's life during an emergency angioplasty. The doctors and nursing staff were exceptionally supportive."</p>
                        <div class="d-flex align-items-center gap-3">
                            <div class="p-2 bg-primary-subtle text-primary rounded-circle fw-bold">AR</div>
                            <div>
                                <h6 class="fw-bold text-dark mb-0">Amit Raut</h6>
                                <small class="text-muted">Nagpur, Maharashtra</small>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card border-0 shadow-sm rounded-4 p-4 h-100">
                        <div class="text-warning mb-3">
                            <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>
                        </div>
                        <p class="text-muted small leading-relaxed mb-4">"Underwent robotic knee replacement at Aadi Hospital. Surprised at how quick my recovery was! Excellent hospital facilities and smooth billing."</p>
                        <div class="d-flex align-items-center gap-3">
                            <div class="p-2 bg-success-subtle text-success rounded-circle fw-bold">SK</div>
                            <div>
                                <h6 class="fw-bold text-dark mb-0">Suresh Kulkarni</h6>
                                <small class="text-muted">Wardha, Maharashtra</small>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card border-0 shadow-sm rounded-4 p-4 h-100">
                        <div class="text-warning mb-3">
                            <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>
                        </div>
                        <p class="text-muted small leading-relaxed mb-4">"Online OPD appointment booking through the portal was seamless. No long queues, clean environment, and top neuro specialists!"</p>
                        <div class="d-flex align-items-center gap-3">
                            <div class="p-2 bg-info-subtle text-info rounded-circle fw-bold">PD</div>
                            <div>
                                <h6 class="fw-bold text-dark mb-0">Priya Joshi</h6>
                                <small class="text-muted">Amravati, Maharashtra</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- SEO Directory Section -->
    <section class="directory-section py-5">
        <div class="container">
            <h5 class="fw-bold mb-4 text-dark"><i class="fa-solid fa-sitemap me-2 text-primary"></i>Aadi Hospital Doctors & Treatments Directory in Nagpur</h5>
            
            <div class="row g-4">
                <div class="col-lg-3 col-md-6">
                    <h6 class="fw-bold text-dark mb-2">Specialists in Nagpur</h6>
                    <a href="user-login.jsp" class="directory-link">Cardiologist in Nagpur</a>
                    <a href="user-login.jsp" class="directory-link">Critical Care Specialist in Nagpur</a>
                    <a href="user-login.jsp" class="directory-link">Neurologist in Nagpur</a>
                    <a href="user-login.jsp" class="directory-link">Oncologist in Nagpur</a>
                    <a href="user-login.jsp" class="directory-link">Orthopaedist in Nagpur</a>
                    <a href="user-login.jsp" class="directory-link">Gastroenterologist in Nagpur</a>
                    <a href="user-login.jsp" class="directory-link">Urologist in Nagpur</a>
                </div>

                <div class="col-lg-3 col-md-6">
                    <h6 class="fw-bold text-dark mb-2">Top Surgical Procedures</h6>
                    <a href="#" class="directory-link">Robotic Knee Replacement Surgery</a>
                    <a href="#" class="directory-link">Coronary Artery Bypass Grafting (CABG)</a>
                    <a href="#" class="directory-link">Kidney Stones Laser Treatment</a>
                    <a href="#" class="directory-link">Brain Tumor Surgery & Micro-Neurosurgery</a>
                    <a href="#" class="directory-link">Chemotherapy & Targeted Radiation</a>
                    <a href="#" class="directory-link">Renal Transplantation Surgery</a>
                    <a href="#" class="directory-link">Advanced Laparoscopic Procedures</a>
                </div>

                <div class="col-lg-3 col-md-6">
                    <h6 class="fw-bold text-dark mb-2">Popular Health Topics</h6>
                    <a href="#" class="directory-link">What is PCOD & Lifestyle Management</a>
                    <a href="#" class="directory-link">How to Lower Triglycerides Naturally</a>
                    <a href="#" class="directory-link">Types of Headaches & Diagnostic Steps</a>
                    <a href="#" class="directory-link">Neurological Disorder Symptoms</a>
                    <a href="#" class="directory-link">Fibroscan Test & Liver Care</a>
                    <a href="#" class="directory-link">Hernia Symptoms & Surgery Options</a>
                </div>

                <div class="col-lg-3 col-md-6">
                    <h6 class="fw-bold text-dark mb-2">Our Healthcare Network</h6>
                    <a href="#" class="directory-link">Aadi Hospital, Main Campus Nagpur</a>
                    <a href="#" class="directory-link">Aadi Super Speciality Unit, Wardha</a>
                    <a href="#" class="directory-link">Aadi Emergency Care, Amravati</a>
                    <a href="#" class="directory-link">Aadi Cancer Care & Research Centre</a>
                </div>
            </div>
        </div>
    </section>

    <!-- Comprehensive Footer -->
    <footer class="pt-5 pb-3">
        <div class="container">
            <div class="row g-4 mb-5">
                <div class="col-lg-3 col-md-6">
                    <h5 class="text-white fw-bold mb-3">AADI HOSPITAL</h5>
                    <p class="small leading-relaxed">Dedicated to clinical excellence, compassionate patient care, and modern healthcare technology in Vidarbha and central India.</p>
                    <p class="small mb-1"><i class="fa-solid fa-phone me-2 text-primary"></i> 24x7 Helpline: +91 926 888 0303</p>
                    <p class="small"><i class="fa-solid fa-envelope me-2 text-primary"></i> contact@aadihospital.com</p>
                </div>

                <div class="col-lg-3 col-md-6">
                    <h6>For Patients</h6>
                    <ul class="list-unstyled small">
                        <li><a href="user-login.jsp">Find a Doctor</a></li>
                        <li><a href="book-appointment.jsp">Book an Appointment</a></li>
                        <li><a href="user-login.jsp">My Health Reports</a></li>
                        <li><a href="tel:+919268880303">Emergency 24x7 Ambulance</a></li>
                        <li><a href="#specialities">Centres of Excellence</a></li>
                        <li><a href="#">International Patient Services</a></li>
                    </ul>
                </div>

                <div class="col-lg-3 col-md-6">
                    <h6>Academics & Research</h6>
                    <ul class="list-unstyled small">
                        <li><a href="#">DNB Medical Programmes</a></li>
                        <li><a href="#">Fellowship Programmes</a></li>
                        <li><a href="#">American Heart Association Courses</a></li>
                        <li><a href="#">Nursing & Allied Healthcare Training</a></li>
                        <li><a href="#">Clinical Observerships</a></li>
                    </ul>
                </div>

                <div class="col-lg-3 col-md-6">
                    <h6>Portals & Corporate</h6>
                    <ul class="list-unstyled small">
                        <li><a href="admin-login.jsp" class="text-warning fw-semibold"><i class="fa-solid fa-user-shield me-1"></i> Administrator Login</a></li>
                        <li><a href="user-login.jsp" class="text-info fw-semibold"><i class="fa-solid fa-user me-1"></i> Patient Portal</a></li>
                        <li><a href="#about">About Leadership</a></li>
                        <li><a href="#investors">Investor Relations</a></li>
                        <li><a href="#">Careers & Job Openings</a></li>
                    </ul>
                </div>
            </div>

            <!-- Fraud & Advisory Notice Box -->
            <div class="disclaimer-box mb-4">
                <span class="fw-bold text-white d-block mb-1"><i class="fa-solid fa-triangle-exclamation text-warning me-1"></i> Advisory Notice:</span>
                1. Lately, unauthorized individuals have attempted to make fraudulent representations using fake contact numbers to solicit money or bank details. Aadi Hospital never asks for online financial credentials or bank passwords. <br>
                2. Aadi Hospital never charges money for job applications or hiring opportunities. Always rely on official channels.
            </div>

            <hr class="border-secondary opacity-25">

            <div class="d-flex flex-column flex-md-row justify-content-between align-items-center small gap-2">
                <p class="mb-0">&copy; 2026 Aadi Hospital & Research Centre. All rights reserved.</p>
                <div class="d-flex gap-3">
                    <a href="#">Privacy Policy</a>
                    <a href="#">Disclaimer</a>
                    <a href="#">Environmental Clearances</a>
                    <a href="#">Bio-Medical Waste Report</a>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>