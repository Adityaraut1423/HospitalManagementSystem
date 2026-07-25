package com.servlet;

import java.io.IOException;

import com.dao.AppointmentDAO;
import com.dao.DBConnect;
import com.dao.DoctorDAO;
import com.dao.PatientDAO;
import com.model.Appointment;
import com.model.Doctor;
import com.model.Patient;
import com.util.EmailUtil;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/SendConfirmEmailServlet")
public class SendConfirmEmailServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int appId = Integer.parseInt(req.getParameter("appointmentId"));

        AppointmentDAO appointmentDAO = new AppointmentDAO(DBConnect.getConn());
        PatientDAO patientDAO = new PatientDAO(DBConnect.getConn());
        DoctorDAO doctorDAO = new DoctorDAO(DBConnect.getConn());

        Appointment appointment = appointmentDAO.getAppointmentById(appId);

        if(appointment == null) {
            req.setAttribute("msg", "Invalid Appointment ID!");
            RequestDispatcher rd = req.getRequestDispatcher("send-confirm-email.jsp");
            rd.forward(req, resp);
            return;
        }

        Patient p = patientDAO.getPatientById(appointment.getPatientId());
        Doctor d = doctorDAO.getDoctorById(appointment.getDoctorId());

        if(p == null || d == null) {
            req.setAttribute("msg", "Patient or Doctor data not found!");
            RequestDispatcher rd = req.getRequestDispatcher("send-confirm-email.jsp");
            rd.forward(req, resp);
            return;
        }

        String toEmail = p.getEmail();
        String subject = "Appointment Confirmation - " + p.getName();

        String message =
                "Dear " + p.getName() + ",\n\n" +
                "Your appointment has been successfully confirmed.\n\n" +

                "----- Patient Details -----\n" +
                "Patient ID: " + p.getId() + "\n" +
                "Name: " + p.getName() + "\n" +
                "Age: " + p.getAge() + "\n" +
                "Gender: " + p.getGender() + "\n" +
                "Phone: " + p.getPhone() + "\n" +
                "Address: " + p.getAddress() + "\n" +
                "Email: " + p.getEmail() + "\n\n" +

                "----- Doctor Details -----\n" +
                "Doctor Name: " + d.getName() + "\n" +
                "Speciality: " + d.getSpeciality() + "\n" +
                "Timing: " + d.getTimings() + "\n\n" +

                "----- Appointment Info -----\n" +
                "Date: " + appointment.getDate() + "\n" +
                "Status: " + appointment.getStatus() + "\n\n" +

                "Thank you for choosing our hospital.\n";

        boolean sent = EmailUtil.sendMail(toEmail, subject, message);

        if(sent) {
            req.setAttribute("msg", "Email Sent Successfully to " + toEmail);
        } else {
            req.setAttribute("msg", "Failed to Send Email!");
        }

        RequestDispatcher rd = req.getRequestDispatcher("send-confirm-email.jsp");
        rd.forward(req, resp);
    }
}
