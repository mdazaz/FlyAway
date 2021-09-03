package com.dao;

import java.util.List;

import javax.persistence.TypedQuery;
import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.boot.Metadata;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;


import com.dto.Flight;

public class FlightDaoImpl implements FlightDAO {

	
		private SessionFactory factory;
	    
	    public FlightDaoImpl() {
	        StandardServiceRegistry ssr = new StandardServiceRegistryBuilder().configure("hibernate.cfg.xml").build();  
	        Metadata meta = new MetadataSources(ssr).getMetadataBuilder().build();  
	        factory = meta.getSessionFactoryBuilder().build();

	    }

	
	@Override
	public Integer addFlight(Flight flight) {
		Integer Id=null;
		Session session=factory.openSession();
		Transaction txn=session.beginTransaction();
		Id=(Integer) session.save(flight);
		txn.commit();
		session.close();
		return Id;
			
	}



	@Override
	public List<Flight> listFlights() {
	List <Flight> flights=null;
		
		Session session=factory.openSession();
		Transaction txn=session.getTransaction();
		String hql="FROM Flight";
		TypedQuery<Flight> query=session.createQuery(hql);
		
		flights=query.getResultList();
		session.close();
		return flights;
	}


	@Override
	@Transactional
	public void updateFLight(Integer ID, Flight flight) {
		Session session=factory.openSession();
		Transaction txn=session.beginTransaction();
		//1.Fatching Flight Row from db and get it into object
		Flight flight1=session.get(Flight.class, ID);
		
		//2.Modify the object attribute with new value		
		flight1.setAirline(flight.getAirline());
		flight1.setArr_datetime(flight.getArr_datetime());
		flight1.setDep_datetime(flight.getDep_datetime());
		flight1.setActual_datetime(flight.getActual_datetime());
		flight1.setPrice(flight.getPrice());
		flight1.setStatus(flight.getStatus());
		flight1.setCapacity(flight.getCapacity());
		flight1.setFrom_airport(flight.getFrom_airport());
		flight1.setTo_airport(flight.getTo_airport());
		flight1.setFlightId(flight.getFlightId());
		
		//3.Save back the object into database		
		session.update(flight1);
		txn.commit();
		session.close();		
	}

	@Override
	public void deleteFlight(Integer ID) {
		Session session=factory.openSession();
		Transaction txn=session.beginTransaction();
		//1.Fatching Employee Row from db and get it into object
		Flight flight1=session.get(Flight.class, ID);
		
		//2.Delete the record				
		session.delete(flight1);
		txn.commit();
		session.close();
	}


	@Override
	@Transactional
	public Flight searchFlightById(Integer ID) {
		Session session=factory.openSession();
		Transaction txn=session.beginTransaction();
		//1.Fatching Employee Row from db and get it into object
		Flight flight1=session.get(Flight.class, ID);
		session.close();
		return flight1;
	}


	@Override
	public List<Flight> searchFlights(String hql) {
		
		List <Flight> flights=null;
		Session session=factory.openSession();
		Transaction txn=session.getTransaction();		
		TypedQuery<Flight> query=session.createQuery(hql);
		
		flights=query.getResultList();
		session.close();
		return flights;
		
	}
}
