<%@page import="com.mycompany.soloboticas.jdbc.JdbcConnection"%>
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
				<a href="Homepage.jsp">PRINCIPAL</a>
				<a href="Buy.jsp">COMPRAR</a>
				<a href="Orders.jsp">ORDENES</a>
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
    String gid=(String)httpSession.getAttribute("currentuser");
    %>
    
    <div class="filler"></div>
    
    <%
    int flag=0;
	ResultSet rs=null;
	CallableStatement cs=null;
	java.sql.Connection conn=null;
		try{
		
		conn=JdbcConnection.getConncetion();
		cs = conn.prepareCall("call getorders(?)");
		cs.setString(1, gid);
		rs = cs.executeQuery();
		%><div class="filler2"></div>
		<table class="tables">
			<tr>
    			<th>ID ORDEN</th>
    			<th>ID PRODUCTO</th>
    			<th>PRECIO</th>
    			<th>CANTIDAD</th>
    			<th>ID VENDEDOR</th>
    			<th>FECHA Y HORA ORDEN</th>
  			</tr>
		<%while(rs.next()) 
		{
			%>
	  		
  			<tr>
    			<td><%=rs.getInt("oid") %></td>
    			<td><%=rs.getString("pid") %></td>
    			<td><%=rs.getInt("price") %></td>
    			<td><%=rs.getInt("quantity") %></td>
    			<td><%=rs.getString("sid") %></td>
    			<td><%=rs.getTimestamp("orderdatetime") %>
  			</tr>
  			
		<%
	}
		%>
		</table>
		</div>
		<% 
	}
	catch(Exception e)
	{
		out.println("error: "+e);
	}
		finally {
		    try { if (rs != null) rs.close(); } catch (Exception e) {};
		    try { if (cs != null) cs.close(); } catch (Exception e) {};
		    try { if (conn != null) conn.close(); } catch (Exception e) {};
	}
	%>
</body>
</html>
