package com.uitm.servlet;

import com.uitm.bean.ProfileBean;
import com.uitm.dao.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLIntegrityConstraintViolationException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ProcessProfile", urlPatterns = {"/ProcessProfile"})
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String studentId = request.getParameter("studentId");
        String program = request.getParameter("programCourse");
        String faculty = request.getParameter("faculty");
        String email = request.getParameter("studentEmail");
        String hobbies = request.getParameter("hobbies");
        String selfIntro = request.getParameter("selfIntro");

        ProfileBean profile = new ProfileBean(
                fullName, studentId, program, faculty, email, hobbies, selfIntro
        );

        boolean success = false;
        String message;

        try {
            success = insertProfile(profile);

            if (success) {
                message = "Profile saved successfully!";

                request.setAttribute("fullName", fullName);
                request.setAttribute("studentId", studentId);
                request.setAttribute("programCourse", program);
                request.setAttribute("faculty", faculty);
                request.setAttribute("studentEmail", email);
                request.setAttribute("hobbies", hobbies);
                request.setAttribute("selfIntro", selfIntro);
            } else {
                message = "Failed to save profile.";
            }

        } catch (SQLIntegrityConstraintViolationException e) {
            message = "Student ID or Email already exists. Please use a different one.";
        } catch (Exception e) {
            message = "System error: " + e.getMessage();
            e.printStackTrace();
        }

        request.setAttribute("success", success);
        request.setAttribute("message", message);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/profile.jsp");
        dispatcher.forward(request, response);
    }

    private boolean insertProfile(ProfileBean profile) throws Exception {

        String sql = "INSERT INTO profile (fullName, studentId, program, faculty, email, hobbies, selfIntro) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, profile.getFullName());
            pstmt.setString(2, profile.getStudentId());
            pstmt.setString(3, profile.getProgram());
            pstmt.setString(4, profile.getFaculty());
            pstmt.setString(5, profile.getEmail());
            pstmt.setString(6, profile.getHobbies());
            pstmt.setString(7, profile.getSelfIntro());

            return pstmt.executeUpdate() > 0;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("index.html");
    }
}
