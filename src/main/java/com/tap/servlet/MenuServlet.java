package com.tap.servlet;

import com.tap.dao.MenuDAO;
import com.tap.dao.RestaurantDAO;
import com.tap.dao.impl.MenuDAOImpl;
import com.tap.dao.impl.RestaurantDAOImpl;
import com.tap.model.Menu;
import com.tap.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

/**
 * Servlet to display the menu items for a selected restaurant.
 * Requires restaurant_id as a request parameter.
 */
public class MenuServlet extends HttpServlet {

    private MenuDAO menuDAO;
    private RestaurantDAO restaurantDAO;

    @Override
    public void init() throws ServletException {
        menuDAO = new MenuDAOImpl();
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

        // Get restaurant_id from request parameter
        String restaurantIdParam = request.getParameter("restaurant_id");
        if (restaurantIdParam == null || restaurantIdParam.isEmpty()) {
            response.sendRedirect("home");
            return;
        }

        try {
            int restaurantId = Integer.parseInt(restaurantIdParam);

            // Fetch restaurant details
            Restaurant restaurant = restaurantDAO.getRestaurant(restaurantId);
            if (restaurant == null) {
                response.sendRedirect("home");
                return;
            }

            // Fetch menu items for this restaurant
            List<Menu> menuList = menuDAO.getMenuByRestaurant(restaurantId);

            // Set attributes and forward to menu.jsp
            request.setAttribute("restaurant", restaurant);
            request.setAttribute("menuList", menuList);
            request.getRequestDispatcher("menu.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("home");
        }
    }
}
