<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.tap.model.Order" %>
<%
    Order order = (Order) request.getAttribute("order");
    if (order == null) {
        response.sendRedirect("dashboard");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment - TastyBites Secure Gateway</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Inline styles for simulated loader -->
    <style>
        .loader {
            border-top-color: #e23744;
            -webkit-animation: spinner 1.5s linear infinite;
            animation: spinner 1.5s linear infinite;
        }
        @keyframes spinner {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body class="bg-gray-100 flex items-center justify-center min-h-screen">
    
    <div class="bg-white rounded-2xl shadow-xl w-full max-w-md p-8 relative overflow-hidden animate-fade-in-up">
        
        <!-- Header -->
        <div class="text-center mb-8">
            <h1 class="text-2xl font-bold text-gray-800 mb-2">Complete Payment</h1>
            <p class="text-gray-500">Order #<%= order.getOrderId() %></p>
            <div class="text-4xl font-extrabold text-gray-900 mt-4">₹<%= order.getTotalAmount() %></div>
        </div>

        <div class="bg-blue-50 border border-blue-100 rounded-lg p-4 mb-6 flex items-start">
            <i class="fa-solid fa-shield-halved text-blue-500 mt-1 mr-3"></i>
            <div>
                <h4 class="text-sm font-bold text-blue-900">Secure Payment Gateway</h4>
                <p class="text-xs text-blue-700">This is a mock payment for testing purposes.</p>
            </div>
        </div>

        <!-- Form -->
        <form action="payment" method="post" id="paymentForm" onsubmit="showLoader()">
            <input type="hidden" name="order_id" value="<%= order.getOrderId() %>">
            <input type="hidden" name="method" value="<%= order.getPaymentMethod() %>">

            <div class="space-y-4 mb-8">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Card Number (Mock)</label>
                    <input type="text" value="4111 •••• •••• 1111" readonly class="w-full px-4 py-3 bg-gray-50 border border-gray-200 rounded-lg text-gray-500 font-mono tracking-widest cursor-not-allowed outline-none">
                </div>
                <div class="flex gap-4">
                    <div class="flex-1">
                        <label class="block text-sm font-medium text-gray-700 mb-1">Expiry</label>
                        <input type="text" value="12/28" readonly class="w-full px-4 py-3 bg-gray-50 border border-gray-200 rounded-lg text-gray-500 cursor-not-allowed outline-none">
                    </div>
                    <div class="flex-1">
                        <label class="block text-sm font-medium text-gray-700 mb-1">CVV</label>
                        <input type="password" value="123" readonly class="w-full px-4 py-3 bg-gray-50 border border-gray-200 rounded-lg text-gray-500 cursor-not-allowed outline-none">
                    </div>
                </div>
            </div>

            <button type="submit" id="payButton" class="w-full bg-zomato-red hover-bg-zomato-red text-white font-bold py-4 rounded-xl shadow-lg transition transform hover:-translate-y-0.5 flex justify-center items-center">
                <span>Pay ₹<%= order.getTotalAmount() %></span>
            </button>
        </form>

        <!-- Loader Overlay -->
        <div id="loaderOverlay" class="absolute inset-0 bg-white/90 backdrop-blur-sm z-50 flex flex-col items-center justify-center hidden">
            <div class="loader ease-linear rounded-full border-4 border-t-4 border-gray-200 h-16 w-16 mb-4"></div>
            <h2 class="text-xl font-bold text-gray-800">Processing Payment...</h2>
            <p class="text-gray-500 text-sm mt-2">Please do not close or refresh this page.</p>
        </div>

    </div>

    <script>
        function showLoader() {
            document.getElementById('loaderOverlay').classList.remove('hidden');
            document.getElementById('payButton').disabled = true;
            // Delay form submission slightly for UX effect (not real async, just delay)
            return true; 
        }
    </script>
</body>
</html>
