package com.dao;

import java.util.List;

import com.dto.Airline;


public interface AirlineDAO {
	public Integer addAirline(Airline airline);
    public void updateAirline(Integer ID, Airline airline );
    public void deleteAirline(Integer ID);
    public List<Airline> listAirlines();
    public List<String> getAirlineNames();
    public Airline searchAirlineById(Integer ID);

}
