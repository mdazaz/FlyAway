<%@ include file="header.jsp"%>
<section class="login-from pt-4">

	<div class="row mt-5">
		
		<div class="col-md-4 mx-auto">
			<%
				if (session.getAttribute("fname") != null) {
					response.sendRedirect("Home.jsp");
				}

				String invaliLogin = request.getParameter("invalidLogin");

				if (invaliLogin != null && invaliLogin.equals("true")) {
					out.println("<div class='alert alert-danger' role='alert'> User name or Password invalid!! </div>");
				}
			%>
			<div class="form-wrapper">
				<div class="row" >
					<div class="col-md-12">

						<div><h4 style="Display:inline">User Login</h4> <a href="LoginAdmin.jsp"><span style="position:relative; left:7rem; top:-2rem " class="link bg-light"><i class="fa fa-user"></i>Admin Login</span></a></div>

					</div>
				</div>
				<br/>
				<form action="Login" method="post">
					<div class="row">

						<div class="col-md-9">
							<div class="form-group">
								<input type="text" name="userName" class="form-control"
									placeholder="User Name" required>
							</div>
						</div>
						<div class="col-md-9">
							<div class="form-group">
								<input type="password" name="password" class="form-control"
									placeholder="Enter Password" required>
							</div>
						</div>

					</div>
					
					<div class="mt-3">
						<button type="submit" class="btn btn-primary">Login Now</button>
						or <a href="Register.jsp"> Register</a>
					</div>
				</form>
			</div>
		</div>
	</div>

</section>
</body>
</html>