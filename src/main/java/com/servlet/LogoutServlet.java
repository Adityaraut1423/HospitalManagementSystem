package com.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get current session without creating a new one if it doesn't exist
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            // 2. Invalidate all session attributes (admin, doctor, user, etc.)
            session.invalidate();
        }

        // 3. Redirect back to unified index.jsp with success message parameter
        response.sendRedirect("index.jsp?msg=Logged+out+successfully");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Allow POST requests to log out as well
        doGet(request, response);
    }
}