package com.food.implementation;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import com.food.DAO.UserImpl;
import com.food.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class RegisterServlet extends HttpServlet{
	@Override
	 protected void doPost(HttpServletRequest req , HttpServletResponse res) throws ServletException, IOException{
		 
		 String name = req.getParameter("username");
		 String email = req.getParameter("email");
		 String password = req.getParameter("password");
		 
		 User u =  new User(name,email,password);
		 
		 try {
			UserImpl.addUser(u);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
		 PrintWriter out = res.getWriter();
		 out.print("Registration Successfull");
		 
		 
		 
		 

}
}
