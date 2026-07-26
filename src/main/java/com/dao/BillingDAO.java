package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.model.Billing;

public class BillingDAO {
    private Connection conn;

    public BillingDAO(Connection conn) {
        this.conn = conn;
    }

    // Add bill (with patient_name)
    public boolean addBill(Billing b) {
        String sql = "INSERT INTO billing(patient_id, amount, bill_date, patient_name) VALUES(?,?,?,?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, b.getPatientId());
            ps.setDouble(2, b.getAmount());
            ps.setString(3, b.getDate());
            ps.setString(4, b.getPatientName());

            return ps.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get all bills
    public List<Billing> getAllBills() {
        List<Billing> list = new ArrayList<>();

        try {
            String sql = "SELECT * FROM billing ORDER BY id DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Billing b = new Billing();
                b.setId(rs.getInt("id"));
                b.setPatientId(rs.getInt("patient_id"));
                b.setPatientName(rs.getString("patient_name"));
                b.setAmount(rs.getDouble("amount"));
                b.setDate(rs.getString("bill_date"));
                list.add(b);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Alias method to ensure compatibility with AdminDashboardServlet
    public List<Billing> getAllBilling() {
        return getAllBills();
    }
}