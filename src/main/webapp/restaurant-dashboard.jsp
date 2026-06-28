<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.tap.model.Menu" %>
<%@ page import="com.tap.model.Order" %>
<%@ page import="com.tap.model.Restaurant" %>
<%
    if (session.getAttribute("loggedInUser") == null) {
        response.sendRedirect("login");
        return;
    }
    Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
    List<Menu> menus = (List<Menu>) request.getAttribute("menus");
    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restaurant Partner Dashboard - TastyBites</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-50 font-sans">

    <!-- Navbar -->
    <nav class="bg-gray-900 shadow-sm sticky top-0 z-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16">
                <div class="flex items-center">
                    <a href="dashboard" class="flex-shrink-0 flex items-center text-white transition">
                        <i class="fa-solid fa-store text-2xl text-zomato-red mr-2"></i>
                        <span class="font-bold text-xl tracking-tight">Partner Portal</span>
                    </a>
                </div>
                <div class="flex items-center">
                    <a href="logout" class="text-sm font-medium text-gray-300 hover:text-white bg-gray-800 hover:bg-gray-700 px-4 py-2 rounded transition">Sign Out</a>
                </div>
            </div>
        </div>
    </nav>

    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <% if (restaurant != null) { %>
            
            <div class="bg-white rounded-xl shadow-sm border border-gray-100 p-6 mb-8 animate-fade-in-up">
                <div class="flex justify-between items-center">
                    <div>
                        <h1 class="text-3xl font-bold text-gray-900"><%= restaurant.getName() %></h1>
                        <p class="text-gray-500"><i class="fa-solid fa-map-marker-alt text-zomato-red mr-1"></i> <%= restaurant.getAddress() %></p>
                    </div>
                    <div class="bg-green-100 text-green-800 px-4 py-2 rounded-lg font-bold">
                        <i class="fa-solid fa-circle text-[10px] mr-1"></i> Active
                    </div>
                </div>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                
                <!-- Orders Section -->
                <div class="lg:col-span-2 space-y-6 animate-fade-in-up delay-100">
                    <div class="bg-white rounded-xl shadow-sm border border-gray-100 p-6">
                        <h2 class="text-xl font-bold text-gray-800 mb-6 border-b pb-2">Active Orders</h2>
                        
                        <% if (orders != null && !orders.isEmpty()) { %>
                            <div class="space-y-4">
                                <% for (Order o : orders) { 
                                    if(o.getStatus().equals("Delivered") || o.getStatus().equals("Cancelled")) continue;
                                %>
                                <div class="border border-gray-200 rounded-lg p-4 hover:shadow-md transition">
                                    <div class="flex justify-between items-start mb-3 border-b border-gray-100 pb-3">
                                        <div>
                                            <div class="font-bold text-gray-900 text-lg">Order #<%= o.getOrderId() %></div>
                                            <div class="text-sm text-gray-500"><%= o.getOrderDate() %></div>
                                        </div>
                                        <div class="text-right">
                                            <div class="font-bold text-zomato-red text-lg">₹<%= o.getTotalAmount() %></div>
                                            <span class="inline-block bg-yellow-100 text-yellow-800 text-xs font-bold px-2 py-1 rounded mt-1"><%= o.getStatus() %></span>
                                        </div>
                                    </div>
                                    <div class="flex gap-2 justify-end">
                                        <form action="update-order-status" method="post" class="inline">
                                            <input type="hidden" name="order_id" value="<%= o.getOrderId() %>">
                                            <input type="hidden" name="status" value="Preparing">
                                            <button class="bg-orange-50 text-orange-600 hover:bg-orange-100 font-bold py-1.5 px-3 rounded text-sm border border-orange-200 transition">Prepare</button>
                                        </form>
                                        <form action="update-order-status" method="post" class="inline">
                                            <input type="hidden" name="order_id" value="<%= o.getOrderId() %>">
                                            <input type="hidden" name="status" value="Ready">
                                            <button class="bg-green-50 text-green-600 hover:bg-green-100 font-bold py-1.5 px-3 rounded text-sm border border-green-200 transition">Ready</button>
                                        </form>
                                    </div>
                                </div>
                                <% } %>
                            </div>
                        <% } else { %>
                            <p class="text-gray-500 text-center py-4">No active orders right now.</p>
                        <% } %>
                    </div>
                </div>

                <!-- Menu Management Section -->
                <div class="space-y-6 animate-fade-in-up delay-200">
                    <div class="bg-white rounded-xl shadow-sm border border-gray-100 p-6">
                        <div class="flex justify-between items-center mb-6 border-b pb-2">
                            <h2 class="text-xl font-bold text-gray-800">Menu Catalog</h2>
                            <button onclick="document.getElementById('addMenuModal').classList.remove('hidden')" class="bg-gray-900 text-white hover:bg-gray-800 font-bold py-1.5 px-3 rounded text-sm transition">
                                <i class="fa-solid fa-plus mr-1"></i> Add
                            </button>
                        </div>

                        <div class="space-y-3 max-h-[500px] overflow-y-auto pr-2">
                            <% if (menus != null && !menus.isEmpty()) { 
                                for (Menu m : menus) { 
                            %>
                            <div class="flex items-center p-3 border border-gray-100 rounded-lg hover:bg-gray-50">
                                <% if(m.getImageUrl() != null && !m.getImageUrl().isEmpty()) { %>
                                    <img src="<%= m.getImageUrl() %>" alt="" class="w-12 h-12 object-cover rounded mr-3">
                                <% } else { %>
                                    <div class="w-12 h-12 bg-gray-200 rounded flex items-center justify-center mr-3 text-gray-400"><i class="fa-solid fa-image"></i></div>
                                <% } %>
                                <div class="flex-1 min-w-0">
                                    <div class="font-bold text-gray-900 text-sm truncate"><%= m.getMenuName() %></div>
                                    <div class="text-gray-500 text-xs truncate">₹<%= m.getPrice() %></div>
                                </div>
                                <div>
                                    <form action="manage-menu" method="post" class="inline">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="menu_id" value="<%= m.getMenuId() %>">
                                        <button class="text-red-500 hover:text-red-700 p-1"><i class="fa-solid fa-trash text-sm"></i></button>
                                    </form>
                                </div>
                            </div>
                            <%  }
                            } else { %>
                                <p class="text-gray-500 text-sm text-center py-4">Your menu is empty.</p>
                            <% } %>
                        </div>
                    </div>
                </div>

            </div>

            <!-- Add Menu Modal -->
            <div id="addMenuModal" class="fixed inset-0 bg-gray-900/75 backdrop-blur-sm z-50 hidden flex items-center justify-center p-4">
                <div class="bg-white rounded-xl shadow-2xl max-w-md w-full overflow-hidden">
                    <div class="bg-gray-50 p-4 border-b flex justify-between items-center">
                        <h3 class="font-bold text-lg text-gray-900">Add New Dish</h3>
                        <button onclick="document.getElementById('addMenuModal').classList.add('hidden')" class="text-gray-400 hover:text-gray-600"><i class="fa-solid fa-xmark text-xl"></i></button>
                    </div>
                    <form action="manage-menu" method="post" enctype="multipart/form-data" class="p-6 space-y-4">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="restaurant_id" value="<%= restaurant.getRestaurantId() %>">
                        
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Dish Name</label>
                            <input type="text" name="menu_name" required class="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-gray-900">
                        </div>
                        
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Description</label>
                            <textarea name="description" rows="2" class="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-gray-900"></textarea>
                        </div>
                        
                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Price (₹)</label>
                                <input type="number" name="price" step="0.01" required class="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-gray-900">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Category</label>
                                <select name="category" class="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-gray-900 bg-white">
                                    <option value="Starters">Starters</option>
                                    <option value="Main Course">Main Course</option>
                                    <option value="Desserts">Desserts</option>
                                    <option value="Beverages">Beverages</option>
                                </select>
                            </div>
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Food Image</label>
                            <input type="file" name="image_file" accept="image/*" class="w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-sm file:font-semibold file:bg-red-50 file:text-zomato-red hover:file:bg-red-100">
                        </div>

                        <div class="flex items-center mt-2">
                            <input type="checkbox" name="is_available" value="true" checked class="h-4 w-4 text-zomato-red focus:ring-red-500 border-gray-300 rounded">
                            <label class="ml-2 block text-sm text-gray-900">Available to order</label>
                        </div>

                        <button type="submit" class="w-full bg-zomato-red text-white font-bold py-3 rounded-lg shadow-md hover:bg-red-700 transition mt-4">Add Dish</button>
                    </form>
                </div>
            </div>

        <% } else { %>
            <!-- Not Registered as Restaurant Owner UI -->
            <div class="bg-white rounded-xl shadow-sm border border-gray-100 py-16 text-center animate-fade-in-up max-w-2xl mx-auto">
                <i class="fa-solid fa-store-slash text-6xl text-gray-300 mb-4"></i>
                <h3 class="text-2xl font-bold text-gray-800 mb-2">Setup Your Restaurant</h3>
                <p class="text-gray-500 mb-8">You need to register your restaurant details before you can access the dashboard.</p>
                <p class="text-xs text-red-500 italic">(Mock: Registration feature to be added in next phase)</p>
            </div>
        <% } %>
    </main>
</body>
</html>
