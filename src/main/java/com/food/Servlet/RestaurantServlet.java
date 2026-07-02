package com.food.Servlet;

import java.io.IOException;
import java.util.List;

import com.food.DAO.RestaurantDAO;
import com.food.implementation.RestaurantDAOImpl;
import com.food.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/callRestaurantServlet")
public class RestaurantServlet extends  HttpServlet{
    //private RestaurantDAO restaurantDAO;

//    @Override
//    public void init() throws ServletException {
//        restaurantDAO = new RestaurantDAOImpl();
//    }
//	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException , IOException{
//        List<Restaurant> restaurantList = restaurantDAO.getAllRestaurants();
//        req.setAttribute("restaurants", restaurantList);
//        req.getRequestDispatcher("/restaurants.jsp").forward(req, resp);
		
		RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();
		List<Restaurant> restaurantList = restaurantDAO.getAllRestaurants();
		req.setAttribute("restaurants", restaurantList);
		req.getRequestDispatcher("/restaurants.jsp").forward(req, resp);
	}
}
