package com.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Optional: constants for admin credentials
    private static final String ADMIN_USERNAME = "admin";
    private static final String ADMIN_PASSWORD = "aditya@123";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html");
        resp.setCharacterEncoding("UTF-8");

        String u = req.getParameter("username").trim();
        String p = req.getParameter("password").trim();

        if (ADMIN_USERNAME.equals(u) && ADMIN_PASSWORD.equals(p)) {
            HttpSession session = req.getSession();
            session.setAttribute("admin", u);
            resp.sendRedirect("admin-dashboard.jsp");
        } else {
            req.setAttribute("msg", "Invalid Username or Password!");
            req.getRequestDispatcher("admin-login.jsp").forward(req, resp);
        }
    }
}
