package com.servlet;

import java.io.IOException;

import com.dao.DBConnect;
import com.dao.PatientDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/deletePatient")
public class DeletePatientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        resp.setCharacterEncoding("UTF-8");

        try {
            int id = Integer.parseInt(req.getParameter("id").trim());
            PatientDAO dao = new PatientDAO(DBConnect.getConn());

            if (dao.deletePatient(id)) {
                resp.sendRedirect("success.jsp");
            } else {
                resp.getWriter().print("Error deleting patient!");
            }
        } catch (NumberFormatException e) {
            resp.getWriter().print("Invalid patient ID!");
        } catch (Exception e) {
            resp.getWriter().print("Server error: " + e.getMessage());
        }
    }
}
