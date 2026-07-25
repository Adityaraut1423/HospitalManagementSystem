<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Get error message from request attribute
    String message = (String) request.getAttribute("errorMessage");
    if(message == null || message.isEmpty()){
        message = "An unexpected error occurred!";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Error</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5 col-md-6">
    <div class="alert alert-danger">
        <h4>Error</h4>
        <p><%= message %></p>
        <a href="index.html" class="btn btn-primary">Go Home</a>
    </div>
</div>
</body>
</html>
