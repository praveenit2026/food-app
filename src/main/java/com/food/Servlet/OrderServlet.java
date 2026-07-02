package com.food.Servlet;

import com.food.DAO.OrderDAO;
import com.food.implementation.OrderDAOImpl;
import com.food.model.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("loggedInUser");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        List<Order> ordersList = orderDAO.getOrdersByUser(user.getId());
        req.setAttribute("orders", ordersList);
        req.getRequestDispatcher("/orders.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("loggedInUser");
        Cart cart = (Cart) session.getAttribute("cart");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        if (cart == null || cart.getItems().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        String paymentMode = req.getParameter("paymentMode");
        if (paymentMode == null || paymentMode.trim().isEmpty()) {
            paymentMode = "COD";
        }

        int restaurantId = 0;
        List<OrderItem> orderItems = new ArrayList<>();
        for (CartItem cartItem : cart.getItems().values()) {
            restaurantId = cartItem.getRestaurantId();
            OrderItem orderItem = new OrderItem(
                    0,
                    cartItem.getItemId(),
                    cartItem.getName(),
                    cartItem.getQuantity(),
                    cartItem.getPrice()
            );
            orderItems.add(orderItem);
        }

        Order order = new Order(
                user.getId(),
                restaurantId,
                new Timestamp(System.currentTimeMillis()),
                cart.getTotalAmount(),
                "Pending",
                paymentMode
        );

        boolean success = orderDAO.addOrder(order, orderItems);

        if (success) {
            cart.clear();
            resp.sendRedirect(req.getContextPath() + "/order?orderSuccess=true");
        } else {
            req.setAttribute("errorMessage", "Failed to place your order. Please try again.");
            req.getRequestDispatcher("/checkout.jsp").forward(req, resp);
        }
    }
}
