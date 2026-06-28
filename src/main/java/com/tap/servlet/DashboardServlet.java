package com.tap.servlet;

import com.tap.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class DashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("login");
            return;
        }

        User user = (User) session.getAttribute("loggedInUser");
        String role = user.getRole();

        if ("RESTAURANT".equalsIgnoreCase(role)) {
            response.sendRedirect("restaurant-dashboard");
        } else if ("DELIVERY".equalsIgnoreCase(role)) {
            response.sendRedirect("delivery-dashboard");
        } else {
            response.sendRedirect("home");
        }
    }
}
