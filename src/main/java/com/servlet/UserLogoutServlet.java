package com.servlet;

import java.io.IOException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UserLogoutServlet")
public class UserLogoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        req.getSession().invalidate();
        resp.sendRedirect("user-login.jsp?msg=Logged out");
    }
}
