package com.dao;

import java.util.List;

import com.dto.Booking;
import com.dto.Booking;


public interface BookingDAO {
	public Integer addBooking(Booking booking1);
	public void updateBooking(Integer ID, Booking booking );
    public void deleteBooking(Integer ID);
    public List<Booking> listBookings();
   // public List<String> getBookingNames();
    public Booking searchBookingById(Integer ID);

}
