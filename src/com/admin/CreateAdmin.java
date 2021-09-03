package com.admin;

import com.dao.AdminDAO;
import com.dao.AdminDaoImpl;
import com.dto.Admin;

public class CreateAdmin {

	public static void main(String[] args) {
		Admin admin1=new Admin("Admin", "admin", "Admin@123", "latter4u@gmail.com", "7201234567");
				AdminDAO admindao=new AdminDaoImpl();
				
				Integer empId=admindao.addAdmin(admin1);
				System.out.println("An Admin User is added with emp id="+empId);
			
	}

}
