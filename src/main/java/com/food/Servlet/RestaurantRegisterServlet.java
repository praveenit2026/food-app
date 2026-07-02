package com.food.Servlet;

import com.food.DAO.RestaurantDAO;
import com.food.implementation.RestaurantDAOImpl;
import com.food.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/restaurant/register")
public class RestaurantRegisterServlet extends HttpServlet {
    private RestaurantDAO restaurantDAO;

    @Override
    public void init() throws ServletException {
        restaurantDAO = new RestaurantDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/restaurant_register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String cuisineType = req.getParameter("cuisineType");
        String address = req.getParameter("address");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        int eta = 30; // default

        try {
            String etaStr = req.getParameter("eta");
            if (etaStr != null && !etaStr.trim().isEmpty()) {
                eta = Integer.parseInt(etaStr);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        Restaurant r = new Restaurant(0, name, cuisineType, 4.0f, address, eta, email, password);
        boolean success = restaurantDAO.addRestaurant(r);

        if (success) {
            resp.sendRedirect(req.getContextPath() + "/restaurant/login?registrationSuccess=true");
        } else {
            req.setAttribute("errorMessage", "Failed to register restaurant. Email might already exist.");
            req.getRequestDispatcher("/restaurant_register.jsp").forward(req, resp);
        }
    }
}
