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

import com.dto.Airport;

public class AirportDaoImpl implements AirportDAO {

	
		private SessionFactory factory;
	    
	    public AirportDaoImpl() {
	        StandardServiceRegistry ssr = new StandardServiceRegistryBuilder().configure("hibernate.cfg.xml").build();  
	        Metadata meta = new MetadataSources(ssr).getMetadataBuilder().build();  
	        factory = meta.getSessionFactoryBuilder().build();

	    }

	

	@Override
	public Integer addAirport(Airport airport) {
		Integer Id=null;
		Session session=factory.openSession();
		Transaction txn=session.beginTransaction();
		Id=(Integer) session.save(airport);
		txn.commit();
		session.close();
		return Id;
	}

	@Override
	public void updateAirport(Integer ID, Airport airport) {
		Session session=factory.openSession();
		Transaction txn=session.beginTransaction();
		//1.Fatching Employee Row from db and get it into object
		Airport airport1=session.get(Airport.class, ID);
		
		//2.Modify the object attribute with new value		
		airport1.setName(airport.getName());
		airport1.setCity(airport.getCity());
		airport1.setCode(airport.getCode());
		airport1.setCountry(airport.getCountry());
		//3.Save back the object into database		
		session.update(airport1);
		txn.commit();
		session.close();		
		
	}

	@Override
	public void deleteAirport(Integer ID) {
		Session session=factory.openSession();
		Transaction txn=session.beginTransaction();
		//1.Fatching Employee Row from db and get it into object
		Airport airport1=session.get(Airport.class, ID);
		
		//2.Delete the record				
		session.delete(airport1);
		txn.commit();
		session.close();	
		
	}

	@Override
	public List<Airport> listAirports() {
		List <Airport> airports=null;
		
		Session session=factory.openSession();
		Transaction txn=session.getTransaction();
		String hql="FROM Airport";
		TypedQuery<Airport> query=session.createQuery(hql);
		
		airports=query.getResultList();
		return airports;
	}

	@Override
	public List<String> getAirportNames() {
		List <String> names=null;
		
		Session session=factory.openSession();
		Transaction txn=session.getTransaction();
		String hql="SELECT A.name FROM Airport A";
		TypedQuery<String> query=session.createQuery(hql);
		
		names=query.getResultList();
		return names;
	}

	@Override
	public Airport searchAirportById(Integer ID) {
		Session session=factory.openSession();
		Transaction txn=session.beginTransaction();
		//1.Fatching Employee Row from db and get it into object
		Airport airport1=session.get(Airport.class, ID);
		return airport1;
	}
}
