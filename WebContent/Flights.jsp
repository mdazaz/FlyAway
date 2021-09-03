<%@page import="com.util.DateUtils"%>
<%@page import="com.dao.AirportDaoImpl"%>
<%@page import="com.dto.Airport"%>
<%@page import="com.dto.Airline"%>
<%@page import="com.dao.AirlineDaoImpl"%>
<%@page import="com.dto.Flight"%>
<%@page import="com.dao.FlightDaoImpl"%>
<%@ page import="java.util.List"%>
<%@ include file="header.jsp"%>
<%
if(null == session.getAttribute("role")){  
	  // User is not logged in.
	response.sendRedirect("LoginAdmin.jsp");
	}else{  
	  // User IS logged in. 
	  if (!session.getAttribute("role").equals("admin")) {
	response.sendRedirect("LoginAdmin.jsp");
	}
	}

%>
<style>
#add {
	display: block;
}
</style>
<script type="text/javascript">
	function addFlight() {
		var x = document.getElementById("frmAdd");
		var btn = document.getElementById("btnAdd")
		if (x.style.display === "none") {
			x.style.display = "block";
			btn.value = "Hide Add Form";
		} else {
			x.style.display = "none";
			btn.value = "Add New Flight";
		}
	}
	function EditFlight(el) {
		var activeRow = el.parentNode.parentNode.rowIndex;
		var tab = document.getElementById("flightTable").rows[activeRow];
		var id = tab.getElementsByTagName("TD")[0].innerText;
		var flightid = tab.getElementsByTagName("TD")[1].innerText;
		var name = tab.getElementsByTagName("TD")[2].innerText;
		var airline_id = tab.getElementsByTagName("TD")[3].innerText;
		var dep_dateTime = tab.getElementsByTagName("TD")[4].innerText;
		var act_dateTime = tab.getElementsByTagName("TD")[5].innerText;
		var arr_dateTime = tab.getElementsByTagName("TD")[6].innerText;
		var price = tab.getElementsByTagName("TD")[7].innerText;
		var status = tab.getElementsByTagName("TD")[8].innerText;
		var capacity = tab.getElementsByTagName("TD")[9].innerText;
		var from_airport = tab.getElementsByTagName("TD")[10].innerText;
		var to_airport = tab.getElementsByTagName("TD")[11].innerText;

		document.getElementById("name").value = airline_id;
		moment(new Date()).format('YYYY-MM-DDTHH:mm')
		document.getElementById("Dep_dateTime").value = moment(dep_dateTime).format('YYYY-MM-DDTHH:mm');
		document.getElementById("Act_dateTime").value = moment(act_dateTime).format('YYYY-MM-DDTHH:mm');
		document.getElementById("Arr_dateTime").value = moment(arr_dateTime).format('YYYY-MM-DDTHH:mm');;
		document.getElementById("price").value = price;
		document.getElementById("status").value = status;
		document.getElementById("capacity").value = capacity;
		document.getElementById("from_airport").value = from_airport;
		document.getElementById("to_airport").value =to_airport;
		document.getElementById("flight_id").value =flightid;
		
		document.getElementById("operation").value = "UPDATE";
		document.getElementById("btnSubmit").value = "UPDATE";

		var input = document.createElement("input");
		input.setAttribute("type", "hidden");
		input.setAttribute("name", "id");
		input.setAttribute("value", id);

		//append to form element id as a hidden field .
		document.getElementById("frmAdd").appendChild(input);

	}

	function deleteFlight(id) {
		var result = confirm("Want to delete?");
		if (result) {
			window.location.href = "FlightManagement?id=" + id
					+ "&operation=DEL";
		}

	}

	$(document).ready(function() {

	});

	$(window).on("load", function() {
		// console.log( "window loaded" );
	});
</script>

<div class="container-md bg-light px-4">

