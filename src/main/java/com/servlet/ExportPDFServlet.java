package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.dao.DBConnect;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ExportPDFServlet")
public class ExportPDFServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String appointmentId = req.getParameter("appointmentId");

        resp.setContentType("application/pdf");
        resp.setHeader("Content-Disposition", "attachment; filename=Receipt_" + (appointmentId != null ? appointmentId : "Report") + ".pdf");

        try (Connection conn = DBConnect.getConn()) {
            Document document = new Document();
            PdfWriter.getInstance(document, resp.getOutputStream());
            document.open();

            // Title
            Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 20, BaseColor.DARK_GRAY);
            Paragraph title = new Paragraph("Hospital Management System", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);

            Paragraph subTitle = new Paragraph("Official Medical Invoice / Receipt\n\n", FontFactory.getFont(FontFactory.HELVETICA, 12, BaseColor.GRAY));
            subTitle.setAlignment(Element.ALIGN_CENTER);
            document.add(subTitle);

            // Table
            PdfPTable table = new PdfPTable(2);
            table.setWidthPercentage(100);
            table.setSpacingBefore(10f);

            Font headFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, BaseColor.WHITE);

            PdfPCell h1 = new PdfPCell(new Phrase("Description", headFont));
            h1.setBackgroundColor(new BaseColor(2, 132, 199));
            h1.setPadding(8);
            table.addCell(h1);

            PdfPCell h2 = new PdfPCell(new Phrase("Details", headFont));
            h2.setBackgroundColor(new BaseColor(2, 132, 199));
            h2.setPadding(8);
            table.addCell(h2);

            if (appointmentId != null && !appointmentId.trim().isEmpty()) {
                // ✅ FIX: Joined with payment table on appointment_id to fetch accurate payment records
                String sql = "SELECT a.*, p.amount FROM appointment a " +
                             "LEFT JOIN payment p ON a.id = p.appointment_id " +
                             "WHERE a.id = ?";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setInt(1, Integer.parseInt(appointmentId));
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        table.addCell("Appointment ID");
                        table.addCell(String.valueOf(rs.getInt("id")));

                        table.addCell("Patient Name");
                        table.addCell(rs.getString("patient_name") != null ? rs.getString("patient_name") : "N/A");

                        table.addCell("Appointment Date");
                        table.addCell(rs.getDate("appointment_date") != null ? rs.getDate("appointment_date").toString() : "N/A");

                        table.addCell("Doctor ID");
                        table.addCell(String.valueOf(rs.getInt("doctor_id")));

                        table.addCell("Status");
                        table.addCell(rs.getString("status") != null ? rs.getString("status") : "Pending");

                        double amount = rs.getDouble("amount");
                        table.addCell("Total Amount Paid");
                        table.addCell(amount > 0 ? "₹" + amount : "Pending / Free Consultation");
                    }
                }
            }

            document.add(table);

            Paragraph footer = new Paragraph("\nThank you for choosing our Healthcare System. Wishing you good health!", FontFactory.getFont(FontFactory.HELVETICA_OBLIQUE, 10, BaseColor.GRAY));
            footer.setAlignment(Element.ALIGN_CENTER);
            document.add(footer);

            document.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}