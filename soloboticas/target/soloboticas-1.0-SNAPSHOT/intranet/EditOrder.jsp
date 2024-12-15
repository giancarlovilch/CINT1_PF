<%@ page import="java.sql.*" %>
<%@ page import="com.mycompany.soloboticas.jdbc.JdbcConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Orden</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<%
    String orderId = request.getParameter("orderId");
    ResultSet rs = null;
    PreparedStatement ps = null;
    Connection conn = null;

    try {
        conn = JdbcConnection.getConncetion();
        String sql = "SELECT * FROM orders WHERE oid = ?";
        ps = conn.prepareStatement(sql);
        ps.setInt(1, Integer.parseInt(orderId));
        rs = ps.executeQuery();

        if (rs.next()) {
%>
<div class="container mt-4">
    <form action="UpdateOrder.jsp" method="post">
        <input type="hidden" name="orderId" value="<%= rs.getInt("oid") %>">
        <div class="form-group">
            <label for="pid">ID Producto:</label>
            <input type="text" class="form-control" name="pid" value="<%= rs.getString("pid") %>">
        </div>
        <div class="form-group">
            <label for="price">Precio:</label>
            <input type="number" class="form-control" name="price" value="<%= rs.getInt("price") %>">
        </div>
        <div class="form-group">
            <label for="quantity">Cantidad:</label>
            <input type="number" class="form-control" name="quantity" value="<%= rs.getInt("quantity") %>">
        </div>
        <div class="form-group">
            <label for="sid">ID Vendedor:</label>
            <input type="text" class="form-control" name="sid" value="<%= rs.getString("sid") %>">
        </div>
        <button type="submit" class="btn btn-primary">Actualizar</button>
    </form>
</div>
<%
        }
    } catch (Exception e) {
        out.println("error: " + e);
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
</body>
</html>





