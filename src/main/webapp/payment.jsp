<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Simulated Payment</title>
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
            padding: 40px 50px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
            width: 400px;
            text-align: center;
        }

        h2 {
            color: #007bff;
            font-size: 28px;
            margin-bottom: 30px;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            text-align: left;
            font-weight: 600;
            margin-bottom: 5px;
            color: #333;
        }

        input[type="number"] {
            padding: 10px 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }

        input[type="number"]:focus {
            border-color: #007bff;
            outline: none;
        }

        button {
            padding: 12px;
            font-size: 16px;
            background-color: #28a745;
            color: #fff;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        button:hover {
            background-color: #218838;
        }

        .note {
            font-size: 14px;
            color: #666;
            margin-top: 15px;
        }
    </style>
</head>
<body>

<div class="card">
    <h2>Pay for Your Appointment</h2>

    <form action="<%=request.getContextPath()%>/SimulatePaymentServlet" method="post">
        <label for="amount">Amount (₹):</label>
        <input type="number" id="amount" name="amount" value="500" required>

        <label for="appointmentId">Appointment ID:</label>
        <input type="number" id="appointmentId" name="appointmentId" value="1" required>

        <button type="submit">Pay Now</button>
    </form>

    <p class="note">This is a simulated payment for demonstration purposes.</p>
</div>

</body>
</html>
