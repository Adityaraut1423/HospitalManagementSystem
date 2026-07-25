package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.model.Doctor;

public class DoctorDAO {
    private Connection conn;

    public DoctorDAO(Connection conn) {
        this.conn = conn;
    }

    // Add doctor
    public boolean addDoctor(Doctor d) {
        try {
            String sql = "INSERT INTO doctor(name, speciality, timings) VALUES(?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, d.getName());
            ps.setString(2, d.getSpeciality());
            ps.setString(3, d.getTimings()); // ✅ use getTimings()
            return ps.executeUpdate() == 1;
        } catch(Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get all doctors
    public List<Doctor> getAllDoctors() {
        List<Doctor> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM doctor";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                Doctor d = new Doctor();
                d.setId(rs.getInt("id"));
                d.setName(rs.getString("name"));
                d.setSpeciality(rs.getString("speciality"));
                d.setTimings(rs.getString("timings")); // ✅ use setTimings()
                list.add(d);
            }
        } catch(Exception e) { e.printStackTrace(); }
        return list;
    }

    // Get doctor by ID
    public Doctor getDoctorById(int id) {
        Doctor d = null;
        try {
            String sql = "SELECT * FROM doctor WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                d = new Doctor();
                d.setId(rs.getInt("id"));
                d.setName(rs.getString("name"));
                d.setSpeciality(rs.getString("speciality"));
                d.setTimings(rs.getString("timings")); // ✅ use setTimings()
            }
        } catch(Exception e) { e.printStackTrace(); }
        return d;
    }

    // Update doctor
    public boolean updateDoctor(Doctor d) {
        try {
            String sql = "UPDATE doctor SET timings=? WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, d.getTimings());
            ps.setInt(2, d.getId());
            return ps.executeUpdate() == 1;
        } catch(Exception e) {
            e.printStackTrace();
        }
        return false;
    }


    // Delete doctor
    public boolean deleteDoctor(int id) {
        try {
            String sql = "DELETE FROM doctor WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() == 1;
        } catch(Exception e) { e.printStackTrace(); }
        return false;
    }

}
