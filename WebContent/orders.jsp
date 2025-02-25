<%@page import="java.text.DecimalFormat"%>
<%@page import="cn.techtutorial.dao.OrderDao"%>
<%@page import="cn.techtutorial.connection.DbCon"%>
<%@page import="cn.techtutorial.dao.ProductDao"%>
<%@page import="cn.techtutorial.model.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%
	DecimalFormat dcf = new DecimalFormat("#.##");
	request.setAttribute("dcf", dcf);
	User auth = (User) request.getSession().getAttribute("auth");
	List<Order> orders = null;
	if (auth != null) {
	    request.setAttribute("person", auth);
	    OrderDao orderDao  = new OrderDao(DbCon.getConnection());
		orders = orderDao.userOrders(auth.getId());
	}else{
		response.sendRedirect("login.jsp");
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
<title>E-Commerce Cart</title>
<style>
    /* Vibrant Background */
    body {
        background: linear-gradient(135deg, #4B0082, #483D8B, #00008B);
        background-attachment: fixed;
        font-family: 'Arial', sans-serif;
        color: #fff;
    }

    /* Orders Container */
    .container {
        background: rgba(255, 255, 255, 0.95);
        border-radius: 15px;
        padding: 20px;
        margin-top: 30px;
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        color: black;
    }

    /* Table Styling */
    .table {
        background: #fff;
        border-radius: 10px;
        overflow: hidden;
    }

    .table thead {
        background: #4B0082;
        color: white;
    }

    .table tbody tr {
        transition: all 0.3s ease-in-out;
    }

    .table tbody tr:hover {
        background: #D8BFD8;
    }

    /* Buttons */
    .btn-danger {
        background: #8B0000;
        color: white;
        transition: 0.3s ease;
    }

    .btn-danger:hover {
        background: #B22222;
        transform: scale(1.1);
    }

    /* Footer */
    .footer {
        background: #191970;
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
	<div class="container">
		<div class="card-header my-3"><h1>All Orders</h1></div>
		<table class="table table-light">
			<thead>
				<tr>
					<th scope="col">Date</th>
					<th scope="col">Name</th>
					<th scope="col">Category</th>
					<th scope="col">Quantity</th>
					<th scope="col">Price</th>
					<th scope="col">Cancel</th>
				</tr>
			</thead>
			<tbody>
			
			<%
			if(orders != null){
				for(Order o:orders){%>
					<tr>
						<td><%=o.getDate() %></td>
						<td><%=o.getName() %></td>
						<td><%=o.getCategory() %></td>
						<td><%=o.getQunatity() %></td>
						<td><%=dcf.format(o.getPrice()) %></td>
						<td><a class="btn btn-sm btn-danger" href="cancel-order?id=<%=o.getOrderId()%>">Cancel Order</a></td>
					</tr>
				<%}
			}
			%>
			
			</tbody>
		</table>
	</div>
	<%@include file="/includes/footer.jsp"%>
</body>
</html>