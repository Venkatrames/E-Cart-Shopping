<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="cn.techtutorial.dao.ProductDao" %>
<%@ page import="cn.techtutorial.connection.DbCon" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="/includes/head.jsp" %>
    <title>Add Product</title>
<style>
        /* Background with constant Violet, Indigo, and Blue shades */
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #4B0082, #483D8B, #1E90FF); /* Violet, Indigo, Blue */
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        /* Form container with stylish glassmorphism effect */
        .container {
            background: rgba(255, 255, 255, 0.15); /* Semi-transparent white */
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(10px); /* Glassmorphism effect */
            max-width: 450px;
            color: white;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 26px;
            font-weight: bold;
        }

        .form-group label {
            font-weight: bold;
        }

        .form-control {
            border-radius: 10px;
            border: none;
            padding: 12px;
            background: rgba(255, 255, 255, 0.2);
            color: white;
        }

        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        .form-control:focus {
            background: rgba(255, 255, 255, 0.3);
            outline: none;
            border: 2px solid #FFD700;
        }

        .btn-custom {
            background: #FFD700; /* Gold */
            color: #4B0082; /* Violet */
            border-radius: 50px;
            font-weight: bold;
            padding: 12px;
            width: 100%;
            transition: 0.3s ease-in-out;
        }

        .btn-custom:hover {
            background: #FFA500; /* Orange */
            color: white;
        }

        .btn-secondary {
            background: transparent;
            color: white;
            border: 2px solid white;
            border-radius: 50px;
            padding: 12px;
            width: 100%;
            transition: 0.3s ease-in-out;
        }

        .btn-secondary:hover {
            background: white;
            color: #4B0082;
        }

    </style>
</head>
<body>

    <div class="container">
        <h2 class="text-center mb-4">Add New Product</h2>
        <form action="AddProductServlet" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label>Product Name</label>
                <input type="text" name="name" class="form-control" required>
            </div>
            <div class="form-group">
                <label>Category</label>
                <input type="text" name="category" class="form-control" required>
            </div>
            <div class="form-group">
                <label>Price</label>
                <input type="number" step="0.01" name="price" class="form-control" required>
            </div>
            <div class="form-group">
                <label>Product Image</label>
                <input type="file" name="image" class="form-control" required>
            </div>
            <div class="text-center">
                <button type="submit" class="btn btn-custom">Add Product</button>
                <a href="admin.jsp" class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>

</body>
</html>

