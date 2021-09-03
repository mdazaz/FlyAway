package com.admin;
import java.util.Date;

import com.dao.AirlineDAO;
import com.dao.AirlineDaoImpl;
import com.dao.FlightDAO;
import com.dao.FlightDaoImpl;
import com.dto.Airline;
import com.dto.Flight;


public class CreateFlight {

	

	public static void main(String[] args) {
		Date dNow = new Date( );
		Date d_arr=dNow;
		
		
					
			Flight flight1=new Flight(dNow, dNow,d_arr, 7999, 250,"3","4", "Active");
			//Flight flight2=new Flight(dNow, d_arr, 6999, "Active");
			FlightDAO flightdao=new FlightDaoImpl();
			
			AirlineDAO airlinedao=new AirlineDaoImpl();
			
			
			
			Airline airline1=airlinedao.searchAirlineById(10);
			//Airline airline1=new Airline("Spice Jet", "spicejet.png", 1);
			//airlinedao.addAirline(airline1);
			//Airline airline2=new Airline("Air Asia", "airasia.png", 1);
			//airlinedao.addAirline(airline2);
			
			airline1.add(flight1);
			//airline2.add(flight2);
			
						
			Integer flightId=flightdao.addFlight(flight1);
			//Integer flightId2=flightdao.addFlight(flight2);
			
			//airlinedao.deleteAirline(1);
			System.out.println("An airline has been deleted");		
					
	}

}
