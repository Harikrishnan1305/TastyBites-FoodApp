package com.tap.model;

public class Menu {
    private int menuId;
    private int restaurantId;
    private String menuName;
    private String description;
    private String category;
    private double price;
    private boolean isAvailable;
    private String imageUrl;

    public Menu() {}
    public Menu(int restaurantId, String menuName, String description, double price, boolean isAvailable, String imageUrl, String category) {
        this.restaurantId = restaurantId;
        this.menuName = menuName;
        this.description = description;
        this.price = price;
        this.isAvailable = isAvailable;
        this.imageUrl = imageUrl;
        this.category = category;
    }

    public int getMenuId() { return menuId; }
    public void setMenuId(int menuId) { this.menuId = menuId; }
    public int getRestaurantId() { return restaurantId; }
    public void setRestaurantId(int restaurantId) { this.restaurantId = restaurantId; }
    public String getMenuName() { return menuName; }
    public void setMenuName(String menuName) { this.menuName = menuName; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public boolean getIsAvailable() { return isAvailable; }
    public void setIsAvailable(boolean isAvailable) { this.isAvailable = isAvailable; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
}
