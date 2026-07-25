package com.servlet;

import java.io.IOException;

import com.dao.DBConnect;
import com.dao.UserDAO;
import com.model.User;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UserLoginServlet")
public class UserLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        UserDAO dao = new UserDAO(DBConnect.getConn());
        User user = dao.login(req.getParameter("email"), req.getParameter("password"));

        if (user != null) {
            req.getSession().setAttribute("user", user);
            resp.sendRedirect("user-dashboard.jsp");
        } else {
            resp.sendRedirect("user-login.jsp?msg=Invalid credentials");
        }
    }
}
