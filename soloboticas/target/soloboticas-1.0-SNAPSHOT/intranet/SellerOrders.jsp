<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Orders</title>
<link rel="stylesheet" href="../css/orders.css">
</head>
<body>
<div class="main">
    <div class="topbar1"></div>
    <div class="topbar2">
        <div class="container1">
            <div class="logout-btn">
                <a href="Logout.jsp">Logout</a>
            </div>
        </div>
    </div>
    <div class="header">
        <div class="container2">
            <div class="navbar">
                <a href="SellerHomepage.jsp">PRINCIPAL</a>
                <a href="AddProduct.html">CREAR</a>
                <a href="AddInventory.jsp">REPONER</a>
                <a href="SellerOrders.jsp">ORDENES</a>
            </div>
        </div>
    </div>
</div>
<div class="active">
    <%@ page import="java.sql.*" %>
    <%@ page import="javax.sql.*" %>
    <%@ page import="com.mycompany.soloboticas.jdbc.JdbcConnection" %>
    <%
    HttpSession httpSession = request.getSession();
    String guid = (String) httpSession.getAttribute("currentuser");
    %>
    <div class="filler"></div>
    <%
    int flag = 0;
    ResultSet rs = null;
    CallableStatement cs = null;
    java.sql.Connection conn = null;
    try {
        conn = JdbcConnection.getConncetion();
        cs = conn.prepareCall("call getsellerorders(?)");
        cs.setString(1, guid);
        rs = cs.executeQuery();
        %>
        <div class="filler2"></div>
        <table class="tables">
            <tr>
                <th>ID ORDEN</th>
                <th>ID PRODUCTO</th>
                <th>PRECIO</th>
                <th>CANTIDAD</th>
                <th>ID CLIENTE</th>
                <th>FECHA Y HORA ORDEN</th>
                <th>FACTURA/BOLETA</th>
            </tr>
            <% while (rs.next()) { %>
            <tr>
                <td><%= rs.getInt("oid") %></td>
                <td><%= rs.getString("pid") %></td>
                <td><%= rs.getInt("price") %></td>
                <td><%= rs.getInt("quantity") %></td>
                <td><%= rs.getString("uid") %></td>
                <td><%= rs.getTimestamp("orderdatetime") %></td>
                <td>
                    <form action="GenerateInvoice.jsp" method="post">
                        <input type="hidden" name="orderId" value="<%= rs.getInt("oid") %>">
                        <button type="submit">Generar Factura/Boleta</button>
                    </form>
                </td>
            </tr>
            <% } %>
        </table>
    </div>
    <%
    } catch (Exception e) {
        out.println("error: " + e);
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
        try { if (cs != null) cs.close(); } catch (Exception e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
    }
    %>
</div>
</body>
</html>

