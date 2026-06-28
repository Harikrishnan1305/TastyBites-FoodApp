package com.tap.dao.impl;

import com.tap.dao.MenuDAO;
import com.tap.model.Menu;
import com.tap.utility.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MenuDAOImpl implements MenuDAO {
    @Override
    public int addMenu(Menu menu) {
        String query = "INSERT INTO menu (restaurant_id, menu_name, description, price, is_available, image_url, category) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, menu.getRestaurantId());
            ps.setString(2, menu.getMenuName());
            ps.setString(3, menu.getDescription());
            ps.setDouble(4, menu.getPrice());
            ps.setBoolean(5, menu.getIsAvailable());
            ps.setString(6, menu.getImageUrl());
            ps.setString(7, menu.getCategory());
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public Menu getMenu(int menuId) {
        String query = "SELECT * FROM menu WHERE menu_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, menuId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return extractMenuFromResultSet(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public int updateMenu(Menu menu) {
        return 0;
    }

    @Override
    public int deleteMenu(int menuId) {
        String query = "DELETE FROM menu WHERE menu_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, menuId);
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public List<Menu> getMenuByRestaurant(int restaurantId) {
        List<Menu> list = new ArrayList<>();
        String query = "SELECT * FROM menu WHERE restaurant_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, restaurantId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(extractMenuFromResultSet(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    private Menu extractMenuFromResultSet(ResultSet rs) throws Exception {
        Menu m = new Menu();
        m.setMenuId(rs.getInt("menu_id"));
        m.setRestaurantId(rs.getInt("restaurant_id"));
        m.setMenuName(rs.getString("menu_name"));
        m.setDescription(rs.getString("description"));
        m.setPrice(rs.getDouble("price"));
        m.setIsAvailable(rs.getBoolean("is_available"));
        m.setImageUrl(rs.getString("image_url"));
        m.setCategory(rs.getString("category"));
        return m;
    }
}