<a href='HomeAdmin.jsp'><i class='fa fa-home fa-2x' style="float: right; margin-top:10px"></i></a>
	<h2 style="padding-top: 50px; color: #002bff">Flight List</h2>
	<br />
	<table class="table table-hover editable" id="flightTable">
		<%
   	FlightDaoImpl flightDao=new FlightDaoImpl();
   	List <Flight> flights=flightDao.listFlights();
   	
   	if (flights.size()>0)
   	{
   		out.print("<thead><tr><th>Id</th><th>Flight Id</th><th>Airline</th><th>Depurture</th><th>Actual Dep</th><th>Arrival</th><th>Price</th><th>Status*</th><th>Capacity</th><th>From</th><th>TO</th><th>Edit</th><th>Delete</th></tr></thead>");
   		out.print("<tbody>");
   		for (Flight x:flights){
   			out.print("<tr>");
   			out.print("<td>"+x.getId()+"</td>");
   			out.print("<td>"+x.getFlightId()+"</td>");
   			out.print("<td>"+x.getAirline().getName()+"</td>");
   			out.print("<td style='display:none'>"+x.getAirline().getId()+"<id>");
   			out.print("<td>"+DateUtils.formatDate(x.getDep_datetime())+"</td>");
   			out.print("<td>"+x.getActual_datetime()+"</td>");
   			out.print("<td>"+x.getArr_datetime()+"</td>");
   			out.print("<td>"+x.getPrice()+"</td>");
   			out.print("<td>"+x.getStatus()+"</td>");
   			out.print("<td>"+x.getCapacity()+"</td>");
   			out.print("<td>"+x.getFrom_airport()+"</td>");
   			out.print("<td>"+x.getTo_airport()+"</td>");
   			
   			out.print("<td><input type='button' value='Edit' name='edit'onclick='EditFlight(this)'/></td>");
   			out.print("<td><input type='button' value='Delete' name='delete'onclick='deleteFlight("+x.getId()+")'/></td>");
   			out.print("</tr>");
   		}
   		out.print("</tbody>");
    	}
    String ID=request.getParameter("ID");
    if(ID!=null)
    {
    	out.print("<div class='alert alert-success' role='alert'>A Record has been added with the id: "+ID+"</div>");
    }
   %>

	</table>
	<input type="button" id="btnAdd" value="Add New Flight"
		onclick="addFlight();" />
	<hr />

	<form id="frmAdd" class="form" action="FlightManagement" method="post">
		<div class="row">
			<div class="col-md-2">
				<div class="form-group">
				<select name="airline_id" class="form-select"id="name">
				<%
				AirlineDaoImpl airlineDao=new AirlineDaoImpl();
			   	List <Airline> airlines=airlineDao.listAirlines();
   	
   				if (airlines !=null && airlines.size()>0)
   				{
   					for (Airline y:airlines){
   			   			out.print("<option value="+y.getId()+">"+y.getName()+"</option>");
   					}
   				}
					
				%>
				</select>
				</div>
			</div>
			<div class="col-sm-1">
				<div class="form-group" >
					<input type="text" name="flight_id" id="flight_id" class="form-control"
						placeholder="Flight Id">
				</div>
			</div>
			<div class="col-md-3">
				<div class="form-group" style="margin-left:5rem">
					<input type="datetime-local" name="Dep_dateTime" id="Dep_dateTime"
						placeholder="Depurture date/time" class="form-control">
				</div>
			</div>
			<div class="col-md-2">
				<div class="form-group">
					<input type="datetime-local" name="Act_dateTime" id="Act_dateTime"
						placeholder="Actual date/time" class="form-control">
				</div>
			</div>
			<div class="col-md-3">
				<div class="form-group">
					<input type="datetime-local" name="Arr_dateTime" id="Arr_dateTime"
						placeholder="Arrival date/time" class="form-control">
				</div>
			</div>	
			</div>
			<div class="row">		
			<div class="col-md-2">
				<div class="form-group">
					<input type="number" name="price" id="price" class="form-control"
						placeholder="price">
				</div>
			</div>
			<div class="col-md-2">
				<div class="form-group">
					<input type="text" name="status" id="status" class="form-control"
						placeholder="Status">
				</div>
			</div>
			<div class="col-md-2">
				<div class="form-group">
					<input type="text" name="capacity" id="capacity" class="form-control"
						placeholder="Capacity">
				</div>
			</div>
			<div class="col-md-3">
				<div class="form-group">
				
				<select name="from_airport" class="form-select" id="from_airport">
				<%
				AirportDaoImpl airportDao=new AirportDaoImpl();
			   	List <Airport> airports=airportDao.listAirports();
   	
   				if (airports !=null && airports.size()>0)
   				{
   					for (Airport z:airports){
   			   			out.print("<option value="+z.getId()+">"+z.getName()+"</option>");
   					}
   				}
					
				%>
				</select>
				</div>
			</div>
			
			<div class="col-md-2">
				<div class="form-group">
				
				<select name="to_airport" class="form-select" id="to_airport">
				<%				   	
   				if (airports !=null && airports.size()>0)
   				{
   					for (Airport z:airports){
   			   			out.print("<option value="+z.getId()+">"+z.getName()+"</option>");
   					}
   				}
					
				%>
				</select>
				</div>
			</div>
						
			<div>
				<div class="form-group">
					<input type="hidden" name="operation" id="operation"
						class="form-control" value="ADD">
				</div>
			</div>
			<hr />
			<div>
				<div class="form-group">
					<input type="Submit" name="btnAdd" id="btnSubmit"
						class="btn btn-primary" value="Add">
				</div>
			</div>
		</div>

	</form>
</div>

</body>
<link rel="stylesheet" type="text/css"
	href="bootstrap-5.1.0-dist/datepicker/jquery.datetimepicker.css" />
<script src="bootstrap-5.1.0-dist/datepicker/jquery.js"></script>
<script src="bootstrap-5.1.0-dist/datepicker/jquery.datetimepicker.js"></script>
<script src="js/moment-with-locales.min.js"></script>
</html>