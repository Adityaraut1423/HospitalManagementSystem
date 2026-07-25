package com.model;

public class Doctor {

    private int id;
    private String name;
    private String speciality;
    private String timings; // Corrected to plural


    // Empty constructor
    public Doctor() {
    }

    // Full constructor
    public Doctor(int id, String name, String speciality, String timings) {
        this.id = id;
        this.name = name;
        this.speciality = speciality;
        this.timings = timings;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSpeciality() {
        return speciality;
    }

    public void setSpeciality(String speciality) {
        this.speciality = speciality;
    }

    public String getTimings() { // plural
        return timings;
    }

    public void setTimings(String timings) { // plural
        this.timings = timings;
    }



}
