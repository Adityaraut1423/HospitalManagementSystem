package com.servlet;

import java.io.IOException;

import com.dao.DBConnect;
import com.dao.UserDAO;
import com.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String mobile = request.getParameter("mobile");
            String password = request.getParameter("password");

            User user = new User();
            user.setName(name);
            user.setEmail(email);
            user.setMobile(mobile);
            user.setPassword(password);

            UserDAO dao = new UserDAO(DBConnect.getConn());

            boolean success = dao.register(user);

            if (success) {

                // 🔥 REMOVE OLD SESSION
                HttpSession session = request.getSession();
                session.invalidate();

                // 🔥 CREATE NEW SESSION
                session = request.getSession(true);

                // 🔥 FETCH USER FROM DB (WITH ID)
                User newUser = dao.login(email, password);

                // 🔥 STORE CORRECT USER
                session.setAttribute("user", newUser);

                response.sendRedirect("user-dashboard.jsp?msg=Registered Successfully");

            } else {
                response.sendRedirect("register.jsp?msg=Registration Failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
