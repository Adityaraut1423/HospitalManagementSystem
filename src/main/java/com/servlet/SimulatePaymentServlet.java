package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/SimulatePaymentServlet")
public class SimulatePaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Get values from form
        int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
        double amount = Double.parseDouble(request.getParameter("amount"));

        try {
            // Get database connection
            Connection conn = com.dao.DBConnect.getConn(); // Make sure your DBConnect class is correct

            // Insert dummy payment record
            String sql = "INSERT INTO payment(appointment_id, razorpay_order_id, razorpay_payment_id, amount, status) VALUES(?,?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, appointmentId);
            ps.setString(2, "SIMULATED_ORDER");       // Dummy order ID
            ps.setString(3, "SIMULATED_PAYMENT");     // Dummy payment ID
            ps.setDouble(4, amount);
            ps.setString(5, "SUCCESS");
            ps.executeUpdate();

            // Show success message
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<h2>Payment Successful!</h2>");
            response.getWriter().println("<p>Appointment ID: " + appointmentId + "</p>");
            response.getWriter().println("<p>Amount Paid: ₹" + amount + "</p>");
            response.sendRedirect("payment_success.jsp?appointmentId=" + appointmentId + "&amount=" + amount);

            response.getWriter().println("<a href='" + request.getContextPath() + "/payment.jsp'>Back to Payment</a>");

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<h2>Payment Failed!</h2>");
            response.getWriter().println("<a href='" + request.getContextPath() + "/payment.jsp'>Try Again</a>");
        }
    }
}
