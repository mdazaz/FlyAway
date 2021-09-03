package com.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.AirlineDAO;
import com.dao.AirlineDaoImpl;
import com.dto.Airline;

/**
 * Servlet implementation class AirlineServlet
 */
public class AirlineServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String opcode = request.getParameter("operation");
		String Name = request.getParameter("name");
		String Logo = request.getParameter("logo");
		
		Integer ID = 0;
		Integer Status = 0;
		if (request.getParameter("status") != null) {
			Status = Integer.parseInt(request.getParameter("status"));
			} 
		if (request.getParameter("id") != null) {
			ID = Integer.parseInt(request.getParameter("id"));
			} 
		Airline airline1 = new Airline(Name,Logo, Status);
		
		try {
			AirlineDAO airlinedao = new AirlineDaoImpl();
			switch (opcode) {
			case "ADD":
				// New Airline add
				Integer Id = airlinedao.addAirline(airline1);
				request.setAttribute("ID", Id);
		        RequestDispatcher rd= request.getRequestDispatcher("Airlines.jsp");
		        rd.forward(request, response);
				break;
			case "UPDATE":
				// Update
				airlinedao.updateAirline(ID, airline1);
				response.sendRedirect("Airlines.jsp");
				break;
			case "DEL":
				// Delete
				airlinedao.deleteAirline(ID);
				response.sendRedirect("Airlines.jsp");
				break;
			case "GET":
				// Fatch all airline list.
				List<Airline> airlines = airlinedao.listAirlines();
				break;
			case "SEARCH":
				// Search airline
				airline1 = airlinedao.searchAirlineById(ID);
				break;
			case "SEARCH_BY_ID":
				// Search airline
				airline1 = airlinedao.searchAirlineById(ID);
				break;
			case "AIRLINE_NAMES":
				// Get airline Names
				List<String> names = airlinedao.getAirlineNames();
			default:
				throw new IllegalArgumentException("Unexpected value: " + opcode);
			}

		} catch (Exception e) {

			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
