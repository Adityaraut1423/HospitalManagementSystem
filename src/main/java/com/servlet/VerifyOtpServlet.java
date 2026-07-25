package com.servlet;

import java.io.IOException;

import com.dao.DBConnect;
import com.dao.UserDAO;
import com.model.User;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/VerifyOtpServlet")
public class VerifyOtpServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false); // false → do not create new session
        if (session == null) {
            resp.sendRedirect("user-register.jsp?msg=Session expired. Try again.");
            return;
        }

        String otpStr = req.getParameter("otp");
        int enteredOtp;

        // Validate OTP input
        try {
            enteredOtp = Integer.parseInt(otpStr);
        } catch (NumberFormatException e) {
            resp.sendRedirect("verify-otp.jsp?msg=Invalid OTP format");
            return;
        }

        // Fetch session OTP and tempUser
        Integer sessionOtp = (Integer) session.getAttribute("otp");
        Long otpTime = (Long) session.getAttribute("otpTime");
        User tempUser = (User) session.getAttribute("tempUser");

        if (sessionOtp == null || otpTime == null || tempUser == null) {
            resp.sendRedirect("user-register.jsp?msg=Session expired. Try again.");
            return;
        }

        // Check expiry (2 minutes)
        if (System.currentTimeMillis() - otpTime > 120_000) {
            resp.sendRedirect("verify-otp.jsp?msg=OTP expired. Resend OTP.");
            return;
        }

        // Check OTP match
        if (enteredOtp != sessionOtp) {
            resp.sendRedirect("verify-otp.jsp?msg=Invalid OTP");
            return;
        }

        // OTP correct → save user in DB
        UserDAO dao = new UserDAO(DBConnect.getConn());
        boolean success = dao.register(tempUser); // ✅ Call correct method

        // Invalidate session after registration
        session.invalidate();

        if (success) {
            resp.sendRedirect("user-login.jsp?msg=Registration successful");
        } else {
            resp.sendRedirect("user-register.jsp?msg=Registration failed");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.sendRedirect("verify-otp.jsp");
    }
}
