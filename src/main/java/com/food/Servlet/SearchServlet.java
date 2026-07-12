package com.food.Servlet;

import com.food.model.Menu;
import com.food.model.Restaurant;
import com.food.util.DBConnection;
import com.food.util.FallbackData;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String query = req.getParameter("q");
        List<Restaurant> matchingRestaurants = new ArrayList<>();
        List<Menu>       matchingMenus       = new ArrayList<>();

        if (query != null && !query.trim().isEmpty()) {
            String searchPattern = "%" + query.trim() + "%";

            Connection con = DBConnection.getConnection();

            if (con == null) {
                // ── DB unavailable – use in-memory fallback search ──────────────
                matchingRestaurants = FallbackData.searchRestaurants(query.trim());
                matchingMenus       = FallbackData.searchMenus(query.trim());
            } else {
                // ── Live DB search ──────────────────────────────────────────────
                try (con) {
                    // 1. Search Restaurants
                    String sqlRest = "SELECT * FROM restaurant WHERE name ILIKE ? OR cuisine_type ILIKE ?";
                    try (PreparedStatement ps = con.prepareStatement(sqlRest)) {
                        ps.setString(1, searchPattern);
                        ps.setString(2, searchPattern);
                        try (ResultSet rs = ps.executeQuery()) {
                            while (rs.next()) {
                                matchingRestaurants.add(new Restaurant(
                                    rs.getInt("restaurant_id"),
                                    rs.getString("name"),
                                    rs.getString("cuisine_type"),
                                    rs.getFloat("rating"),
                                    rs.getString("address"),
                                    rs.getInt("eta"),
                                    rs.getString("email"),
                                    rs.getString("password")
                                ));
                            }
                        }
                    }

                    // 2. Search Menus
                    String sqlMenu = "SELECT * FROM menu WHERE name ILIKE ? OR description ILIKE ?";
                    try (PreparedStatement ps = con.prepareStatement(sqlMenu)) {
                        ps.setString(1, searchPattern);
                        ps.setString(2, searchPattern);
                        try (ResultSet rs = ps.executeQuery()) {
                            while (rs.next()) {
                                matchingMenus.add(new Menu(
                                    rs.getInt("menu_id"),
                                    rs.getInt("restaurant_id"),
                                    rs.getString("name"),
                                    rs.getString("description"),
                                    rs.getDouble("price"),
                                    rs.getBoolean("is_available"),
                                    rs.getString("image_path")
                                ));
                            }
                        }
                    }
                } catch (SQLException e) {
                    // Mid-query DB failure – fall back to static data
                    e.printStackTrace();
                    matchingRestaurants = FallbackData.searchRestaurants(query.trim());
                    matchingMenus       = FallbackData.searchMenus(query.trim());
                }
            }
        }

        req.setAttribute("query", query);
        req.setAttribute("matchingRestaurants", matchingRestaurants);
        req.setAttribute("matchingMenus", matchingMenus);
        req.getRequestDispatcher("/search_results.jsp").forward(req, resp);
    }
}
