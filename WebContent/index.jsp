<%@page import="cn.techtutorial.connection.DbCon"%>
<%@page import="cn.techtutorial.dao.ProductDao"%>
<%@page import="cn.techtutorial.model.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
    request.setAttribute("person", auth);
}
ProductDao pd = new ProductDao(DbCon.getConnection());
List<Product> products = pd.getAllProducts();
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
    /* Outer Background - Stylish and Impressive */
    body {
        font-family: 'Poppins', sans-serif;
        background: linear-gradient(135deg, #1a1a2e, #16213e, #0f3460); /* Dark Gradient */
        background-size: cover;
        height: 100vh;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    /* Product Box - Constant Violet */
    .card {
        background: #8B00FF; /* Constant Violet */
        color: white;
        border-radius: 15px;
        padding: 15px;
        box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.3);
        transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
    }

    .card:hover {
        transform: scale(1.05);
        box-shadow: 0px 15px 35px rgba(0, 0, 0, 0.4);
    }

    .card img {
        border-radius: 10px;
    }

    .card-body {
        text-align: center;
    }

    .btn-dark, .btn-primary {
        border-radius: 50px;
        font-weight: bold;
        transition: 0.3s ease-in-out;
    }

    .btn-dark:hover {
        background: #6a00cc;
        transform: translateY(-3px);
    }

    .btn-primary {
        background: #ff7eb3;
    }

    .btn-primary:hover {
        background: #ff3e80;
        transform: translateY(-3px);
        box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.3);
    }

    /* Footer Section */
    .footer {
        background-color: #2c3e50;
        color: #ffffff;
        padding: 40px 0;
        width: 100%;
        text-align: center;
        position: relative;
        bottom: 0;
    }

    .footer-content {
        display: flex;
        justify-content: space-between;
        max-width: 1200px;
        margin: 0 auto;
        flex-wrap: wrap;
    }

    .footer .points ul {
        list-style-type: none;
    }

    .footer .points ul li {
        margin-bottom: 10px;
    }

    .footer .points ul li a {
        color: #ffffff;
        font-size: 14px;
        text-decoration: none;
        transition: color 0.3s ease;
    }

    .footer .points ul li a:hover {
        color: #f39c12;
    }

    .footer .socials img {
        width: 50px;
        margin-right: 20px;
    }

    .footer p {
        text-align: center;
        margin-top: 20px;
        font-size: 14px;
    }
</style>
</head>
<body>
	<%@include file="/includes/navbar.jsp"%>

	<div class="container mt-4">
		<h2 class="text-center text-light">All Products</h2>
		<div class="row">
			<%
			if (!products.isEmpty()) {
				for (Product p : products) {
			%>
			<div class="col-md-3 my-3">
				<div class="card w-100">
					<img class="card-img-top" src="product-image/<%=p.getImage() %>"
						alt="Product Image">
					<div class="card-body">
						<h5 class="card-title"><%=p.getName() %></h5>
						<h6 class="price">Price: Rs.<%=p.getPrice() %></h6>
						<h6 class="category">Category: <%=p.getCategory() %></h6>
						<div class="mt-3 d-flex justify-content-between">
							<a class="btn btn-dark" href="add-to-cart?id=<%=p.getId()%>">Add to Cart</a> 
							<a class="btn btn-primary" href="order-now?quantity=1&id=<%=p.getId()%>">Buy Now</a>
						</div>
					</div>
				</div>
			</div>
			<%
			}
			} else {
			out.println("<h4 class='text-center text-light'>There are no products available.</h4>");
			}
			%>
		</div>
	</div>

	<%@include file="/includes/footer.jsp"%>
	<footer class="footer">
        <div class="footer-content">
            <div class="points">
                <h3>Company</h3>
                <ul>
                    <li><a href="#">About</a></li>
                    <li><a href="#">Terms of Use</a></li>
                    <li><a href="#">Privacy Policy</a></li>
                </ul>
            </div>
            <div class="points">
                <h3>Learn More</h3>
                <ul>
                    <li><a href="#">FAQs</a></li>
                    <li><a href="#">Help</a></li>
                </ul>
            </div>
            <div class="socials">
                <h3>Follow Us</h3>
                <a href="#"><img src="product-image/facebook.png" alt="Facebook" /></a>
                <a href="#"><img src="product-image/instagram.png" alt="Instagram" /></a>
                <a href="#"><img src="product-image/twitter.png" alt="Twitter" /></a>
            </div>
        </div>
        <p>&copy; 2024 VRshopping. All Rights Reserved.</p>
    </footer>
</body>
</html>