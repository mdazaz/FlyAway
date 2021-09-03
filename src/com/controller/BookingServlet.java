package com.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.BookingDAO;
import com.dao.BookingDaoImpl;
import com.dao.FlightDAO;
import com.dao.FlightDaoImpl;
import com.dao.UserDaoImpl;
import com.dto.Booking;
import com.dto.Flight;
import com.dto.Traveller;
import com.dto.User;

/**
 * Servlet implementation class BookingServlet
 */
public class BookingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String flightId = request.getParameter("flightId");
		String no_travellers = request.getParameter("num_traveller");			
		String operation = request.getParameter("operation");
		
		BookingDAO bookingdao=new BookingDaoImpl();		
		FlightDAO flightdao=new FlightDaoImpl();
		
		if (operation.equals("ADD")) {
			String amount = request.getParameter("amount");
		
		Date dNow = new Date( );
		int user_id=0;
		float Amount=Float.parseFloat(amount);
		HttpSession session = request.getSession(true);
		if (session.getAttribute("userId") != null ) {
			 user_id= (int) session.getAttribute("userId");           
	      }
		
		Booking booking1=new Booking(dNow, user_id, Amount,"confirm");
		
		
		Flight flight1=flightdao.searchFlightById(Integer.parseInt(flightId));
		
		flight1.add(booking1);
		
		PrintWriter out =response.getWriter();
		out.print("<table class='table table-hover ' id='flightTable'>");
		out.print("<thead><tr><th>Sr.No</th><th>Name</th><th>Gender</th><th>Age</th><th>Phone</th><th>Address</th></tr></thead>");
   		out.print("<tbody>");
   		
		for (int i=1;i<=Integer.parseInt(no_travellers);i++)
        {
			String var_name="name"+i;
			String var_gender="gender"+i;
			String var_age="age"+i;
			String var_phone="phone"+i;
			String var_address="address"+i;
			var_name=request.getParameter(var_name);
			var_gender=request.getParameter(var_gender);
			var_age=request.getParameter(var_age);
			var_phone=request.getParameter(var_phone);
			var_address=request.getParameter(var_address);
			
			if(var_name==null || var_age==null || var_gender==null)
			{
				return ;
			}
			Traveller traveller=new Traveller(var_name, Integer.parseInt(var_age), var_gender.charAt(0), var_phone, var_address);
			booking1.addTraveller(traveller);
			out.print("<hr/>");
   			out.print("<div class='row'>");
   			out.print("<tr style='height:7rem; padding-top:3rem'>");
   			out.print("<td>"+i+"</td>");   			
   			out.print("<td '>"+var_name+"<id>");
   			out.print("<td>"+var_gender+"</td>");
   			out.print("<td>"+var_age+"</td>");
   			out.print("<td>"+var_phone+"</td>");
   			out.print("<td>"+var_address+"</td>"); 	   			  			
   	
   			out.print("</tr>");
   			out.print("</div");
   			
   		}
		
		int BookingId=bookingdao.addBooking(booking1);
		
		
   		out.print("</tbody>");
   		out.print("</table>");
   		UserDaoImpl userDao=new UserDaoImpl();
   	   	User user=userDao.getUserById(user_id);
   		out.print("<h3> Successfully Booked with the Id "+BookingId+"</h3>");
   		request.setAttribute("Email", user.getEmail());
        request.setAttribute("UserName", user.getUserName());
        
       
         session.setAttribute("to", user.getEmail());
        
        request.setAttribute("Booking_id",BookingId );
        //request.setAttribute("pnr",flightId+flight1.getAirline().getName().charAt(1)+Math.random()*user_id*Math.random() );
        
        RequestDispatcher rd= request.getRequestDispatcher("BookingStatus.jsp?"+"Email="+user.getEmail()+"&UserName="+user.getUserName()+"&Booking_id="+BookingId);
        rd.forward(request, response);
		}
		
		else if (operation.equals("DEL"))
		{
			String Id = request.getParameter("id");
			bookingdao.deleteBooking(Integer.parseInt(Id));
			response.sendRedirect("View_Bookings.jsp");
		}
		
		else if (operation.equals("UPDATE"))
		{
			String Id = request.getParameter("id");
			String Book_dateTime = request.getParameter("Book_dateTime");
			String user_id = request.getParameter("userid");
			String amount = request.getParameter("amount");
			String status = request.getParameter("status");
			int ID=Integer.parseInt(Id);
			int flightid=Integer.parseInt(request.getParameter("flightid"));
			Booking booking1=new Booking();
			
			
			DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm");
			Date Book_dt=null;
			try {
				if(Book_dateTime!=null)
				{
					Book_dt = (Date)formatter.parse(Book_dateTime);				
				}
			} catch (ParseException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}	
			
			booking1.setAmount(Float.parseFloat(amount));
			booking1.setBook_datetime(Book_dt);
			booking1.setStatus(status);
			booking1.setUser_id(Integer.parseInt(user_id));
			Flight flight1=flightdao.searchFlightById(flightid);
			booking1.setFlight(flight1);
			
			bookingdao.updateBooking(ID, booking1);
			response.sendRedirect("View_Bookings.jsp");
			
		}
		
		else
		{
			
		}
   		
    	}
        	

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
