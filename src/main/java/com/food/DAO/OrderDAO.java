package com.food.DAO;

import com.food.model.Order;
import com.food.model.OrderItem;
import java.util.List;

public interface OrderDAO {
    boolean addOrder(Order order, List<OrderItem> orderItems);
    Order getOrder(int orderId);
    List<Order> getOrdersByUser(int userId);
    List<Order> getOrdersByRestaurant(int restaurantId);
    List<Order> getAllOrders();
    List<OrderItem> getOrderItems(int orderId);
    boolean updateOrderStatus(int orderId, String status);
}

