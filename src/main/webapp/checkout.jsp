<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.tap.model.Menu" %>
<%@ page import="com.tap.dao.MenuDAO" %>
<%@ page import="com.tap.dao.impl.MenuDAOImpl" %>
<%@ page import="com.tap.model.User" %>
<%
    User user = (User) session.getAttribute("loggedInUser");
    if (user == null) {
        response.sendRedirect("login");
        return;
    }
    Map<Integer, int[]> cart = (Map<Integer, int[]>) session.getAttribute("cart");
    if (cart == null || cart.isEmpty()) {
        response.sendRedirect("cart");
        return;
    }
    MenuDAO menuDAO = new MenuDAOImpl();
    double total = 0.0;
    for (Map.Entry<Integer, int[]> entry : cart.entrySet()) {
        Menu menu = menuDAO.getMenu(entry.getKey());
        if (menu != null) {
            total += menu.getPrice() * entry.getValue()[0];
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - TastyBites</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-50 font-sans">
    
    <!-- Minimal Navbar -->
    <nav class="bg-white shadow-sm sticky top-0 z-50">
        <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-20 items-center">
                <a href="cart" class="flex items-center text-zomato-red hover:text-red-700 transition">
                    <i class="fa-solid fa-arrow-left mr-3"></i> Back to Cart
                </a>
                <span class="font-bold text-2xl tracking-tight text-gray-800">Checkout</span>
                <div class="w-10"></div>
            </div>
        </div>
    </nav>

    <main class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
        <div class="flex flex-col md:flex-row gap-8 animate-fade-in-up">
            
            <!-- Form Section -->
            <div class="flex-1">
                <form action="order" method="post" id="checkoutForm" class="space-y-6">
                    <!-- Delivery Address -->
                    <div class="bg-white p-8 rounded-xl shadow-sm border border-gray-100">
                        <h2 class="text-xl font-bold text-gray-800 mb-6 flex items-center">
                            <i class="fa-solid fa-location-dot text-zomato-red mr-3"></i> Delivery Details
                        </h2>
                        
                        <div class="space-y-4">
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Full Name</label>
                                <input type="text" value="<%= user.getUsername() %>" readonly class="w-full px-4 py-2 bg-gray-50 border border-gray-200 rounded-lg text-gray-500 cursor-not-allowed">
                            </div>
                            
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Delivery Address</label>
                                <textarea name="delivery_address" rows="3" required class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-red-500 focus:border-red-500 transition-colors"><%= user.getAddress() != null ? user.getAddress() : "" %></textarea>
                            </div>
                        </div>
                    </div>

                    <!-- Payment Method -->
                    <div class="bg-white p-8 rounded-xl shadow-sm border border-gray-100">
                        <h2 class="text-xl font-bold text-gray-800 mb-6 flex items-center">
                            <i class="fa-solid fa-wallet text-zomato-red mr-3"></i> Payment Method
                        </h2>
                        
                        <div class="space-y-3">
                            <label class="flex items-center p-4 border border-gray-200 rounded-lg cursor-pointer hover:bg-gray-50 transition peer-checked:border-red-500">
                                <input type="radio" name="payment_method" value="Credit Card" required class="w-4 h-4 text-red-600 focus:ring-red-500">
                                <i class="fa-regular fa-credit-card mx-3 text-xl text-gray-400"></i>
                                <span class="font-medium text-gray-700">Credit / Debit Card</span>
                            </label>
                            
                            <label class="flex items-center p-4 border border-gray-200 rounded-lg cursor-pointer hover:bg-gray-50 transition">
                                <input type="radio" name="payment_method" value="UPI" required class="w-4 h-4 text-red-600 focus:ring-red-500">
                                <i class="fa-brands fa-google-pay mx-3 text-xl text-gray-400"></i>
                                <span class="font-medium text-gray-700">UPI / Wallets</span>
                            </label>

                            <label class="flex items-center p-4 border border-gray-200 rounded-lg cursor-pointer hover:bg-gray-50 transition">
                                <input type="radio" name="payment_method" value="Cash on Delivery" required class="w-4 h-4 text-red-600 focus:ring-red-500">
                                <i class="fa-solid fa-money-bill-wave mx-3 text-xl text-gray-400"></i>
                                <span class="font-medium text-gray-700">Cash on Delivery</span>
                            </label>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Order Summary Section -->
            <div class="w-full md:w-80">
                <div class="bg-white p-6 rounded-xl shadow-sm border border-gray-100 sticky top-28">
                    <h2 class="text-lg font-bold text-gray-800 mb-4 pb-2 border-b border-gray-100">Order Summary</h2>
                    
                    <div class="space-y-3 mb-6 max-h-48 overflow-y-auto">
                        <% 
                            for (Map.Entry<Integer, int[]> entry : cart.entrySet()) {
                                Menu menu = menuDAO.getMenu(entry.getKey());
                                if (menu != null) {
                        %>
                        <div class="flex justify-between text-sm">
                            <span class="text-gray-600 truncate pr-2"><%= entry.getValue()[0] %>x <%= menu.getMenuName() %></span>
                            <span class="text-gray-900 font-medium">₹<%= menu.getPrice() * entry.getValue()[0] %></span>
                        </div>
                        <%      }
                            } 
                        %>
                    </div>

                    <div class="border-t border-gray-100 pt-4 space-y-2 mb-6">
                        <div class="flex justify-between text-sm text-gray-600">
                            <span>Subtotal</span>
                            <span>₹<%= total %></span>
                        </div>
                        <div class="flex justify-between text-sm text-gray-600">
                            <span>Delivery Partner Fee</span>
                            <span class="text-green-600">Free</span>
                        </div>
                        <div class="flex justify-between text-lg font-bold text-gray-900 mt-4 pt-4 border-t border-gray-100">
                            <span>Total</span>
                            <span>₹<%= total %></span>
                        </div>
                    </div>

                    <button type="submit" form="checkoutForm" class="w-full bg-zomato-red hover-bg-zomato-red text-white font-bold py-4 rounded-xl shadow-lg transition transform hover:-translate-y-0.5">
                        Place Order
                    </button>
                    <p class="text-xs text-center text-gray-400 mt-4">By placing your order, you agree to our Terms of Use and Privacy Policy.</p>
                </div>
            </div>

        </div>
    </main>

</body>
</html>
