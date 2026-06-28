package com.tap.servlet;

import com.tap.dao.MenuDAO;
import com.tap.dao.impl.MenuDAOImpl;
import com.tap.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Servlet to manage the shopping cart stored in HttpSession.
 * 
 * Cart is stored as a Map<Integer, int[]> where:
 *   Key   = menu_id
 *   Value = int[] { quantity, restaurantId }
 * 
 * Menu details (name, price) are looked up from DB when displaying the cart.
 * 
 * POST actions:
 *   - action=add       → add an item to the cart
 *   - action=update    → update quantity of an item
 *   - action=remove    → remove an item from the cart
 *   - action=clear     → clear the entire cart
 *
 * GET → display the cart page (cart.jsp)
 */
public class CartServlet extends HttpServlet {

    private MenuDAO menuDAO;

    @Override
    public void init() throws ServletException {
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

        // Retrieve cart from session
        @SuppressWarnings("unchecked")
        Map<Integer, int[]> cart = (Map<Integer, int[]>) session.getAttribute("cart");

        if (cart != null && !cart.isEmpty()) {
            // Build a map of menu details for display
            Map<Menu, Integer> cartItems = new LinkedHashMap<>();
            double totalAmount = 0;
            int cartRestaurantId = -1;
            String restaurantName = "";

            for (Map.Entry<Integer, int[]> entry : cart.entrySet()) {
                int menuId = entry.getKey();
                int quantity = entry.getValue()[0];
                int restaurantId = entry.getValue()[1];

                Menu menu = menuDAO.getMenu(menuId);
                if (menu != null) {
                    cartItems.put(menu, quantity);
                    totalAmount += menu.getPrice() * quantity;
                    cartRestaurantId = restaurantId;
                }
            }

            request.setAttribute("cartItems", cartItems);
            request.setAttribute("totalAmount", totalAmount);
            request.setAttribute("cartRestaurantId", cartRestaurantId);
        }

        request.getRequestDispatcher("cart.jsp").forward(request, response);
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

        String action = request.getParameter("action");

        // Retrieve or create cart
        @SuppressWarnings("unchecked")
        Map<Integer, int[]> cart = (Map<Integer, int[]>) session.getAttribute("cart");
        if (cart == null) {
            cart = new LinkedHashMap<>();
        }

        switch (action) {
            case "add":
                int menuId = Integer.parseInt(request.getParameter("menu_id"));
                int restaurantId = Integer.parseInt(request.getParameter("restaurant_id"));
                int qty = 1;
                String qtyParam = request.getParameter("quantity");
                if (qtyParam != null && !qtyParam.isEmpty()) {
                    qty = Integer.parseInt(qtyParam);
                }

                // Check if adding from a different restaurant — clear cart if so
                if (!cart.isEmpty()) {
                    int existingRestId = cart.values().iterator().next()[1];
                    if (existingRestId != restaurantId) {
                        cart.clear(); // Clear cart for new restaurant
                    }
                }

                if (cart.containsKey(menuId)) {
                    int[] existing = cart.get(menuId);
                    existing[0] += qty; // Increase quantity
                } else {
                    cart.put(menuId, new int[]{qty, restaurantId});
                }
                session.setAttribute("cart", cart);
                response.sendRedirect("menu?restaurant_id=" + restaurantId);
                break;

            case "update":
                int updateMenuId = Integer.parseInt(request.getParameter("menu_id"));
                int newQty = Integer.parseInt(request.getParameter("quantity"));
                if (newQty <= 0) {
                    cart.remove(updateMenuId);
                } else if (cart.containsKey(updateMenuId)) {
                    cart.get(updateMenuId)[0] = newQty;
                }
                session.setAttribute("cart", cart);
                response.sendRedirect("cart");
                break;

            case "remove":
                int removeMenuId = Integer.parseInt(request.getParameter("menu_id"));
                cart.remove(removeMenuId);
                session.setAttribute("cart", cart);
                response.sendRedirect("cart");
                break;

            case "clear":
                cart.clear();
                session.setAttribute("cart", cart);
                response.sendRedirect("cart");
                break;

            default:
                response.sendRedirect("cart");
                break;
        }
    }
}
