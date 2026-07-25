package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.dao.DBConnect;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateAppointmentStatusServlet")
public class UpdateAppointmentStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        String status = req.getParameter("status");

        if (idParam != null && status != null) {
            try (Connection conn = DBConnect.getConn();
                 PreparedStatement ps = conn.prepareStatement("UPDATE appointment SET status = ? WHERE id = ?")) {

                ps.setString(1, status);
                ps.setInt(2, Integer.parseInt(idParam));

                int i = ps.executeUpdate();
                if (i > 0) {
                    resp.sendRedirect("see-all-appointment.jsp?msg=Status+updated+successfully");
                    return;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        resp.sendRedirect("see-all-appointment.jsp?msg=Failed+to+update+status");
    }
}