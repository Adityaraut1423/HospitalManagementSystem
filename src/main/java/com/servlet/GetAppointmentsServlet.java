package com.servlet;

import java.io.IOException;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import com.dao.AppointmentDAO;
import com.dao.DBConnect;
import com.model.Appointment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/getAppointments")
public class GetAppointmentsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        try {
            AppointmentDAO dao = new AppointmentDAO(DBConnect.getConn());
            List<Appointment> appointments = dao.getAllAppointments();

            JSONArray arr = new JSONArray();

            for (Appointment a : appointments) {
                JSONObject obj = new JSONObject();

                // Include patient ID, doctor ID, and status in title
                obj.put("title", "Patient ID: " + a.getPatientId()
                        + " | Doctor ID: " + a.getDoctorId()
                        + " | Status: " + a.getStatus());

                // Ensure date is in YYYY-MM-DD format
                obj.put("start", a.getDate());

                arr.put(obj);
            }

            resp.getWriter().write(arr.toString());

        } catch (Exception e) {
            e.printStackTrace();
            JSONObject error = new JSONObject();
            error.put("error", "Failed to fetch appointments: " + e.getMessage());
            resp.getWriter().write(error.toString());
        }
    }
}
