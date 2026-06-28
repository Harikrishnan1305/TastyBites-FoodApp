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
import java.util.List;

public class OrderHistoryServlet extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("login");
            return;
        }

        User user = (User) session.getAttribute("loggedInUser");
        
        List<Order> orders = orderDAO.getOrdersByUser(user.getUserId());
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("order-history.jsp").forward(request, response);
    }
}
