<%@ page import="java.sql.*" %>
<%@ page import="com.mycompany.soloboticas.jdbc.JdbcConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Actualizar Orden</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<%
    String orderId = request.getParameter("orderId");
    String pid = request.getParameter("pid");
    int price = Integer.parseInt(request.getParameter("price"));
    int quantity = Integer.parseInt(request.getParameter("quantity"));
    String sid = request.getParameter("sid");

    PreparedStatement ps = null;
    Connection conn = null;

    try {
        conn = JdbcConnection.getConncetion();
        String sql = "UPDATE orders SET pid = ?, price = ?, quantity = ?, sid = ? WHERE oid = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, pid);
        ps.setInt(2, price);
        ps.setInt(3, quantity);
        ps.setString(4, sid);
        ps.setInt(5, Integer.parseInt(orderId));
        ps.executeUpdate();

        response.sendRedirect("Orders.jsp");
    } catch (Exception e) {
        out.println("error: " + e);
    } finally {
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
</body>
</html>

