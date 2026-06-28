<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.tap.model.Menu" %>
<%@ page import="com.tap.dao.MenuDAO" %>
<%@ page import="com.tap.dao.impl.MenuDAOImpl" %>
<%
    if (session.getAttribute("loggedInUser") == null) {
        response.sendRedirect("login");
        return;
    }
    Map<Integer, int[]> cart = (Map<Integer, int[]>) session.getAttribute("cart");
    MenuDAO menuDAO = new MenuDAOImpl();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Secure Checkout - TastyBites</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-50 font-sans">

    <!-- Minimal Navbar -->
    <nav class="bg-white shadow-sm sticky top-0 z-50">
        <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-20 items-center">
                <a href="dashboard" class="flex items-center text-zomato-red hover:text-red-700 transition">
                    <i class="fa-solid fa-arrow-left mr-3"></i> Back to Menu
                </a>
                <span class="font-bold text-2xl tracking-tight text-gray-800">Secure Checkout</span>
                <div class="w-10"></div> <!-- Spacer for centering -->
            </div>
        </div>
    </nav>

    <main class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
        <% if (cart != null && !cart.isEmpty()) { %>
            <div class="bg-white rounded-xl shadow-lg border border-gray-100 overflow-hidden animate-fade-in-up">
                
                <div class="p-6 sm:p-8 bg-gray-50 border-b border-gray-100">
                    <h2 class="text-xl font-bold text-gray-900">Your Cart (<%= cart.size() %> items)</h2>
                </div>

                <div class="p-6 sm:p-8">
                    <table class="w-full text-left border-collapse">
                        <thead>
                            <tr class="border-b-2 border-gray-100 text-gray-500 uppercase text-xs tracking-wider">
                                <th class="pb-3 w-1/2">Item</th>
                                <th class="pb-3 text-center">Qty</th>
                                <th class="pb-3 text-right">Price</th>
                                <th class="pb-3 text-right">Action</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-100">
                            <% 
                                double total = 0.0;
                                for (Map.Entry<Integer, int[]> entry : cart.entrySet()) {
                                    Menu menu = menuDAO.getMenu(entry.getKey());
                                    if (menu != null) {
                                        int quantity = entry.getValue()[0];
                                        double subtotal = menu.getPrice() * quantity;
                                        total += subtotal;
                            %>
                            <tr class="hover:bg-gray-50 transition">
                                <td class="py-4">
                                    <div class="flex items-center">
                                        <div class="w-4 h-4 border border-green-600 flex items-center justify-center rounded-sm mr-3 flex-shrink-0">
                                            <div class="w-2 h-2 bg-green-600 rounded-full"></div>
                                        </div>
                                        <span class="font-semibold text-gray-800"><%= menu.getMenuName() %></span>
                                    </div>
                                </td>
                                <td class="py-4 text-center text-gray-700 font-medium"><%= quantity %></td>
                                <td class="py-4 text-right text-gray-900 font-bold">₹<%= subtotal %></td>
                                <td class="py-4 text-right">
                                    <form action="cart" method="post">
                                        <input type="hidden" name="action" value="remove">
                                        <input type="hidden" name="menu_id" value="<%= menu.getMenuId() %>">
                                        <button type="submit" class="text-red-500 hover:text-red-700 hover:bg-red-50 p-2 rounded-full transition">
                                            <i class="fa-solid fa-trash"></i>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                            <%      }
                                } 
                            %>
                        </tbody>
                    </table>
                </div>

                <div class="bg-gray-50 p-6 sm:p-8 border-t border-gray-100">
                    <div class="flex justify-between text-gray-600 mb-2">
                        <span>Item Total</span>
                        <span>₹<%= total %></span>
                    </div>
                    <div class="flex justify-between text-gray-600 mb-4 border-b border-gray-200 pb-4">
                        <span>Delivery Fee</span>
                        <span class="text-green-600">FREE</span>
                    </div>
                    <div class="flex justify-between text-2xl font-bold text-gray-900 mb-8">
                        <span>To Pay</span>
                        <span>₹<%= total %></span>
                    </div>

                    <a href="order" class="block w-full bg-zomato-red hover-bg-zomato-red text-white text-center font-bold text-lg py-4 rounded-xl shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 transition duration-200">
                        Proceed to Checkout
                    </a>
                </div>
            </div>
        <% } else { %>
            <div class="bg-white rounded-xl shadow-sm border border-gray-100 py-16 text-center animate-fade-in-up">
                <img src="https://cdni.iconscout.com/illustration/premium/thumb/empty-cart-2130356-1800917.png" alt="Empty Cart" class="mx-auto w-64 h-64 object-contain opacity-50 mb-4">
                <h3 class="text-2xl font-bold text-gray-800 mb-2">Your cart is empty</h3>
                <p class="text-gray-500 mb-8">You can go to home page to view more restaurants</p>
                <a href="dashboard" class="inline-block bg-zomato-red text-white font-semibold py-3 px-8 rounded-lg shadow hover:bg-red-700 transition">
                    See restaurants near you
                </a>
            </div>
        <% } %>
    </main>
</body>
</html>
