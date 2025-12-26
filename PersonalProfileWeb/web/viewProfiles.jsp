<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.uitm.bean.ProfileBean"%>
<%@page import="com.uitm.dao.DBConnection"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Media Club Members</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="style.css">
</head>

<body class="display-page">

<%
    String searchType = request.getParameter("searchType");
    String searchTerm = request.getParameter("searchTerm");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    ArrayList<ProfileBean> profiles = new ArrayList<ProfileBean>();
    String error = null;

    try {
        conn = DBConnection.getConnection();

        String sql;

        
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            if ("id".equals(searchType)) {
                sql = "SELECT * FROM profile WHERE studentId = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, searchTerm);
            } else {
                sql = "SELECT * FROM profile WHERE LOWER(fullName) LIKE LOWER(?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, "%" + searchTerm + "%");
            }
        } 
        else {
            sql = "SELECT * FROM profile ORDER BY id ASC";
            pstmt = conn.prepareStatement(sql);
        }

        rs = pstmt.executeQuery();

        while (rs.next()) {
            ProfileBean p = new ProfileBean();
            p.setId(rs.getInt("id"));
            p.setFullName(rs.getString("fullName"));
            p.setStudentId(rs.getString("studentId"));
            p.setProgram(rs.getString("program"));
            p.setFaculty(rs.getString("faculty"));
            p.setEmail(rs.getString("email"));
            p.setHobbies(rs.getString("hobbies"));
            p.setSelfIntro(rs.getString("selfIntro"));
            profiles.add(p);
        }

    } catch (Exception e) {
        error = e.getMessage();
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (Exception e) {}
    }
%>

<div class="profile-card">

    <h1 class="text-3xl font-bold text-white mb-4">
        Media Club Members
    </h1>

    <!-- search functinality -->
    <form method="get" class="flex gap-3 mb-8">
        <select name="searchType" class="input-highlight">
            <option value="name" <%= "name".equals(searchType) ? "selected" : "" %>>
                Name
            </option>
            <option value="id" <%= "id".equals(searchType) ? "selected" : "" %>>
                Student ID
            </option>
        </select>

        <input type="text"
               name="searchTerm"
               value="<%= searchTerm != null ? searchTerm : "" %>"
               placeholder="Search..."
               class="input-highlight flex-1">

        <button type="submit" class="submit-button">
            Search
        </button>
        <a href="viewProfiles.jsp" class="text-gray-400 hover:text-white self-center">
            Reset
        </a>
    </form>

    <% if (error != null) { %>
        <div class="bg-red-900 text-red-200 p-4 rounded mb-6">
            Error: <%= error %>
        </div>
    <% } %>

    <% if (profiles.isEmpty()) { %>
        <p class="text-gray-400">
            No profiles found.
        </p>
    <% } else { %>

        <div class="space-y-6">
            <%
                int number = 1;
                for (ProfileBean profile : profiles) {
            %>

            <div class="bg-gray-900 border border-gray-800 rounded-lg p-6">

                <!-- Number -->
                <div class="text-pink-500 text-xl font-bold mb-4">
                    <%= number++ %>
                </div>

                <p class="text-white">
                    <span class="text-gray-400">Name :</span>
                    <%= profile.getFullName() %>
                </p>

                <p class="text-white">
                    <span class="text-gray-400">Student ID :</span>
                    <%= profile.getStudentId() %>
                </p>

                <p class="text-white">
                    <span class="text-gray-400">Program :</span>
                    <%= profile.getProgram() %>
                </p>

                <p class="text-white">
                    <span class="text-gray-400">Faculty :</span>
                    <%= profile.getFaculty() %>
                </p>

                <p class="text-white">
                    <span class="text-gray-400">Email :</span>
                    <%= profile.getEmail() %>
                </p>

                <p class="text-white">
                    <span class="text-gray-400">Hobbies :</span>
                    <%= profile.getHobbies() %>
                </p>

                <p class="text-white">
                    <span class="text-gray-400">Self Intro :</span>
                    <%= profile.getSelfIntro() %>
                </p>

            </div>

            <% } %>
        </div>

    <% } %>

    <div class="mt-8 text-center">
        <a href="index.html" class="text-pink-400 hover:text-pink-300 font-medium">Back to Home</a>
    </div>

</div>
</body>
</html>
