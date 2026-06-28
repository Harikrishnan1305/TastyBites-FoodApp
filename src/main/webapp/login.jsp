<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login — TastyBites</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/style.css">
</head>
<body class="bg-gray-50 flex items-center justify-center min-h-screen">
    <div class="flex w-full max-w-5xl bg-white rounded-2xl shadow-2xl overflow-hidden animate-fade-in-up">
        <!-- Left Banner -->
        <div class="hidden md:flex flex-col justify-center w-1/2 p-12 bg-zomato-red text-white">
            <h1 class="text-5xl font-bold mb-6">TastyBites</h1>
            <p class="text-xl opacity-90 leading-relaxed">
                Discover the best food & drinks in your city.
                Order from your favorite restaurants and track your delivery in real-time.
            </p>
            <div class="mt-12 flex space-x-4">
                <span class="px-4 py-2 bg-white/20 rounded-full backdrop-blur-sm">Fast Delivery</span>
                <span class="px-4 py-2 bg-white/20 rounded-full backdrop-blur-sm">Best Offers</span>
            </div>
        </div>

        <!-- Right Login Form -->
        <div class="w-full md:w-1/2 p-8 md:p-12">
            <div class="max-w-md mx-auto">
                <h2 class="text-3xl font-bold text-gray-800 mb-2">Welcome Back</h2>
                <p class="text-gray-500 mb-8">Please enter your details to sign in.</p>

                <% if (request.getAttribute("errorMessage") != null) { %>
                    <div class="bg-red-50 text-red-600 p-4 rounded-lg mb-6 border border-red-100 flex items-center">
                        <svg class="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"></path></svg>
                        <%= request.getAttribute("errorMessage") %>
                    </div>
                <% } %>
                
                <% if ("success".equals(request.getParameter("registration"))) { %>
                    <div class="bg-green-50 text-green-600 p-4 rounded-lg mb-6 border border-green-100">
                        Registration successful! You can now log in.
                    </div>
                <% } %>

                <form action="login" method="post" class="space-y-6">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Email Address</label>
                        <input type="email" name="email" required 
                            class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-red-500 focus:border-red-500 transition-colors"
                            placeholder="Enter your email">
                    </div>
                    
                    <div>
                        <div class="flex items-center justify-between mb-2">
                            <label class="block text-sm font-medium text-gray-700">Password</label>
                            <a href="#" class="text-sm text-zomato-red hover:underline">Forgot password?</a>
                        </div>
                        <input type="password" name="password" required 
                            class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-red-500 focus:border-red-500 transition-colors"
                            placeholder="••••••••">
                    </div>

                    <button type="submit" 
                        class="w-full bg-zomato-red hover-bg-zomato-red text-white font-semibold py-3 px-4 rounded-lg transition-colors shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 duration-200">
                        Sign In
                    </button>
                </form>

                <p class="mt-8 text-center text-gray-600">
                    Don't have an account? 
                    <a href="register" class="text-zomato-red font-semibold hover:underline">Sign up</a>
                </p>
            </div>
        </div>
    </div>
</body>
</html>
