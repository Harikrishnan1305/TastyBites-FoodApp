package com.tap.dao.impl;

import com.tap.dao.PaymentDAO;
import com.tap.model.Payment;
import com.tap.utility.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class PaymentDAOImpl implements PaymentDAO {
    @Override
    public int addPayment(Payment payment) {
        String query = "INSERT INTO payment (order_id, amount, method, status, transaction_id) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, payment.getOrderId());
            ps.setDouble(2, payment.getAmount());
            ps.setString(3, payment.getMethod());
            ps.setString(4, payment.getStatus());
            ps.setString(5, payment.getTransactionId());
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
