package com.dao;

import java.util.List;

import javax.persistence.TypedQuery;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.boot.Metadata;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;

import com.dto.Booking;

public class BookingDaoImpl implements BookingDAO {

	
		private SessionFactory factory;
	    
	    public BookingDaoImpl() {
	        StandardServiceRegistry ssr = new StandardServiceRegistryBuilder().configure("hibernate.cfg.xml").build();  
	        Metadata meta = new MetadataSources(ssr).getMetadataBuilder().build();  
	        factory = meta.getSessionFactoryBuilder().build();

	    }

	
	@Override
	public Integer addBooking(Booking booking) {
		Integer Id=null;
		Session session=factory.openSession();
		Transaction txn=session.beginTransaction();
		Id=(Integer) session.save(booking);
		txn.commit();
		session.close();
		return Id;
			
	}



	@Override
	public List<Booking> listBookings() {
	List <Booking> bookings=null;
		
		Session session=factory.openSession();
		Transaction txn=session.getTransaction();
		String hql="FROM Booking";
		TypedQuery<Booking> query=session.createQuery(hql);
		
		bookings=query.getResultList();
		return bookings;
	}


	@Override
	public void updateBooking(Integer ID, Booking booking) {
		Session session=factory.openSession();
		Transaction txn=session.beginTransaction();
		//1.Fatching Employee Row from db and get it into object
		Booking booking1=session.get(Booking.class, ID);
		
		//2.Modify the object attribute with new value		
		booking1.setFlight(booking.getFlight());
		booking1.setBook_datetime(booking.getBook_datetime());
		//booking1.setTravellers(booking.getTravellers());
		booking1.setUser_id(booking.getUser_id());
		booking1.setAmount(booking.getAmount());
		booking1.setStatus(booking.getStatus());
			
		//3.Save back the object into database		
		session.update(booking1);
		txn.commit();
		session.close();		
	}

	@Override
	public void deleteBooking(Integer ID) {
		Session session=factory.openSession();
		Transaction txn=session.beginTransaction();
		//1.Fatching Employee Row from db and get it into object
		Booking booking1=session.get(Booking.class, ID);
		
		//2.Delete the record				
		session.delete(booking1);
		txn.commit();
		session.close();
	}


	@Override
	public Booking searchBookingById(Integer ID) {
		Session session=factory.openSession();
		Transaction txn=session.beginTransaction();
		//1.Fatching Employee Row from db and get it into object
		Booking booking1=session.get(Booking.class, ID);		
		session.close();
		return booking1;
	}
}
