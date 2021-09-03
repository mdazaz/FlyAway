package com.dao;
import com.dto.Flight;
import com.dto.Traveller;

import java.util.List;

import javax.persistence.TypedQuery;

	import org.hibernate.Session;
	import org.hibernate.SessionFactory;
	import org.hibernate.Transaction;
	import org.hibernate.boot.Metadata;
	import org.hibernate.boot.MetadataSources;
	import org.hibernate.boot.registry.StandardServiceRegistry;
	import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
	import org.hibernate.criterion.Restrictions;


	 
	public class TravellerDaoImpl implements TravellerDAO{
		//constructor
		private SessionFactory factory;
		public TravellerDaoImpl() {
	        StandardServiceRegistry ssr = new StandardServiceRegistryBuilder().configure("hibernate.cfg.xml").build();  
	        Metadata meta = new MetadataSources(ssr).getMetadataBuilder().build();  
	        factory = meta.getSessionFactoryBuilder().build();

	    }
	
		@Override
		public Integer addTraveller(Traveller traveller) {
			Integer Id=null;
			Session session=factory.openSession();
			Transaction txn=session.beginTransaction();
			Id=(Integer) session.save(traveller);
			txn.commit();
			session.close();
			return Id;
		}

   	@Override
		public void updateTraveller(Integer ID, Traveller traveller) {
			Session session=factory.openSession();
			Transaction txn=session.beginTransaction();
			//1.Fatching Traveller Row from db and get it into object
			Traveller traveller1=session.get(Traveller.class, ID);
			
			//2.Modify the object attribute with new value	
			traveller1.setName(traveller.getName());			
			traveller1.setGender(traveller.getGender());
			traveller1.setAge(traveller.getAge());
			traveller1.setPhone(traveller.getPhone());
			traveller1.setAddress(traveller.getAddress());
			//3.Save back the object into database		
			session.update(traveller1);
			txn.commit();
			session.close();	
			
		}

		@Override
		public void deleteTraveller(Integer ID) {
			Session session=factory.openSession();
			Transaction txn=session.beginTransaction();
			//1.Fatching Employee Row from db and get it into object
			Traveller traveller1=session.get(Traveller.class, ID);
			
			//2.Delete the record				
			session.delete(traveller1);
			txn.commit();
			session.close();
		}

		@Override
		public List<Traveller> listTravellers() {
			List <Traveller> travellers=null;
			
			Session session=factory.openSession();
			Transaction txn=session.getTransaction();
			String hql="FROM Traveller";
			TypedQuery<Traveller> query=session.createQuery(hql);
			
			travellers=query.getResultList();
			return travellers;
		}

		@Override
		public Traveller searchTravellerById(Integer ID) {
			Session session=factory.openSession();
			Transaction txn=session.beginTransaction();
			//1.Fatching Traveller Row from db and get it into object
			Traveller traveller1=session.get(Traveller.class, ID);
			return traveller1;
		}
	}


