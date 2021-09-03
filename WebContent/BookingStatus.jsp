<%@page import="java.util.List"%>
<%@page import="com.dto.Traveller"%>
<%@page import="com.dto.Booking"%>
<%@page import="com.dao.BookingDaoImpl"%>
<%@page import="com.dao.BookingDAO"%>
<%@ page import="com.util.*"%>
<%@ include file="header.jsp"%>

<%
   SendEmail sm=new SendEmail();

      // Now set the actual message      
      String to=request.getParameter("Email");
      String userName=request.getParameter("UserName");
      String booking_id=request.getParameter("Booking_id");
      //String pnr=request.getParameter("pnr");
         //out.println("<br/>pnr: "+pnr);
         
  
to=session.getAttribute("to").toString();
 
      if(to==null){
    	  to="latter2u@gmail.com";
      }
     
%>

<div class="container py-4">
    
     


    <div class="p-5 mb-4 bg-light rounded-3">
      <div class="container-fluid py-5">
       <p class="d-flex align-items-center text-dark text-decoration-none">
      <% BookingDAO bookdao=new BookingDaoImpl();
      if(booking_id!=null)
      {
      	Booking curBooking=bookdao.searchBookingById(Integer.parseInt(booking_id));
      	 String msg=("Hi "+userName+"! <br> Congratulations!!<br/> Your Booking has created Successfully!.<br/> Kindly note the Booking Detailss for future reference:<br/>" +"Booking Id: "+curBooking.getFlight().getFlightId()+"<br/></br>  Thank you & Regards<br/> Mohammad Azaz");
         boolean result=sm.composeMessage(msg, to);
         	if(result)
         	{
         		out.println("<div class='alert alert-success'>Congratulations!! "+userName+" Booking details has been sent Successfully! </div>");
         	}
         	else {
         		out.print("<p class='alert alert-danger'> Email couldn't be sent!</a>");
         	}
         %>
             
      </p>
      <%
      if(result)
   	{
   		out.println("<p class='col-md-8 fs-4'><p>An Email has been sent to your registered email <span style='color:blue'> "+to+"</span> which contains your Booking Details<p>");
   		out.println ("<div class='row'><div class='col-sm-3'><a href='SearchFlight.jsp'><input type='button' class='btn-primary btn-sm' value='Another Booking'></a></div>");
   		out.println ("<div class='col-sm-3'><a href='SearchFlight.jsp'><input type='button' class='btn-primary btn-sm' value='Email Ticket'></a></div>");
   		out.println ("<div class='col-sm-3'><a href='SearchFlight.jsp'><input type='button' class='btn-primary btn-sm' value='Print'></a></div></div>");
   	}
      else {
    	  out.println("<p class='col-md-8 fs-4'><p>Email Couldn't sent to your Booking Details email <p>");
     		out.println ("<a href='SearchFlight.jsp.jsp'></div><button class='btn btn-primary btn-lg' type='button'>Try Again</button></a>");
      }
      %>
      <table class="table table-hover" id="userTable">
      <h3 style="padding-top: 50px; color: #002bff">Booking Details:</h3>
      <%
         
      
      	
    	out.print("<thead><tr><th>Id</th><th>Airline</th><th>Flight</th><th>Amount</th><th>Schedule Dep.</th><th>Schedule Arrival.</th></tr></thead>");
   		out.print("<tbody>");
   		
   			out.print("<tr>");
   			out.print("<td>"+curBooking.getId()+"</td>");
   			out.print("<td> <img src='images/airlines/" + curBooking.getFlight().getAirline().getLogo()
					+ "' width='100px' height='50px'/></td>");   			 
   			out.print("<td>"+curBooking.getFlight().getFlightId()+"</td>");
   			out.print("<td>"+curBooking.getAmount()+"</td>");   			  
   			out.print("<td>"+curBooking.getFlight().getDep_datetime()+"</td>"); 
   			out.print("<td>"+curBooking.getFlight().getArr_datetime()+"</td>"); 
   			out.print("</tr>");   		
   		out.print("</tbody>");
      
      	
   		//out.print("<h2 style='padding-top: 50px; color: #002bff'>Tavellers List</h2>");
   	out.print("<hr/>");
   	
   		out.print("<table class='table table-hover editable' id='travellerTable'>");
   		out.print("<h3 style='padding-top: 50px; color: #002bff'>Travellers Details:</h3>");
   		out.print("<thead><tr><th>Id</th><th>Name</th><th>Age</th><th>Gender</th><th>Phone</th><th>Address</th></thead>");
   		out.print("<tbody>");
   		List <Traveller> travellers=curBooking.getTravellers();
   		for (Traveller t:travellers){
   			out.print("<tr>");
   			out.print("<td>"+t.getId()+"</td>");
   			out.print("<td style='display:none'>"+t.getId()+"<id>");
   			out.print("<td>"+t.getName()+"</td>");   			
   			out.print("<td>"+t.getAge()+"</td>");
   			out.print("<td>"+t.getGender()+"</td>");
   			out.print("<td>"+t.getPhone()+"</td>");
   			out.print("<td>"+t.getAddress()+"</td>");
   			
   			
   			out.print("</tr>");
   		}
   		out.print("</tbody>");
   		out.print("</table>");
   		out.print("<hr/>");
    	}
	
   %>
             
     </table> 
        
      </div>
    </div>	

</body>
</html>