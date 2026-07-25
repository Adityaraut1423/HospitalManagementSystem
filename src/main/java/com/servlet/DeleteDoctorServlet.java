package com.servlet;

import java.io.IOException;

import com.dao.DBConnect;
import com.dao.DoctorDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/deleteDoctor")
public class DeleteDoctorServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        DoctorDAO dao = new DoctorDAO(DBConnect.getConn());
        dao.deleteDoctor(id);

        resp.sendRedirect("view-doctors.jsp");
    }
}
