package com.tap.model;

import java.sql.Timestamp;

public class Order {
    private int orderId;
    private int userId;
    private int restaurantId;
    private double totalAmount;
    private String status;
    private String paymentMethod;
    private String deliveryAddress;
    private int deliveryPartnerId;
    private String estimatedTime;
    private Timestamp orderDate;

    public Order() {}

    // Constructor used by OrderServlet
    public Order(int userId, int restaurantId, double totalAmount, String status, String paymentMethod, String deliveryAddress) {
        this.userId = userId;
        this.restaurantId = restaurantId;
        this.totalAmount = totalAmount;
        this.status = status;
        this.paymentMethod = paymentMethod;
        this.deliveryAddress = deliveryAddress;
    }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public int getRestaurantId() { return restaurantId; }
    public void setRestaurantId(int restaurantId) { this.restaurantId = restaurantId; }
    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
    public String getDeliveryAddress() { return deliveryAddress; }
    public void setDeliveryAddress(String deliveryAddress) { this.deliveryAddress = deliveryAddress; }
    public int getDeliveryPartnerId() { return deliveryPartnerId; }
    public void setDeliveryPartnerId(int deliveryPartnerId) { this.deliveryPartnerId = deliveryPartnerId; }
    public String getEstimatedTime() { return estimatedTime; }
    public void setEstimatedTime(String estimatedTime) { this.estimatedTime = estimatedTime; }
    public Timestamp getOrderDate() { return orderDate; }
    public void setOrderDate(Timestamp orderDate) { this.orderDate = orderDate; }
}
