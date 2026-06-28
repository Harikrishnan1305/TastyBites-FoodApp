package com.tap.dao.impl;

import com.tap.dao.OrderItemDAO;
import com.tap.model.OrderItem;
import com.tap.utility.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderItemDAOImpl implements OrderItemDAO {

    @Override
    public int addOrderItem(OrderItem orderItem) {
        // DB table: orderitem, columns: order_item_id, order_id, menu_id, quantity, price
        String sql = "INSERT INTO orderitem (order_id, menu_id, quantity, price) VALUES (?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, orderItem.getOrderId());
            ps.setInt(2, orderItem.getMenuId());
            ps.setInt(3, orderItem.getQuantity());
            ps.setDouble(4, orderItem.getItemPrice());
            return ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public List<OrderItem> getOrderItemsByOrder(int orderId) {
        List<OrderItem> orderItems = new ArrayList<>();
        String sql = "SELECT * FROM orderitem WHERE order_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setOrderItemId(rs.getInt("order_item_id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setMenuId(rs.getInt("menu_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setItemPrice(rs.getDouble("price"));
                orderItems.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderItems;
    }
}
