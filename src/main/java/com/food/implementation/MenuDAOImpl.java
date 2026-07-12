package com.food.implementation;

import com.food.DAO.MenuDAO;
import com.food.model.Menu;
import com.food.util.DBConnection;
import com.food.util.FallbackData;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MenuDAOImpl implements MenuDAO {
    private static final String INSERT_MENU = "INSERT INTO menu (restaurant_id, name, description, price, is_available, image_path) VALUES (?, ?, ?, ?, ?, ?)";
    private static final String SELECT_MENU_BY_ID = "SELECT * FROM menu WHERE menu_id = ?";
    private static final String SELECT_MENU_BY_RESTAURANT = "SELECT * FROM menu WHERE restaurant_id = ?";
    private static final String SELECT_ALL_MENUS = "SELECT * FROM menu";
    private static final String UPDATE_MENU = "UPDATE menu SET restaurant_id = ?, name = ?, description = ?, price = ?, is_available = ?, image_path = ? WHERE menu_id = ?";
    private static final String DELETE_MENU = "DELETE FROM menu WHERE menu_id = ?";

    @Override
    public boolean addMenu(Menu menu) {
        Connection con = DBConnection.getConnection();
        if (con == null) return false;
        try (con;
             PreparedStatement ps = con.prepareStatement(INSERT_MENU)) {
            ps.setInt(1, menu.getRestaurantId());
            ps.setString(2, menu.getName());
            ps.setString(3, menu.getDescription());
            ps.setDouble(4, menu.getPrice());
            ps.setBoolean(5, menu.isAvailable());
            ps.setString(6, menu.getImagePath());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public Menu getMenu(int menuId) {
        Connection con = DBConnection.getConnection();
        if (con == null) {
            for (Menu m : FallbackData.getAllMenus()) {
                if (m.getMenuId() == menuId) return m;
            }
            return null;
        }
        try (con;
             PreparedStatement ps = con.prepareStatement(SELECT_MENU_BY_ID)) {
            ps.setInt(1, menuId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return extractMenuFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Menu> getMenuByRestaurant(int restaurantId) {
        Connection con = DBConnection.getConnection();
        if (con == null) return FallbackData.getMenuByRestaurant(restaurantId);
        List<Menu> menus = new ArrayList<>();
        try (con;
             PreparedStatement ps = con.prepareStatement(SELECT_MENU_BY_RESTAURANT)) {
            ps.setInt(1, restaurantId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    menus.add(extractMenuFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return FallbackData.getMenuByRestaurant(restaurantId);
        }
        return menus;
    }

    @Override
    public List<Menu> getAllMenus() {
        Connection con = DBConnection.getConnection();
        if (con == null) return FallbackData.getAllMenus();
        List<Menu> menus = new ArrayList<>();
        try (con;
             PreparedStatement ps = con.prepareStatement(SELECT_ALL_MENUS);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                menus.add(extractMenuFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return FallbackData.getAllMenus();
        }
        return menus;
    }

    @Override
    public boolean updateMenu(Menu menu) {
        Connection con = DBConnection.getConnection();
        if (con == null) return false;
        try (con;
             PreparedStatement ps = con.prepareStatement(UPDATE_MENU)) {
            ps.setInt(1, menu.getRestaurantId());
            ps.setString(2, menu.getName());
            ps.setString(3, menu.getDescription());
            ps.setDouble(4, menu.getPrice());
            ps.setBoolean(5, menu.isAvailable());
            ps.setString(6, menu.getImagePath());
            ps.setInt(7, menu.getMenuId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteMenu(int menuId) {
        Connection con = DBConnection.getConnection();
        if (con == null) return false;
        try (con;
             PreparedStatement ps = con.prepareStatement(DELETE_MENU)) {
            ps.setInt(1, menuId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Menu extractMenuFromResultSet(ResultSet rs) throws SQLException {
        return new Menu(
                rs.getInt("menu_id"),
                rs.getInt("restaurant_id"),
                rs.getString("name"),
                rs.getString("description"),
                rs.getDouble("price"),
                rs.getBoolean("is_available"),
                rs.getString("image_path")
        );
    }
}
