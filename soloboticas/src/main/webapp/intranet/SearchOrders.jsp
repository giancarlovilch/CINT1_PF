<%@ page import="java.sql.*" %>
<%@ page import="com.mycompany.soloboticas.jdbc.JdbcConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Buscar Órdenes</title>
<link rel="stylesheet" href="../css/orders.css">
</head>
<body>
<%
    String search = request.getParameter("search");
    ResultSet rs = null;
    PreparedStatement ps = null;
    Connection conn = null;

    try {
        conn = JdbcConnection.getConncetion();
        String sql = "SELECT * FROM orders WHERE oid LIKE ? OR pid LIKE ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, "%" + search + "%");
        ps.setString(2, "%" + search + "%");
        rs = ps.executeQuery();
%>
<table class="tables">
    <tr>
        <th>ID ORDEN</th>
        <th>ID PRODUCTO</th>
        <th>PRECIO</th>
        <th>CANTIDAD</th>
        <th>ID VENDEDOR</th>
        <th>FECHA Y HORA ORDEN</th>
        <th>FACTURA/BOLETA</th>
        <th>ACCIONES</th>
    </tr>
    <% while (rs.next()) { %>
        <tr>
            <td><%= rs.getInt("oid") %></td>
            <td><%= rs.getString("pid") %></td>
            <td><%= rs.getInt("price") %></td>
            <td><%= rs.getInt("quantity") %></td>
            <td><%= rs.getString("sid") %></td>
            <td><%= rs.getTimestamp("orderdatetime") %></td>
            <td>
                <form action="GenerateInvoice.jsp" method="post">
                    <input type="hidden" name="orderId" value="<%= rs.getInt("oid") %>">
                    <button type="submit">Generar Factura/Boleta</button>
                </form>
            </td>
            <td>
                <form action="EditOrder.jsp" method="post" style="display:inline;">
                    <input type="hidden" name="orderId" value="<%= rs.getInt("oid") %>">
                    <button type="submit">Editar</button>
                </form>
                <form action="DeleteOrder.jsp" method="post" style="display:inline;">
                    <input type="hidden" name="orderId" value="<%= rs.getInt("oid") %>">
                    <button type="submit" onclick="return confirm('¿Está seguro de que desea eliminar esta orden?');">Eliminar</button>
                </form>
            </td>
        </tr>
    <% } %>
</table>
<%
    } catch (Exception e) {
        out.println("error: " + e);
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
<a href="Orders.jsp">Volver a Órdenes</a>
</body>
</html>

