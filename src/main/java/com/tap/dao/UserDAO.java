package com.tap.dao;

import com.tap.model.User;

/**
 * DAO Interface for User CRUD operations.
 */
public interface UserDAO {
    int addUser(User user);
    User getUserById(int userId);
    User getUserByEmail(String email);
    User getUser(String email, String password);
    int updateUser(User user);
    int deleteUser(int userId);
}
