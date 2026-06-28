package com.tap.model;

public class Restaurant {
    private int restaurantId;
    private String name;
    private String cuisineType;
    private String deliveryTime;
    private String address;
    private String imageUrl;
    private double minOrder;
    private double ratings;
    private boolean isActive;
    private int adminUserId;

    public Restaurant() {}

    public int getRestaurantId() { return restaurantId; }
    public void setRestaurantId(int restaurantId) { this.restaurantId = restaurantId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getCuisineType() { return cuisineType; }
    public void setCuisineType(String cuisineType) { this.cuisineType = cuisineType; }
    public String getDeliveryTime() { return deliveryTime; }
    public void setDeliveryTime(String deliveryTime) { this.deliveryTime = deliveryTime; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public double getMinOrder() { return minOrder; }
    public void setMinOrder(double minOrder) { this.minOrder = minOrder; }
    public double getRatings() { return ratings; }
    public void setRatings(double ratings) { this.ratings = ratings; }
    public boolean getIsActive() { return isActive; }
    public void setIsActive(boolean isActive) { this.isActive = isActive; }
    public int getAdminUserId() { return adminUserId; }
    public void setAdminUserId(int adminUserId) { this.adminUserId = adminUserId; }
}
