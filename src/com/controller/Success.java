package com.controller;

import java.io.IOException;
import java.io.PrintWriter;
 
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 

public class Success extends HttpServlet {
 
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        PrintWriter writer = response.getWriter();
 
        writer.println("" + "" + "<h3>"
                + "A User has  Added Successfully" + "</h3>" + ""
                + "");
    }
    
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException ,IOException {
    	doGet(req, resp);
    };
 
}
