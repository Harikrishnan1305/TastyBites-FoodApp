<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Something went wrong. Please try again.">
    <title>Error — TastyBites</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/style.css">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <div class="container">
            <a href="index.jsp" class="navbar-brand">
                <span class="brand-icon">🍔</span>
                <span class="brand-text">TastyBites</span>
            </a>
            <div class="navbar-links">
                <a href="home">Home</a>
                <a href="login">Login</a>
            </div>
        </div>
    </nav>

    <!-- Error Card -->
    <div class="page-wrapper">
        <div class="error-card glass-card animate-fade-in-up">
            <div class="error-icon">😵</div>
            <h1>Oops! Something Went Wrong</h1>
            <p>We encountered an unexpected error while processing your request. Please try again or go back to the home page.</p>
            
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="alert alert-danger" style="text-align: left; margin-bottom: 24px;">
                    <span>⚠️</span> <%= request.getAttribute("errorMessage") %>
                </div>
            <% } %>

            <div style="display: flex; gap: 12px; justify-content: center; flex-wrap: wrap;">
                <a href="home" class="btn btn-primary">Go to Home</a>
                <a href="javascript:history.back()" class="btn btn-secondary">Go Back</a>
            </div>
        </div>
    </div>
</body>
</html>
