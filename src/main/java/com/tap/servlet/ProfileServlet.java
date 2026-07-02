package com.tap.servlet;

import com.tap.dao.UserDAO;
import com.tap.dao.impl.UserDAOImpl;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Handles viewing and updating user profile details.
 */
public class ProfileServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAOImpl();
    }

    /** GET → show profile page */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    /** POST → save updated details */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        String username       = request.getParameter("username");
        String phone          = request.getParameter("phone");
        String address        = request.getParameter("address");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword    = request.getParameter("newPassword");

        // Update basic details
        user.setUsername(username);
        user.setPhone(phone);
        user.setAddress(address);

        // Change password if provided
        if (newPassword != null && !newPassword.trim().isEmpty()) {
            if (!user.getPassword().equals(currentPassword)) {
                request.setAttribute("errorMessage", "Current password is incorrect!");
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }
            user.setPassword(newPassword);
        }

        int result = userDAO.updateUser(user);

        if (result > 0) {
            // Refresh session with updated user
            session.setAttribute("loggedInUser", user);
            response.sendRedirect("profile?updated=true");
        } else {
            request.setAttribute("errorMessage", "Update failed. Please try again.");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }
    }
}
