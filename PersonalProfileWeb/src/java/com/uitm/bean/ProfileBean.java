package com.uitm.bean;

import java.io.Serializable;

public class ProfileBean implements Serializable {
    private int id;
    private String fullName;
    private String studentId;
    private String program;
    private String faculty;
    private String email;
    private String hobbies;
    private String selfIntro;
    
    // Constructors
    public ProfileBean() {}
    
    public ProfileBean(String fullName, String studentId, String program, 
                       String faculty, String email, String hobbies, String selfIntro) {
        this.fullName = fullName;
        this.studentId = studentId;
        this.program = program;
        this.faculty = faculty;
        this.email = email;
        this.hobbies = hobbies;
        this.selfIntro = selfIntro;
    }
    
    // Getters and Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    
    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }
    
    public String getProgram() { return program; }
    public void setProgram(String program) { this.program = program; }
    
    public String getFaculty() { return faculty; }
    public void setFaculty(String faculty) { this.faculty = faculty; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getHobbies() { return hobbies; }
    public void setHobbies(String hobbies) { this.hobbies = hobbies; }
    
    public String getSelfIntro() { return selfIntro; }
    public void setSelfIntro(String selfIntro) { this.selfIntro = selfIntro; }
}