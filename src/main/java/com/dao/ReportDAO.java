package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

public class ReportDAO {

    private Connection conn;

    public ReportDAO(Connection conn) {
        this.conn = conn;
    }

    /**
     * Fetch Monthly Revenue.
     * Joins billing and appointment to safely fetch the appointment_date.
     */
    public Map<String, Double> getMonthlyRevenue() {
        Map<String, Double> revenue = new LinkedHashMap<>();

        // Joins billing with appointment to get appointment_date safely
        String sql = "SELECT MONTH(a.appointment_date) AS month_num, SUM(b.amount) AS total_revenue " +
                     "FROM billing b " +
                     "JOIN appointment a ON b.appointment_id = a.id " +
                     "WHERE a.appointment_date IS NOT NULL " +
                     "GROUP BY MONTH(a.appointment_date) " +
                     "ORDER BY month_num ASC";

        String[] monthNames = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                int monthNumber = rs.getInt("month_num");
                double amount = rs.getDouble("total_revenue");

                if (monthNumber >= 1 && monthNumber <= 12) {
                    revenue.put(monthNames[monthNumber - 1], amount);
                }
            }
        } catch (SQLException e) {
            // Fallback strategy if billing does not use appointment_id foreign key
            System.err.println("⚠️ Standard JOIN failed in getMonthlyRevenue, attempting fallback query...");
            revenue = getMonthlyRevenueFallback();
        }
        return revenue;
    }

    /**
     * Fallback method if billing is queried directly without joining appointment.
     */
    private Map<String, Double> getMonthlyRevenueFallback() {
        Map<String, Double> revenue = new LinkedHashMap<>();
        String sql = "SELECT MONTH(billing_date) AS month_num, SUM(amount) AS total_revenue " +
                     "FROM billing " +
                     "GROUP BY MONTH(billing_date) " +
                     "ORDER BY month_num ASC";

        String[] monthNames = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                int monthNumber = rs.getInt("month_num");
                double amount = rs.getDouble("total_revenue");

                if (monthNumber >= 1 && monthNumber <= 12) {
                    revenue.put(monthNames[monthNumber - 1], amount);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return revenue;
    }

    /**
     * Fetch Total Appointments per Doctor
     */
    public Map<String, Integer> getAppointmentsPerDoctor() {
        Map<String, Integer> map = new LinkedHashMap<>();
        String sql = "SELECT d.name AS doctor_name, COUNT(a.id) AS total_appointments " +
                     "FROM appointment a " +
                     "JOIN doctor d ON a.doctor_id = d.id " +
                     "GROUP BY d.id, d.name";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String doctorName = rs.getString("doctor_name");
                int total = rs.getInt("total_appointments");
                map.put(doctorName != null ? doctorName : "Unassigned", total);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return map;
    }

    /**
     * Fetch Patient Demographics by Gender
     */
    public Map<String, Integer> getPatientDemographics() {
        Map<String, Integer> map = new LinkedHashMap<>();
        String sql = "SELECT gender, COUNT(*) AS total FROM patient GROUP BY gender";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String gender = rs.getString("gender");
                int total = rs.getInt("total");
                map.put((gender != null && !gender.trim().isEmpty()) ? gender : "Other", total);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return map;
    }
}