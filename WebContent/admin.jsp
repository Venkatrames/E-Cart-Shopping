<%@ page import="java.util.*" %>
<%@ page import="cn.techtutorial.model.Product" %>
<%@ page import="cn.techtutorial.dao.ProductDao" %>
<%@ page import="cn.techtutorial.connection.DbCon" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%
    ProductDao productDao = new ProductDao(DbCon.getConnection());
    List<Product> productList = productDao.getAllProducts();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="/includes/head.jsp" %>
    <title>Admin Panel - Manage Products</title>
 <style>
        body {
            background: #FF5733; /* Vibrant Background */
            color: white;
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .container {
            background: #222; /* Dark Box for Contrast */
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
            width: 90%;
            max-width: 900px;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 26px;
            font-weight: 600;
            color: #FFC107; /* Golden Heading */
        }

        .search-box {
            width: 60%;
            border-radius: 5px;
            padding: 10px;
            border: 2px solid #FFC107;
        }

        .btn-custom {
            padding: 10px 15px;
            border-radius: 5px;
            font-weight: bold;
        }

        .btn-add {
            background: #28A745;
            color: white;
        }

        .btn-add:hover {
            background: #218838;
        }

        .table {
            background: #333;
            color: white;
        }

        .table img {
            border-radius: 5px;
        }

        .btn-warning {
            background: #FFC107;
            color: black;
        }

        .btn-danger {
            background: #DC3545;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2 class="text-center mb-4">Admin Panel - Manage Products</h2>

        <!-- Search Bar -->
        <div class="d-flex justify-content-between mb-3">
            <input type="text" id="searchInput" class="form-control search-box" placeholder="Search Products...">
            <a href="add-product.jsp" class="btn btn-custom btn-add">+ Add New Product</a>
        </div>

        <!-- Product Table -->
        <table class="table table-bordered">
            <thead class="thead-dark">
                <tr>
                    <th>ID</th>
                    <th>Image</th>
                    <th>Name</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="productTable">
                <%
                    for (Product p : productList) {
                %>
                <tr>
                    <td><%= p.getId() %></td>
                    <td><img src="product-image/<%= p.getImage() %>?t=<%= System.currentTimeMillis() %>" width="50"></td>
                    <td><%= p.getName() %></td>
                    <td><%= p.getCategory() %></td>
                    <td>Rs.<%= p.getPrice() %></td>
                    <td>
                        <a href="update-product.jsp?id=<%= p.getId() %>" class="btn btn-warning btn-sm btn-custom">Edit</a>
                        <a href="delete-product?id=<%= p.getId() %>" class="btn btn-danger btn-sm btn-custom" onclick="return confirm('Are you sure you want to delete this product?');">Delete</a>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>

    <!-- JavaScript for Dynamic Search -->
    <script>
        document.getElementById("searchInput").addEventListener("keyup", function () {
            let searchValue = this.value.toLowerCase();
            let tableRows = document.querySelectorAll("#productTable tr");

            tableRows.forEach(row => {
                let productName = row.cells[2].textContent.toLowerCase();
                let category = row.cells[3].textContent.toLowerCase();
                if (productName.includes(searchValue) || category.includes(searchValue)) {
                    row.style.display = "";
                } else {
                    row.style.display = "none";
                }
            });
        });
    </script>

</body>
</html>

