package com.food.Servlet;

import com.food.DAO.MenuDAO;
import com.food.implementation.MenuDAOImpl;
import com.food.model.Cart;
import com.food.model.CartItem;
import com.food.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private MenuDAO menuDAO;

    @Override
    public void init() throws ServletException {
        menuDAO = new MenuDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        req.getRequestDispatcher("/cart.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        String action = req.getParameter("action");
        boolean isAdd = false;
        if (action != null) {
            try {
                if (action.equalsIgnoreCase("add")) {
                    isAdd = true;
                    int itemId = Integer.parseInt(req.getParameter("itemId"));
                    int quantity = Integer.parseInt(req.getParameter("quantity"));
                    
                    Menu menu = menuDAO.getMenu(itemId);
                    if (menu != null) {
                        CartItem cartItem = new CartItem(
                                menu.getMenuId(),
                                menu.getRestaurantId(),
                                menu.getName(),
                                menu.getPrice(),
                                quantity
                        );
                        cart.addItem(cartItem);
                    }
                } else if (action.equalsIgnoreCase("update")) {
                    int itemId = Integer.parseInt(req.getParameter("itemId"));
                    int quantity = Integer.parseInt(req.getParameter("quantity"));
                    cart.updateQuantity(itemId, quantity);
                } else if (action.equalsIgnoreCase("remove")) {
                    int itemId = Integer.parseInt(req.getParameter("itemId"));
                    cart.removeItem(itemId);
                } else if (action.equalsIgnoreCase("clear")) {
                    cart.clear();
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        // After adding an item always go to the cart page.
        // For update/remove/clear, stay on the current page (menu or cart).
        if (isAdd) {
            resp.sendRedirect(req.getContextPath() + "/cart");
        } else {
            String referer = req.getHeader("referer");
            if (referer != null && !referer.isEmpty()) {
                resp.sendRedirect(referer);
            } else {
                resp.sendRedirect(req.getContextPath() + "/cart");
            }
        }
    }
}
