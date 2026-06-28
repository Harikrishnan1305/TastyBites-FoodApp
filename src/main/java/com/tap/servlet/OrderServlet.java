package com.tap.servlet;

import com.tap.dao.MenuDAO;
import com.tap.dao.OrderDAO;
import com.tap.dao.OrderItemDAO;
import com.tap.dao.impl.MenuDAOImpl;
import com.tap.dao.impl.OrderDAOImpl;
import com.tap.dao.impl.OrderItemDAOImpl;
import com.tap.model.Menu;
import com.tap.model.Order;
import com.tap.model.OrderItem;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Map;

/**
 * Servlet to handle order placement (checkout).
 * 
 * GET  → displays the checkout page (checkout.jsp)
 * POST → creates an Order and OrderItems from the session cart, clears cart,
 *         and forwards to order-confirmation.jsp
 */
public class OrderServlet extends HttpServlet {

    private OrderDAO orderDAO;
    private OrderItemDAO orderItemDAO;
    private MenuDAO menuDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAOImpl();
        orderItemDAO = new OrderItemDAOImpl();
        menuDAO = new MenuDAOImpl();
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

        // Check if cart has items
        @SuppressWarnings("unchecked")
        Map<Integer, int[]> cart = (Map<Integer, int[]>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("home");
            return;
        }

        // Calculate total and set attributes for checkout page
        double totalAmount = 0;
        for (Map.Entry<Integer, int[]> entry : cart.entrySet()) {
            Menu menu = menuDAO.getMenu(entry.getKey());
            if (menu != null) {
                totalAmount += menu.getPrice() * entry.getValue()[0];
            }
        }

        User user = (User) session.getAttribute("loggedInUser");
        request.setAttribute("totalAmount", totalAmount);
        request.setAttribute("userAddress", user.getAddress());
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("login");
            return;
        }

        // Get cart from session
        @SuppressWarnings("unchecked")
        Map<Integer, int[]> cart = (Map<Integer, int[]>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("home");
            return;
        }

        // Get payment method and delivery address from form
        String paymentMethod = request.getParameter("payment_method");
        String deliveryAddress = request.getParameter("delivery_address");

        // Get user info from session
        User user = (User) session.getAttribute("loggedInUser");
        int userId = user.getUserId();

        // Determine restaurant_id and total amount
        int restaurantId = cart.values().iterator().next()[1];
        double totalAmount = 0;

        for (Map.Entry<Integer, int[]> entry : cart.entrySet()) {
            Menu menu = menuDAO.getMenu(entry.getKey());
            if (menu != null) {
                totalAmount += menu.getPrice() * entry.getValue()[0];
            }
        }

        // Create the Order as Pending Payment
        Order order = new Order(userId, restaurantId, totalAmount, "Pending Payment", paymentMethod, deliveryAddress);
        int orderId = orderDAO.addOrder(order);

        if (orderId > 0) {
            // Create OrderItems for each item in the cart
            for (Map.Entry<Integer, int[]> entry : cart.entrySet()) {
                int menuId = entry.getKey();
                int quantity = entry.getValue()[0];
                Menu menu = menuDAO.getMenu(menuId);
                if (menu != null) {
                    OrderItem orderItem = new OrderItem(orderId, menuId, quantity, menu.getPrice());
                    orderItemDAO.addOrderItem(orderItem);
                }
            }

            // Clear the cart
            session.removeAttribute("cart");

            // Redirect to payment page
            response.sendRedirect("payment?order_id=" + orderId);
        } else {
            request.setAttribute("errorMessage", "Failed to place order. Please try again.");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        }
    }
}
