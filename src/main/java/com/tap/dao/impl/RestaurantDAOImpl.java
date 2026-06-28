package com.tap.dao.impl;

import com.tap.dao.RestaurantDAO;
import com.tap.model.Restaurant;
import com.tap.utility.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RestaurantDAOImpl implements RestaurantDAO {
    @Override
    public int addRestaurant(Restaurant restaurant) {
        String query = "INSERT INTO restaurant (name, cuisine_type, delivery_time, address, image_url, min_order, ratings, is_active, admin_user_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, restaurant.getName());
            ps.setString(2, restaurant.getCuisineType());
            ps.setString(3, restaurant.getDeliveryTime());
            ps.setString(4, restaurant.getAddress());
            ps.setString(5, restaurant.getImageUrl());
            ps.setDouble(6, restaurant.getMinOrder());
            ps.setDouble(7, restaurant.getRatings());
            ps.setBoolean(8, restaurant.getIsActive());
            ps.setInt(9, restaurant.getAdminUserId());
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public Restaurant getRestaurant(int restaurantId) {
        String query = "SELECT * FROM restaurant WHERE restaurant_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, restaurantId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return extractRestaurantFromResultSet(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public int updateRestaurant(Restaurant restaurant) {
        return 0; // Simplification
    }

    @Override
    public int deleteRestaurant(int restaurantId) {
        return 0; // Simplification
    }

    @Override
    public List<Restaurant> getAllRestaurants() {
        return getActiveRestaurants();
    }

    @Override
    public List<Restaurant> getActiveRestaurants() {
        List<Restaurant> list = new ArrayList<>();
        String query = "SELECT * FROM restaurant WHERE is_active = 1";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(extractRestaurantFromResultSet(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    private Restaurant extractRestaurantFromResultSet(ResultSet rs) throws Exception {
        Restaurant r = new Restaurant();
        r.setRestaurantId(rs.getInt("restaurant_id"));
        r.setName(rs.getString("name"));
        r.setCuisineType(rs.getString("cuisine_type"));
        r.setDeliveryTime(rs.getString("delivery_time"));
        r.setAddress(rs.getString("address"));
        r.setImageUrl(rs.getString("image_url"));
        r.setMinOrder(rs.getDouble("min_order"));
        r.setRatings(rs.getDouble("ratings"));
        r.setIsActive(rs.getBoolean("is_active"));
        r.setAdminUserId(rs.getInt("admin_user_id"));
        return r;
    }
}
