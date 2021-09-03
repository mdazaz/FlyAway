package com.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.UserDAO;
import com.dao.UserDaoImpl;
import com.dto.User;

/**
 * Servlet implementation class LoginServlet
 */
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String userName = request.getParameter("userName");
        String password = request.getParameter("password");
        
        HttpSession session = request.getSession(true);
        try {
            UserDAO userDAO = new UserDaoImpl();
            User foundUser=userDAO.getUser( userName, password);
            if (foundUser!=null)
            {
            	session.setAttribute("fname",foundUser.getFname() );
            	session.setAttribute("lname",foundUser.getLname() );
            	session.setAttribute("userId",foundUser.getId() );
            	session.setAttribute("role","user" );
            	response.sendRedirect("Home.jsp");
            }
            else
            {
            	
            	response.sendRedirect("Login.jsp?invalidLogin=true");
            }
        } catch (Exception e) {
 
            e.printStackTrace();
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
