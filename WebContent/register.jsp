<%@page import="cn.techtutorial.model.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%
	User auth = (User) request.getSession().getAttribute("auth");
	if (auth != null) {
		response.sendRedirect("index.jsp");
	}
	%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/includes/head.jsp"%>
    <title>User Registration</title>
    <style>
        /* Outer Background - Impressive Constant Color */
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #1a1a2e, #16213e, #0f3460); /* Constant Dark Gradient */
            background-size: cover;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* Registration Box - Constant Violet */
        .container {
            background: #8B00FF; /* Constant Violet */
            color: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s ease-in-out;
            width: 400px;
            text-align: center;
            animation: fadeIn 1.5s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: scale(0.8); }
            to { opacity: 1; transform: scale(1); }
        }

        .container:hover {
            transform: scale(1.02);
        }

        h2 {
            font-weight: bold;
            margin-bottom: 20px;
        }

        .form-control {
            border-radius: 10px;
            padding: 10px;
            border: none;
            box-shadow: inset 0px 3px 10px rgba(0, 0, 0, 0.2);
        }

        .btn-primary {
            background: #ff7eb3;
            border: none;
            padding: 12px 20px;
            border-radius: 50px;
            font-weight: bold;
            transition: 0.3s ease-in-out;
        }

        .btn-primary:hover {
            background: #ff3e80;
            transform: translateY(-3px);
            box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.3);
        }

        .text-center a {
            font-weight: bold;
            color: #ffd700;
            text-decoration: none;
        }

        .text-center a:hover {
            text-decoration: underline;
        }

        .alert {
            background: #ff4d4d;
            color: white;
            border-radius: 10px;
            padding: 10px;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>User Registration</h2>
        <%
            String message = (String) request.getSession().getAttribute("message");
            if (message != null) {
        %>
        <div class="alert"><%= message %></div>
        <%
            request.getSession().removeAttribute("message");
            }
        %>
        <form action="register" method="post">
            <div class="mb-3">
                <label for="name" class="form-label">Full Name</label>
                <input type="text" class="form-control" id="name" name="name" required>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <div class="mb-3">
                <label for="confirmPassword" class="form-label">Confirm Password</label>
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">Register</button>
        </form>
        <p class="mt-3 text-center">Already have an account? <a href="login.jsp">Login here</a></p>
    </div>

</body>
</html>
