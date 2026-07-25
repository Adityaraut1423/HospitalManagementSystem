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

@WebServlet("/AddPatientServlet")
public class AddPatientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        int age = Integer.parseInt(request.getParameter("age"));
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        Patient p = new Patient();
        p.setName(name);
        p.setEmail(email);
        p.setAge(age);
        p.setGender(gender);
        p.setPhone(phone);
        p.setAddress(address);

        PatientDAO dao = new PatientDAO(DBConnect.getConn());
        boolean added = dao.addPatient(p);

        if (added) {
            response.sendRedirect("admin-dashboard.jsp?msg=Patient added successfully");
        } else {
            response.sendRedirect("add-patient.jsp?msg=Failed to add patient");
        }
    }
}
