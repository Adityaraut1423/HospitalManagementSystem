<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Get parameters from servlet
    String appointmentId = request.getParameter("appointmentId");
    String amount = request.getParameter("amount");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Successful</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f6f8;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .card {
            background: #fff;
            padding: 40px 60px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
            text-align: center;
            max-width: 400px;
        }

        .card h1 {
            color: #28a745;
            font-size: 32px;
            margin-bottom: 20px;
        }

        .card p {
            font-size: 18px;
            margin: 10px 0;
            color: #333;
        }

        .btn {
            display: inline-block;
            margin-top: 25px;
            padding: 12px 30px;
            font-size: 16px;
            color: #fff;
            background-color: #007bff;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            transition: background 0.3s ease;
        }

        .btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="card">
        <h1>Payment Successful!</h1>
        <p><strong>Appointment ID:</strong> <%= appointmentId %></p>
        <p><strong>Amount Paid:</strong> ₹<%= amount %></p>
        <a href="<%=request.getContextPath()%>/payment.jsp" class="btn">Back to Payment</a>
    </div>
</body>
</html>
