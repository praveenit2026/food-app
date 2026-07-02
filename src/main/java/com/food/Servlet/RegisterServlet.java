package com.food.Servlet;

import com.food.DAO.UserDAO;
import com.food.implementation.UserDAOImpl;
import com.food.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String eamil = req.getParameter("email");
        String password = req.getParameter("password");

        User user = new User(name, eamil, password);
        boolean success = userDAO.addUser(user);

        if (success) {
            resp.sendRedirect(req.getContextPath() + "/login?registrationSuccess=true");
        } else {
            req.setAttribute("errorMessage", "Registration failed. Email might already exist.");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        }
    }
}
