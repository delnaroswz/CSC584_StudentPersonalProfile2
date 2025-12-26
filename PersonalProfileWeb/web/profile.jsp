<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Submitted Profile Details</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="style.css">
</head>

<body class="display-page">

<div class="profile-card">

    <div class="profile-header">
        <h1 class="text-3xl font-extrabold text-white">Profile Submission Status</h1>
    </div>

    <div class="text-center mb-6 text-lg font-semibold text-pink-400">
        <%= request.getAttribute("message") %>
    </div>

    <%
        Boolean success = (Boolean) request.getAttribute("success");
    %>

    <% if (success != null && success) { %>

        <h2 class="text-xl font-bold text-gray-300 mb-4">Your Information</h2>

        <div class="space-y-2">

            <div class="detail-item">
                <span class="detail-label">Full Name</span>
                <span class="detail-value">${fullName}</span>
            </div>

            <div class="detail-item">
                <span class="detail-label">Student ID</span>
                <span class="detail-value">${studentId}</span>
            </div>

            <div class="detail-item">
                <span class="detail-label">Program</span>
                <span class="detail-value">${programCourse}</span>
            </div>

            <div class="detail-item">
                <span class="detail-label">Faculty</span>
                <span class="detail-value">${faculty}</span>
            </div>

            <div class="detail-item">
                <span class="detail-label">Email</span>
                <span class="detail-value">${studentEmail}</span>
            </div>

            <div class="detail-item">
                <span class="detail-label">Hobbies</span>
                <span class="detail-value">${hobbies}</span>
            </div>

        </div>

        <div class="intro-section mt-6">
            <h3 class="text-lg font-bold text-white mb-2">Self Introduction</h3>
            <p class="text-gray-400 whitespace-pre-wrap">${selfIntro}</p>
        </div>

    <% } %>

    <div class="mt-8 text-center space-x-4">
        <a href="index.html" class="submit-button">Home</a>
        <a href="profile_form.html" class="submit-button">Add Profile</a>
        <a href="viewProfiles.jsp" class="submit-button">View Profiles</a>
    </div>

</div>
</body>
</html>
