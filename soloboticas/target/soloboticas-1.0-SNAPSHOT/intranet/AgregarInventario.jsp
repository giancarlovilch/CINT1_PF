<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ReStock</title>
<link rel="stylesheet" href="../css/buy.css">  
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

<!-- Barra de búsqueda -->
<div class="search-bar">
	<form method="get" action="SearchProducts.jsp">
		<input type="text" name="searchQuery" placeholder="Buscar productos..." class="search-input">
		<button type="submit" class="search-button">Buscar</button>
	</form>
</div>

<div class="active">
	<%@ page import="java.sql.*" %>
	<%@ page import="javax.sql.*" %>
	<%@ page import="com.mycompany.soloboticas.jdbc.JdbcConnection" %>
	<%
		HttpSession httpSession = request.getSession();
    	String guid = (String) httpSession.getAttribute("currentuser");
    	String searchQuery = request.getParameter("searchQuery");
    	if (searchQuery == null || searchQuery.isEmpty()) {
    	    searchQuery = "%"; // Mostrar todos los productos si no se busca nada específico
    	} else {
    	    searchQuery = "%" + searchQuery + "%"; // Filtrar productos
    	}
    %>
    
    <%
   		ResultSet rs = null;
		PreparedStatement ps = null;
		java.sql.Connection conn = null;
		String query = "SELECT p.pid, i.quantity, p.pname, p.manufacturer, p.mfg, p.exp, p.price " +
		               "FROM product p, inventory i " +
		               "WHERE p.pid = i.pid AND i.sid = ? AND p.pname LIKE ? LIMIT 20";
		try {
			conn = JdbcConnection.getConncetion();
			ps = conn.prepareStatement(query);
			ps.setString(1, guid);
			ps.setString(2, searchQuery); // Filtrar por nombre de producto
			rs = ps.executeQuery();
	%>
    
    <div class="product-list">
		<table class="product-table">
			<thead>
				<tr>
					<th>ID</th>
					<th>Nombre</th>
					<th>Fabricante</th>
					<th>Fecha de Fabricación</th>
					<th>Fecha de Caducidad</th>
					<th>Stock</th>
					<th>Precio</th>
					<th>Acciones</th>
				</tr>
			</thead>
			<tbody>
			<%
				while(rs.next()) {
			%>
				<tr>
					<td><%=rs.getString("pid") %></td>
					<td><%=rs.getString("pname") %></td>
					<td><%=rs.getString("manufacturer") %></td>
					<td><%=rs.getDate("mfg") %></td>
					<td><%=rs.getDate("exp") %></td>
					<td><%=rs.getInt("quantity") %></td>
					<td><%=rs.getInt("price") %></td>
					<td>
						<form action="UpdateInventory.jsp" method="post">
							<input type="hidden" name="pid" value="<%=rs.getString("pid") %>">
							<input type="text" name="restock" placeholder="cantidad" onkeypress="return event.charCode>= 48 && event.charCode<= 57" required>
							<button type="submit">REPONER</button>
						</form>
					</td>
				</tr>
			<%
				}
			%>
			</tbody>
		</table>
	</div>
	<%
		} catch(Exception e) {
			out.println("error: " + e);
		} finally {
			try { if (rs != null) rs.close(); } catch (Exception e) {};
			try { if (ps != null) ps.close(); } catch (Exception e) {};
			try { if (conn != null) conn.close(); } catch (Exception e) {};
		}
	%>
</div>

</body>
</html>
