package com.model;

public class Billing {

    private int id;
    private int patientId;
    private String patientName;   // NEW FIELD
    private double amount;
    private String date;

    // Empty Constructor
    public Billing() {
    }

    // Full Constructor
    public Billing(int id, int patientId, String patientName, double amount, String date) {
        this.id = id;
        this.patientId = patientId;
        this.patientName = patientName;
        this.amount = amount;
       	this.date = date;
    }

    // Getters & Setters

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

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
}
