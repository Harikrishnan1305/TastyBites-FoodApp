<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.tap.model.Order" %>
<%@ page import="com.tap.dao.OrderDAO" %>
<%@ page import="com.tap.dao.impl.OrderDAOImpl" %>
<%
    if (session.getAttribute("loggedInUser") == null) {
        response.sendRedirect("login");
        return;
    }
    String orderIdStr = request.getParameter("order_id");
    Order order = null;
    if (orderIdStr != null) {
        OrderDAO orderDAO = new OrderDAOImpl();
        order = orderDAO.getOrder(Integer.parseInt(orderIdStr));
    }
    if (order == null) {
        response.sendRedirect("order-history");
        return;
    }

    String status = order.getStatus();
    int progress = 0;
    if (status.equals("Placed") || status.equals("Pending Payment") || status.equals("Confirmed")) progress = 25;
    else if (status.equals("Preparing") || status.equals("Ready")) progress = 50;
    else if (status.equals("Picked Up") || status.equals("On the Way")) progress = 75;
    else if (status.equals("Delivered")) progress = 100;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Track Order - TastyBites</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <meta http-equiv="refresh" content="30"> <!-- Auto refresh every 30 seconds -->
</head>
<body class="bg-gray-50 font-sans">

    <nav class="bg-white shadow-sm sticky top-0 z-50">
        <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-20 items-center">
                <a href="order-history" class="flex items-center text-zomato-red hover:text-red-700 transition">
                    <i class="fa-solid fa-arrow-left mr-3"></i> Back
                </a>
                <span class="font-bold text-2xl tracking-tight text-gray-800">Track Order</span>
                <div class="w-10"></div>
            </div>
        </div>
    </nav>

    <main class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
        
        <div class="bg-white rounded-2xl shadow-xl overflow-hidden animate-fade-in-up">
            
            <div class="p-8 border-b border-gray-100 flex justify-between items-center bg-gray-900 text-white">
                <div>
                    <p class="text-sm text-gray-400 mb-1">ORDER ID</p>
                    <h2 class="text-2xl font-bold">#<%= order.getOrderId() %></h2>
                </div>
                <div class="text-right">
                    <p class="text-sm text-gray-400 mb-1">TOTAL AMOUNT</p>
                    <h2 class="text-2xl font-bold">₹<%= order.getTotalAmount() %></h2>
                </div>
            </div>

            <div class="p-8 md:p-12">
                <div class="text-center mb-12">
                    <h3 class="text-2xl font-bold text-gray-800 mb-2"><%= status %></h3>
                    <p class="text-gray-500">
                        <% if(progress < 100) { %>
                            Your food is on its way to you!
                        <% } else { %>
                            Enjoy your meal!
                        <% } %>
                    </p>
                </div>

                <!-- Progress Bar -->
                <div class="relative max-w-2xl mx-auto mb-16">
                    <div class="overflow-hidden h-2 mb-4 text-xs flex rounded bg-gray-200">
                        <div style="width: <%= progress %>%" class="shadow-none flex flex-col text-center whitespace-nowrap text-white justify-center bg-zomato-red transition-all duration-1000"></div>
                    </div>
                    
                    <div class="flex justify-between text-xs font-bold text-gray-400 absolute w-full top-4">
                        <div class="text-center w-1/4 <%= progress >= 25 ? "text-zomato-red" : "" %>">
                            <i class="fa-solid fa-receipt text-xl mb-1 block"></i>
                            Confirmed
                        </div>
                        <div class="text-center w-1/4 <%= progress >= 50 ? "text-zomato-red" : "" %>">
                            <i class="fa-solid fa-fire-burner text-xl mb-1 block"></i>
                            Preparing
                        </div>
                        <div class="text-center w-1/4 <%= progress >= 75 ? "text-zomato-red" : "" %>">
                            <i class="fa-solid fa-motorcycle text-xl mb-1 block"></i>
                            On the Way
                        </div>
                        <div class="text-center w-1/4 <%= progress >= 100 ? "text-green-500" : "" %>">
                            <i class="fa-solid fa-box-open text-xl mb-1 block"></i>
                            Delivered
                        </div>
                    </div>
                </div>
                <br><br>

                <div class="bg-gray-50 p-6 rounded-xl border border-gray-200 flex items-start mt-8">
                    <i class="fa-solid fa-location-dot text-zomato-red text-xl mr-4 mt-1"></i>
                    <div>
                        <h4 class="font-bold text-gray-900 mb-1">Delivery Address</h4>
                        <p class="text-gray-600 text-sm leading-relaxed"><%= order.getDeliveryAddress() %></p>
                    </div>
                </div>

            </div>
        </div>

    </main>

</body>
</html>
