<%@ page import="java.util.*,com.dao.*,com.model.*,com.dao.DBConnect" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>View Patients</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="container">
    <h2>Patient List</h2>
<%
    PatientDAO dao = new PatientDAO(DBConnect.getConn());
    List<Patient> list = dao.getAllPatients();
%>
<table>
    <tr><th>ID</th><th>Name</th><th>Age</th><th>Gender</th><th>Phone</th><th>Address</th></tr>
<%
    for(Patient p : list){
%>
    <tr>
        <td><%= p.getId() %></td>
        <td><%= p.getName() %></td>
        <td><%= p.getAge() %></td>
        <td><%= p.getGender() %></td>
        <td><%= p.getPhone() %></td>
        <td><%= p.getAddress() %></td>
    </tr>
<%
    }
%>
</table>
</div>
</body>
</html>
