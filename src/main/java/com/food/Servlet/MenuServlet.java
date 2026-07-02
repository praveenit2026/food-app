package com.food.Servlet;

import com.food.DAO.MenuDAO;
import com.food.DAO.RestaurantDAO;
import com.food.implementation.MenuDAOImpl;
import com.food.implementation.RestaurantDAOImpl;
import com.food.model.Menu;
import com.food.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/menu")
public class MenuServlet extends HttpServlet {
    private MenuDAO menuDAO;
    private RestaurantDAO restaurantDAO;

    @Override
    public void init() throws ServletException {
        menuDAO = new MenuDAOImpl();
        restaurantDAO = new RestaurantDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String restaurantIdParam = req.getParameter("restaurantId");
        if (restaurantIdParam != null && !restaurantIdParam.trim().isEmpty()) {
            try {
                int restaurantId = Integer.parseInt(restaurantIdParam);
                List<Menu> menuList = menuDAO.getMenuByRestaurant(restaurantId);
                Restaurant restaurant = restaurantDAO.getRestaurant(restaurantId);
                
                req.setAttribute("menuList", menuList);
                req.setAttribute("restaurant", restaurant);
                req.getRequestDispatcher("/menu.jsp").forward(req, resp);
                return;
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        resp.sendRedirect(req.getContextPath() + "/callRestaurantServlet");
    }
}
