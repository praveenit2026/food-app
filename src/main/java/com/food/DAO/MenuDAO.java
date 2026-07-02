package com.food.DAO;

import com.food.model.Menu;
import java.util.List;

public interface MenuDAO {
    boolean addMenu(Menu menu);
    Menu getMenu(int menuId);
    List<Menu> getMenuByRestaurant(int restaurantId);
    List<Menu> getAllMenus();
    boolean updateMenu(Menu menu);
    boolean deleteMenu(int menuId);
}
