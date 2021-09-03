	package com.dao;
import com.dto.Flight;
import com.dto.User;

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


	 
	public class UserDaoImpl implements UserDAO{
		//constructor
		private SessionFactory factory;
		public UserDaoImpl() {
	        StandardServiceRegistry ssr = new StandardServiceRegistryBuilder().configure("hibernate.cfg.xml").build();  
	        Metadata meta = new MetadataSources(ssr).getMetadataBuilder().build();  
	        factory = meta.getSessionFactoryBuilder().build();

	    }
	
		@Override
		public Integer addUser(User user) {
			Integer Id=null;
			Session session=factory.openSession();
			Transaction txn=session.beginTransaction();
			Id=(Integer) session.save(user);
			txn.commit();
			session.close();
			return Id;
		}

   
	    @SuppressWarnings("deprecation")
		public User getUser(String userName, String Password) {
	    	User foundUser=new User();
	    	Session session=factory.openSession();
			Transaction txn=session.beginTransaction();
			//1.Fatching User Row from db and get it into object
			foundUser = (User) session.createCriteria(User.class)				 
		             .add(Restrictions.and(Restrictions.eq("userName",userName),Restrictions.eq("password",Password))).uniqueResult();		
			return foundUser;
			
	    }

		@Override
		public void updateUser(Integer ID, User user) {
			Session session=factory.openSession();
			Transaction txn=session.beginTransaction();
			//1.Fatching Employee Row from db and get it into object
			User user1=session.get(User.class, ID);
			
			//2.Modify the object attribute with new value	
			user1.setFname(user.getFname());
			user1.setLname(user.getLname());
			user1.setGender(user.getGender());
			user1.setCity(user.getCity());
			user1.setCountry(user.getCountry());
			user1.setEmail(user.getEmail());
			user1.setPhone(user.getPhone());
			//3.Save back the object into database		
			session.update(user1);
			txn.commit();
			session.close();	
			
		}

		@Override
		public void deleteUser(Integer ID) {
			Session session=factory.openSession();
			Transaction txn=session.beginTransaction();
			//1.Fatching Employee Row from db and get it into object
			User user1=session.get(User.class, ID);
			
			//2.Delete the record				
			session.delete(user1);
			txn.commit();
			session.close();
		}

		@Override
		public List<User> listUsers() {
			List <User> users=null;
			
			Session session=factory.openSession();
			Transaction txn=session.getTransaction();
			String hql="FROM User";
			TypedQuery<User> query=session.createQuery(hql);
			
			users=query.getResultList();
			return users;
		}

		@Override
		public User getUserById(Integer ID) {
			Session session=factory.openSession();
			Transaction txn=session.beginTransaction();
			//1.Fatching User Row from db and get it into object
			User user1=session.get(User.class, ID);
			
			txn.commit();
			session.close();			
			return user1;
		}
	}


