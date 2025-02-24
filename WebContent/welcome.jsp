<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to E-Commerce</title>
    <style>
        /* Background Animation with VIBGYOR Colors */
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(-45deg, violet, indigo, blue, green, yellow, orange, red);
            background-size: 400% 400%;
            animation: vibgyorBG 8s linear infinite;
            text-align: center;
            color: white;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        @keyframes vibgyorBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* Content Box with Constant Background */
        .container {
            max-width: 550px;
            padding: 30px;
            background: rgba(255, 255, 255, 0.95); /* Soft White for Contrast */
            border-radius: 15px;
            box-shadow: 0px 8px 25px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s ease-in-out;
            animation: fadeIn 1.5s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: scale(0.8); }
            to { opacity: 1; transform: scale(1); }
        }

        .container:hover {
            transform: scale(1.05);
        }

        /* Vibrant Gradient Text */
        h1 {
            font-size: 40px;
            margin: 10px 0;
            font-weight: bold;
            background: linear-gradient(90deg, #ff7eb3, #ff758c, #f857a6, #8a2387);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        p {
            font-size: 20px;
            margin-bottom: 20px;
            font-weight: bold;
            color: #333; /* Dark text for better contrast */
        }

        /* Stylish Buttons */
        .btn {
            display: inline-block;
            padding: 14px 30px;
            margin: 15px;
            font-size: 18px;
            font-weight: bold;
            text-decoration: none;
            color: white;
            border: none;
            border-radius: 50px;
            transition: 0.3s ease-in-out;
            background: linear-gradient(to right, #ff7eb3, #ff758c, #f857a6);
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.3);
            cursor: pointer;
        }

        .btn:hover {
            background: linear-gradient(to right, #f857a6, #ff758c, #ff7eb3);
            transform: translateY(-4px);
            box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.4);
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>Welcome to Our</h1> 
        <h1>E-Commerce Platform</h1>
        <p>Shop the best products with ease and comfort.</p>
        <a href="login.jsp" class="btn">Login</a>
        <a href="register.jsp" class="btn">Register</a>
    </div>

</body>
</html>

