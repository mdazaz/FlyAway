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
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>FlyAway || Booking you dream destination flights at
	Lowest price</title>
<style type="text/css">
#form-wrapper {
	height: 7rem;
}
</style>
<script type="text/javascript">
	function BookFlight(id) {
		//var result = confirm("Want to Book flight?");
		var no_traveller = document.getElementById("num_traveller").value;
		document.getElementById("flightId").value = id;
		//if (result) {
		//	window.location.href="BookingManagement?flight-id="+id+"&operation=ADD_TRAVELLERS&no_travellers="+no_traveller;
		//}

	}

	$(document).ready(
			function() {
				var today = new Date().toISOString().split('T')[0];
				document.getElementsByName("from_dt")[0].setAttribute('min',
						today);
				document.getElementById("no_travellers").value = localStorage
						.getItem("item1");

				$('#btnSubmit').click(function() {

				});
			});

	$(window).on(
			'beforeunload',
			function() {
				localStorage.setItem("item1", document
						.getElementById("no_travellers").value);
			});
</script>
</head>
<div class="container-md bg-light px-4">
	<h2 style="padding-top: 50px; color: #285980">Flight Search</h2>
	<br />
	<div id="form-wrapper">
		<form method="post" class="bg-info">
			<div class="row tab-content tabing">
			<%
								AirportDaoImpl airportDao = new AirportDaoImpl();
								List<Airport> airports = airportDao.listAirports();
			%>
				
				<ul>
                        <li><a class="active" href="#1"><i class="fa fa-plane" aria-hidden="true"></i> Flight</a>
                        </li>
                         <li><a  href="#2"><i class="fa fa-plane" aria-hidden="true"></i> Flight</a>
                        </li>
                     </ul>
				<div class="col-3">
					<div class="form-group">						
						<input type="datetime-local" class="form-control" name="from_dt"
							id="from_dt" />
					</div>
				</div>

				<div class="col-3">
					<div class="form-group">
						
						<input type="text" class="form-control" min="1" max="1000"
							name="flightId" id="flightId" placeholder="Flight Id" />
					</div>
				</div>

				<div class="col-2">
					<div class="form-group">
						<input type="Submit" class="btn-warning " name="btnSearch"
							value="Search" style="width:7rem;height:2rem">
					</div>
				</div>

			</div>
		</form>
	</div>
	<br />
	<br />
	<table class="table table-hover editable " id="flightTable">
		<%
			String flight_id = request.getParameter("flightId");
			String to_airport = request.getParameter("to_airport");

			String from_dt = request.getParameter("from_dt");			
			FlightDaoImpl flightDao = new FlightDaoImpl();
			List<Flight> flights = null;

			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			if (flight_id != null && from_dt != null) {
				Date to_Dt = (Date) formatter.parse(from_dt);
				to_Dt = new Date(to_Dt.getTime() + (1000 * 60 * 60 * 24));
				String str_To_Dt = DateUtils.formatDate(to_Dt);
				String hql = "FROM Flight F WHERE F.flightId LIKE '%"
						+ flight_id + "%' AND F.dep_datetime >'" + from_dt + "' AND F.dep_datetime <'" + str_To_Dt
						+ "' ORDER BY F.price ASC";
				flights = flightDao.searchFlights(hql);
			}

			//List <Flight> flights=flightDao.listFlights();

			if (flights != null && flights.size() > 0) {

				out.print(
						"<thead><tr><th>Airline</th><th>Flight</th><th>Scheduled Depurture</th><th>Arrival</th><th>Duration</th><th>Actual Time</th><th>Status</th></tr></thead>");
				out.print("<tbody>");
				for (Flight x : flights) {
					////////////////Calculate Flight Duration////////////////////////////////////
					long difference_In_Time = x.getArr_datetime().getTime() - x.getDep_datetime().getTime();
					long difference_In_Seconds = (difference_In_Time / 1000) % 60;

					long difference_In_Minutes = (difference_In_Time / (1000 * 60)) % 60;

					long difference_In_Hours = (difference_In_Time / (1000 * 60 * 60)) % 24;

					long difference_In_Days = (difference_In_Time / (1000 * 60 * 60 * 24)) % 365;

					String duration = difference_In_Hours + " Hr, " + difference_In_Minutes + " min, ";
					///////////////////////////////////
					
					////////////////Calculate Flight Delay /Prepone Time////////////////////////////////////
					 difference_In_Time = x.getActual_datetime().getTime() - x.getDep_datetime().getTime();
					 difference_In_Seconds = (difference_In_Time / 1000) % 60;

					 difference_In_Minutes = (difference_In_Time / (1000 * 60)) % 60;

					 difference_In_Hours = (difference_In_Time / (1000 * 60 * 60)) % 24;

					 difference_In_Days = (difference_In_Time / (1000 * 60 * 60 * 24)) % 365;

					String delay = difference_In_Hours + " Hr, " + difference_In_Minutes + " min, ";
					
					String status="No Update";
					if(difference_In_Hours>0 || difference_In_Minutes >5 )
					{						 
						 status="<span class='bg-danger ' Style='color: white;'> Delayed By "+delay+" </span> ";
					}
					else if(difference_In_Hours <0 || difference_In_Minutes < -2)
					{						 
						 status="<span class='bg-warning ' Style='color: white;'> Preponed By "+delay+" </span> ";
					}
					else {
						 status="<span class='bg-success ' Style='color: white;'> On Time </span> ";
					}
						
					///////////////////////////////////
	
					SimpleDateFormat sdf = new SimpleDateFormat("HH:MM");
					//System.out.println(sdf.format(x.getDep_datetime()));

					out.print("<hr/>");
					out.print("<div class='row'>");
					out.print("<tr style='height:7rem; padding-top:3rem'>");
					out.print("<td> <img src='images/airlines/" + x.getAirline().getLogo()+ "' width='100px' height='50px'/></td>");
					
					out.print("<td style='display:none'>" + x.getAirline().getId() + "</td>");
					out.print("<td>" + x.getFlightId() + "</td>");
					out.print("<td>" + sdf.format(x.getDep_datetime()) + "<br/><span>"
							+ airports.get(Integer.parseInt(x.getFrom_airport()) - 1).getCity() + "</span></td>");
					out.print("<td>" + sdf.format(x.getArr_datetime()) + "<br/><span>"
							+ airports.get(Integer.parseInt(x.getTo_airport()) - 1).getCity() + "</span></td>");
					out.print("<td>" + duration + "<br/><span class='text-success'> <i class='fas fa-fighter-jet'></i>--non stop-->|</span></td>");
					out.print("<td> INR " + sdf.format(x.getActual_datetime()) + "</td>");
					
					out.print("<td>" + status + "</td>");

					out.print("</tr>");
					out.print("</div");

				}
				out.print("</tbody>");
			}
			String ID = request.getParameter("ID");
			if (ID != null) {
				out.print("<div class='alert alert-success' role='alert'>A Record has been added with the id: " + ID
						+ "</div>");
			}
		%>

	</table>
	<br />
	<br />
</div>
</div>
</main>


</body>
</html>