package com.tap.servlet;

import com.tap.dao.UserDAO;
import com.tap.dao.impl.UserDAOImpl;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String role = request.getParameter("role");

        User user = new User(username, password, email, address, phone, role);
        int result = userDAO.addUser(user);

        if (result > 0) {
            response.sendRedirect("login?registration=success");
        } else {
            request.setAttribute("errorMessage", "Registration failed. Email might already be registered.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
