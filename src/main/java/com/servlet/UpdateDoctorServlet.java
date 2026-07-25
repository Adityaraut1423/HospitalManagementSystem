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

@WebServlet("/updateDoctor")
public class UpdateDoctorServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        String timings = req.getParameter("timings");

        Doctor d = new Doctor();
        d.setId(id);
        d.setTimings(timings);

        DoctorDAO dao = new DoctorDAO(DBConnect.getConn());
        dao.updateDoctor(d);

        resp.sendRedirect("view-doctors.jsp");
    }
}
