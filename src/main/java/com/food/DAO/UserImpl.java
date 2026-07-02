package com.food.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.food.model.User;

public class UserImpl {
	
	private static final String url = "jdbc:mysql://localhost:3306/jdbc";
	private static final String user = "root";
	private static final String password = "mysql";
	
	//private static final String query = "SELECT * FROM employee";
	private static final String insert = "INSERT INTO user(name,email,password)"
			+"Values(?,?,?)";
	
	public static void addUser(User u) throws SQLException {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			System.out.println("Driver is Connected");
			
		     Connection con = DriverManager.getConnection(url,user,password);
		    System.out.println("Connected Successfully...");
		    
		    PreparedStatement pstmt = con.prepareStatement(insert);
		    
		    pstmt.setString(1,u.getName());
		    pstmt.setString(2,u.getEamil());
		    pstmt.setString(3,u.getPassword());
		    
		    pstmt.executeUpdate();
		    
		    
		    
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
