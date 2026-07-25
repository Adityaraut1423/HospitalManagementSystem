package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.model.Appointment;

public class AppointmentDAO {

    private Connection conn;

    public AppointmentDAO(Connection conn) {
        this.conn = conn;
    }

    // ✅ Add appointment
    public boolean addAppointment(Appointment a) {
        String sql = "INSERT INTO appointment(patient_id, patient_name, doctor_id, appointment_date, status) VALUES(?,?,?,?,?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, a.getPatientId());
            ps.setString(2, a.getPatientName());
            ps.setInt(3, a.getDoctorId());
            ps.setString(4, a.getDate());
            ps.setString(5, a.getStatus() != null ? a.getStatus() : "Pending");

            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Get all appointments
    public List<Appointment> getAllAppointments() {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT * FROM appointment ORDER BY id DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Appointment a = mapResultSetToAppointment(rs);
                list.add(a);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ Get all appointments with Patient & Doctor Names (Double JOIN + Direct Column Fallback)
    public List<Appointment> getAllAppointmentsWithPatientName() {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT a.id, a.patient_id, a.patient_name AS direct_patient_name, " +
                     "a.doctor_id, a.appointment_date, a.status, " +
                     "COALESCE(a.patient_name, p.name) AS patientName, " +
                     "d.name AS doctorName " +
                     "FROM appointment a " +
                     "LEFT JOIN patient p ON a.patient_id = p.id " +
                     "LEFT JOIN doctor d ON a.doctor_id = d.id " +
                     "ORDER BY a.id DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Appointment a = new Appointment();
                a.setId(rs.getInt("id"));
                a.setPatientId(rs.getInt("patient_id"));
                a.setDoctorId(rs.getInt("doctor_id"));
                a.setDate(rs.getString("appointment_date"));
                a.setStatus(rs.getString("status"));
                a.setPatientName(rs.getString("patientName"));
                a.setDoctorName(rs.getString("doctorName"));
                list.add(a);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ Get appointments by date
    public List<Appointment> getAppointmentsByDate(String date) {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT * FROM appointment WHERE appointment_date=?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, date);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Appointment a = mapResultSetToAppointment(rs);
                    list.add(a);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ Check if doctor is already booked on a given date
    public boolean isDoctorBooked(int doctorId, String date) {
        String sql = "SELECT COUNT(*) FROM appointment WHERE doctor_id=? AND appointment_date=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, doctorId);
            ps.setString(2, date);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Get appointment by ID
    public Appointment getAppointmentById(int id) {
        Appointment a = null;
        String sql = "SELECT * FROM appointment WHERE id=?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    a = mapResultSetToAppointment(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return a;
    }

    // ✅ Get appointments by patient ID
    public List<Appointment> getAppointmentsByPatient(int patientId) {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT * FROM appointment WHERE patient_id=? ORDER BY id DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, patientId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Appointment a = mapResultSetToAppointment(rs);
                    list.add(a);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ Update status (e.g., Pending -> Confirmed/Completed/Cancelled)
    public boolean updateStatus(int id, String status) {
        String sql = "UPDATE appointment SET status=? WHERE id=?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Delete appointment by ID
    public boolean deleteAppointment(int id) {
        String sql = "DELETE FROM appointment WHERE id=?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 🛠️ Helper method to map ResultSet row to Appointment Object
    private Appointment mapResultSetToAppointment(ResultSet rs) throws SQLException {
        Appointment a = new Appointment();
        a.setId(rs.getInt("id"));
        a.setPatientId(rs.getInt("patient_id"));

        // Safely check for patient_name column
        try {
            a.setPatientName(rs.getString("patient_name"));
        } catch (SQLException e) {
            // Column name wasn't present in query output, skip
        }

        a.setDoctorId(rs.getInt("doctor_id"));
        a.setDate(rs.getString("appointment_date"));
        a.setStatus(rs.getString("status"));
        return a;
    }
}