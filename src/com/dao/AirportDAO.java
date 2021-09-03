package com.dao;

import java.util.List;

import com.dto.Airport;

public interface AirportDAO {
	public Integer addAirport(Airport airport);
    public void updateAirport(Integer ID, Airport airport );
    public void deleteAirport(Integer ID);
    public List<Airport> listAirports();
    public List<String> getAirportNames();
    public Airport searchAirportById(Integer ID);

}
