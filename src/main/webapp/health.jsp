<%@ page contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter" %>
<%
    // Lightweight health-check endpoint — no DB query, no session, no JSP rendering overhead.
    // Used by cron-job.org to ping every 10 minutes and prevent Render.com from spinning down.
    response.setStatus(200);
    String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
%>
OK | FoodieHub is alive | <%= timestamp %>
