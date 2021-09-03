<%@page import="com.dto.Traveller"%>
<%@page import="com.dto.Flight"%>
<%@page import="com.dao.FlightDAO"%>
<%@page import="com.dto.User"%>
<%@page import="com.dao.UserDaoImpl"%>
<%@page import="com.dao.BookingDaoImpl"%>
<%@page import="com.dao.AirportDaoImpl"%>
<%@page import="com.dto.Airport"%>
<%@page import="com.dto.Booking"%>
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

function viewTravellers(){
	 var bookingid = document.getElementById("bookingid").value;
	 //alert (bookingid);
	 window.location.href = "View_Bookings.jsp?Booking_id="+bookingid;
	 
	
}
	
	function EditBooking(el) {		
		var activeRow = el.parentNode.parentNode.rowIndex;
		var tab = document.getElementById("bookingTable").rows[activeRow];
		tab.classList.add("bg-info");
		var id = tab.getElementsByTagName("TD")[0].innerText;
		var flightid = tab.getElementsByTagName("TD")[1].innerText;		
		var userid = tab.getElementsByTagName("TD")[3].innerText;
		var amount = tab.getElementsByTagName("TD")[4].innerText;
		var book_dateTime = tab.getElementsByTagName("TD")[5].innerText;
		var status = tab.getElementsByTagName("TD")[6].innerText;
		console.log("id"+id);
		console.log("flightid: "+flightid);
		console.log("userid: "+userid);console.log("amount"+amount);console.log("book_dateTime"+book_dateTime);
		console.log("status"+status);
		document.getElementById("flightid").value = flightid;
		moment(new Date()).format('YYYY-MM-DDTHH:mm')
		document.getElementById("Book_dateTime").value = moment(book_dateTime).format('YYYY-MM-DDTHH:mm');		
		document.getElementById("amount").value = amount;
		document.getElementById("status").value = status;
		document.getElementById("userid").value = userid;
		
		
		document.getElementById("operation").value = "UPDATE";
		document.getElementById("btnSubmit").value = "UPDATE";
		var travellersDiv=document.getElementById("travellerDiv");
		//if (travellersDiv.style.display === "block") {
			travellersDiv.style.display = "none";
		 // }
		var input = document.createElement("input");
		input.setAttribute("type", "hidden");
		input.setAttribute("name", "id");
		input.setAttribute("id", "bookingid");
		input.setAttribute("value", id);

		//append to form element id as a hidden field .
		document.getElementById("frmAdd").appendChild(input);

	}

	function deleteBooking(id) {
		var result = confirm("Want to delete?");
		if (result) {
			window.location.href = "BookingManagement?id=" + id
					+ "&operation=DEL";
		}

	}

	$(document).ready(function() {

	});

	$(window).on("load", function() {
		// console.log( "window loaded" );
	});
	
	function EditTraveller(el){	
		var activeRow = el.parentNode.parentNode.rowIndex;
		var tab = document.getElementById("bookingTable").rows[activeRow];
		var id = tab.getElementsByTagName("TD")[0].innerText;
	}
</script>

