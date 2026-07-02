package com.food.filters;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String path = req.getRequestURI().substring(req.getContextPath().length());

        // Paths requiring user login
        if (path.startsWith("/profile") || path.startsWith("/checkout")) {
            if (session == null || session.getAttribute("loggedInUser") == null) {
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }
        }

        // Paths requiring restaurant login
        if (path.startsWith("/restaurant/dashboard") || path.startsWith("/restaurant/menu")) {
            if (session == null || session.getAttribute("loggedInRestaurant") == null) {
                resp.sendRedirect(req.getContextPath() + "/restaurant/login");
                return;
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}
