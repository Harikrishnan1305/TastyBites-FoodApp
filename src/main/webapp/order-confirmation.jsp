<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.tap.model.Order" %>
<%@ page import="com.tap.model.Payment" %>
<%
    if (session.getAttribute("loggedInUser") == null) {
        response.sendRedirect("login");
        return;
    }
    Order order = (Order) request.getAttribute("order");
    Payment payment = (Payment) request.getAttribute("payment");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmed - TastyBites</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-50 flex items-center justify-center min-h-screen p-4">
    
    <% if (order != null) { %>
    <div class="bg-white rounded-2xl shadow-xl w-full max-w-lg overflow-hidden animate-fade-in-up">
        
        <div class="bg-green-500 p-8 text-center text-white relative">
            <div class="w-20 h-20 bg-white rounded-full flex items-center justify-center mx-auto mb-4 shadow-lg text-green-500">
                <i class="fa-solid fa-check text-4xl"></i>
            </div>
            <h1 class="text-3xl font-bold mb-2">Order Confirmed!</h1>
            <p class="opacity-90 text-sm">Your order is received and will be processed shortly.</p>
        </div>

        <div class="p-8">
            <div class="flex justify-between items-center border-b border-gray-100 pb-4 mb-4">
                <div>
                    <p class="text-xs text-gray-500 uppercase tracking-wider font-bold mb-1">Order ID</p>
                    <p class="text-lg font-bold text-gray-900">#<%= order.getOrderId() %></p>
                </div>
                <div class="text-right">
                    <p class="text-xs text-gray-500 uppercase tracking-wider font-bold mb-1">Amount Paid</p>
                    <p class="text-lg font-bold text-gray-900">₹<%= order.getTotalAmount() %></p>
                </div>
            </div>

            <div class="space-y-3 mb-8 text-sm">
                <div class="flex justify-between">
                    <span class="text-gray-500">Payment Method:</span>
                    <span class="font-medium text-gray-900"><%= order.getPaymentMethod() %></span>
                </div>
                <% if(payment != null) { %>
                <div class="flex justify-between">
                    <span class="text-gray-500">Transaction ID:</span>
                    <span class="font-medium text-gray-900"><%= payment.getTransactionId() %></span>
                </div>
                <% } %>
                <div class="flex justify-between">
                    <span class="text-gray-500">Delivery Address:</span>
                    <span class="font-medium text-gray-900 text-right w-1/2 truncate"><%= order.getDeliveryAddress() %></span>
                </div>
            </div>

            <div class="flex gap-4">
                <a href="order-history" class="flex-1 bg-white border border-gray-300 text-gray-700 text-center font-bold py-3 px-4 rounded-xl hover:bg-gray-50 transition">
                    Track Order
                </a>
                <a href="dashboard" class="flex-1 bg-zomato-red text-white text-center font-bold py-3 px-4 rounded-xl hover-bg-zomato-red shadow hover:shadow-lg transition">
                    Back to Home
                </a>
            </div>
        </div>
    </div>
    <% } else { %>
        <div class="bg-white rounded-2xl shadow-xl w-full max-w-lg p-10 text-center">
            <h1 class="text-3xl font-bold text-red-500 mb-4">Error</h1>
            <p class="text-gray-600 mb-6">Could not retrieve order details.</p>
            <a href="dashboard" class="inline-block bg-gray-900 text-white px-6 py-2 rounded-lg font-semibold hover:bg-gray-800">Return Home</a>
        </div>
    <% } %>

</body>
</html>
