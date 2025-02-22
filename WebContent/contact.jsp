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