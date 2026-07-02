package com.food.model;

public class Restaurant {
    private int restaurantId;
    private String name;
    private String cuisineType;
    private float rating;
    private String address;
    private int eta;
    private String email;
    private String password;

    public Restaurant() {
    }

    public Restaurant(int restaurantId, String name, String cuisineType,
            float rating, String address, int eta) {
        this.restaurantId = restaurantId;
        this.name = name;
        this.cuisineType = cuisineType;
        this.rating = rating;
        this.address = address;
        this.eta = eta;
    }

    public Restaurant(int restaurantId, String name, String cuisineType,
            float rating, String address, int eta, String email, String password) {
        this.restaurantId = restaurantId;
        this.name = name;
        this.cuisineType = cuisineType;
        this.rating = rating;
        this.address = address;
        this.eta = eta;
        this.email = email;
        this.password = password;
    }

    public int getRestaurantId() {
        return restaurantId;
    }

    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCuisineType() {
        return cuisineType;
    }

    public void setCuisineType(String cuisineType) {
        this.cuisineType = cuisineType;
    }

    public float getRating() {
        return rating;
    }

    public void setRating(float rating) {
        this.rating = rating;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getEta() {
        return eta;
    }

    public void setEta(int eta) {
        this.eta = eta;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "Restaurant [restaurantId=" + restaurantId + ", name=" + name + ", cuisineType=" + cuisineType
                + ", rating=" + rating + ", address=" + address + ", eta=" + eta + ", email=" + email + "]";
    }
}


