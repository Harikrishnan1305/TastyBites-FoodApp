package com.tap.servlet;

import com.tap.dao.OrderDAO;
import com.tap.dao.PaymentDAO;
import com.tap.dao.impl.OrderDAOImpl;
import com.tap.dao.impl.PaymentDAOImpl;
import com.tap.model.Order;
import com.tap.model.Payment;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.UUID;

public class PaymentServlet extends HttpServlet {

    private OrderDAO orderDAO;
    private PaymentDAO paymentDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAOImpl();
        paymentDAO = new PaymentDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("login");
            return;
        }

        String orderIdStr = request.getParameter("order_id");
        if (orderIdStr != null) {
            int orderId = Integer.parseInt(orderIdStr);
            Order order = orderDAO.getOrder(orderId);
            if (order != null) {
                request.setAttribute("order", order);
                request.getRequestDispatcher("payment.jsp").forward(request, response);
                return;
            }
        }
        response.sendRedirect("home");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("login");
            return;
        }

        int orderId = Integer.parseInt(request.getParameter("order_id"));
        String method = request.getParameter("method");
        
        Order order = orderDAO.getOrder(orderId);
        
        if (order != null) {
            String transactionId = "TXN" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
            
            Payment payment = new Payment(0, orderId, order.getTotalAmount(), method, "Success", transactionId, null);
            paymentDAO.addPayment(payment);
            
            orderDAO.updateOrderStatus(orderId, "Confirmed");
            
            request.setAttribute("order", order);
            request.setAttribute("payment", payment);
            request.getRequestDispatcher("order-confirmation.jsp").forward(request, response);
        } else {
            response.sendRedirect("home");
        }
    }
}
