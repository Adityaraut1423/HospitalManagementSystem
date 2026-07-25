package com.servlet;

import java.io.IOException;

import com.dao.DBConnect;
import com.dao.PatientDAO;
import com.model.Patient;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/updatePatient")
public class UpdatePatientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        resp.setCharacterEncoding("UTF-8");

        try {
            Patient p = new Patient();
            p.setId(Integer.parseInt(req.getParameter("id").trim()));
            p.setName(req.getParameter("name").trim());
            p.setAge(Integer.parseInt(req.getParameter("age").trim()));
            p.setGender(req.getParameter("gender").trim());
            p.setPhone(req.getParameter("phone").trim());
            p.setAddress(req.getParameter("address").trim());
            // ✅ FIX: Set email to prevent NULL overwrite in database
            p.setEmail(req.getParameter("email") != null ? req.getParameter("email").trim() : "");

            PatientDAO dao = new PatientDAO(DBConnect.getConn());

            if (dao.updatePatient(p)) {
                resp.sendRedirect("success.jsp");
            } else {
                resp.getWriter().print("Error updating patient!");
            }
        } catch (NumberFormatException e) {
            resp.getWriter().print("Invalid ID or age format!");
        } catch (Exception e) {
            resp.getWriter().print("Server error: " + e.getMessage());
        }
    }
}