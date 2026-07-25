package com.servlet;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import com.dao.AppointmentDAO;
import com.dao.DBConnect;
import com.dao.DoctorDAO;
import com.dao.PatientDAO;
import com.model.Appointment;
import com.model.Doctor;
import com.model.Patient;
import com.util.EmailUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/confirmAppointment")
public class ConfirmAppointmentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            String idParam = req.getParameter("id");
            if (idParam == null || idParam.trim().isEmpty()) {
                resp.sendRedirect("see-all-appointment.jsp?msg=" +
                        URLEncoder.encode("Invalid Appointment ID!", StandardCharsets.UTF_8));
                return;
            }

            int appId = Integer.parseInt(idParam);

            AppointmentDAO appointmentDAO = new AppointmentDAO(DBConnect.getConn());
            PatientDAO patientDAO = new PatientDAO(DBConnect.getConn());
            DoctorDAO doctorDAO = new DoctorDAO(DBConnect.getConn());

            // 1. Get appointment
            Appointment appointment = appointmentDAO.getAppointmentById(appId);
            if (appointment == null) {
                resp.sendRedirect("see-all-appointment.jsp?msg=" +
                        URLEncoder.encode("Appointment #" + appId + " not found!", StandardCharsets.UTF_8));
                return;
            }

            // 2. Update status to Confirmed
            boolean updated = appointmentDAO.updateStatus(appId, "Confirmed");

            if (!updated) {
                resp.sendRedirect("see-all-appointment.jsp?msg=" +
                        URLEncoder.encode("Failed to update status for appointment #" + appId, StandardCharsets.UTF_8));
                return;
            }

            // 3. Fetch patient & doctor details safely
            Patient p = patientDAO.getPatientById(appointment.getPatientId());
            Doctor d = doctorDAO.getDoctorById(appointment.getDoctorId());

            String patientName = (p != null && p.getName() != null) ? p.getName() : "Valued Patient";
            String doctorName = (d != null && d.getName() != null) ? d.getName() : "Assigned Doctor";
            String doctorSpeciality = (d != null && d.getSpeciality() != null) ? d.getSpeciality() : "General Medicine";
            String doctorTimings = (d != null && d.getTimings() != null) ? d.getTimings() : "Hospital Hours";

            // 4. Prepare email content
            boolean emailSent = false;
            if (p != null && p.getEmail() != null && !p.getEmail().trim().isEmpty()) {
                String subject = "Appointment Confirmation - " + patientName;
                String message = "Dear " + patientName + ",\n\n" +
                        "Your appointment has been successfully confirmed.\n\n" +
                        "----- Patient Details -----\n" +
                        "Patient ID: " + p.getId() + "\n" +
                        "Name: " + patientName + "\n" +
                        "Age: " + p.getAge() + "\n" +
                        "Gender: " + p.getGender() + "\n" +
                        "Phone: " + (p.getPhone() != null ? p.getPhone() : "N/A") + "\n" +
                        "Address: " + (p.getAddress() != null ? p.getAddress() : "N/A") + "\n" +
                        "Email: " + p.getEmail() + "\n\n" +
                        "----- Doctor Details -----\n" +
                        "Doctor Name: " + doctorName + "\n" +
                        "Speciality: " + doctorSpeciality + "\n" +
                        "Timing: " + doctorTimings + "\n\n" +
                        "----- Appointment Info -----\n" +
                        "Date: " + appointment.getDate() + "\n" +
                        "Status: Confirmed\n\n" +
                        "Thank you for choosing our hospital.";

                // Dispatch Email
                emailSent = EmailUtil.sendMail(p.getEmail(), subject, message);
            }

            // 5. Redirect back to admin table with detailed status banner
            String statusMsg;
            if (emailSent) {
                statusMsg = "Appointment #" + appId + " confirmed and email sent to " + p.getEmail();
            } else {
                statusMsg = "Appointment #" + appId + " confirmed successfully!";
            }

            resp.sendRedirect("see-all-appointment.jsp?msg=" + URLEncoder.encode(statusMsg, StandardCharsets.UTF_8));

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("see-all-appointment.jsp?msg=" +
                    URLEncoder.encode("Error confirming appointment: " + e.getMessage(), StandardCharsets.UTF_8));
        }
    }
}