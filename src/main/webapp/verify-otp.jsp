<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Verify OTP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5 col-md-4">
    <h3>OTP Verification</h3>
    <form action="VerifyOtpServlet" method="post">
        <div class="mb-3">
            <label>Enter OTP</label>
            <input type="text" name="otp" class="form-control" pattern="\d{6}" required>
        </div>
        <button type="submit" class="btn btn-success">Verify OTP</button>
    </form>

    <form action="ResendOtpServlet" method="post" style="margin-top:10px;">
        <button type="submit" class="btn btn-warning">Resend OTP</button>
    </form>

    <p style="color:red; margin-top:10px;">
        <%= request.getParameter("msg") != null ? request.getParameter("msg") : "" %>
    </p>
</div>
</body>
</html>
