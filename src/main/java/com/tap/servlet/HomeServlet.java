package com.tap.servlet;

import com.tap.dao.RestaurantDAO;
import com.tap.dao.impl.RestaurantDAOImpl;
import com.tap.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

/**
 * Servlet to display the home page with a list of all active restaurants.
 * Requires an active user session.
 */
public class HomeServlet extends HttpServlet {

    private RestaurantDAO restaurantDAO;

    @Override
    public void init() throws ServletException {
        restaurantDAO = new RestaurantDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("login");
            return;
        }

        // Fetch all active restaurants from the database
        List<Restaurant> restaurants = restaurantDAO.getActiveRestaurants();
        request.setAttribute("restaurantList", restaurants);

        // Forward to home.jsp
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}
