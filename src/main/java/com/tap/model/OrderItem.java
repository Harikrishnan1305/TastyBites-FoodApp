package com.tap.model;

/**
 * POJO class representing the Order_Item table.
 */
public class OrderItem {

    private int orderItemId;
    private int orderId;
    private int menuId;
    private int quantity;
    private double itemPrice;

    // No-arg constructor
    public OrderItem() {
    }

    // All-arg constructor
    public OrderItem(int orderItemId, int orderId, int menuId, int quantity, double itemPrice) {
        this.orderItemId = orderItemId;
        this.orderId = orderId;
        this.menuId = menuId;
        this.quantity = quantity;
        this.itemPrice = itemPrice;
    }

    // Constructor without auto-generated fields (for adding items to an order)
    public OrderItem(int orderId, int menuId, int quantity, double itemPrice) {
        this.orderId = orderId;
        this.menuId = menuId;
        this.quantity = quantity;
        this.itemPrice = itemPrice;
    }

    // Getters and Setters
    public int getOrderItemId() {
        return orderItemId;
    }

    public void setOrderItemId(int orderItemId) {
        this.orderItemId = orderItemId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getMenuId() {
        return menuId;
    }

    public void setMenuId(int menuId) {
        this.menuId = menuId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getItemPrice() {
        return itemPrice;
    }

    public void setItemPrice(double itemPrice) {
        this.itemPrice = itemPrice;
    }

    @Override
    public String toString() {
        return "OrderItem{" +
                "orderItemId=" + orderItemId +
                ", orderId=" + orderId +
                ", menuId=" + menuId +
                ", quantity=" + quantity +
                ", itemPrice=" + itemPrice +
                '}';
    }
}
