package com.tap.dao;

import com.tap.model.Order;
import java.util.List;

/**
 * DAO Interface for Order CRUD operations.
 */
public interface OrderDAO {
    int addOrder(Order order);
    Order getOrder(int orderId);
    List<Order> getAllOrders();
    List<Order> getOrdersByUser(int userId);
    int updateOrderStatus(int orderId, String status);
    int updateDeliveryPartner(int orderId, int deliveryPartnerId);
}
