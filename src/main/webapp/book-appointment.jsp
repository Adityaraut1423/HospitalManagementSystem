<%@ page import="java.util.List, com.dao.DoctorDAO, com.dao.DBConnect, com.model.Doctor, com.model.User" %>
<%@ page session="true" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("user-login.jsp?msg=Please login first");
        return;
    }

    DoctorDAO doctorDAO = new DoctorDAO(DBConnect.getConn());
    List<Doctor> doctors = doctorDAO.getAllDoctors();

    String msg = request.getParameter("msg");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Book Appointment</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5 col-md-6">
    <h2>Book Appointment</h2>

    <% if(msg != null){ %>
        <div class="alert alert-info"><%= msg %></div>
    <% } %>

    <form action="BookAppointmentServlet" method="post">
        <div class="mb-3">
            <label>Doctor</label>
            <select name="doctorId" class="form-control" required>
                <option value="">-- Select Doctor --</option>
                <% for(Doctor d : doctors) { %>
                    <option value="<%= d.getId() %>">
                        <%= d.getName() %> - <%= d.getSpeciality() %> | Timing: <%= d.getTimings() %>
                    </option>
                <% } %>
            </select>
        </div>

        <div class="mb-3">
            <label>Appointment Date</label>
            <input type="date" name="date" class="form-control" required min="<%= java.time.LocalDate.now() %>">
        </div>

        <button type="submit" class="btn btn-success">Book Appointment</button>
    </form>

    <div class="mt-3">
        <a href="user-dashboard.jsp" class="btn btn-primary">Back to Dashboard</a>
    </div>
</div>
</body>
</html>
