<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Test Email</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5 col-md-6">
    <h2>Send Test Email</h2>
    <form action="EmailTestServlet" method="post">
        <div class="mb-3">
            <label>Recipient Email</label>
            <input type="email" name="toEmail" class="form-control" placeholder="Enter email" required>
        </div>
        <div class="mb-3">
            <label>Subject</label>
            <input type="text" name="subject" class="form-control" placeholder="Subject" required>
        </div>
        <div class="mb-3">
            <label>Message</label>
            <textarea name="body" class="form-control" rows="5" placeholder="Message" required></textarea>
        </div>
        <button type="submit" class="btn btn-success">Send Email</button>
    </form>
</div>
</body>
</html>
