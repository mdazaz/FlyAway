package com.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.AirlineDAO;
import com.dao.AirlineDaoImpl;
import com.dao.FlightDAO;
import com.dao.FlightDaoImpl;
import com.dto.Airline;
import com.dto.Flight;


/**
 * Servlet implementation class FlightServlet
 */
public class FlightServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public FlightServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String flight_id = request.getParameter("flight_id");
		String Dep_dt = request.getParameter("Dep_dateTime");
		String Act_dt = request.getParameter("Act_dateTime");
		String Arr_dt = request.getParameter("Arr_dateTime");		
		String status = request.getParameter("status");
		String price = request.getParameter("price");
		String capacity = request.getParameter("capacity");
		String from_airport = request.getParameter("from_airport");	
		String to_airport = request.getParameter("to_airport");	
		String opcode = request.getParameter("operation");
		Integer ID = 0;
		Integer air_id = 0;
		
		if (request.getParameter("id") != null) {
			ID = Integer.parseInt(request.getParameter("id"));
			} 
		if (request.getParameter("airline_id") != null) {
			air_id = Integer.parseInt(request.getParameter("airline_id"));
			} 
		
		Date theDep_dt=null;
		Date theArr_dt=null;
		Date theAct_dt=null;
		DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm");
		
		try {
			if(Dep_dt!=null && Arr_dt !=null)
			{
			theDep_dt = (Date)formatter.parse(Dep_dt);
			theArr_dt = (Date)formatter.parse(Arr_dt);
			}
			if( Act_dt!=null)
			{
				theAct_dt = (Date)formatter.parse(Act_dt);
			}
			else
			{
				theAct_dt =(Date)formatter.parse(Dep_dt);
			}
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}		
		
		Flight flight1 = null;
		
		try {
			AirlineDAO airlinedao = new AirlineDaoImpl();			
			// get Airline record
			Airline airline1=airlinedao.searchAirlineById(air_id);
			FlightDAO flightdao=new FlightDaoImpl();
			switch (opcode) {
			case "ADD":				
				flight1 = new Flight(theDep_dt, theArr_dt,theDep_dt, Float.parseFloat(price),Integer.parseInt(capacity),from_airport,to_airport, status);
				//add flight to Airline record
				if(flight_id!=null) {
					flight1.setFlightId(flight_id);
				}
				airline1.add(flight1);				
				Integer Id=flightdao.addFlight(flight1);
				request.setAttribute("ID", Id);
		        RequestDispatcher rd= request.getRequestDispatcher("Flights.jsp");
		        rd.forward(request, response);
				break;
			case "UPDATE":
				// Update
				flight1 = new Flight(theDep_dt, theArr_dt,theAct_dt,  Float.parseFloat(price),Integer.parseInt(capacity),from_airport,to_airport, status);
				if(flight_id!=null) {
					flight1.setFlightId(flight_id);
				}
				airline1.add(flight1);							
				flightdao.updateFLight(ID, flight1);
				response.sendRedirect("Flights.jsp");
				break;
			case "DEL":
				// Delete
				flightdao.deleteFlight(ID);
				response.sendRedirect("Flights.jsp");
				break;
			case "GET":
				// Fatch all airline list.
				List<Flight> flights = flightdao.listFlights();
				break;
				
			case "SEARCH":
				String hql= "FROM flights F WHERE F.FROM_AIRPORT = '"+from_airport+"' AND F.TO_AIRPORT = '"+to_airport+"'ORDER BY F.PRICE DESC";
				List <Flight> Foundflights=flightdao.searchFlights(hql);
				break;
			/*case "SEARCH_BY_ID":
				// Search airline
				airline1 = airlinedao.searchAirlineById(ID);
				break;
			case "AIRLINE_NAMES":
				// Get airline Names
				List<String> names = airlinedao.getAirlineNames();
				*/
			default:
				throw new IllegalArgumentException("Unexpected value: " + opcode);
			}

		} catch (Exception e) {

			e.printStackTrace();
		}
		//Flight airline1 = new Flight(dep_datetime, arr_datetime, price, status);
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
