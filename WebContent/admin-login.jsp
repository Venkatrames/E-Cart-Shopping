<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: linear-gradient(135deg, #E3FDFD, #FFE6FA); /* Light background outside */
        }

        .login-container {
            background: #222; /* Dark background inside the box */
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.5);
            text-align: center;
            width: 400px;
            color: white;
            transition: transform 0.3s ease-in-out;
        }

        .login-container:hover {
            transform: scale(1.05); /* Smooth hover effect */
        }

        .login-container h2 {
            margin-bottom: 20px;
            font-size: 26px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            text-shadow: 2px 2px 10px rgba(255, 255, 255, 0.2);
        }

        .form-control {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border-radius: 5px;
            border: none;
            background: #333; /* Dark field background */
            color: white;
            font-size: 16px;
        }

        .form-control:focus {
            outline: none;
            border: 2px solid #6C5CE7;
        }

        .btn-login {
            background: #6C5CE7;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 5px;
            width: 100%;
            cursor: pointer;
            font-size: 18px;
            font-weight: 600;
            transition: 0.3s;
        }

        .btn-login:hover {
            background: #4834d4;
        }

        .error {
            color: #ff6b6b;
            font-weight: 500;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<div class="login-container">
    <h2>Admin Login</h2>
    <form action="admin-login" method="post">
        <input type="email" name="email" class="form-control" placeholder="Email" required>
        <input type="password" name="password" class="form-control" placeholder="Password" required>
        <button type="submit" class="btn-login">Login</button>
    </form>

    <% String error = request.getParameter("error");
        if (error != null) { %>
        <p class="error"><%= error %></p>
    <% } %>
</div>

</body>
</html>

