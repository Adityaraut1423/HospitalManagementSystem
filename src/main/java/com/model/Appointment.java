package com.model;

/**
 * Model class representing an Appointment entity.
 */
public class Appointment {

    private int id;
    private int patientId;
    private String patientName;   // Joined field from patient table
    private int doctorId;
    private String doctorName;    // Joined field from doctor table
    private String date;
    private String status;

    // --- Constructors ---

    // Default no-arg constructor
    public Appointment() {
    }

    // Constructor without ID (Ideal for creating new appointments before DB insertion)
    public Appointment(int patientId, int doctorId, String date, String status) {
        this.patientId = patientId;
        this.doctorId = doctorId;
        this.date = date;
        this.status = status;
    }

    // Constructor without names (For standard CRUD operations)
    public Appointment(int id, int patientId, int doctorId, String date, String status) {
        this.id = id;
        this.patientId = patientId;
        this.doctorId = doctorId;
        this.date = date;
        this.status = status;
    }

    // Full constructor with patient and doctor names (For JOIN queries in views/tables)
    public Appointment(int id, int patientId, String patientName, int doctorId, String doctorName, String date, String status) {
        this.id = id;
        this.patientId = patientId;
        this.patientName = patientName;
        this.doctorId = doctorId;
        this.doctorName = doctorName;
        this.date = date;
        this.status = status;
    }

    // --- Getters & Setters ---

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPatientId() {
        return patientId;
    }

    public void setPatientId(int patientId) {
        this.patientId = patientId;
    }

    public String getPatientName() {
        return patientName;
    }

    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }

    public int getDoctorId() {
        return doctorId;
    }

    public void setDoctorId(int doctorId) {
        this.doctorId = doctorId;
    }

    public String getDoctorName() {
        return doctorName;
    }

    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    // --- Utility Methods ---

    @Override
    public String toString() {
        return "Appointment{" +
                "id=" + id +
                ", patientId=" + patientId +
                ", patientName='" + patientName + '\'' +
                ", doctorId=" + doctorId +
                ", doctorName='" + doctorName + '\'' +
                ", date='" + date + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}