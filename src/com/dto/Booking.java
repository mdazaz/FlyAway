package com.dto;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
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
@Table(name="Bookings")
public class Booking {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="ID")
	private int id;	
	@Temporal(TemporalType.TIMESTAMP)	
	@Column(name="BOOKING_DATETIME")
	private Date book_datetime;
	
	@Column(name="USER_ID")
	private Integer user_id;
	
	@Column(name="AMOUNT")
	private Float amount;
	
	@Column(name="STATUS")
	private String status;
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@OneToMany(fetch=FetchType.EAGER,cascade = CascadeType.ALL)
	@JoinColumn (name="booking_id")	
	private List <Traveller> travellers;
	
	@ManyToOne (fetch=FetchType.EAGER,cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST,CascadeType.REFRESH})
	@JoinColumn(name="flight_id")
	private Flight flight;
	//private Float amount;
	//private Integer transaction_id;
	//private Integer user_id;
	//private Integer flight_id;
	//private Integer no_traveller;	
	
	public void addTraveller(Traveller tempTraveller) {
		if (travellers == null)
		{
			travellers = new ArrayList<Traveller>();
		}
		travellers.add(tempTraveller);
	}

	public Booking() {}
	
	

	public Booking(Date book_datetime, Integer user_id, Float amount, String status) {
		super();
		this.book_datetime = book_datetime;
		this.user_id = user_id;
		this.amount = amount;
		this.status=status;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Date getBook_datetime() {
		return book_datetime;
	}

	public void setBook_datetime(Date book_datetime) {
		this.book_datetime = book_datetime;
	}

	public Integer getUser_id() {
		return user_id;
	}

	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}

	public Float getAmount() {
		return amount;
	}

	public void setAmount(Float amount) {
		this.amount = amount;
	}

	public List<Traveller> getTravellers() {
		return travellers;
	}

	public void setTravellers(List<Traveller> travellers) {
		this.travellers = travellers;
	}

	public Flight getFlight() {
		return flight;
	}

	public void setFlight(Flight flight) {
		this.flight = flight;
	}

}
