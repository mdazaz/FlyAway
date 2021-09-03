package com.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.AdminDAO;
import com.dao.AdminDaoImpl;
import com.dto.Admin;


/**
 * Servlet implementation class LoginServlet
 */
public class AdminLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String userName = request.getParameter("userName");
        String password = request.getParameter("password");
        
        HttpSession session = request.getSession(true);
        try {
            AdminDAO adminDAO = new AdminDaoImpl();
            Admin foundAdmin=adminDAO.getAdmin( userName, password);
            if (foundAdmin!=null)
            {
            	session.setAttribute("name",foundAdmin.getName());
            	session.setAttribute("userName",foundAdmin.getUserName() );
            	session.setAttribute("role", "admin");
            	response.sendRedirect("HomeAdmin.jsp");
            }
            else
            {
            	
            	response.sendRedirect("LoginAdmin.jsp?invalidLogin=true");
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
