<%@page import="cn.techtutorial.connection.DbCon"%>
<%@page import="cn.techtutorial.dao.ProductDao"%>
<%@page import="cn.techtutorial.model.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
DecimalFormat dcf = new DecimalFormat("#.##");
request.setAttribute("dcf", dcf);
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
    request.setAttribute("person", auth);
}
ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
List<Cart> cartProduct = null;
if (cart_list != null) {
	ProductDao pDao = new ProductDao(DbCon.getConnection());
	cartProduct = pDao.getCartProducts(cart_list);
	double total = pDao.getTotalCartPrice(cart_list);
	request.setAttribute("total", total);
	request.setAttribute("cart_list", cart_list);
}
%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/includes/head.jsp"%>
<title>E-Commerce Cart</title>
<style>
    /* Vibrant Page Background */
   body {
        background: linear-gradient(135deg, #1e3c72, #2a5298); /* Deep Blue Gradient */
        background-attachment: fixed;
        font-family: 'Arial', sans-serif;
        color: #ffffff; /* White text for contrast */
    }

    /* Cart Container */
    .container {
        background: rgba(255, 255, 255, 0.95);
        border-radius: 15px;
        padding: 20px;
        margin-top: 30px;
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        color: #333333; /* Dark text for readability */
    }

    /* Table Styling */
    .table {
        background: #ffffff;
        border-radius: 10px;
        overflow: hidden;
    }

    .table thead {
        background: #ff9800; /* Vibrant Orange */
        color: white;
    }

    .table tbody tr {
        transition: all 0.3s ease-in-out;
    }

    .table tbody tr:hover {
        background: #ffcc80; /* Light Orange Hover */
    }

    /* Buttons */
    .btn-incre, .btn-decre, .btn-primary {
        background: #ff9800;
        border: none;
        color: white;
        font-size: 18px;
        padding: 5px 10px;
        transition: 0.3s ease;
    }

    .btn-incre:hover, .btn-decre:hover, .btn-primary:hover {
        background: #e65100;
        transform: scale(1.1);
    }

    .btn-danger {
        background: #d32f2f;
        color: white;
        transition: 0.3s ease;
    }

    .btn-danger:hover {
        background: #b71c1c;
        transform: scale(1.1);
    }

    /* Footer */
    .footer {
        background: #2c3e50;
        color: white;
        padding: 20px 0;
        text-align: center;
        margin-top: 50px;
        border-radius: 10px 10px 0 0;
    }
</style>
</head>
<body>
	<%@include file="/includes/navbar.jsp"%>

	<div class="container my-3">
		<div class="d-flex py-3"><h3>Total Price: Rs. ${(total>0)?dcf.format(total):0} </h3> <a class="mx-3 btn btn-primary" href="cart-check-out">Check Out</a></div>
		<table class="table table-light">
			<thead>
				<tr>
					<th scope="col">Name</th>
					<th scope="col">Category</th>
					<th scope="col">Price</th>
					<th scope="col">Buy Now</th>
					<th scope="col">Cancel</th>
				</tr>
			</thead>
			<tbody>
				<%
				if (cart_list != null) {
					for (Cart c : cartProduct) {
				%>
				<tr>
					<td><%=c.getName()%></td>
					<td><%=c.getCategory()%></td>
					<td><%= dcf.format(c.getPrice())%></td>
					<td>
						<form action="order-now" method="post" class="form-inline">
						<input type="hidden" name="id" value="<%= c.getId()%>" class="form-input">
							<div class="form-group d-flex justify-content-between">
								<a class="btn bnt-sm btn-incre" href="quantity-inc-dec?action=inc&id=<%=c.getId()%>"><i class="fas fa-plus-square"></i></a> 
								<input type="text" name="quantity" class="form-control"  value="<%=c.getQuantity()%>" readonly> 
								<a class="btn btn-sm btn-decre" href="quantity-inc-dec?action=dec&id=<%=c.getId()%>"><i class="fas fa-minus-square"></i></a>
							</div>
							<button type="submit" class="btn btn-primary btn-sm">Buy</button>
						</form>
					</td>
					<td><a href="remove-from-cart?id=<%=c.getId() %>" class="btn btn-sm btn-danger">Remove</a></td>
				</tr>

				<%
				}}%>
			</tbody>
		</table>
	</div>

	<%@include file="/includes/footer.jsp"%>
</body>
</html>