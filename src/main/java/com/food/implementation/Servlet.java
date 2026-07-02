package com.food.implementation;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;



@SuppressWarnings("serial")
public class Servlet extends HttpServlet{
	 @SuppressWarnings("unused")
	@Override
	 protected void doPost(HttpServletRequest req , HttpServletResponse res) throws ServletException, IOException{
		 String name = req.getParameter("name");
		 String password = req.getParameter("pwd");
		
		 PrintWriter out =  res.getWriter();
		 out.println("<h1>Hi "+name+" Welcome to our first JEE Project</h1>");

	 }
	 
}
