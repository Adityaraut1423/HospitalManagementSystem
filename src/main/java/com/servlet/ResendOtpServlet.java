package com.servlet;

import java.io.IOException;
import java.util.Random;

import com.model.User;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ResendOtpServlet")
public class ResendOtpServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        User tempUser = (User) session.getAttribute("tempUser");

        if (tempUser == null) {
            resp.sendRedirect("user-register.jsp?msg=Session expired. Register again.");
            return;
        }

        int otp = new Random().nextInt(900000) + 100000;
        session.setAttribute("otp", otp);
        session.setAttribute("otpTime", System.currentTimeMillis());

        System.out.println("Resent OTP (for testing): " + otp);

        resp.sendRedirect("verify-otp.jsp?msg=New OTP sent (check console)");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.sendRedirect("verify-otp.jsp");
    }
}
