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

import com.dto.Airline;
import com.dto.Airport;

public class AirlineDaoImpl implements AirlineDAO {

	
		private SessionFactory factory;
	    
	    public AirlineDaoImpl() {
	        StandardServiceRegistry ssr = new StandardServiceRegistryBuilder().configure("hibernate.cfg.xml").build();  
	        Metadata meta = new MetadataSources(ssr).getMetadataBuilder().build();  
	        factory = meta.getSessionFactoryBuilder().build();

	    }

	

	@Override
	public Integer addAirline(Airline airline) {
		Integer Id=null;
		Session session=factory.openSession();
		Transaction txn=session.beginTransaction();
		Id=(Integer) session.save(airline);
		txn.commit();
		session.close();
		return Id;
	}

	@Override
	public void updateAirline(Integer ID, Airline airline) {
		Session session=factory.openSession();
		Transaction txn=session.beginTransaction();
		//1.Fatching Employee Row from db and get it into object
		Airline airline1=session.get(Airline.class, ID);
		
		//2.Modify the object attribute with new value		
		airline1.setName(airline.getName());
		airline1.setLogo(airline.getLogo());
		airline1.setStatus(airline.getStatus());		
		//3.Save back the object into database		
		session.update(airline1);
		txn.commit();
		session.close();		
		
	}

	@Override
	public void deleteAirline(Integer ID) {
		Session session=factory.openSession();
		Transaction txn=session.beginTransaction();
		//1.Fatching Employee Row from db and get it into object
		Airline airline1=session.get(Airline.class, ID);
		
		//2.Delete the record				
		session.delete(airline1);
		txn.commit();
		session.close();	
		
	}

	@Override
	public List<Airline> listAirlines() {
		List <Airline> airlines=null;
		
		Session session=factory.openSession();
		Transaction txn=session.getTransaction();
		String hql="FROM Airline";
		TypedQuery<Airline> query=session.createQuery(hql);
		
		airlines=query.getResultList();
		return airlines;
	}

	@Override
	public List<String> getAirlineNames() {
		List <String> names=null;
		
		Session session=factory.openSession();
		Transaction txn=session.getTransaction();
		String hql="SELECT A.name FROM Airline A";
		TypedQuery<String> query=session.createQuery(hql);
		
		names=query.getResultList();
		return names;
	}

	@Override
	public Airline searchAirlineById(Integer ID) {
		Session session=factory.openSession();
		Transaction txn=session.beginTransaction();
		//1.Fatching Employee Row from db and get it into object
		Airline airline1=session.get(Airline.class, ID);
		return airline1;
	}
}
