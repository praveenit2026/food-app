package com.food.Servlet;

import com.food.DAO.MenuDAO;
import com.food.DAO.OrderDAO;
import com.food.DAO.RestaurantDAO;
import com.food.implementation.MenuDAOImpl;
import com.food.implementation.OrderDAOImpl;
import com.food.implementation.RestaurantDAOImpl;
import com.food.model.Menu;
import com.food.model.Order;
import com.food.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/restaurant/dashboard")
public class RestaurantDashboardServlet extends HttpServlet {
    private MenuDAO menuDAO;
    private OrderDAO orderDAO;
    private RestaurantDAO restaurantDAO;

    @Override
    public void init() throws ServletException {
        menuDAO = new MenuDAOImpl();
        orderDAO = new OrderDAOImpl();
        restaurantDAO = new RestaurantDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loggedInRestaurant") == null) {
            resp.sendRedirect(req.getContextPath() + "/restaurant/login");
            return;
        }

        Restaurant r = (Restaurant) session.getAttribute("loggedInRestaurant");
        int restaurantId = r.getRestaurantId();

        List<Menu> menuList = menuDAO.getMenuByRestaurant(restaurantId);
        List<Order> orderList = orderDAO.getOrdersByRestaurant(restaurantId);

        req.setAttribute("menuList", menuList);
        req.setAttribute("orderList", orderList);

        req.getRequestDispatcher("/restaurant_dashboard.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loggedInRestaurant") == null) {
            resp.sendRedirect(req.getContextPath() + "/restaurant/login");
            return;
        }

        Restaurant r = (Restaurant) session.getAttribute("loggedInRestaurant");
        int restaurantId = r.getRestaurantId();
        String action = req.getParameter("action");

        if ("add_menu".equals(action)) {
            String name = req.getParameter("name");
            String description = req.getParameter("description");
            double price = Double.parseDouble(req.getParameter("price"));
            boolean isAvailable = req.getParameter("isAvailable") == null || Boolean.parseBoolean(req.getParameter("isAvailable"));
            String imagePath = req.getParameter("imagePath");

            Menu item = new Menu(restaurantId, name, description, price, isAvailable, imagePath);
            menuDAO.addMenu(item);
            resp.sendRedirect(req.getContextPath() + "/restaurant/dashboard?success=add_menu");

        } else if ("edit_menu".equals(action)) {
            int menuId = Integer.parseInt(req.getParameter("menuId"));
            String name = req.getParameter("name");
            String description = req.getParameter("description");
            double price = Double.parseDouble(req.getParameter("price"));
            boolean isAvailable = req.getParameter("isAvailable") != null && req.getParameter("isAvailable").equals("true");
            String imagePath = req.getParameter("imagePath");

            Menu existingMenu = menuDAO.getMenu(menuId);
            if (existingMenu != null && existingMenu.getRestaurantId() == restaurantId) {
                existingMenu.setName(name);
                existingMenu.setDescription(description);
                existingMenu.setPrice(price);
                existingMenu.setAvailable(isAvailable);
                existingMenu.setImagePath(imagePath);
                menuDAO.updateMenu(existingMenu);
            }
            resp.sendRedirect(req.getContextPath() + "/restaurant/dashboard?success=edit_menu");

        } else if ("delete_menu".equals(action)) {
            int menuId = Integer.parseInt(req.getParameter("menuId"));
            Menu existingMenu = menuDAO.getMenu(menuId);
            if (existingMenu != null && existingMenu.getRestaurantId() == restaurantId) {
                menuDAO.deleteMenu(menuId);
            }
            resp.sendRedirect(req.getContextPath() + "/restaurant/dashboard?success=delete_menu");

        } else if ("update_order_status".equals(action)) {
            int orderId = Integer.parseInt(req.getParameter("orderId"));
            String status = req.getParameter("status");
            Order order = orderDAO.getOrder(orderId);
            if (order != null && order.getRestaurantId() == restaurantId) {
                orderDAO.updateOrderStatus(orderId, status);
            }
            resp.sendRedirect(req.getContextPath() + "/restaurant/dashboard?success=update_order_status");

        } else if ("update_profile".equals(action)) {
            String name = req.getParameter("name");
            String cuisineType = req.getParameter("cuisineType");
            String address = req.getParameter("address");
            int eta = Integer.parseInt(req.getParameter("eta"));
            String email = req.getParameter("email");
            String password = req.getParameter("password");

            r.setName(name);
            r.setCuisineType(cuisineType);
            r.setAddress(address);
            r.setEta(eta);
            r.setEmail(email);
            if (password != null && !password.trim().isEmpty()) {
                r.setPassword(password);
            }

            boolean success = restaurantDAO.updateRestaurant(r);
            if (success) {
                session.setAttribute("loggedInRestaurant", r);
                resp.sendRedirect(req.getContextPath() + "/restaurant/dashboard?success=update_profile");
            } else {
                resp.sendRedirect(req.getContextPath() + "/restaurant/dashboard?error=update_profile");
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/restaurant/dashboard");
        }
    }
}
