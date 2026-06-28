<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.tap.model.Order" %>
<%@ page import="com.tap.model.User" %>
<%
    User user = (User) session.getAttribute("loggedInUser");
    if (user == null || !"DELIVERY".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("login");
        return;
    }
    List<Order> availableOrders = (List<Order>) request.getAttribute("availableOrders");
    List<Order> myOrders = (List<Order>) request.getAttribute("myOrders");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delivery Partner - TastyBites</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100 font-sans">

    <!-- Navbar -->
    <nav class="bg-blue-600 shadow-sm sticky top-0 z-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16 items-center">
                <a href="dashboard" class="flex-shrink-0 flex items-center text-white transition">
                    <i class="fa-solid fa-motorcycle text-2xl mr-3"></i>
                    <span class="font-bold text-xl tracking-tight">Delivery Portal</span>
                </a>
                <div class="flex items-center text-white text-sm font-medium">
                    <span class="mr-4"><i class="fa-solid fa-circle text-green-300 text-[10px] mr-1"></i> Online</span>
                    <a href="logout" class="hover:text-blue-200 bg-blue-700 px-3 py-1.5 rounded transition">Sign Out</a>
                </div>
            </div>
        </div>
    </nav>

    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
            
            <!-- Available Orders to Pickup -->
            <div class="space-y-4 animate-fade-in-up">
                <h2 class="text-xl font-bold text-gray-800 flex items-center">
                    <i class="fa-solid fa-satellite-dish text-blue-500 mr-2"></i> New Requests
                </h2>
                
                <% if (availableOrders != null && !availableOrders.isEmpty()) { 
                    for (Order o : availableOrders) { 
                %>
                <div class="bg-white rounded-xl shadow-sm border-l-4 border-blue-500 p-5 hover:shadow-md transition">
                    <div class="flex justify-between mb-3">
                        <div class="font-bold text-gray-900">Order #<%= o.getOrderId() %></div>
                        <div class="bg-yellow-100 text-yellow-800 text-xs font-bold px-2 py-1 rounded"><%= o.getStatus() %></div>
                    </div>
                    <div class="text-sm text-gray-600 mb-4 flex items-start">
                        <i class="fa-solid fa-location-dot text-red-500 mt-1 mr-2 w-4"></i>
                        <span class="truncate pr-4"><%= o.getDeliveryAddress() %></span>
                    </div>
                    <% if (o.getDeliveryPartnerId() == 0) { %>
                    <form action="update-order-status" method="post">
                        <input type="hidden" name="order_id" value="<%= o.getOrderId() %>">
                        <input type="hidden" name="status" value="<%= o.getStatus() %>">
                        <input type="hidden" name="accept" value="true">
                        <button class="w-full bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 rounded-lg transition">Accept Delivery</button>
                    </form>
                    <% } else { %>
                        <div class="w-full bg-gray-100 text-gray-500 text-center font-bold py-2 rounded-lg">Accepted by you</div>
                    <% } %>
                </div>
                <%  }
                } else { %>
                    <div class="bg-white p-8 rounded-xl border border-dashed border-gray-300 text-center text-gray-500">
                        <i class="fa-solid fa-radar text-4xl mb-2 text-gray-300"></i>
                        <p>Scanning for nearby orders...</p>
                    </div>
                <% } %>
            </div>

            <!-- My Active Deliveries -->
            <div class="space-y-4 animate-fade-in-up delay-100">
                <h2 class="text-xl font-bold text-gray-800 flex items-center">
                    <i class="fa-solid fa-route text-green-500 mr-2"></i> Active Deliveries
                </h2>

                <% if (myOrders != null && !myOrders.isEmpty()) { 
                    for (Order o : myOrders) { 
                %>
                <div class="bg-white rounded-xl shadow-sm border border-gray-100 p-5">
                    <div class="flex justify-between items-center mb-4">
                        <div class="font-bold text-gray-900 text-lg">Order #<%= o.getOrderId() %></div>
                        <div class="font-bold text-gray-900">₹<%= o.getTotalAmount() %></div>
                    </div>
                    <div class="text-sm text-gray-600 mb-4 bg-gray-50 p-3 rounded border border-gray-100">
                        <i class="fa-solid fa-map-pin text-zomato-red mr-2"></i> <%= o.getDeliveryAddress() %>
                    </div>
                    
                    <div class="flex gap-2">
                        <form action="update-order-status" method="post" class="flex-1">
                            <input type="hidden" name="order_id" value="<%= o.getOrderId() %>">
                            <input type="hidden" name="status" value="Picked Up">
                            <button class="w-full bg-orange-100 text-orange-700 hover:bg-orange-200 font-bold py-2 rounded transition text-sm">Picked Up</button>
                        </form>
                        <form action="update-order-status" method="post" class="flex-1">
                            <input type="hidden" name="order_id" value="<%= o.getOrderId() %>">
                            <input type="hidden" name="status" value="On the Way">
                            <button class="w-full bg-blue-100 text-blue-700 hover:bg-blue-200 font-bold py-2 rounded transition text-sm">On Way</button>
                        </form>
                        <form action="update-order-status" method="post" class="flex-1">
                            <input type="hidden" name="order_id" value="<%= o.getOrderId() %>">
                            <input type="hidden" name="status" value="Delivered">
                            <button class="w-full bg-green-500 text-white hover:bg-green-600 font-bold py-2 rounded shadow transition text-sm">Delivered</button>
                        </form>
                    </div>
                </div>
                <%  }
                } else { %>
                    <div class="bg-white p-8 rounded-xl border border-gray-100 text-center text-gray-500 shadow-sm">
                        <i class="fa-solid fa-box-open text-4xl mb-2 text-gray-300"></i>
                        <p>No active deliveries.</p>
                    </div>
                <% } %>
            </div>

        </div>
    </main>
</body>
</html>
