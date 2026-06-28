package com.tap.dao;

import com.tap.model.Restaurant;
import java.util.List;

/**
 * DAO Interface for Restaurant CRUD operations.
 * Return type int: rows affected (0 = failure, >0 = success).
 */
public interface RestaurantDAO {
    int addRestaurant(Restaurant restaurant);
    Restaurant getRestaurant(int restaurantId);
    int updateRestaurant(Restaurant restaurant);
    int deleteRestaurant(int restaurantId);
    List<Restaurant> getAllRestaurants();
    List<Restaurant> getActiveRestaurants();
}
