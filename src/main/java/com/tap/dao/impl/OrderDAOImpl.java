package com.tap.dao.impl;

import com.tap.dao.OrderDAO;
import com.tap.model.Order;
import com.tap.utility.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAOImpl implements OrderDAO {

    @Override
    public int addOrder(Order order) {
        String query = "INSERT INTO `order` (user_id, restaurant_id, total_amount, status, payment_method, delivery_address) VALUES (?, ?, ?, ?, ?, ?)";
        int orderId = 0;
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, order.getUserId());
            ps.setInt(2, order.getRestaurantId());
            ps.setDouble(3, order.getTotalAmount());
            ps.setString(4, order.getStatus());
            ps.setString(5, order.getPaymentMethod());
            ps.setString(6, order.getDeliveryAddress());
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) orderId = rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return orderId;
    }

    @Override
    public Order getOrder(int orderId) {
        String query = "SELECT * FROM `order` WHERE order_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return extract(rs);
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    @Override
    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String query = "SELECT * FROM `order` ORDER BY order_date DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(extract(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    @Override
    public List<Order> getOrdersByUser(int userId) {
        List<Order> list = new ArrayList<>();
        String query = "SELECT * FROM `order` WHERE user_id = ? ORDER BY order_date DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(extract(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    @Override
    public int updateOrderStatus(int orderId, String status) {
        String query = "UPDATE `order` SET status = ? WHERE order_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, status);
            ps.setInt(2, orderId);
            return ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    @Override
    public int updateDeliveryPartner(int orderId, int deliveryPartnerId) {
        String query = "UPDATE `order` SET delivery_partner_id = ? WHERE order_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, deliveryPartnerId);
            ps.setInt(2, orderId);
            return ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    private Order extract(ResultSet rs) throws Exception {
        Order o = new Order();
        o.setOrderId(rs.getInt("order_id"));
        o.setUserId(rs.getInt("user_id"));
        o.setRestaurantId(rs.getInt("restaurant_id"));
        o.setTotalAmount(rs.getDouble("total_amount"));
        o.setStatus(rs.getString("status"));
        o.setPaymentMethod(rs.getString("payment_method"));
        o.setDeliveryAddress(rs.getString("delivery_address"));
        o.setDeliveryPartnerId(rs.getInt("delivery_partner_id"));
        o.setEstimatedTime(rs.getString("estimated_time"));
        o.setOrderDate(rs.getTimestamp("order_date"));
        return o;
    }
}
