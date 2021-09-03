package com.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.AirportDAO;
import com.dao.AirportDaoImpl;
import com.dto.Airport;

/**
 * Servlet implementation class AirportServlet
 */
public class AirportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String opcode = request.getParameter("operation");
		String Name = request.getParameter("name");
		String City = request.getParameter("city");
		String Country = request.getParameter("country");
		String Code = request.getParameter("code");
		Integer ID = 0;
		if (request.getParameter("id") != null) {
			ID = Integer.parseInt(request.getParameter("id"));
			} 
		Airport airport1 = new Airport(Name, City, Country, Code);
		
		try {
			AirportDAO airportdao = new AirportDaoImpl();
			switch (opcode) {
			case "ADD":
				// New Airport add
				Integer Id = airportdao.addAirport(airport1);
				request.setAttribute("ID", Id);
		        RequestDispatcher rd= request.getRequestDispatcher("Airports.jsp");
		        rd.forward(request, response);
				break;
			case "UPDATE":
				// Update
				airportdao.updateAirport(ID, airport1);
				response.sendRedirect("Airports.jsp");
				break;
			case "DEL":
				// Delete
				airportdao.deleteAirport(ID);
				response.sendRedirect("Airports.jsp");
				break;
			case "GET":
				// Fatch all airport list.
				List<Airport> airports = airportdao.listAirports();
				break;
			case "SEARCH":
				// Search airport
				airport1 = airportdao.searchAirportById(ID);
				break;
			case "SEARCH_BY_ID":
				// Search airport
				airport1 = airportdao.searchAirportById(ID);
				break;
			case "AIRPORT_NAMES":
				// Get airport Names
				List<String> names = airportdao.getAirportNames();
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
