package com.food.Servlet;

import com.food.DAO.RestaurantDAO;
import com.food.implementation.RestaurantDAOImpl;
import com.food.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/restaurant/login")
public class RestaurantLoginServlet extends HttpServlet {
    private RestaurantDAO restaurantDAO;

    @Override
    public void init() throws ServletException {
        restaurantDAO = new RestaurantDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/restaurant_login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        Restaurant restaurant = restaurantDAO.getRestaurantByEmail(email);

        if (restaurant != null && restaurant.getPassword() != null && restaurant.getPassword().equals(password)) {
            HttpSession session = req.getSession();
            session.setAttribute("loggedInRestaurant", restaurant);
            resp.sendRedirect(req.getContextPath() + "/restaurant/dashboard");
        } else {
            req.setAttribute("errorMessage", "Invalid restaurant credentials.");
            req.getRequestDispatcher("/restaurant_login.jsp").forward(req, resp);
        }
    }
}
