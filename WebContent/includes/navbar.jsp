<nav class="navbar navbar-expand-lg navbar-light bg-light">
	<div class="container">
		<a class="navbar-brand" href="index.jsp"><img src="product-image/VRshopping_Cropped.jpg" alt="VRshopping Logo" width="60" height="50" class="rounded-circle d-inline-block align-top me-2">
            <span style="font-size: 2rem; font-weight: bold;">VRshopping</span> 
        </a>

		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
	
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav ml-auto">
			<!-- Contact Us Button (Only for Logged-in Users) -->
                    <li class="nav-item">
                        <a class="nav-link btn btn-info text-white px-3" href="contact.jsp">Contact Us</a>
                    </li>
				<li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
				<li class="nav-item"><a class="nav-link" href="cart.jsp">Cart <span class="badge badge-danger">${cart_list.size()}</span> </a></li>
				
				<%
				if (auth != null) {
				%>
				
				
				<li class="nav-item"><a class="nav-link" href="orders.jsp">Orders</a></li>
				<li class="nav-item"><a class="nav-link" href="log-out">Logout</a></li>
				 
				<%
				} else {
				%>
				<li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
				<%
				}
				%>
			</ul>
		</div>
	</div>
</nav>