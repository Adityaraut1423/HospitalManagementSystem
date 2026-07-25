<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.dao.*, com.model.*" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("user-login.jsp?msg=Please login first");
        return;
    }

    PatientDAO patientDao = new PatientDAO(DBConnect.getConn());
    Patient patient = patientDao.getPatientByEmail(user.getEmail());

    AppointmentDAO appointmentDao = new AppointmentDAO(DBConnect.getConn());
    DoctorDAO doctorDao = new DoctorDAO(DBConnect.getConn());

    List<Appointment> list = new ArrayList<>();
    if (patient != null) {
        list = appointmentDao.getAppointmentsByPatient(patient.getId());
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Appointments</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-4 mb-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="fa-solid fa-calendar-days text-primary me-2"></i>My Appointments</h2>
        <div>
            <a href="book-appointment.jsp" class="btn btn-primary"><i class="fa-solid fa-plus me-1"></i>Book New</a>
            <a href="user-dashboard.jsp" class="btn btn-outline-secondary">Dashboard</a>
        </div>
    </div>

    <% if (list != null && !list.isEmpty()) { %>
        <div class="card border-0 shadow-sm">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th>Appt ID</th>
                            <th>Doctor</th>
                            <th>Date</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Appointment a : list) { 
                            Doctor doc = doctorDao.getDoctorById(a.getDoctorId());
                            String doctorName = (doc != null) ? doc.getName() : "Assigned Specialist";
                        %>
                            <tr>
                                <td>#<%= a.getId() %></td>
                                <td class="fw-medium"><i class="fa-solid fa-user-doctor me-1 text-primary"></i><%= doctorName %></td>
                                <td><%= a.getDate() %></td>
                                <td>
                                    <% if ("Confirmed".equalsIgnoreCase(a.getStatus())) { %>
                                        <span class="badge bg-success-subtle text-success border border-success px-3 py-2">Confirmed</span>
                                    <% } else { %>
                                        <span class="badge bg-warning-subtle text-warning border border-warning px-3 py-2">Pending</span>
                                    <% } %>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    <% } else { %>
        <div class="text-center py-5 bg-white rounded-3 shadow-sm">
            <i class="fa-regular fa-calendar-xmark text-muted fa-3x mb-3 d-block"></i>
            <h5 class="text-secondary">You have not booked any appointments yet.</h5>
            <p class="text-muted small">Schedule an appointment with one of our specialized doctors today.</p>
            <a href="book-appointment.jsp" class="btn btn-primary mt-2">Book Appointment</a>
        </div>
    <% } %>
</div>

</body>
</html>