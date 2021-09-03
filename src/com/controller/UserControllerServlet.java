package com.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.UserDAO;
import com.dao.UserDaoImpl;
import com.dto.User;

/**
 * Servlet implementation class UserControllerServlet
 */
public class UserControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			String fname = request.getParameter("fname");
			String lname = request.getParameter("lname");	
			String userName = request.getParameter("userName");
	        String password = request.getParameter("password");
	        String email = request.getParameter("email");
	        String phone = request.getParameter("phone");
	        String city = request.getParameter("city");	
	        String country = request.getParameter("country");	        	        
	        String opcode = request.getParameter("operation");			
			Integer ID = 0;
			char gender=0;
			
			if (request.getParameter("gender")!= null) {
				 gender  = request.getParameter("gender").charAt(0);
				} 
			if (request.getParameter("id") != null) {
				ID = Integer.parseInt(request.getParameter("id"));
				} 
			User user1 = new User(fname, lname, userName, password, email, phone, city, country, gender);
			
			try {
				UserDAO userDao=new UserDaoImpl();
				switch (opcode) {
				case "ADD":
					// New Airport add					      	
		        	
		            Integer Id=userDao.addUser(user1);
		            System.out.println("A user is added with the Id " +Id);
		            request.setAttribute("email", user1.getEmail());
		            request.setAttribute("userName", user1.getUserName());
		            request.setAttribute("pwd", user1.getPassword());
		            RequestDispatcher rd= request.getRequestDispatcher("SendMail.jsp");
		            rd.forward(request, response);
					break;
				case "UPDATE":
					// Update
					userDao.updateUser(ID, user1);
					response.sendRedirect("Users.jsp");
					break;
				case "OWN_PROFILE_UPDATE":
					// Update
					userDao.updateUser(ID, user1);
					response.sendRedirect("User_Profile.jsp");
					break;
				case "DEL":
					// Delete
					userDao.deleteUser(ID);
					response.sendRedirect("Users.jsp");
					break;
				case "GET":
					// Fatch all airport list.
					List<User> users = userDao.listUsers();
					break;

				default:
					throw new IllegalArgumentException("Unexpected value: " + opcode);
				}
			}
	        	        
	       catch (Exception e) {
	 
	            e.printStackTrace();
	        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
