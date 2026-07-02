package com.tap.dao.impl;

import com.tap.dao.UserDAO;
import com.tap.model.User;
import com.tap.utility.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAOImpl implements UserDAO {

    @Override
    public int addUser(User user) {
        String query = "INSERT INTO user (username, password, email, phone, address, role) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getAddress());
            ps.setString(6, user.getRole());
            return ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    @Override
    public User getUserById(int userId) {
        String query = "SELECT * FROM user WHERE user_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return extractUser(rs);
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    @Override
    public User getUserByEmail(String email) {
        String query = "SELECT * FROM user WHERE email = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return extractUser(rs);
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    @Override
    public User getUser(String email, String password) {
        String query = "SELECT * FROM user WHERE email = ? AND password = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return extractUser(rs);
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    @Override
    public int updateUser(User user) {
        String query = "UPDATE user SET username=?, address=?, phone=?, password=? WHERE user_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getAddress());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getPassword());
            ps.setInt(5, user.getUserId());
            return ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    @Override
    public int deleteUser(int userId) {
        String query = "DELETE FROM user WHERE user_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, userId);
            return ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    private User extractUser(ResultSet rs) throws Exception {
        User user = new User();
        user.setUserId(rs.getInt("user_id"));
        user.setUsername(rs.getString("username"));
        user.setPassword(rs.getString("password"));
        user.setEmail(rs.getString("email"));
        user.setPhone(rs.getString("phone"));
        user.setAddress(rs.getString("address"));
        user.setRole(rs.getString("role"));
        return user;
    }
}
