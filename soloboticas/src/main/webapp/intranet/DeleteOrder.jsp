<%@ page import="java.sql.*" %>
<%@ page import="com.mycompany.soloboticas.jdbc.JdbcConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Eliminar Orden</title>
<link rel="stylesheet" href="../css/orders.css">
</head>
<body>
<%
    String orderId = request.getParameter("orderId");

    PreparedStatement ps = null;
    Connection conn = null;

    try {
        conn = JdbcConnection.getConncetion();
        String sql = "DELETE FROM orders WHERE oid = ?";
        ps = conn.prepareStatement(sql);
        ps.setInt(1, Integer.parseInt(orderId));
        ps.executeUpdate();
        out.println("Orden eliminada exitosamente.");
    } catch (Exception e) {
        out.println("error: " + e);
    } finally {
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
<a href="Orders.jsp">Volver a Órdenes</a>
</body>
</html>

