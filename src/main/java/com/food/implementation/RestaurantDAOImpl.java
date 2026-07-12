package com.food.implementation;

import com.food.DAO.RestaurantDAO;
import com.food.model.Restaurant;
import com.food.util.DBConnection;
import com.food.util.FallbackData;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RestaurantDAOImpl implements RestaurantDAO {
    private static final String INSERT_RESTAURANT = "INSERT INTO restaurant (name, cuisine_type, rating, address, eta, email, password) VALUES (?, ?, ?, ?, ?, ?, ?)";
    private static final String SELECT_RESTAURANT_BY_ID = "SELECT * FROM restaurant WHERE restaurant_id = ?";
    private static final String SELECT_RESTAURANT_BY_EMAIL = "SELECT * FROM restaurant WHERE email = ?";
    private static final String SELECT_ALL_RESTAURANTS = "SELECT * FROM restaurant";
    private static final String UPDATE_RESTAURANT = "UPDATE restaurant SET name = ?, cuisine_type = ?, rating = ?, address = ?, eta = ?, email = ?, password = ? WHERE restaurant_id = ?";
    private static final String DELETE_RESTAURANT = "DELETE FROM restaurant WHERE restaurant_id = ?";

    @Override
    public boolean addRestaurant(Restaurant restaurant) {
        Connection con = DBConnection.getConnection();
        if (con == null) return false;
        try (con;
             PreparedStatement ps = con.prepareStatement(INSERT_RESTAURANT)) {
            ps.setString(1, restaurant.getName());
            ps.setString(2, restaurant.getCuisineType());
            ps.setFloat(3, restaurant.getRating());
            ps.setString(4, restaurant.getAddress());
            ps.setInt(5, restaurant.getEta());
            ps.setString(6, restaurant.getEmail());
            ps.setString(7, restaurant.getPassword());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public Restaurant getRestaurant(int restaurantId) {
        Connection con = DBConnection.getConnection();
        if (con == null) return FallbackData.getRestaurant(restaurantId);
        try (con;
             PreparedStatement ps = con.prepareStatement(SELECT_RESTAURANT_BY_ID)) {
            ps.setInt(1, restaurantId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractRestaurantFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public Restaurant getRestaurantByEmail(String email) {
        Connection con = DBConnection.getConnection();
        if (con == null) return null; // Login not possible without DB
        try (con;
             PreparedStatement ps = con.prepareStatement(SELECT_RESTAURANT_BY_EMAIL)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractRestaurantFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Restaurant> getAllRestaurants() {
        Connection con = DBConnection.getConnection();
        if (con == null) return FallbackData.getAllRestaurants();
        List<Restaurant> list = new ArrayList<>();
        try (con;
             PreparedStatement ps = con.prepareStatement(SELECT_ALL_RESTAURANTS);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(extractRestaurantFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return FallbackData.getAllRestaurants(); // Fallback on mid-query failure too
        }
        return list;
    }

    @Override
    public boolean updateRestaurant(Restaurant restaurant) {
        Connection con = DBConnection.getConnection();
        if (con == null) return false;
        try (con;
             PreparedStatement ps = con.prepareStatement(UPDATE_RESTAURANT)) {
            ps.setString(1, restaurant.getName());
            ps.setString(2, restaurant.getCuisineType());
            ps.setFloat(3, restaurant.getRating());
            ps.setString(4, restaurant.getAddress());
            ps.setInt(5, restaurant.getEta());
            ps.setString(6, restaurant.getEmail());
            ps.setString(7, restaurant.getPassword());
            ps.setInt(8, restaurant.getRestaurantId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteRestaurant(int restaurantId) {
        Connection con = DBConnection.getConnection();
        if (con == null) return false;
        try (con;
             PreparedStatement ps = con.prepareStatement(DELETE_RESTAURANT)) {
            ps.setInt(1, restaurantId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Restaurant extractRestaurantFromResultSet(ResultSet rs) throws SQLException {
        return new Restaurant(
                rs.getInt("restaurant_id"),
                rs.getString("name"),
                rs.getString("cuisine_type"),
                rs.getFloat("rating"),
                rs.getString("address"),
                rs.getInt("eta"),
                rs.getString("email"),
                rs.getString("password")
        );
    }
}