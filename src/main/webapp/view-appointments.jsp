<%@ page import="java.util.List, com.dao.AppointmentDAO, com.dao.DBConnect, com.model.Appointment, com.model.User" %>
<%@ page session="true" %>
<%
    // User session check
    User user = (User) session.getAttribute("user");
    if(user == null){
        response.sendRedirect("user-login.jsp?msg=Please login first");
        return;
    }

    // Fetch appointments for logged-in user
    AppointmentDAO dao = new AppointmentDAO(DBConnect.getConn());
    List<Appointment> appointments = dao.getAppointmentsByPatient(user.getId());
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Appointments</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>My Appointments</h2>

    <% if(appointments == null || appointments.isEmpty()) { %>
        <p class="text-warning">You have not booked any appointments yet.</p>
    <% } else { %>
        <table class="table table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>Doctor ID</th>
                    <th>Date</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
            <% for(Appointment a : appointments) { %>
                <tr>
                    <td><%= a.getDoctorId() %></td>
                    <td><%= a.getDate() %></td>
                    <td><%= a.getStatus() %></td>
                </tr>
            <% } %>
            </tbody>
        </table>
    <% } %>
</div>
</body>
</html>
