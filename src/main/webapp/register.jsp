<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account — TastyBites</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/style.css">
</head>
<body class="bg-gray-50 flex items-center justify-center min-h-screen py-10">
    <div class="flex w-full max-w-5xl bg-white rounded-2xl shadow-2xl overflow-hidden animate-fade-in-up">
        
        <!-- Left Banner -->
        <div class="hidden md:flex flex-col justify-center w-5/12 p-12 bg-zomato-red text-white">
            <h1 class="text-4xl font-bold mb-6">Join TastyBites</h1>
            <p class="text-lg opacity-90 leading-relaxed mb-8">
                Whether you're a foodie, a restaurant owner, or a delivery partner, we have something for you.
            </p>
            <ul class="space-y-4 opacity-90">
                <li class="flex items-center"><span class="mr-3 text-xl">🍔</span> Order your favorite meals</li>
                <li class="flex items-center"><span class="mr-3 text-xl">🏪</span> Grow your restaurant business</li>
                <li class="flex items-center"><span class="mr-3 text-xl">🛵</span> Earn by delivering food</li>
            </ul>
        </div>

        <!-- Right Registration Form -->
        <div class="w-full md:w-7/12 p-8 md:p-12">
            <div class="max-w-md mx-auto">
                <h2 class="text-3xl font-bold text-gray-800 mb-2">Create an account</h2>
                <p class="text-gray-500 mb-8">Fill in the details below to get started.</p>

                <% if (request.getAttribute("errorMessage") != null) { %>
                    <div class="bg-red-50 text-red-600 p-4 rounded-lg mb-6 border border-red-100">
                        <%= request.getAttribute("errorMessage") %>
                    </div>
                <% } %>

                <form action="register" method="post" class="space-y-5">
                    
                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Username</label>
                            <input type="text" name="username" required 
                                class="w-full px-4 py-2.5 rounded-lg border border-gray-300 focus:ring-2 focus:ring-red-500 focus:border-red-500 transition-colors"
                                placeholder="john_doe">
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Password</label>
                            <div class="relative">
                                <input type="password" name="password" id="regPassword" required
                                    class="w-full px-4 py-2.5 rounded-lg border border-gray-300 focus:ring-2 focus:ring-red-500 focus:border-red-500 transition-colors pr-10"
                                    placeholder="••••••••">
                                <button type="button" onclick="togglePassword('regPassword','regEyeIcon')"
                                    class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-700 focus:outline-none">
                                    <svg id="regEyeIcon" xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                                    </svg>
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Email</label>
                            <input type="email" name="email" required 
                                class="w-full px-4 py-2.5 rounded-lg border border-gray-300 focus:ring-2 focus:ring-red-500 focus:border-red-500 transition-colors"
                                placeholder="john@example.com">
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Phone</label>
                            <input type="tel" name="phone" required 
                                class="w-full px-4 py-2.5 rounded-lg border border-gray-300 focus:ring-2 focus:ring-red-500 focus:border-red-500 transition-colors"
                                placeholder="+91 9876543210">
                        </div>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Address</label>
                        <textarea name="address" rows="2" required 
                            class="w-full px-4 py-2.5 rounded-lg border border-gray-300 focus:ring-2 focus:ring-red-500 focus:border-red-500 transition-colors"
                            placeholder="Enter your full address"></textarea>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">I am a...</label>
                        <div class="grid grid-cols-3 gap-3">
                            <label class="cursor-pointer">
                                <input type="radio" name="role" value="CUSTOMER" class="peer sr-only" checked>
                                <div class="text-center p-3 rounded-lg border border-gray-200 peer-checked:border-red-500 peer-checked:bg-red-50 peer-checked:text-red-700 hover:bg-gray-50 transition-colors">
                                    Customer
                                </div>
                            </label>
                            <label class="cursor-pointer">
                                <input type="radio" name="role" value="RESTAURANT" class="peer sr-only">
                                <div class="text-center p-3 rounded-lg border border-gray-200 peer-checked:border-red-500 peer-checked:bg-red-50 peer-checked:text-red-700 hover:bg-gray-50 transition-colors">
                                    Restaurant
                                </div>
                            </label>
                            <label class="cursor-pointer">
                                <input type="radio" name="role" value="DELIVERY" class="peer sr-only">
                                <div class="text-center p-3 rounded-lg border border-gray-200 peer-checked:border-red-500 peer-checked:bg-red-50 peer-checked:text-red-700 hover:bg-gray-50 transition-colors">
                                    Delivery
                                </div>
                            </label>
                        </div>
                    </div>

                    <button type="submit" 
                        class="w-full bg-zomato-red hover-bg-zomato-red text-white font-semibold py-3 px-4 rounded-lg mt-6 shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 transition-all duration-200">
                        Create Account
                    </button>
                </form>

                <p class="mt-8 text-center text-gray-600">
                    Already have an account? 
                    <a href="login" class="text-zomato-red font-semibold hover:underline">Sign in</a>
                </p>
            </div>
        </div>
    </div>
<script>
    function togglePassword(inputId, iconId) {
        const input = document.getElementById(inputId);
        const icon  = document.getElementById(iconId);
        if (input.type === 'password') {
            input.type = 'text';
            icon.innerHTML = `<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21"/>`;
        } else {
            input.type = 'password';
            icon.innerHTML = `<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>`;
        }
    }
</script>
</body>
</html>
