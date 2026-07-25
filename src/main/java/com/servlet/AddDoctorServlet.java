package com.servlet;

import java.io.IOException;

import com.dao.DBConnect;
import com.dao.DoctorDAO;
import com.model.Doctor;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AddDoctorServlet")
public class AddDoctorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String speciality = request.getParameter("speciality");
        String timings = request.getParameter("timings");

        Doctor d = new Doctor();
        d.setName(name);
        d.setSpeciality(speciality);
        d.setTimings(timings);

        DoctorDAO dao = new DoctorDAO(DBConnect.getConn());
        boolean added = dao.addDoctor(d);

        if(added) {
            response.sendRedirect("admin-dashboard.jsp?msg=Doctor added successfully");
        } else {
            response.sendRedirect("add-doctor.jsp?msg=Failed to add doctor");
        }
    }
}
