<%@page import="cn.techtutorial.model.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%
	User auth = (User) request.getSession().getAttribute("auth");
	if (auth != null) {
		response.sendRedirect("index.jsp");
	}
	ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
	if (cart_list != null) {
		request.setAttribute("cart_list", cart_list);
	}
	%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/includes/head.jsp"%>
<title>VRshopping</title>
<style>
        /* Background with Violet, Indigo, and Black Blue Gradient */
  body {
        font-family: 'Poppins', sans-serif;
        background: linear-gradient(135deg, #4B0082, #8A2BE2, #00008B); /* Violet → Indigo → Black Blue */
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    /* Card Container with Constant Violet Background */
    .card {
        background: violet; /* Constant VIBGYOR 'V' color */
        color: white;
        border-radius: 15px;
        box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.3);
        transition: transform 0.3s ease-in-out;
        animation: fadeIn 1.5s ease-in-out;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: scale(0.8); }
        to { opacity: 1; transform: scale(1); }
    }

    .card:hover {
        transform: scale(1.03);
    }

    .card-header {
        font-size: 22px;
        font-weight: bold;
        background: rgba(0, 0, 0, 0.1);
        padding: 15px;
        border-radius: 15px 15px 0 0;
        text-align: center;
    }

    .form-group label {
        font-weight: bold;
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
        color: #ffebcd;
        text-decoration: none;
    }

    .text-center a:hover {
        text-decoration: underline;
    }
    </style>
</head>
<body>

    <div class="container">
        <div class="card w-50 mx-auto my-5">
            <div class="card-header text-center">User Login</div>
            <div class="card-body">
                <form action="user-login" method="post">
                    <div class="form-group">
                        <label>Email address</label> 
                        <input type="email" name="login-email" class="form-control" placeholder="Enter email">
                    </div>
                    <div class="form-group">
                        <label>Password</label> 
                        <input type="password" name="login-password" class="form-control" placeholder="Password">
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary">Login</button>
                    </div>
                </form>
                <p class="mt-3 text-center">New user? <a href="register.jsp">Register here</a></p>
            </div>
        </div>
    </div>

</body>
</html>
