<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="header.jsp"%>
<%@page import="com.dao.AirportDaoImpl"%>
<%@page import="com.dto.Airport"%>
<%@page import="com.dao.FlightDaoImpl"%>
<%@page import="com.dto.Flight"%>
<%@page import="com.util.DateUtils"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%@ include file="header.jsp" %>
<%
if (session.getAttribute("userId") == null) {
	response.sendRedirect("Login.jsp");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>FlyAway || Booking you dream destination flights at
	Lowest price</title>
	
<style type="text/css">



</style>
<script>
	function onPromoApply() {
		key = 'promo';
		ele = document.getElementById('promo');
		val = ele.value;

		insertParam(key, val);

		if (val.trim() == "FLYAWAY"){
			alert("Promo Applied!!");
			var lblPromo=document.getElementById('lblPromo');
			lblPromo.classList.add("bg-success");
			lblPromo.innerText='Promocode applied!!';
			ele.disabled='true'
			console.log(ele);
		}
		else
			alert("Invalid Promo Code");
	}

	function insertParam(key, value) {
		key = encodeURIComponent(key);
		value = encodeURIComponent(value);

		// kvp looks like ['key1=value1', 'key2=value2', ...]
		var kvp = document.location.search.substr(1).split('&');
		let i = 0;

		for (; i < kvp.length; i++) {
			if (kvp[i].startsWith(key + '=')) {
				let pair = kvp[i].split('=');
				pair[1] = value;
				kvp[i] = pair.join('=');
				break;
			}
		}

		if (i >= kvp.length) {
			kvp[kvp.length] = [ key, value ].join('=');
		}

		// can return this or...
		let params = kvp.join('&');
		console.log("params:" + params);
		// reload page with new params
		document.location.search = params;

	}

	$(document).ready(
			function() {
				
				//$('#btnPayConfirm').click(function() {
					//console.log("Payment Successfull");
				//});

			});

	function btnPayConfirm(e) {		
		var validationFailed = false;

		$('#formPayment input, #formPayment select').each(
		// do your validation here ...    		   
		function(index) {
			var input = $(this);
			var x = document.getElementById("errors");
			x.style.display === "none";
			//alert('Type: ' + input.attr('type') + 'Name: ' + input.attr('name') + 'Value: ' + input.val());        
			if (input.val() == '') {
				$(input).addClass('error');
				//alert("Please enter value of " + input.attr('name'))
				//var node = document.createElement("LI");
  				//var textnode = document.createTextNode("For " +input.attr('name') + "the vlaue ="+ input.val()+" is invalid");
  				//node.appendChild(textnode);
  				//x.appendChild(node);
				validationFailed = true;				 
				  if (x.style.display === "none") {
				    x.style.display = "block";
				  }
			}
			else{
				$(input).addClass('is-valid');
			}
		});
		if (!validationFailed) {
			e.preventDefault();			
			$("#PaymentDetailsModal").modal('hide');
			$("#PaymentFinalModal").modal('show');
			
			return false;
		}
		
	}
	
	function btnPayConfirm2(e) {		
		var key = "operation";
		var value = "ADD";
		key = encodeURIComponent(key);
		value = encodeURIComponent(value);

		// kvp looks like ['key1=value1', 'key2=value2', ...]
		var kvp = document.location.search.substr(1).split('&');
		let i = 0;

		for (; i < kvp.length; i++) {
			if (kvp[i].startsWith(key + '=')) {
				let pair = kvp[i].split('=');
				pair[1] = value;
				kvp[i] = pair.join('=');
				break;
			}
		}

		if (i >= kvp.length) {
			kvp[kvp.length] = [ key, value ].join('=');
		}

		// can return this or...
		let params = kvp.join('&');
		// reload page with new params
		//document.location.search = params; 
		
		$('#formPayment input, #formPayment select').each(
		// do your validation here ...    		   
		function(index) {
			var input = $(this);
			       
			if (input.val() == '') {
				$(input).addClass('error');				
			}			
		});		
			e.preventDefault();	
			var total=document.getElementById("txtTotalAmount").value;
			window.location.href = "BookingManagement?" + params+"&amount="+total;
						
			return true;
				
	}
</script>

</head>
<div class="container-md bg-light px-4">
	<div class="row">
		<h2 style="margin-top: 3rem; margin-bottom: 2rem; color: #285980">Booking
			Details</h2>
	</div>

	<div class="row" style="font-family: Arial, Helvetica, sans-serif;">
		<div class="col-md-9">
			<div class="card">
				<div class="card-body">
					<div class="card-header">Flight Details:</div>
					<div class="card-body">
						<%
							AirportDaoImpl airportDao = new AirportDaoImpl();
							List<Airport> airports = airportDao.listAirports();

							String flightId = request.getParameter("flightId");
							String no_travellers = request.getParameter("num_traveller");
							String operation = request.getParameter("operation");

							FlightDaoImpl flightDao = new FlightDaoImpl();
							int ID = 0;
							Flight flight = null;
							if (flightId != null) {
								ID = Integer.parseInt(flightId);
								flight = flightDao.searchFlightById(ID);

								////////////////Calculate Flight Duration////////////////////////////////////
								long difference_In_Time = flight.getArr_datetime().getTime() - flight.getDep_datetime().getTime();
								long difference_In_Seconds = (difference_In_Time / 1000) % 60;

								long difference_In_Minutes = (difference_In_Time / (1000 * 60)) % 60;

								long difference_In_Hours = (difference_In_Time / (1000 * 60 * 60)) % 24;

								long difference_In_Days = (difference_In_Time / (1000 * 60 * 60 * 24)) % 365;

								String duration = difference_In_Hours + " Hr, " + difference_In_Minutes + " min, ";
								///////////////////////////////////

								SimpleDateFormat sdf = new SimpleDateFormat("HH:MM");
								//System.out.println(sdf.format(x.getDep_datetime()));
								out.print("<h5 class='card-title'>"
										+ airports.get(Integer.parseInt(flight.getFrom_airport()) - 1).getCity() + "-------"
										+ airports.get(Integer.parseInt(flight.getTo_airport()) - 1).getCity() + "</span></h5>");
								out.print("<table class='table'>");
								out.print(
										"<thead><tr><th>Airline</th><th>Depurture</th><th>Arrival</th><th>Duration</th><th>Price</th></tr></thead>");
								out.print("<tbody>");

								out.print("<div class='row'>");
								out.print("<tr style='height:7rem; padding-top:3rem'>");
								out.print("<td> <img src='images/airlines/" + flight.getAirline().getLogo()
										+ "' width='100px' height='50px'/></td>");
								//out.print("<td>"+x.getAirline().getName()+"</td>");
								out.print("<td style='display:none'>" + flight.getAirline().getId() + "<id>");
								out.print("<td>" + sdf.format(flight.getDep_datetime()) + "<br/><span>"
										+ airports.get(Integer.parseInt(flight.getFrom_airport()) - 1).getCity() + "</span></td>");
								out.print("<td>" + sdf.format(flight.getArr_datetime()) + "<br/><span>"
										+ airports.get(Integer.parseInt(flight.getTo_airport()) - 1).getCity() + "</span></td>");
								out.print("<td>" + duration + "<br/><span class='text-success'><---non stop--></span></td>");
								out.print("<td> INR " + flight.getPrice() + "</td>");

								out.print("</tr>");
							}
						%>
						</table>
						<a href="SearchFlight.jsp" class="btn bg-warning">Modify</a>
					</div>
				</div>
			</div>
			<div class="card">
				<div class="card-body">
					<div class="card-header">Traveller Details:</div>
					<table class="table table-hover" id="TravellerTable">
						<%
							out.print("<table class='table table-hover ' id='flightTable'>");
							out.print(
									"<thead><tr><th>Sr.No</th><th>Name</th><th>Gender</th><th>Age</th><th>Phone</th><th>Address</th></tr></thead>");
							out.print("<tbody>");
							if (no_travellers != null) {
								for (int i = 1; i <= Integer.parseInt(no_travellers); i++) {
									String var_name = "name" + i;
									String var_gender = "gender" + i;
									String var_age = "age" + i;
									String var_phone = "phone" + i;
									String var_address = "address" + i;
									var_name = request.getParameter(var_name);
									var_gender = request.getParameter(var_gender);
									var_age = request.getParameter(var_age);
									var_phone = request.getParameter(var_phone);
									var_address = request.getParameter(var_address);

									out.print("<div class='row'>");
									out.print("<tr>");
									out.print("<td>" + i + "</td>");
									out.print("<td '>" + var_name + "<id>");
									out.print("<td>" + var_gender + "</td>");
									out.print("<td>" + var_age + "</td>");
									out.print("<td>" + var_phone + "</td>");
									out.print("<td>" + var_address + "</td>");

									out.print("</tr>");
									out.print("</div");

								}
							}
							out.print("</tbody>");
							out.print("</table>");
						%>

					</table>
				</div>
			</div>
		</div>
		<div class="col-sm-3">
			<!-- 2nd Card -->
			<div class="card">
				<h5 class="card-header">Fare Summary</h5>
				<div class="card-body">

					<p class="card-text">
					<ul class="list-group list-group-flush">
						<li class="list-group-item">
							<p class="card-title bold">Base Fare</p> <%
 	float tot_fare = 0;
 	if (flight != null) {
 		float tot_bfare = Float.parseFloat(no_travellers) * flight.getPrice();
 		float tax_otherCharge = (flight.getPrice() * 12) / 100;
 		tot_bfare = tot_bfare - tax_otherCharge;
 		out.print(
 				"<span class='text-muted'>Adult X" + no_travellers + " = &nbsp &nbsp" + tot_bfare + "</span>");
 %>
						</li>
						<li class="list-group-item">Fee & Surcharges <%
							out.print("<span class='text-muted'> = &nbsp &nbsp" + tax_otherCharge + "</span>");
						%>
						</li>

						<%
							String promo = request.getParameter("promo");
								float promo_disc = 0;
								if (promo != null && promo.equalsIgnoreCase("FLYAWAY")) {
									promo_disc = (tot_bfare * 12) / 100;
									out.print("<li class='list-group-item'> Promo discount");
									out.print("<span class='text-muted'> = &nbsp &nbsp" + promo_disc + "</span>");
								}
						%>
						</li>
						<li class="list-group-item">Total Amount<%
							tot_fare = tot_bfare + tax_otherCharge - promo_disc;
								out.print("<span class='h5'> = &nbsp &nbsp" + tot_fare + "</span>");
							}
						%></li>
					</ul>
					</p>
					<button data-bs-toggle='modal' href='#PaymentDetailsModal' class="btn-success">Pay Now</button>
				</div>
			</div>
			<!-- Card end -->


			<!-- 2nd Card -->
			<div class="card">
				<h5 class="card-header">Promotions</h5>
				<div class="card-body">
					<div class="input-group mb-3">
						<input type="text" class="form-control" name='promo' id='promo'
							placeholder="Promo Code">
						<div class="input-group-append">
							<button id='btnPromo' class="btn-sm bg-light" type="button"
								onCLick='onPromoApply();'>Apply</button>
						</div>
					</div>
					<p id="lblPromo"
						style="align: right; margin-left: 15px; position: relative; top: -15px;">
						<small> Use code: FLYAWAY</small>
					</p>


				</div>
			</div>
			<!-- Card end -->
		</div>

	</div>

</div>




</div>
</main>

<!-- Payment Model -->

<div class="modal fade" id="PaymentDetailsModal" aria-hidden="true"
	aria-labelledby="PaymentDetailsModalLabel" tabindex="-1">
	<div class="modal-dialog modal-dialog-centered modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="PaymentDetailsModalLabel">Pay Now</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body"
				style="font-family: Arial, Helvetica, sans-serif;">
				<div class='h3'>Transaction Details</div>
				<hr />
				<p class="lead">
					Total Payment INR:
					<%=tot_fare%>
				</p>
				<form id="formPayment">
				<div class='row'>
				<div id="errors" style="display:none" class='alert alert-danger'>
					One or more Error present in the form input.
				</div>
				</div>
					<div class='row'>
						<div class="card mb-3" style="max-width: 60%;">
							<div class="card-header bg-transparent ">
								<label for="fname">Billing Address </label>
							</div>
							<div class="card-body ">
								<div class="form-control">
									<label for="name"><i class="fa fa-user"></i> Full Name</label>
									<input class="form-control " type="text" id="name" name="name"
										placeholder="John M. Doe" class="form-control is-valid"
										required> <label for="email"><i
										class="fa fa-envelope"></i> Email</label> <input class="form-control"
										type="text" id="email" name="email"
										placeholder="john@example.com"> <label for="adr"><i
										class="fa fa-address-card-o"></i> Address</label> <input
										class="form-control" type="text" id="adr" name="address"
										placeholder="542 W. 15th Street"> <label for="city"><i
										class="fa fa-institution"></i> City</label> <input
										class="form-control" type="text" id="city" name="city"
										placeholder="New York">



									<div class="row g-3">
										<div class="col-sm-7">
											<label for="expyear"> State </label> <input type="text"
												id="expyear" name="expyear" class="form-control"
												placeholder="NY" aria-label="State">
										</div>
										<div class="col-sm">
											<label for="cvv"> Zip </label> <input type="text" id="zip"
												name="zip" placeholder="400001" class="form-control"
												aria-label="ZIP">
										</div>

									</div>

								</div>

							</div>

						</div>


						<div class="card border-success mb-3" style="max-width: 35%;">
							<div class="card-header bg-transparent border-success">
								Accepted Cards
								<div class="icon-container">
									<i class="fa fa-cc-visa fa-2x" style="color: navy;"></i> <i
										class="fa fa-cc-amex fa-2x" style="color: blue;"></i> <i
										class="fa fa-cc-mastercard fa-2x" style="color: red;"></i> <i
										class="fa fa-cc-discover fa-2x" style="color: orange;"></i> <i
										class="fa fa-cc-paypal fa-2x" style="color: indigo;"></i>
								</div>
							</div>
							<div class="card-body">


								<div class="row g-3">
									<div class="col-sm">
										<label for="cname">Name on Card</label> <input type="text"
											id="cname" name="cardname" class="form-control"
											placeholder="John More Doe" required>
									</div>
								</div>


								<div class="row g-3">
									<div class="col-sm">
										<label for="ccnum"> Credit card number </label> <input
											type="text" id="ccnum" name="cardnumber" class="form-control"
											placeholder="1111-2222-3333-4444" aria-label="ccnum" required>
									</div>
								</div>

								<div class="row g-3">
									<div class="col-sm">
										<label for="expmonth">Exp Month</label> <input type="text"
											id="expmonth" name="expmonth" placeholder="September"
											class="form-control" aria-label="expmonth" required>
									</div>

								</div>


								<div class="row g-3">
									<div class="col-sm-7">
										<label for="expyear"> Expiry </label> <input type="text"
											id="expyear" name="expyear" class="form-control"
											placeholder="2021" aria-label="expyear" required>
									</div>
									<div class="col-sm">
										<label for="cvv"> CVV </label> <input type="text" id="cvv"
											name="cvv" placeholder="352" class="form-control"
											aria-label="CVV" required>
									</div>

								</div>




							</div>

						</div>
						<div class="row">
							<div class="d-grid gap-2 col-3 mx-auto">
								<button type="button" class="btn-secondary"
									data-bs-dismiss="modal" aria-label="Cancel">Cancel
									Transaction</button>
							</div>

							<div class="d-grid gap-2 col-6 mx-auto">
								<button class="btn btn-success"
									onClick='return btnPayConfirm(event)'>Make Payment</button>
							</div>

						</div>

					</div>
				</form>
				<div class="modal-footer">
					<p>Secure payment gateway</p>

				</div>
			</div>
		</div>
	</div>
</div>
	<!-- end -->
	
	<!-- Payment Confirmation modal -->
	<div class="modal fade" id="PaymentFinalModal" aria-hidden="true"
	aria-labelledby="PaymentFinalModalLabel" tabindex="-1">
	<div class="modal-dialog modal-dialog-centered modal-md">
		<div class="modal-content">
			<div class="modal-header">
				
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body"
				style="font-family: Arial, Helvetica, sans-serif;">
				<div class='h3'>Transaction Details</div>
				<hr />
				<p class="lead">
					Total Payment INR:
					<%=tot_fare%>
				</p>
				<div>
				<input type="hidden" id="txtTotalAmount" value="<%=tot_fare%>" />
				<div class="card border-success mb-3" style="max-width: 30rem;">
  				<div class="card-header bg-transparent border-success">Varified By VISA<i class="fa fa-cc-visa fa-2x" style="color: navy;"></i></div>
  					<div class="card-body text-success">
   					 <p class="card-text">Please Enter 4 -Digit Card PIN.</p>
    					
    					<input type="number" min='1000' maximun="9999" placeholder="PIN">
  							</div>
  													

						<div class="row">
							<div class="col-3">
								<button  class="btn-sm btn-secondary"
									data-bs-dismiss="modal" aria-label="Cancel">Cancel
									Transaction</button>
							
							</div>
							<div class="col-3">
								<button class="btn-sm btn-success"
									onClick='return btnPayConfirm2(event)'>Make Payment</button>
							</div>

						</div>
					</div>
				</div>
				<div class="modal-footer">
					<p>Secure payment gateway</p>

				</div>
			</div>
		</div>
	</div>
	</div>

 
<!-- Ends -->

	</body>
</html>