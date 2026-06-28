package com.tap.dao;

import com.tap.model.OrderItem;
import java.util.List;

/**
 * DAO Interface for OrderItem CRUD operations.
 */
public interface OrderItemDAO {

    /**
     * Adds a new order item to the database.
     * @param orderItem the OrderItem object to add
     * @return the number of rows affected
     */
    int addOrderItem(OrderItem orderItem);

    /**
     * Retrieves all order items for a specific order.
     * @param orderId the order ID
     * @return a list of OrderItem objects belonging to the order
     */
    List<OrderItem> getOrderItemsByOrder(int orderId);
}
