package com.servlet;

import java.io.IOException;
import java.util.Map;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.dao.DBConnect;
import com.dao.ReportDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ExportExcelServlet")
public class ExportExcelServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ReportDAO reportDao = new ReportDAO(DBConnect.getConn());
        Map<String, Double> monthlyRevenue = reportDao.getMonthlyRevenue();

        try (Workbook wb = new XSSFWorkbook()) {
            Sheet sheet = wb.createSheet("Monthly Revenue");

            Row header = sheet.createRow(0);
            header.createCell(0).setCellValue("Month");
            header.createCell(1).setCellValue("Revenue");

            int rownum = 1;
            for (Map.Entry<String, Double> entry : monthlyRevenue.entrySet()) {
                Row row = sheet.createRow(rownum++);
                row.createCell(0).setCellValue(entry.getKey());
                row.createCell(1).setCellValue(entry.getValue());
            }

            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setHeader("Content-Disposition", "attachment; filename=MonthlyRevenue.xlsx");
            wb.write(response.getOutputStream());
        }
    }
}
