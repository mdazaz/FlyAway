package com.dto;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name="flights")
public class Flight {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="ID")
	private int id;	
	
	@Column(name="FLIGHT_ID")
	private String flightId;
	
	public String getFlightId() {
		return flightId;
	}

	public void setFlightId(String flightId) {
		this.flightId = flightId;
	}
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="DEP_DATETIME")
	private Date dep_datetime;
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="ARR_DATETIME")
	private Date arr_datetime;
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="ACTUAL_DATETIME")
	private Date actual_datetime;
	
	@Column(name="PRICE")
	private float price;
	
	@Column (name="CAPACITY")
	private Integer capacity;
	
	@Column(name="STATUS")
	private String status;
	
	@Column(name="FROM_AIRPORT")
	private String from_airport;
	
	@Column(name="TO_AIRPORT")
	private String to_airport;
	
	@ManyToOne (cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST,CascadeType.REFRESH})
	@JoinColumn(name="airline_id")
	private Airline airline;
	
	//Relationship with Booking 
	@OneToMany (mappedBy = "flight",cascade = CascadeType.ALL)
	private List <Booking> bookings;
	
	
	public List<Booking> getBookings() {
		return bookings;
	}

	public void setBookings(List<Booking> bookings) {
		this.bookings = bookings;
	}

	public void add(Booking tempBooking) {
		
		if (bookings == null) {
			bookings = new ArrayList<>();
		}
		
		//bookings.add(tempBooking);
		
		tempBooking.setFlight(this);
	}
	//End
	
	public Airline getAirline() {
		return airline;
	}
	public void setAirline(Airline airline) {
		this.airline = airline;
	}
	public Flight() {};
	
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	public Date getDep_datetime() {
		return dep_datetime;
	}
	public void setDep_datetime(Date dep_datetime) {
		this.dep_datetime = dep_datetime;
	}
	public Date getArr_datetime() {
		return arr_datetime;
	}
	public void setArr_datetime(Date arr_datetime) {
		this.arr_datetime = arr_datetime;
	}
	
	
	public Date getActual_datetime() {
		return actual_datetime;
	}

	public void setActual_datetime(Date actual_datetime) {
		this.actual_datetime = actual_datetime;
	}

	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	public Flight(Date dep_datetime, Date arr_datetime, Date actual_datetime, float price, Integer capacity,
			String from_airport, String to_airport,String status) {
		super();
		this.dep_datetime = dep_datetime;
		this.arr_datetime = arr_datetime;
		this.actual_datetime = actual_datetime;
		this.price = price;
		this.capacity = capacity;
		this.status = status;
		this.from_airport = from_airport;
		this.to_airport = to_airport;
	}
	public Integer getCapacity() {
		return capacity;
	}
	public void setCapacity(Integer capacity) {
		this.capacity = capacity;
	}
	public String getFrom_airport() {
		return from_airport;
	}
	public void setFrom_airport(String from_airport) {
		this.from_airport = from_airport;
	}
	public String getTo_airport() {
		return to_airport;
	}
	public void setTo_airport(String to_airport) {
		this.to_airport = to_airport;
	}
	
	
}
