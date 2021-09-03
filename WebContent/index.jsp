<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ include file="header.jsp" %>
 <%@page import="com.dao.AirportDaoImpl"%>
<%@page import="com.dto.Airport"%>
<%@page import="com.dao.FlightDaoImpl"%>
<%@page import="com.dto.Flight"%>
<%@page import="com.util.DateUtils"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>FlyAway || Booking you dream destination flights at Lowest price</title>
<style type="text/css">
#form-wrapper{
height:7rem;
}

</style>
<script type="text/javascript">
function BookFlight(id){
	//var result = confirm("Want to Book flight?");
	var no_traveller=document.getElementById("num_traveller").value;
	document.getElementById("flightId").value = id;
	//if (result) {
	//	window.location.href="BookingManagement?flight-id="+id+"&operation=ADD_TRAVELLERS&no_travellers="+no_traveller;
	//}
     
}


$(document).ready(function() {
	var today = new Date().toISOString().split('T')[0];
	document.getElementsByName("from_dt")[0].setAttribute('min', today);
	document.getElementById("no_travellers").value = localStorage.getItem("item1");	
	
    $('#btnSubmit').click(function()
    {
    	
    });
});

$(window).on('beforeunload', function() {
    localStorage.setItem("item1",document.getElementById("no_travellers").value);
});
</script> 
</head>
<div class="container-md bg-light px-4">
<h2 style="padding-top: 50px; color:#285980">Flight Search</h2>
	<br />
	<div id="form-wrapper">
		<form method="post" class="bg-info">
			<div class="row tab-content tabing">
						<ul>
                        <li><a class="active" href="#1"><i class="fa fa-plane" aria-hidden="true"></i> Flight</a>
                        </li>
                         <li><a  href="#2"><i class="fa fa-plane" aria-hidden="true"></i> Flight</a>
                        </li>
                     </ul>
				<div class="col-3">
					<div class="form-group">

						<select name="from_airport" id="from_airport" class="form-control">
							<%
								AirportDaoImpl airportDao = new AirportDaoImpl();
								List<Airport> airports = airportDao.listAirports();

								if (airports != null && airports.size() > 0) {
									out.print("<option value=''>--Select Source--</option>");
									for (Airport z : airports) {
										out.print("<option value=" + z.getId() + ">" + z.getName() + "</option>");
									}
								}
							%>
						</select>
					</div>
				</div>

				<div class="col-3">
					<div class="form-group">
						<select name="to_airport"
							id="to_airport" class="form-control">
							<%
								if (airports != null && airports.size() > 0) {
									out.print("<option value=''>--Select Destination--</option>");
									for (Airport z : airports) {
										out.print("<option value=" + z.getId() + ">" + z.getName() + "</option>");
									}
								}
							%>
						</select>
					</div>
				</div>
				<div class="col-3">
					<div class="form-group">
						<input type="datetime-local" class="form-control" name="from_dt"
							id="from_dt" />
					</div>
				</div>

				<div class="col-1">
					<div class="form-group">
						<input type="number" class="form-control" min="1" max="10"
							name="no_travellers" id="no_travellers" placeholder="Passengers" />
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
	<br/><br/>
	<table class="table table-hover editable " id="flightTable">
		<%
		String from_airport=request.getParameter("from_airport");
		String to_airport=request.getParameter("to_airport");
		
		String from_dt=request.getParameter("from_dt");
		String no_traveller=request.getParameter("no_travellers");
		FlightDaoImpl flightDao=new FlightDaoImpl();
		List <Flight> flights=null;
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		if(from_airport !=null && to_airport !=null){
		Date to_Dt = (Date)formatter.parse(from_dt);			
		to_Dt = new Date(to_Dt.getTime() + (1000 * 60 * 60 * 24));
		String str_To_Dt=DateUtils.formatDate(to_Dt);
		String hql= "FROM Flight F WHERE F.from_airport = '"+from_airport+"' AND F.to_airport = '"+to_airport+"' AND F.dep_datetime >'"+from_dt+"' AND F.dep_datetime <'"+str_To_Dt+"' ORDER BY F.price ASC";
		 flights=flightDao.searchFlights(hql);	
		}
   	
   	//List <Flight> flights=flightDao.listFlights();
   	
   	if (flights !=null && flights.size()>0)
   	{
   		
   		out.print("<thead><tr><th>Airline</th><th>Depurture</th><th>Arrival</th><th>Duration</th><th>Price</th><th>Book</th></tr></thead>");
   		out.print("<tbody>");
   		for (Flight x:flights){
   			////////////////Calculate Flight Duration////////////////////////////////////
            long difference_In_Time
                = x.getArr_datetime().getTime() - x.getDep_datetime().getTime();
            long difference_In_Seconds
            = (difference_In_Time
               / 1000)
              % 60;

        long difference_In_Minutes
            = (difference_In_Time
               / (1000 * 60))
              % 60;

        long difference_In_Hours
            = (difference_In_Time
               / (1000 * 60 * 60))
              % 24;
        
        long difference_In_Days
            = (difference_In_Time
               / (1000 * 60 * 60 * 24))
              % 365;
        
       String duration=  difference_In_Hours
                + " Hr, "
                + difference_In_Minutes
                + " min, ";
   			///////////////////////////////////
   			
   			SimpleDateFormat sdf = new SimpleDateFormat("HH:MM");
			//System.out.println(sdf.format(x.getDep_datetime()));
   			
   			out.print("<hr/>");
   			out.print("<div class='row'>");
   			out.print("<tr style='height:7rem; padding-top:3rem'>");
   			out.print("<td> <img src='images/airlines/"+x.getAirline().getLogo()+"' width='100px' height='50px'/></td>");
   			//out.print("<td>"+x.getAirline().getName()+"</td>");
   			out.print("<td style='display:none'>"+x.getAirline().getId()+"<id>");
   			out.print("<td>"+sdf.format(x.getDep_datetime())+"<br/><span>"+airports.get(Integer.parseInt(x.getFrom_airport())-1).getCity()+"</span></td>");
   			out.print("<td>"+sdf.format(x.getArr_datetime())+"<br/><span>"+airports.get(Integer.parseInt(x.getTo_airport())-1).getCity()+"</span></td>");
   			out.print("<td>"+duration+"<br/><span class='text-success'><---non stop--></span></td>");
   			out.print("<td> INR "+x.getPrice()+"</td>");
   			   			  			
   			out.print("<td><input type='button' value='Book Now' class='btn-info' data-bs-toggle='modal' href='#exampleModalToggle' style='border-radius: 100%; color:white;}' name='book' onclick='BookFlight("+x.getId()+")'/></td>");
   			
   			out.print("</tr>");
   			out.print("</div");
   			
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
	<br/><br/>
</div>
</div>
</main>

<!-- Traveller Model -->

<div class="modal fade" id="exampleModalToggle" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered  modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalToggleLabel">Add Travellers </h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
       <form class="form" action="BookingManagement">
        <%
        if(no_traveller!=null)
        {
        for (int i=0;i<Integer.parseInt(no_traveller);i++)
        {
        	out.println("<br/><p>"+(i+1)+".Passenger</p>");
        out.println("<div class='row'>");
        //out.print(i+1+".");
        	out.print("<div class='col-auto'> <div class='form-group'>");
			out.print ("<input type='text' class='form-control' name='name"+(i+1)+"'  placeholder='Name'/>");
			out.print ("</div></div>");
			
			out.print("<div class='col-1'> <div class='form-group'>");
			out.print ("<input type='number' class='form-control' name='age"+(i+1)+"' min='5' max='100' placeholder='Age'/>");
			out.print ("</div></div>");		
			
			out.print("<div class='col-auto'> <div class='form-group'>");
			out.print("<div class='form-check form-check-inline'>");
			 out.print("<input class='form-check-input' type='radio' name='gender"+(i+1)+"' id='inlineRadio1' value='M'>");
             out.print("<label class='form-check-label' for='inlineRadio1'>Male</label>");
              out.print ("</div> <div class='form-check form-check-inline'>");
              out.print("<input class='form-check-input' type='radio' name='gender"+(i+1)+"' id='inlineRadio2' value='F'>");
               out.print("<label class='form-check-label' for='inlineRadio2'>Female</label>");
            out.print("</div></div></div>");
           
			out.print("<div class='col-2'> <div class='form-group'>");
			out.print ("<input type='tel' class='form-control' name='phone"+(i+1)+"'  placeholder='Mobile'/>");
			out.print ("</div></div>");
			
			out.print("<div class='col-3'> <div class='form-group'>");
			out.print ("<input type='textarea' class='form-control' name='address"+(i+1)+"'  placeholder='Address'/>");
			out.print ("</div></div>");
		
        }
        }
       		 out.print("<input name='num_traveller' id='num_traveller' type='hidden' value='"+no_traveller+"'>");
			out.print("<input name='flightId' id='flightId' type='hidden'>");
        %>
       		</div>
			<div class="col-auto">
				<div class="form-group">
					<input type="Submit" class="form-control btn-warning" name="btnSearch" id="btnSubmit"
						class="btn-sm btn-info" value="Search">
				</div>
			</div>
        
        </div>
        </form>
      </div>
      <div class="modal-footer">
        <button class="btn btn-primary" data-bs-target="#exampleModalToggle2" data-bs-toggle="modal" data-bs-dismiss="modal">Submit </button>
      </div>
    </div>
  </div>
</div>
<div class="modal fade" id="exampleModalToggle2" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalToggleLabel2">Modal 2</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        Hide this modal and show the first with the button below.
      </div>
      <div class="modal-footer">
        <button class="btn btn-primary" data-bs-target="#exampleModalToggle" data-bs-toggle="modal" data-bs-dismiss="modal">Back to first</button>
      </div>
    </div>
  </div>
</div>
<!-- a class="btn btn-primary" data-bs-toggle="modal" href="#exampleModalToggle" role="button">Open first modal</a-->
</body>
</html>