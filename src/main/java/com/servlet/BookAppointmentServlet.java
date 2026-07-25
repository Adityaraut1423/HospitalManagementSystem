package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.time.LocalDate;

import com.dao.AppointmentDAO;
import com.dao.DBConnect;
import com.dao.PatientDAO;
import com.model.Appointment;
import com.model.Patient;
import com.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/BookAppointmentServlet")
public class BookAppointmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // 1. Verify user is logged in
        if (user == null) {
            response.sendRedirect("user-login.jsp?msg=Please login first");
            return;
        }

        try {
            int doctorId = Integer.parseInt(request.getParameter("doctorId"));
            String date = request.getParameter("date");

            // 2. Validate date
            LocalDate appointmentDate = LocalDate.parse(date);
            if (appointmentDate.isBefore(LocalDate.now())) {
                response.sendRedirect("book-appointment.jsp?msg=Invalid date selected!");
                return;
            }

            Connection conn = DBConnect.getConn();
            PatientDAO patientDAO = new PatientDAO(conn);

            // 3. Map User -> Patient record using Email (Fixes wrong patient name issue)
            Patient patient = patientDAO.getPatientByEmail(user.getEmail());

            // Auto-create patient record if user does not have one yet
            if (patient == null) {
                patient = patientDAO.createPatientFromUser(user.getName(), user.getEmail(), user.getMobile());
            }

            if (patient == null) {
                response.sendRedirect("book-appointment.jsp?msg=Failed to link patient profile!");
                return;
            }

            AppointmentDAO dao = new AppointmentDAO(conn);

            // 4. Check if doctor is available
            boolean alreadyBooked = dao.isDoctorBooked(doctorId, date);
            if (alreadyBooked) {
                response.sendRedirect("book-appointment.jsp?msg=Doctor not available on selected date!");
                return;
            }

            // 5. Book appointment using actual patient.id
            Appointment appointment = new Appointment();
            appointment.setPatientId(patient.getId()); // Uses true patient.id!
            appointment.setDoctorId(doctorId);
            appointment.setDate(date);
            appointment.setStatus("Pending");

            boolean booked = dao.addAppointment(appointment);

            if (booked) {
                response.sendRedirect("book-appointment.jsp?msg=Appointment booked successfully!");
            } else {
                response.sendRedirect("book-appointment.jsp?msg=Failed to book appointment!");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("book-appointment.jsp?msg=Error: " + e.getMessage());
        }
    }
}