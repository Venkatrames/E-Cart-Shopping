<%@ page import="java.util.*" %>
<%@ page import="cn.techtutorial.model.Product" %>
<%@ page import="cn.techtutorial.dao.ProductDao" %>
<%@ page import="cn.techtutorial.connection.DbCon" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    ProductDao productDao = new ProductDao(DbCon.getConnection());
    Product product = productDao.getProductById(id);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="/includes/head.jsp" %>
    <title>Update Product</title>
    <style>
        /* Body Background */
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #4B0082, #483D8B, #1E90FF);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        /* Stylish Form Container */
        .container {
            background: rgba(255, 255, 255, 0.1); /* Glass Effect */
            backdrop-filter: blur(10px);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            max-width: 450px;
            color: white;
        }

        h2 {
            text-align: center;
            font-size: 26px;
            font-weight: 600;
            margin-bottom: 20px;
        }

        label {
            font-weight: 500;
        }

        .form-control {
            border-radius: 10px;
            border: 2px solid rgba(255, 255, 255, 0.4);
            background: rgba(255, 255, 255, 0.2);
            color: white;
        }

        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        /* Button Custom Styling */
        .btn-custom {
            background: #FFD700;
            color: black;
            border-radius: 50px;
            font-weight: bold;
            transition: 0.3s;
        }

        .btn-custom:hover {
            background: #FFA500;
        }

        .btn-secondary {
            border-radius: 50px;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2 class="text-center mb-4">Update Product</h2>
        <form action="UpdateProductServlet" method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="<%= product.getId() %>">
            <div class="form-group">
                <label>Product Name</label>
                <input type="text" name="name" class="form-control" value="<%= product.getName() %>" required>
            </div>
            <div class="form-group">
                <label>Category</label>
                <input type="text" name="category" class="form-control" value="<%= product.getCategory() %>" required>
            </div>
            <div class="form-group">
                <label>Price</label>
                <input type="number" step="0.01" name="price" class="form-control" value="<%= product.getPrice() %>" required>
            </div>
            <div class="form-group">
                <label>Product Image</label>
                <input type="file" name="image" class="form-control">
            </div>
            <div class="text-center">
                <button type="submit" class="btn btn-custom">Update Product</button>
                <a href="admin.jsp" class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>

</body>
</html>

