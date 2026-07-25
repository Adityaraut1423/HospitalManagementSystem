package com.servlet;

import java.io.IOException;

import com.util.EmailUtil;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/sendEmail")
public class SendEmailServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Fetch form values
        String email = req.getParameter("email");
        String message = req.getParameter("message");

        // Send Email
        boolean sent = EmailUtil.sendMail(email, "Hospital Confirmation", message);

        // Show message on JSP
        if (sent) {
            req.setAttribute("msg", "Email Sent Successfully!");
        } else {
            req.setAttribute("msg", "Email Sending Failed!");
        }

        // Forward back to the same page
        RequestDispatcher rd = req.getRequestDispatcher("send-confirm-email.jsp");
        rd.forward(req, resp);
    }
}
