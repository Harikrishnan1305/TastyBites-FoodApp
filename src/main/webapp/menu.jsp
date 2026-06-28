<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.tap.model.Menu" %>
<%@ page import="com.tap.model.Restaurant" %>
<%@ page import="com.tap.model.User" %>
<%
    User loggedInUser = (User) session.getAttribute("loggedInUser");
    if (loggedInUser == null) {
        response.sendRedirect("login");
        return;
    }
    Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
    List<Menu> menuList = (List<Menu>) request.getAttribute("menuList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= restaurant != null ? restaurant.getName() : "Menu" %> - TastyBites</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-50 font-sans">

    <!-- Navbar -->
    <nav class="bg-white shadow-sm sticky top-0 z-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-20">
                <div class="flex items-center">
                    <a href="dashboard" class="flex-shrink-0 flex items-center text-zomato-red hover:text-red-700 transition">
                        <i class="fa-solid fa-burger text-3xl mr-2"></i>
                        <span class="font-bold text-3xl tracking-tight">TastyBites</span>
                    </a>
                </div>
                
                <div class="flex items-center space-x-6">
                    <a href="cart" class="relative text-gray-600 hover:text-zomato-red transition">
                        <i class="fa-solid fa-shopping-cart text-2xl"></i>
                        <% if (session.getAttribute("cart") != null && !((java.util.Map)session.getAttribute("cart")).isEmpty()) { %>
                            <span class="absolute -top-2 -right-2 inline-flex items-center justify-center px-2 py-1 text-xs font-bold leading-none text-white transform bg-zomato-red rounded-full shadow-sm"><%= ((java.util.Map)session.getAttribute("cart")).size() %></span>
                        <% } %>
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <% if (restaurant != null) { 
        String resImgUrl = (restaurant.getImageUrl() != null && !restaurant.getImageUrl().isEmpty()) 
                            ? restaurant.getImageUrl() 
                            : "https://images.unsplash.com/photo-1552566626-52f8b828add9?w=1200";
    %>
    <!-- Restaurant Header Banner -->
    <div class="relative bg-gray-900 h-80 animate-fade-in-up">
        <div class="absolute inset-0">
            <img class="w-full h-full object-cover opacity-60" src="<%= resImgUrl %>" alt="Restaurant">
            <div class="absolute inset-0 bg-gradient-to-t from-gray-900 via-gray-900/40"></div>
        </div>
        <div class="absolute bottom-0 w-full">
            <div class="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 pb-8">
                <div class="flex justify-between items-end">
                    <div>
                        <h1 class="text-4xl font-bold text-white mb-2"><%= restaurant.getName() %></h1>
                        <p class="text-gray-300 text-lg mb-2"><%= restaurant.getCuisineType() %></p>
                        <p class="text-gray-400 text-sm"><i class="fa-solid fa-map-marker-alt mr-1 text-zomato-red"></i> <%= restaurant.getAddress() %></p>
                    </div>
                    <div class="bg-green-600 rounded-lg p-3 text-center shadow-lg backdrop-blur-sm">
                        <div class="text-white font-bold text-xl"><%= restaurant.getRatings() %> <i class="fa-solid fa-star text-sm"></i></div>
                        <div class="text-green-100 text-xs mt-1">Delivery Rating</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <% } %>

    <main class="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <h2 class="text-2xl font-bold text-gray-800 mb-8 border-b pb-4">Order Online</h2>

        <% if (menuList != null && !menuList.isEmpty()) { %>
            <div class="space-y-6">
                <% for (Menu menu : menuList) { 
                    String menuImgUrl = (menu.getImageUrl() != null && !menu.getImageUrl().isEmpty()) 
                                        ? menu.getImageUrl() 
                                        : "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=500";
                %>
                <div class="bg-white rounded-xl shadow-sm border border-gray-100 p-4 flex flex-col sm:flex-row items-center gap-6 hover:shadow-md transition animate-fade-in-up">
                    <div class="w-full sm:w-32 h-32 flex-shrink-0 rounded-lg overflow-hidden">
                        <img src="<%= menuImgUrl %>" alt="<%= menu.getMenuName() %>" class="w-full h-full object-cover">
                    </div>
                    
                    <div class="flex-1 w-full">
                        <div class="flex items-center mb-1">
                            <!-- Veg/NonVeg Indicator mock -->
                            <div class="w-4 h-4 border border-green-600 flex items-center justify-center rounded-sm mr-2">
                                <div class="w-2 h-2 bg-green-600 rounded-full"></div>
                            </div>
                            <h3 class="text-xl font-bold text-gray-900"><%= menu.getMenuName() %></h3>
                        </div>
                        <div class="text-gray-900 font-semibold mb-2">₹<%= menu.getPrice() %></div>
                        <p class="text-gray-500 text-sm mb-2"><%= menu.getDescription() %></p>
                        <% if(menu.getCategory() != null) { %>
                            <span class="inline-block bg-gray-100 text-gray-600 text-xs px-2 py-1 rounded"><%= menu.getCategory() %></span>
                        <% } %>
                    </div>

                    <div class="w-full sm:w-auto flex-shrink-0 flex justify-end">
                        <% if (menu.getIsAvailable()) { %>
                            <form action="cart" method="post" class="flex items-center border border-zomato-red rounded-lg overflow-hidden bg-red-50 text-zomato-red hover:bg-red-100 transition shadow-sm w-full sm:w-32">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="menu_id" value="<%= menu.getMenuId() %>">
                                <input type="hidden" name="restaurant_id" value="<%= menu.getRestaurantId() %>">
                                <input type="number" name="quantity" value="1" min="1" class="w-12 text-center bg-transparent border-none focus:ring-0 text-sm font-bold p-2 outline-none">
                                <button type="submit" class="flex-1 font-bold p-2 border-l border-red-200">ADD</button>
                            </form>
                        <% } else { %>
                            <button disabled class="w-full sm:w-32 bg-gray-200 text-gray-500 font-bold py-2 px-4 rounded-lg cursor-not-allowed">
                                OUT OF STOCK
                            </button>
                        <% } %>
                    </div>
                </div>
                <% } %>
            </div>
        <% } else { %>
            <div class="text-center py-12 bg-white rounded-xl shadow-sm border border-gray-100">
                <p class="text-gray-500">No menu items found for this restaurant.</p>
            </div>
        <% } %>
    </main>

</body>
</html>
