<%@ page contentType="text/html;charset=UTF-8" language="java" import="com.model.User" %>

<%
    HttpSession sessionObj = request.getSession(false);

    if (sessionObj == null || sessionObj.getAttribute("user") == null) {
        response.sendRedirect("user-login.jsp?msg=Please login first");
        return;
    }

    User user = (User) sessionObj.getAttribute("user");
%>

<!DOCTYPE html>
<html>
<head>
    <title>User Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">

    <h2>Welcome, <%= user.getName() %>!</h2>

    <a href="LogoutServlet" class="btn btn-danger mb-3">Logout</a>

    <h3>Available Doctors</h3>
    <a href="book-appointment.jsp" class="btn btn-success mb-3">Book Appointment</a>
    <a href="view-appointments.jsp" class="btn btn-primary mb-3">My Appointments</a>
    <a href="payment.jsp" class="btn btn-primary mb-3">Advance Pay For Appointment</a>

</div>
</body>
</html>
