package com.tap.servlet;

import com.tap.dao.OrderDAO;
import com.tap.dao.impl.OrderDAOImpl;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class UpdateOrderStatusServlet extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("login");
            return;
        }

        User user = (User) session.getAttribute("loggedInUser");
        String role = user.getRole();

        int orderId = Integer.parseInt(request.getParameter("order_id"));
        String status = request.getParameter("status");

        if ("RESTAURANT".equalsIgnoreCase(role) || "DELIVERY".equalsIgnoreCase(role)) {
            orderDAO.updateOrderStatus(orderId, status);
        }

        if ("DELIVERY".equalsIgnoreCase(role) && request.getParameter("accept") != null) {
            orderDAO.updateDeliveryPartner(orderId, user.getUserId());
        }

        if ("RESTAURANT".equalsIgnoreCase(role)) {
            response.sendRedirect("restaurant-dashboard");
        } else if ("DELIVERY".equalsIgnoreCase(role)) {
            response.sendRedirect("delivery-dashboard");
        } else {
            response.sendRedirect("home");
        }
    }
}
