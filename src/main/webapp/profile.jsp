<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.tap.model.User" %>
<%
    User user = (User) session.getAttribute("loggedInUser");
    if (user == null) {
        response.sendRedirect("login");
        return;
    }
    String updated = request.getParameter("updated");
    String error   = (String) request.getAttribute("errorMessage");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile — TastyBites</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/style.css">
</head>
<body class="bg-gray-50 min-h-screen">

    <!-- Navbar -->
    <nav class="bg-white shadow-sm sticky top-0 z-50 border-b border-gray-100">
        <div class="max-w-5xl mx-auto px-4 h-16 flex items-center justify-between">
            <a href="home" class="flex items-center gap-2 text-gray-700 hover:text-red-500 transition font-semibold">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
                </svg>
                Back to Home
            </a>
            <span class="font-bold text-xl" style="color:#e23744">🍔 TastyBites</span>
            <a href="logout" class="text-sm text-gray-500 hover:text-red-500 transition">Sign Out</a>
        </div>
    </nav>

    <div class="max-w-2xl mx-auto px-4 py-10">

        <!-- Profile Header -->
        <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-8 mb-6 text-center">
            <div class="w-20 h-20 rounded-full flex items-center justify-center text-4xl mx-auto mb-4"
                 style="background:linear-gradient(135deg,#e23744,#ff6b35)">
                <%= user.getUsername().substring(0,1).toUpperCase() %>
            </div>
            <h1 class="text-2xl font-bold text-gray-800"><%= user.getUsername() %></h1>
            <p class="text-gray-500 text-sm mt-1"><%= user.getEmail() %></p>
            <span class="inline-block mt-3 px-4 py-1 rounded-full text-xs font-bold
                <%= user.getRole().equals("CUSTOMER") ? "bg-blue-100 text-blue-700" :
                    user.getRole().equals("RESTAURANT") ? "bg-orange-100 text-orange-700" :
                    "bg-green-100 text-green-700" %>">
                <%= user.getRole() %>
            </span>
        </div>

        <!-- Success / Error Alert -->
        <% if ("true".equals(updated)) { %>
        <div class="flex items-center gap-3 bg-green-50 border border-green-200 text-green-700 p-4 rounded-xl mb-6">
            <svg class="w-5 h-5 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
            </svg>
            Profile updated successfully!
        </div>
        <% } %>
        <% if (error != null) { %>
        <div class="flex items-center gap-3 bg-red-50 border border-red-200 text-red-700 p-4 rounded-xl mb-6">
            <svg class="w-5 h-5 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
            </svg>
            <%= error %>
        </div>
        <% } %>

        <!-- Edit Form -->
        <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-8">
            <h2 class="text-lg font-bold text-gray-800 mb-6 flex items-center gap-2">
                <svg class="w-5 h-5 text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/>
                </svg>
                Edit My Details
            </h2>

            <form action="profile" method="post" class="space-y-5">

                <!-- Username -->
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Username</label>
                    <input type="text" name="username" value="<%= user.getUsername() %>" required
                        class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-red-500 focus:border-red-500 transition outline-none text-gray-800">
                </div>

                <!-- Email (read-only) -->
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">
                        Email <span class="text-xs text-gray-400 font-normal">(cannot be changed)</span>
                    </label>
                    <input type="email" value="<%= user.getEmail() %>" readonly
                        class="w-full px-4 py-3 rounded-xl border border-gray-200 bg-gray-50 text-gray-400 cursor-not-allowed outline-none">
                </div>

                <!-- Phone -->
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Phone Number</label>
                    <input type="tel" name="phone" value="<%= user.getPhone() != null ? user.getPhone() : "" %>" required
                        class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-red-500 focus:border-red-500 transition outline-none text-gray-800">
                </div>

                <!-- Address -->
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Delivery Address</label>
                    <textarea name="address" rows="3" required
                        class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-red-500 focus:border-red-500 transition outline-none text-gray-800 resize-none"><%= user.getAddress() != null ? user.getAddress() : "" %></textarea>
                </div>

                <!-- Change Password Section -->
                <div class="border-t border-gray-100 pt-5">
                    <h3 class="text-sm font-bold text-gray-700 mb-4">Change Password <span class="font-normal text-gray-400">(leave blank to keep current)</span></h3>

                    <!-- Current Password -->
                    <div class="mb-4">
                        <label class="block text-sm font-medium text-gray-700 mb-1">Current Password</label>
                        <div class="relative">
                            <input type="password" name="currentPassword" id="currentPwd"
                                class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-red-500 focus:border-red-500 transition outline-none pr-12"
                                placeholder="Enter current password">
                            <button type="button" onclick="togglePassword('currentPwd','eyeCurrent')"
                                class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-700">
                                <svg id="eyeCurrent" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
                                </svg>
                            </button>
                        </div>
                    </div>

                    <!-- New Password -->
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">New Password</label>
                        <div class="relative">
                            <input type="password" name="newPassword" id="newPwd"
                                class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:ring-2 focus:ring-red-500 focus:border-red-500 transition outline-none pr-12"
                                placeholder="Enter new password">
                            <button type="button" onclick="togglePassword('newPwd','eyeNew')"
                                class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-700">
                                <svg id="eyeNew" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
                                </svg>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Submit -->
                <button type="submit"
                    class="w-full text-white font-bold py-3 rounded-xl shadow-lg transition transform hover:-translate-y-0.5 hover:shadow-xl mt-2"
                    style="background:#e23744">
                    💾 Save Changes
                </button>
            </form>
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
