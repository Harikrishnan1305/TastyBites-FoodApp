<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.tap.model.Restaurant" %>
<%@ page import="com.tap.model.User" %>
<%
    User loggedInUser = (User) session.getAttribute("loggedInUser");
    if (loggedInUser == null) {
        response.sendRedirect("login");
        return;
    }
    List<Restaurant> restaurantList = (List<Restaurant>) request.getAttribute("restaurantList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TastyBites - Order Food Online</title>
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
                    
                    <div class="hidden sm:ml-10 sm:flex sm:space-x-8">
                        <a href="dashboard" class="border-zomato-red text-gray-900 inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium">Home</a>
                        <a href="order-history" class="border-transparent text-gray-500 hover:border-gray-300 hover:text-gray-700 inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium">Orders</a>
                    </div>
                </div>
                
                <div class="flex items-center space-x-6">
                    <div class="relative hidden md:block">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <i class="fa-solid fa-search text-gray-400"></i>
                        </div>
                        <input type="text" class="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-lg leading-5 bg-gray-50 placeholder-gray-500 focus:outline-none focus:placeholder-gray-400 focus:ring-1 focus:ring-zomato-red focus:border-zomato-red sm:text-sm transition duration-150 ease-in-out" placeholder="Search for restaurant, cuisine or a dish">
                    </div>

                    <a href="cart" class="relative text-gray-600 hover:text-zomato-red transition">
                        <i class="fa-solid fa-shopping-cart text-2xl"></i>
                        <% if (session.getAttribute("cart") != null && !((java.util.Map)session.getAttribute("cart")).isEmpty()) { %>
                            <span class="absolute -top-2 -right-2 inline-flex items-center justify-center px-2 py-1 text-xs font-bold leading-none text-white transform bg-zomato-red rounded-full shadow-sm"><%= ((java.util.Map)session.getAttribute("cart")).size() %></span>
                        <% } %>
                    </a>

                    <div class="relative flex items-center gap-3">
                        <img class="h-10 w-10 rounded-full object-cover border border-gray-200 p-0.5" src="https://ui-avatars.com/api/?name=<%= loggedInUser.getUsername() %>&background=e23744&color=fff" alt="">
                        <div class="hidden md:block">
                            <div class="text-sm font-medium text-gray-900"><%= loggedInUser.getUsername() %></div>
                            <a href="logout" class="text-xs text-gray-500 hover:text-zomato-red font-medium transition">Sign Out</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <!-- Hero Banner -->
    <div class="relative bg-gray-900 overflow-hidden animate-fade-in-up">
        <div class="absolute inset-0">
            <img class="w-full h-full object-cover opacity-40" src="https://images.unsplash.com/photo-1504674900247-0877df9cc836?q=80&w=2070&auto=format&fit=crop" alt="Food background">
            <div class="absolute inset-0 bg-gradient-to-t from-gray-900 via-gray-900/40"></div>
        </div>
        <div class="relative max-w-7xl mx-auto py-24 px-4 sm:py-32 sm:px-6 lg:px-8 text-center">
            <h1 class="text-4xl font-extrabold tracking-tight text-white sm:text-5xl lg:text-6xl mb-4">
                Hungry? We've got you.
            </h1>
            <p class="mt-4 text-xl text-gray-300 max-w-3xl mx-auto">
                Order from the best local restaurants with easy, on-demand delivery.
            </p>
        </div>
    </div>

    <!-- Main Content -->
    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        
        <div class="flex justify-between items-end mb-8 animate-fade-in-up delay-100">
            <div>
                <h2 class="text-3xl font-bold tracking-tight text-gray-900">Top Restaurants in your location</h2>
                <p class="mt-2 text-gray-500">Curated choices just for you.</p>
            </div>
            <div class="hidden md:flex space-x-2">
                <button class="px-4 py-2 bg-white border border-gray-300 rounded-full text-sm font-medium text-gray-700 hover:bg-gray-50 shadow-sm transition">Rating 4.0+</button>
                <button class="px-4 py-2 bg-white border border-gray-300 rounded-full text-sm font-medium text-gray-700 hover:bg-gray-50 shadow-sm transition">Fast Delivery</button>
            </div>
        </div>

        <% if (restaurantList != null && !restaurantList.isEmpty()) { %>
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8">
                <% 
                   int index = 0;
                   for (Restaurant restaurant : restaurantList) { 
                       String imgUrl = (restaurant.getImageUrl() != null && !restaurant.getImageUrl().isEmpty()) 
                                       ? restaurant.getImageUrl() 
                                       : "https://images.unsplash.com/photo-1552566626-52f8b828add9?w=500";
                %>
                <a href="menu?restaurant_id=<%= restaurant.getRestaurantId() %>" 
                   class="group flex flex-col bg-white rounded-2xl overflow-hidden shadow-sm hover:shadow-xl transition-all duration-300 transform hover:-translate-y-1 animate-fade-in-up delay-<%= (index%4 + 1)*100 %> border border-gray-100">
                    
                    <div class="relative h-48 overflow-hidden img-hover-zoom">
                        <img src="<%= imgUrl %>" alt="<%= restaurant.getName() %>" class="w-full h-full object-cover">
                        <!-- Promoted Badge -->
                        <% if(restaurant.getRatings() > 4.5) { %>
                            <div class="absolute top-4 left-0 bg-zomato-red text-white text-xs font-bold px-2 py-1 rounded-r-md shadow-md">
                                PROMOTED
                            </div>
                        <% } %>
                        <!-- Time Badge -->
                        <div class="absolute bottom-4 right-4 bg-white/90 backdrop-blur-sm text-gray-800 text-xs font-bold px-2 py-1 rounded shadow-sm">
                            <%= restaurant.getDeliveryTime() %>
                        </div>
                    </div>

                    <div class="p-5 flex-1 flex flex-col">
                        <div class="flex justify-between items-start mb-2">
                            <h3 class="text-xl font-bold text-gray-900 group-hover:text-zomato-red transition truncate pr-2"><%= restaurant.getName() %></h3>
                            <div class="flex items-center bg-green-600 text-white px-2 py-0.5 rounded text-sm font-bold shadow-sm">
                                <span><%= restaurant.getRatings() %></span>
                                <i class="fa-solid fa-star text-[10px] ml-1"></i>
                            </div>
                        </div>
                        
                        <p class="text-gray-500 text-sm mb-4 truncate"><%= restaurant.getCuisineType() %></p>
                        
                        <div class="mt-auto pt-4 border-t border-gray-100 flex justify-between items-center text-sm text-gray-500">
                            <div class="flex items-center">
                                <i class="fa-solid fa-map-marker-alt mr-1.5 text-gray-400"></i>
                                <span class="truncate max-w-[120px]"><%= restaurant.getAddress() %></span>
                            </div>
                            <div class="font-medium text-gray-900">
                                Min: ₹<%= restaurant.getMinOrder() %>
                            </div>
                        </div>
                    </div>
                </a>
                <% index++; } %>
            </div>
        <% } else { %>
            <div class="text-center py-24 bg-white rounded-2xl shadow-sm border border-gray-100 animate-fade-in-up">
                <i class="fa-solid fa-store-slash text-6xl text-gray-300 mb-4"></i>
                <h3 class="text-2xl font-bold text-gray-900 mb-2">No Restaurants Found</h3>
                <p class="text-gray-500">We are currently not serving in this area or all restaurants are offline.</p>
            </div>
        <% } %>

    </main>

    <!-- Footer -->
    <footer class="bg-gray-900 py-12 mt-12 border-t border-gray-800">
        <div class="max-w-7xl mx-auto px-4 text-center">
            <h2 class="text-2xl font-bold text-white mb-4"><i class="fa-solid fa-burger text-zomato-red mr-2"></i>TastyBites</h2>
            <p class="text-gray-400 text-sm">© 2026 TastyBites Technologies Pvt. Ltd. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
