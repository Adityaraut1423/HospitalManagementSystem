<%@ page import="com.dao.*,com.model.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Get ID parameter safely
    String idParam = request.getParameter("id");
    if(idParam == null || idParam.isEmpty()){
        out.println("<h3 style='color:red'>Patient ID is missing!</h3>");
        return; // stop further execution
    }

    int id = Integer.parseInt(idParam);

    PatientDAO dao = new PatientDAO(com.dao.DBConnect.getConn());
    Patient p = dao.getPatientById(id);
    if(p == null){
        out.println("<h3 style='color:red'>Patient not found!</h3>");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Patient</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5 col-md-6">
    <h2>Edit Patient</h2>
    <form action="UpdatePatientServlet" method="post">
        <input type="hidden" name="id" value="<%= p.getId() %>">
        <div class="mb-3">
            <label>Name</label>
            <input type="text" name="name" class="form-control" value="<%= p.getName() %>" required>
        </div>
        <div class="mb-3">
            <label>Age</label>
            <input type="number" name="age" class="form-control" value="<%= p.getAge() %>" required>
        </div>
        <div class="mb-3">
            <label>Gender</label>
            <select name="gender" class="form-control" required>
                <option value="Male" <%= p.getGender().equals("Male") ? "selected" : "" %>>Male</option>
                <option value="Female" <%= p.getGender().equals("Female") ? "selected" : "" %>>Female</option>
            </select>
        </div>
        <div class="mb-3">
            <label>Phone</label>
            <input type="text" name="phone" class="form-control" value="<%= p.getPhone() %>" required>
        </div>
        <div class="mb-3">
            <label>Address</label>
            <textarea name="address" class="form-control" required><%= p.getAddress() %></textarea>
        </div>
        <button type="submit" class="btn btn-success">Update Patient</button>
    </form>
</div>
</body>
</html>
