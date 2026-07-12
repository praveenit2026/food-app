package com.food.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.food.model.User;
import com.food.util.DBConnection;


public class UserImpl {
	
	private static final String insert = "INSERT INTO users(name,email,password)"
			+" Values(?,?,?)";
	
	public static void addUser(User u) throws SQLException {
		try (Connection con = DBConnection.getConnection();
		     PreparedStatement pstmt = con.prepareStatement(insert)) {
			
			System.out.println("Adding user: " + u.getName());
		    pstmt.setString(1, u.getName());
		    pstmt.setString(2, u.getEamil());
		    pstmt.setString(3, u.getPassword());
		    
		    pstmt.executeUpdate();
		    System.out.println("User added successfully.");
		}
	}
}
