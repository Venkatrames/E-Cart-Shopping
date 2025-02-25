<%@page import="cn.techtutorial.model.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%
User auth = (User) session.getAttribute("auth");
if (auth == null) {
    response.sendRedirect("login.jsp"); // Redirect user to login page if not authenticated
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="/includes/head.jsp" %>
    <title>Contact Us</title>
    <!-- Other meta tags, styles, etc. -->
    <script>
        window.onload = function() {
            const urlParams = new URLSearchParams(window.location.search);
            const message = urlParams.get('message');
            if (message === 'success') {
                alert(" Email sent successfully!");
            } else if (message === 'failure') {
                alert(" Failed to send email. Please try again!");
            }
        }
    </script>
    <style>
        body {
            background: linear-gradient(135deg, #4B0082, #8B0000, #FF4500, #FF69B4, #4169E1);
            background-attachment: fixed;
            font-family: 'Arial', sans-serif;
            color: #fff;
        }

        .container {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            padding: 20px;
            margin-top: 30px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            color: black;
        }

        .form-control {
            background: #f8f9fa;
            color: black;
        }

        .btn-primary {
            background: #8B0000;
            border: none;
        }

        .btn-primary:hover {
            background: #FF4500;
        }
    </style>
</head>
<body>
    <%@ include file="/includes/navbar.jsp" %>

    <div class="container my-5">
        <h2 class="text-center">Contact Us</h2>
        <form action="ContactServlet" method="post">
            <div class="form-group">
                <label>Name</label>
                <input type="text" class="form-control" name="name" value="<%= auth.getName() %>" readonly>
            </div>
            <div class="form-group">
                <label>Email</label>
                <input type="email" class="form-control" name="email" value="<%= auth.getEmail() %>" readonly>
            </div>
            <div class="form-group">
                <label>Message</label>
                <textarea class="form-control" name="message" rows="5" required></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Send Message</button>
        </form>
    </div>

    <%@ include file="/includes/footer.jsp" %>
</body>
</html>