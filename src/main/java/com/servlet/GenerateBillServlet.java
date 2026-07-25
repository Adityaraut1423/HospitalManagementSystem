package com.servlet;

import java.io.IOException;
import java.time.LocalDate;

import com.dao.BillingDAO;
import com.dao.DBConnect;
import com.dao.PatientDAO;
import com.model.Billing;
import com.model.Patient;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/GenerateBillServlet")
public class GenerateBillServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;   // fixes serial warning

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("text/html;charset=UTF-8");
        req.setCharacterEncoding("UTF-8");

        try {
            // Get form parameters
            String patientIdStr = req.getParameter("patientId");
            String amountStr = req.getParameter("amount");

            if (patientIdStr == null || amountStr == null) {
                resp.getWriter().print("Invalid input!");
                return;
            }

            int patientId = Integer.parseInt(patientIdStr);
            double amount = Double.parseDouble(amountStr);

            // Fetch patient details from DB
            PatientDAO patientDAO = new PatientDAO(DBConnect.getConn());
            Patient patient = patientDAO.getPatientById(patientId);

            if (patient == null) {
                resp.getWriter().print("Invalid patient selected!");
                return;
            }

            // Create Billing object
            Billing bill = new Billing();
            bill.setPatientId(patientId);
            bill.setPatientName(patient.getName());   // important: set patient name
            bill.setAmount(amount);
            bill.setDate(LocalDate.now().toString());

            // Save bill in DB
            BillingDAO billingDAO = new BillingDAO(DBConnect.getConn());
            boolean success = billingDAO.addBill(bill);

            if (success) {
                resp.sendRedirect("success.jsp?msg=Bill generated successfully!");
            } else {
                resp.getWriter().print("Error generating bill!");
            }

        } catch (NumberFormatException e) {
            resp.getWriter().print("Invalid numeric input!");
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().print("Server error: " + e.getMessage());
        }
    }
}
