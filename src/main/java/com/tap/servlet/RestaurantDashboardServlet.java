package com.tap.servlet;

import com.tap.dao.MenuDAO;
import com.tap.dao.OrderDAO;
import com.tap.dao.RestaurantDAO;
import com.tap.dao.impl.MenuDAOImpl;
import com.tap.dao.impl.OrderDAOImpl;
import com.tap.dao.impl.RestaurantDAOImpl;
import com.tap.model.Menu;
import com.tap.model.Order;
import com.tap.model.Restaurant;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class RestaurantDashboardServlet extends HttpServlet {
    private RestaurantDAO restaurantDAO;
    private MenuDAO menuDAO;
    private OrderDAO orderDAO;

    @Override
    public void init() {
        restaurantDAO = new RestaurantDAOImpl();
        menuDAO = new MenuDAOImpl();
        orderDAO = new OrderDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("login");
            return;
        }

        User user = (User) session.getAttribute("loggedInUser");
        if (!"RESTAURANT".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect("dashboard");
            return;
        }

        // We assume there's a method getRestaurantByUser in RestaurantDAOImpl
        // If not, we iterate through active restaurants to find the match.
        Restaurant myRestaurant = null;
        List<Restaurant> allRestaurants = restaurantDAO.getActiveRestaurants();
        for (Restaurant r : allRestaurants) {
            if (r.getAdminUserId() == user.getUserId()) {
                myRestaurant = r;
                break;
            }
        }

        if (myRestaurant != null) {
            request.setAttribute("restaurant", myRestaurant);
            List<Menu> menus = menuDAO.getMenuByRestaurant(myRestaurant.getRestaurantId());
            request.setAttribute("menus", menus);

            // Using getAllOrders and filtering for this restaurant (simplification)
            List<Order> allOrders = orderDAO.getAllOrders();
            allOrders.removeIf(o -> o.getRestaurantId() != myRestaurant.getRestaurantId());
            request.setAttribute("orders", allOrders);
        }

        request.getRequestDispatcher("restaurant-dashboard.jsp").forward(request, response);
    }
}
