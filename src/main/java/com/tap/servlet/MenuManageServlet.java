package com.tap.servlet;

import com.tap.dao.MenuDAO;
import com.tap.dao.impl.MenuDAOImpl;
import com.tap.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@MultipartConfig
public class MenuManageServlet extends HttpServlet {
    private MenuDAO menuDAO;

    @Override
    public void init() {
        menuDAO = new MenuDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            int restaurantId = Integer.parseInt(request.getParameter("restaurant_id"));
            String menuName = request.getParameter("menu_name");
            String description = request.getParameter("description");
            String category = request.getParameter("category");
            double price = Double.parseDouble(request.getParameter("price"));
            boolean isAvailable = request.getParameter("is_available") != null;
            
            // Simplified: we will just use a placeholder image instead of complex file upload
            String imageUrl = "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=500";

            Menu menu = new Menu(restaurantId, menuName, description, price, isAvailable, imageUrl, category);
            menuDAO.addMenu(menu);

        } else if ("delete".equals(action)) {
            int menuId = Integer.parseInt(request.getParameter("menu_id"));
            menuDAO.deleteMenu(menuId);
        }

        response.sendRedirect("restaurant-dashboard");
    }
}
