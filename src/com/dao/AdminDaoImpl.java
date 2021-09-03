package com.dao;

import com.dto.Admin;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.boot.Metadata;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.criterion.Restrictions;

public class AdminDaoImpl implements AdminDAO {
	// constructor
	private SessionFactory factory;

	public AdminDaoImpl() {
		StandardServiceRegistry ssr = new StandardServiceRegistryBuilder().configure("hibernate.cfg.xml").build();
		Metadata meta = new MetadataSources(ssr).getMetadataBuilder().build();
		factory = meta.getSessionFactoryBuilder().build();

	}

	@Override
	public Integer addAdmin(Admin admin) {
		Integer Id = null;
		Session session = factory.openSession();
		Transaction txn = session.beginTransaction();
		Id = (Integer) session.save(admin);
		txn.commit();
		session.close();
		return Id;
	}

	@Override
	@SuppressWarnings("deprecation")
	public Admin getAdmin(String userName, String Password) {
		Admin foundAdmin = new Admin();
		Session session = factory.openSession();
		Transaction txn = session.beginTransaction();
		// 1.Fatching User Row from db and get it into object
		List<Admin> admin = session
				.createQuery("FROM Admin a WHERE a.userName ='" + userName + "' AND a.password='" + Password + "'")
				.getResultList();
		// foundAdmin = (Admin) session.createCriteria(Admin.class)
		// .add(Restrictions.and(Restrictions.eq("userName",userName),Restrictions.eq("password",Password))).uniqueResult();
		txn.commit();
		session.close();
		if (!admin.isEmpty())
			foundAdmin = admin.get(0);
		else
			foundAdmin = null;
		return foundAdmin;

	}

}
