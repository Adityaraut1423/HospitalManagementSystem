package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.model.Patient;

public class PatientDAO {

    private Connection conn;

    public PatientDAO(Connection conn) {
        this.conn = conn;
    }

    // ✅ Add new patient
    public boolean addPatient(Patient p) {
        String sql = "INSERT INTO patient(name, age, gender, phone, address, email) VALUES (?,?,?,?,?,?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getName());
            ps.setInt(2, p.getAge());
            ps.setString(3, p.getGender());
            ps.setString(4, p.getPhone());
            ps.setString(5, p.getAddress());
            ps.setString(6, p.getEmail());
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            System.err.println("Error adding patient: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Get all patients
    public List<Patient> getAllPatients() {
        List<Patient> list = new ArrayList<>();
        String sql = "SELECT * FROM patient ORDER BY id DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Patient p = mapResultSetToPatient(rs);
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ Get patient by ID
    public Patient getPatientById(int id) {
        Patient p = null;
        String sql = "SELECT * FROM patient WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    p = mapResultSetToPatient(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return p;
    }

    // ✅ Get patient by Email (Case-insensitive & Trimmed)
    public Patient getPatientByEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return null;
        }
        Patient p = null;
        String sql = "SELECT * FROM patient WHERE LOWER(TRIM(email)) = LOWER(TRIM(?))";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email.trim());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    p = mapResultSetToPatient(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching patient by email: " + e.getMessage());
            e.printStackTrace();
        }
        return p;
    }

    // ✅ Auto-create patient profile from registered user details
    // Uses 'N/A' for gender to avoid MySQL VARCHAR truncation exceptions
    public Patient createPatientFromUser(String name, String email, String phone) {
        String safeName = (name != null && !name.trim().isEmpty()) ? name.trim() : "New Patient";
        String safeEmail = (email != null && !email.trim().isEmpty()) ? email.trim() : "no-email@hospital.com";
        String safePhone = (phone != null && !phone.trim().isEmpty()) ? phone.trim() : "0000000000";

        String sql = "INSERT INTO patient(name, age, gender, phone, address, email) VALUES(?, 0, 'N/A', ?, 'N/A', ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, safeName);
            ps.setString(2, safePhone);
            ps.setString(3, safeEmail);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        Patient p = new Patient();
                        p.setId(rs.getInt(1)); // Retrieves auto-generated ID
                        p.setName(safeName);
                        p.setEmail(safeEmail);
                        p.setPhone(safePhone);
                        p.setAge(0);
                        p.setGender("N/A");
                        p.setAddress("N/A");
                        return p;
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Failed to auto-create patient record for user [" + safeEmail + "]: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    // ✅ Update patient
    public boolean updatePatient(Patient p) {
        String sql = "UPDATE patient SET name=?, age=?, gender=?, phone=?, address=?, email=? WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getName());
            ps.setInt(2, p.getAge());
            ps.setString(3, p.getGender());
            ps.setString(4, p.getPhone());
            ps.setString(5, p.getAddress());
            ps.setString(6, p.getEmail());
            ps.setInt(7, p.getId());
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Delete patient
    public boolean deletePatient(int id) {
        String sql = "DELETE FROM patient WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Search patient by name
    public List<Patient> searchPatients(String keyword) {
        List<Patient> list = new ArrayList<>();
        String sql = "SELECT * FROM patient WHERE name LIKE ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Patient p = mapResultSetToPatient(rs);
                    list.add(p);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 🛠️ Helper method to map ResultSet row to Patient Object
    private Patient mapResultSetToPatient(ResultSet rs) throws SQLException {
        Patient p = new Patient();
        p.setId(rs.getInt("id"));
        p.setName(rs.getString("name"));
        p.setAge(rs.getInt("age"));
        p.setGender(rs.getString("gender"));
        p.setPhone(rs.getString("phone"));
        p.setAddress(rs.getString("address"));
        p.setEmail(rs.getString("email"));
        return p;
    }
}