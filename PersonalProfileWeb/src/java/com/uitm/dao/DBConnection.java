package com.uitm.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    
    private static final String URL = "jdbc:derby://localhost:1527/StudentProfilesDB";
    private static final String USERNAME = "app"; 
    private static final String PASSWORD = "app";
    
    static {
        try {
           
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            System.out.println("DEBUG: Derby driver loaded successfully");
        } catch (ClassNotFoundException e) {
            System.out.println("DEBUG: Failed to load Derby driver");
            e.printStackTrace();
        }
    }
    
    public static Connection getConnection() throws SQLException {
        System.out.println("DEBUG: Attempting to connect to: " + URL);
        Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
        System.out.println("DEBUG: Database connection successful!");
        return conn;
    }
}