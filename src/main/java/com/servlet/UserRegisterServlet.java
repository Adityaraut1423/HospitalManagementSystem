package com.servlet;

import java.io.IOException;
import java.util.Random;

import com.model.User;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/UserRegisterServlet")
public class UserRegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.sendRedirect("user-register.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String mobile = req.getParameter("mobile");
        String password = req.getParameter("password");

        // Generate 6-digit OTP
        int otp = new Random().nextInt(900000) + 100000;

        HttpSession session = req.getSession();
        session.setAttribute("otp", otp);
        session.setAttribute("otpTime", System.currentTimeMillis());

        // Temporarily store user info in session
        session.setAttribute("tempUser", new User(name, email, mobile, password));

        // Print OTP to console (development only)
        System.out.println("OTP for testing: " + otp);

        // Redirect to OTP verification page
        resp.sendRedirect("verify-otp.jsp?msg=OTP sent (check console)");
    }
}
