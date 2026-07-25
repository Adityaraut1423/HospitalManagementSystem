package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import org.json.JSONObject;

import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import com.razorpay.RazorpayException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CreatePaymentServlet")
public class CreatePaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Fetch API credentials from Environment Variables with fallback test values
    private static final String RAZORPAY_KEY_ID = System.getenv("RAZORPAY_KEY_ID") != null ?
            System.getenv("RAZORPAY_KEY_ID") : "rzp_test_YourKeyID";

    private static final String RAZORPAY_KEY_SECRET = System.getenv("RAZORPAY_KEY_SECRET") != null ?
            System.getenv("RAZORPAY_KEY_SECRET") : "YourKeySecret";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Parse requested payment amount
            String amountStr = request.getParameter("amount");
            if (amountStr == null || amountStr.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"error\": \"Amount parameter is missing\"}");
                return;
            }

            double amountInRupees = Double.parseDouble(amountStr);
            int amountInPaise = (int) Math.round(amountInRupees * 100); // Razorpay requires paise

            // Initialize Razorpay Client
            RazorpayClient client = new RazorpayClient(RAZORPAY_KEY_ID, RAZORPAY_KEY_SECRET);

            // Construct order payload
            JSONObject orderRequest = new JSONObject();
            orderRequest.put("amount", amountInPaise);
            orderRequest.put("currency", "INR");
            orderRequest.put("receipt", "txn_" + System.currentTimeMillis());

            // FIXED: Used lowercase 'client.orders' as required by modern Razorpay Java SDK
            Order order = client.orders.create(orderRequest);

            // Send Razorpay order JSON back to frontend
            out.print(order.toString());
            out.flush();

        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"error\": \"Invalid amount format\"}");
        } catch (RazorpayException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            System.err.println("Razorpay Error: " + e.getMessage());
            out.print("{\"error\": \"Failed to create Razorpay order: " + e.getMessage() + "\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            e.printStackTrace();
            out.print("{\"error\": \"An unexpected error occurred\"}");
        }
    }
}