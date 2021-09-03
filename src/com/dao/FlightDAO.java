package com.dao;

import java.util.List;

import com.dto.Flight;


public interface FlightDAO {
	public Integer addFlight(Flight flight1);
	public void updateFLight(Integer ID, Flight flight );
    public void deleteFlight(Integer ID);
    public List<Flight> listFlights();
    public List<Flight> searchFlights(String hql);
    public Flight searchFlightById(Integer ID);

}
