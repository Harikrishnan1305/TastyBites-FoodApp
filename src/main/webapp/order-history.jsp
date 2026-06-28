<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.tap.model.Order" %>
<%@ page import="com.tap.model.User" %>
<%
    User loggedInUser = (User) session.getAttribute("loggedInUser");
    if (loggedInUser == null) {
        response.sendRedirect("login");
        return;
    }
    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders - TastyBites</title>
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
                        <a href="dashboard" class="border-transparent text-gray-500 hover:border-gray-300 hover:text-gray-700 inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium">Home</a>
                        <a href="order-history" class="border-zomato-red text-gray-900 inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium">Orders</a>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <main class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
        <h1 class="text-3xl font-bold text-gray-900 mb-8 animate-fade-in-up">Order History</h1>

        <% if (orders != null && !orders.isEmpty()) { %>
            <div class="space-y-6">
                <% 
                    int delay = 100;
                    for (Order order : orders) { 
                        String statusColor = "text-gray-500";
                        String statusBg = "bg-gray-100";
                        if (order.getStatus().equalsIgnoreCase("Delivered")) {
                            statusColor = "text-green-700"; statusBg = "bg-green-100";
                        } else if (order.getStatus().equalsIgnoreCase("Confirmed") || order.getStatus().equalsIgnoreCase("On the Way") || order.getStatus().equalsIgnoreCase("Picked Up")) {
                            statusColor = "text-blue-700"; statusBg = "bg-blue-100";
                        } else if (order.getStatus().equalsIgnoreCase("Cancelled")) {
                            statusColor = "text-red-700"; statusBg = "bg-red-100";
                        }
                %>
                <div class="bg-white rounded-xl shadow-sm border border-gray-100 p-6 animate-fade-in-up delay-<%= delay %>">
                    <div class="flex flex-col md:flex-row justify-between items-start md:items-center border-b border-gray-100 pb-4 mb-4 gap-4">
                        <div>
                            <div class="text-lg font-bold text-gray-900">Order #<%= order.getOrderId() %></div>
                            <div class="text-sm text-gray-500"><i class="fa-regular fa-clock mr-1"></i> <%= order.getOrderDate() %></div>
                        </div>
                        <div class="flex flex-col items-end">
                            <span class="px-3 py-1 rounded-full text-sm font-bold <%= statusBg %> <%= statusColor %> mb-2">
                                <%= order.getStatus().toUpperCase() %>
                            </span>
                            <div class="text-lg font-bold text-gray-900">₹<%= order.getTotalAmount() %></div>
                        </div>
                    </div>
                    
                    <div class="flex flex-col sm:flex-row justify-between items-center gap-4">
                        <div class="text-sm text-gray-600 flex items-center">
                            <i class="fa-solid fa-map-marker-alt text-zomato-red mr-2"></i>
                            <span class="truncate max-w-sm"><%= order.getDeliveryAddress() %></span>
                        </div>
                        
                        <div class="flex gap-3 w-full sm:w-auto">
                            <% if (!order.getStatus().equalsIgnoreCase("Delivered") && !order.getStatus().equalsIgnoreCase("Cancelled") && !order.getStatus().equalsIgnoreCase("Pending Payment")) { %>
                                <a href="order-track.jsp?order_id=<%= order.getOrderId() %>" class="flex-1 sm:flex-none bg-blue-50 text-blue-600 hover:bg-blue-100 font-bold py-2 px-4 rounded-lg text-center transition">Track</a>
                            <% } %>
                            <% if (order.getStatus().equalsIgnoreCase("Delivered")) { %>
                                <button class="flex-1 sm:flex-none border border-zomato-red text-zomato-red hover:bg-red-50 font-bold py-2 px-4 rounded-lg text-center transition">Reorder</button>
                            <% } %>
                        </div>
                    </div>
                </div>
                <% delay += 100; } %>
            </div>
        <% } else { %>
            <div class="bg-white rounded-xl shadow-sm border border-gray-100 py-16 text-center animate-fade-in-up">
                <i class="fa-solid fa-receipt text-6xl text-gray-300 mb-4"></i>
                <h3 class="text-2xl font-bold text-gray-800 mb-2">No orders yet</h3>
                <p class="text-gray-500 mb-8">You haven't placed any orders. Go ahead and explore top restaurants!</p>
                <a href="dashboard" class="inline-block bg-zomato-red text-white font-semibold py-3 px-8 rounded-lg shadow hover:bg-red-700 transition">
                    Explore Restaurants
                </a>
            </div>
        <% } %>
    </main>
</body>
</html>
