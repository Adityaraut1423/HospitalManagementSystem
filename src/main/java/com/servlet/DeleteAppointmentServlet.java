package com.servlet;

import java.io.IOException;

import com.dao.AppointmentDAO;
import com.dao.DBConnect;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/deleteAppointment")
public class DeleteAppointmentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        AppointmentDAO dao = new AppointmentDAO(DBConnect.getConn());
        dao.deleteAppointment(id);

        resp.sendRedirect("see-all-appointment.jsp");
    }
}