<div class="container-md bg-light px-4">
<a href='HomeAdmin.jsp'><i class='fa fa-home fa-2x' style="float: right; margin-top:10px"></i></a>
	<h2 style="padding-top:20px; color: #002bff">Booking List</h2>
	<br />
	<table class="table table-hover editable" id="bookingTable">
		<%
   	BookingDaoImpl bookingDao=new BookingDaoImpl();
   	List <Booking> bookings=bookingDao.listBookings();
   	
   	if (bookings.size()>0)
   	{
   		out.print("<thead><tr><th>Id</th><th>Flight ID</th><th>User_Id</th><th>Amount</th><th>Booking Time</th><th>Status</th><th>Select</th><th>Delete</th></tr></thead>");
   		out.print("<tbody>");
   		for (Booking x:bookings){
   			out.print("<tr>");
   			out.print("<td>"+x.getId()+"</td>");
   			out.print("<td>"+x.getFlight().getId()+"</td>");
   			out.print("<td style='display:none'>"+x.getFlight().getId()+"<id>");
   			out.print("<td>"+x.getUser_id()+"</td>");
   			out.print("<td>"+x.getAmount()+"</td>");
   			out.print("<td>"+x.getBook_datetime()+"</td>");
   			out.print("<td>"+x.getStatus()+"</td>");
   			
   			
   			out.print("<td><input type='button' value='Select' name='edit'onclick='EditBooking(this)'/></td>");
   			out.print("<td><input type='button' value='Delete' name='delete'onclick='deleteBooking("+x.getId()+")'/></td>");
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
	<input type="button" id="btnViewTravellers" value="View Travellers"
		onclick="viewTravellers();" />
	<hr />

	<form id="frmAdd" class="form" action="BookingManagement" method="post">
		<div class="row">
			<div class="col-md-2">
				<div class="form-group">
				<select name="flightid" class="form-select" id="flightid">
				<%
				FlightDAO flightDao=new FlightDaoImpl();
			   	List <Flight> flights=flightDao.listFlights();
   	
   				if (flights !=null && flights.size()>0)
   				{
   					for (Flight f:flights){
   			   			out.print("<option value="+f.getId()+">"+f.getFlightId()+"</option>");
   					}
   				}
					
				%>
				</select>				
				
				</div>
			</div>
			<div class="col-md-2">
				<div class="form-group">
				
				<select name="userid" class="form-select" id="userid">
				<%
				UserDaoImpl userDao=new UserDaoImpl();
			   	List <User> users=userDao.listUsers();
   	
   				if (users !=null && users.size()>0)
   				{
   					for (User z:users){
   			   			out.print("<option value="+z.getId()+">"+z.getUserName()+"</option>");
   					}
   				}
					
				%>
				</select>
				</div>
			</div>		
			
			<div class="col-md-2">
				<div class="form-group">
					<input type="text" name="amount" id="amount" class="form-control"
						placeholder="Amount">
				</div>
			</div>
			<div class="col-md-3">
				<div class="form-group">
					<input type="datetime-local" name="Book_dateTime" id="Book_dateTime"
						placeholder="Depurture date/time">
				</div>
			</div>
			
				
			<div class="col-md-2">
				<div class="form-group">
				
				<select name="status" class="form-select" id="status">
				<option value="confirm" >confirm</option>
				<option value="cancel" >cancel</option>
				<option value="pending" >pending</option>			
   				
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

  <div id="travellerDiv">
		<%
	
	String strBookingId=request.getParameter("Booking_id");
			
	if(strBookingId!=null){
		int bookingid=Integer.parseInt(strBookingId);
   	List <Traveller> travellers=bookingDao.searchBookingById(bookingid).getTravellers();
   	
   	if (bookings.size()>0)
   	{
   		//out.print("<h2 style='padding-top: 50px; color: #002bff'>Tavellers List</h2>");
   	
   		out.print("<table class='table table-hover editable' id='bookingTable'>");
   		out.print("<thead><tr><th>Id</th><th>Name</th><th>Age</th><th>Gender</th><th>Phone</th><th>Address</th><th>Select</th><th>Delete</th></tr></thead>");
   		out.print("<tbody>");
   		for (Traveller t:travellers){
   			out.print("<tr>");
   			out.print("<td>"+t.getId()+"</td>");
   			out.print("<td style='display:none'>"+t.getId()+"<id>");
   			out.print("<td>"+t.getName()+"</td>");   			
   			out.print("<td>"+t.getAge()+"</td>");
   			out.print("<td>"+t.getGender()+"</td>");
   			out.print("<td>"+t.getPhone()+"</td>");
   			out.print("<td>"+t.getAddress()+"</td>");
   			
   			
   			out.print("<td><input type='button' value='Select' name='edit'onclick='EditTraveller(this)'/></td>");
   			out.print("<td><input type='button' value='Delete' name='delete'onclick='deleteTraveller("+t.getId()+")'/></td>");
   			out.print("</tr>");
   		}
   		out.print("</tbody>");
   		out.print("</table>");
   		out.print("<hr/>");
    	}
	}
   %>
</div>
	
</div>
</body>
<link rel="stylesheet" type="text/css"
	href="bootstrap-5.1.0-dist/datepicker/jquery.datetimepicker.css" />
<script src="bootstrap-5.1.0-dist/datepicker/jquery.js"></script>
<script src="bootstrap-5.1.0-dist/datepicker/jquery.datetimepicker.js"></script>
<script src="js/moment-with-locales.min.js"></script>
</html>