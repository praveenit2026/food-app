package com.food.DAO;

import com.food.model.Restaurant;
import java.util.List;

public interface RestaurantDAO {
    boolean addRestaurant(Restaurant restaurant);
    Restaurant getRestaurant(int restaurantId);
    Restaurant getRestaurantByEmail(String email);
    List<Restaurant> getAllRestaurants();
    boolean updateRestaurant(Restaurant restaurant);
    boolean deleteRestaurant(int restaurantId);
}

