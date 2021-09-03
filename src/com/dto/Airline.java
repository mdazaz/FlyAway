package com.dto;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="airlines")
public class Airline {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="ID")
	private int id;
	@Column(name="NAME")
	private String name;
	@Column(name="LOGO")
	private String logo;
	
	@Column(name="STATUS")
	private int status;
	
	@OneToMany (mappedBy = "airline",cascade = CascadeType.ALL)
	private List <Flight> flights;
	public List<Flight> getFlights() {
		return flights;
	}
	public void setFlights(List<Flight> flights) {
		this.flights = flights;
	}
	public Airline() {}
	public Airline(String name, String logo, int status) {
		this.name = name;
		this.logo = logo;
		this.status = status;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLogo() {
		return logo;
	}
	public void setLogo(String logo) {
		this.logo = logo;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
	// add convenience methods for bi-directional relationship
	
		public void add(Flight tempFlight) {
			
			if (flights == null) {
				flights = new ArrayList<>();
			}
			
			flights.add(tempFlight);
			
			tempFlight.setAirline(this);
		}
}
