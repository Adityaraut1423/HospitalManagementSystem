package com.servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.dao.DoctorDAO;
import com.dao.UserDAO;
import com.dao.AppointmentDAO;
import com.dao.BillingDAO;
import com.dao.DBConnect;
import com.model.Doctor;
import com.model.User;
import com.model.Billing;

@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        DoctorDAO doctorDAO = new DoctorDAO(DBConnect.getConn());
        UserDAO userDAO = new UserDAO(DBConnect.getConn());
        AppointmentDAO appDAO = new AppointmentDAO(DBConnect.getConn());
        BillingDAO billDAO = new BillingDAO(DBConnect.getConn());

        List<Doctor> doctorList = doctorDAO.getAllDoctors();
        List<User> userList = userDAO.getAllUsers();

        req.setAttribute("doctorList", doctorList);
        req.setAttribute("userList", userList);
        req.setAttribute("appointmentList", appDAO.getAllAppointments());
        
        // Use getAllBills() or the matching method in your BillingDAO
        req.setAttribute("billingList", billDAO.getAllBills());

        req.getRequestDispatcher("admin-dashboard.jsp").forward(req, resp);
    }
}