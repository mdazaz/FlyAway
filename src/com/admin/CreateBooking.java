package com.admin;

import java.util.Date;

import com.dao.AirlineDAO;
import com.dao.AirlineDaoImpl;
import com.dao.BookingDAO;
import com.dao.BookingDaoImpl;
import com.dao.FlightDAO;
import com.dao.FlightDaoImpl;
import com.dto.Airline;
import com.dto.Booking;
import com.dto.Flight;
import com.dto.Traveller;


public class CreateBooking {

	

	public static void main(String[] args) {
		Date dNow = new Date( );
		
		Integer user_id=2;
		Float amt=(float) 10000.99;
		
		
			Booking booking1=new Booking(dNow, user_id,amt,"Confirm" );
			
			BookingDAO bookingdao=new BookingDaoImpl();
			
			FlightDAO flightdao=new FlightDaoImpl();
			
			
			
			Flight flight1=flightdao.searchFlightById(3);
			//Airline airline1=airlinedao.searchAirlineById(1);
			//Airline airline1=new Airline("Spice Jet", "spicejet.png", 1);
			//airlinedao.addAirline(airline1);
			//Airline airline2=new Airline("Air Asia", "airasia.png", 1);
			//airlinedao.addAirline(airline2);
			
			flight1.add(booking1);		
			//airline1.add(flight1);
			//airline2.add(flight2);
			
			//create travellers
			
			Traveller traveller1=new Traveller("Azaz", 30, 'M', "7208642888", "Koremangla Bangalore 560029");
			
			Traveller traveller2=new Traveller("Savita", 20, 'F', "7208642890", "Koremangla Bangalore 560030");
			
			booking1.addTraveller(traveller1);
			booking1.addTraveller(traveller2);
			
			bookingdao.addBooking(booking1);
						
			//Integer flightId=flightdao.addFlight(flight1);
			//Integer flightId2=flightdao.addFlight(flight2);
			
			//airlinedao.deleteAirline(1);
			System.out.println("An airline has been deleted");		
					
	}

}
