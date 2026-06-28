package com.tap.servlet;

import com.tap.dao.OrderDAO;
import com.tap.dao.impl.OrderDAOImpl;
import com.tap.model.Order;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class DeliveryDashboardServlet extends HttpServlet {
    private OrderDAO orderDAO;

    @Override
    public void init() {
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
        if (!"DELIVERY".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect("dashboard");
            return;
        }

        List<Order> allOrders = orderDAO.getAllOrders();
        List<Order> availableOrders = new ArrayList<>();
        List<Order> myOrders = new ArrayList<>();

        for (Order o : allOrders) {
            if ("Ready".equalsIgnoreCase(o.getStatus()) && o.getDeliveryPartnerId() == 0) {
                availableOrders.add(o);
            } else if (o.getDeliveryPartnerId() == user.getUserId() && !o.getStatus().equalsIgnoreCase("Delivered")) {
                myOrders.add(o);
            }
        }

        request.setAttribute("availableOrders", availableOrders);
        request.setAttribute("myOrders", myOrders);
        request.getRequestDispatcher("delivery-dashboard.jsp").forward(request, response);
    }
}
