package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.model.Doctor;

public class DoctorDAO {
    private Connection conn;

    public DoctorDAO(Connection conn) {
        this.conn = conn;
    }

    // Helper method to ensure a valid, non-null database connection
    private Connection getConnection() throws SQLException {
        if (this.conn == null || this.conn.isClosed()) {
            this.conn = DBConnect.getConn();
        }
        return this.conn;
    }

    // Add doctor
    public boolean addDoctor(Doctor d) {
        String sql = "INSERT INTO doctor(name, speciality, timings) VALUES(?,?,?)";
        try {
            Connection activeConn = getConnection();
            if (activeConn == null) return false;

            try (PreparedStatement ps = activeConn.prepareStatement(sql)) {
                ps.setString(1, d.getName());
                ps.setString(2, d.getSpeciality());
                ps.setString(3, d.getTimings());
                return ps.executeUpdate() == 1;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get all doctors
    public List<Doctor> getAllDoctors() {
        List<Doctor> list = new ArrayList<>();
        String sql = "SELECT * FROM doctor ORDER BY id DESC";
        try {
            Connection activeConn = getConnection();
            if (activeConn == null) {
                System.err.println("❌ Database connection is null in DoctorDAO.getAllDoctors()");
                return list;
            }

            try (PreparedStatement ps = activeConn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    Doctor d = new Doctor();
                    d.setId(rs.getInt("id"));
                    d.setName(rs.getString("name"));
                    
                    // Safely check for both speciality and specialist column names
                    try {
                        d.setSpeciality(rs.getString("speciality"));
                    } catch (SQLException e) {
                        d.setSpeciality(rs.getString("specialist"));
                    }

                    d.setTimings(rs.getString("timings"));
                    list.add(d);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Alias method for JSPs or Servlets that call getAllDoctor()
    public List<Doctor> getAllDoctor() {
        return getAllDoctors();
    }

    // Get doctor by ID
    public Doctor getDoctorById(int id) {
        Doctor d = null;
        String sql = "SELECT * FROM doctor WHERE id=?";
        try {
            Connection activeConn = getConnection();
            if (activeConn == null) return null;

            try (PreparedStatement ps = activeConn.prepareStatement(sql)) {
                ps.setInt(1, id);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        d = new Doctor();
                        d.setId(rs.getInt("id"));
                        d.setName(rs.getString("name"));
                        
                        try {
                            d.setSpeciality(rs.getString("speciality"));
                        } catch (SQLException e) {
                            d.setSpeciality(rs.getString("specialist"));
                        }

                        d.setTimings(rs.getString("timings"));
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return d;
    }

    // Update doctor
    public boolean updateDoctor(Doctor d) {
        String sql = "UPDATE doctor SET timings=? WHERE id=?";
        try {
            Connection activeConn = getConnection();
            if (activeConn == null) return false;

            try (PreparedStatement ps = activeConn.prepareStatement(sql)) {
                ps.setString(1, d.getTimings());
                ps.setInt(2, d.getId());
                return ps.executeUpdate() == 1;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete doctor
    public boolean deleteDoctor(int id) {
        String sql = "DELETE FROM doctor WHERE id=?";
        try {
            Connection activeConn = getConnection();
            if (activeConn == null) return false;

            try (PreparedStatement ps = activeConn.prepareStatement(sql)) {
                ps.setInt(1, id);
                return ps.executeUpdate() == 1;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}