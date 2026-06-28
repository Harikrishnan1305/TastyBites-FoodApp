package com.tap.dao;

import com.tap.model.Menu;
import java.util.List;

/**
 * DAO Interface for Menu CRUD operations.
 */
public interface MenuDAO {
    int addMenu(Menu menu);
    Menu getMenu(int menuId);
    int updateMenu(Menu menu);
    int deleteMenu(int menuId);
    List<Menu> getMenuByRestaurant(int restaurantId);
}
