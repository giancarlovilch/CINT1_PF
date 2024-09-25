<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Buy</title>
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
    String uid=(String)httpSession.getAttribute("currentuser");
    %>
    
    <div class="filler"></div>
    
    <%
    int flag=0;
	ResultSet rs=null;
	PreparedStatement ps=null;
	java.sql.Connection conn=null;
	String query="select p.pname,p.pid,p.manufacturer,p.mfg,p.price,i.quantity from product p,inventory i where p.pid=i.pid";
	
	try{
		
		conn=JdbcConnection.getConncetion();
		ps=conn.prepareStatement(query);
		rs=ps.executeQuery();
		%><div class="filler2"></div>
				<div class="block">
				<%
		while(rs.next())
		{
			if(flag==4)
				{
				flag=1;
				%></div><div class="filler2"></div><%
				}
			else
			flag++;
		%>
			<div class="row">
 				<div class="column">
    				<div class="card">
    				<img src="../img/pills.png" width=180 height=200>
  					<h2><%=rs.getString("pname") %></h2>
  					<p><b>ID: </b><%=rs.getString("pid") %></p>
					<p><b>Fabricante: </b><%=rs.getString("manufacturer") %></p>
					<p><b>F. Fabricación: </b><%=rs.getDate("mfg") %></p>
					<p><b>Stock: </b><%=rs.getInt("quantity") %></p>
					<p><b>Precio: </b><%=rs.getInt("price") %></p>
					<%if (rs.getInt("quantity")>0) 
					{
					%>
  					<form action="PlaceOrder.jsp" method="post">
  					<input type="number" name="orderquantity" onkeypress="return event.charCode>= 48 && event.charCode<= 57" placeholder="cantidad" max="<%=rs.getInt("quantity") %>" required >
  					<input type="hidden" name="pid" value="<%=rs.getString("pid") %>">
  					<p></p>
  					<button>COMPRAR</button></form></div>
  					<%
  					}
  					else	
  						{
  						%>
  					
  					<button>Out Of Stock</button></div>
  					<% 
  						} 
  					%>
  				</div>
  				<%
  				}
				%>
			</div>
		<%
	}
	catch(Exception e)
	{
		out.println("error: "+e);
	}
	finally {
	    try { if (rs != null) rs.close(); } catch (Exception e) {};
	    try { if (ps != null) ps.close(); } catch (Exception e) {};
	    try { if (conn != null) conn.close(); } catch (Exception e) {};
}
	%>
</body>
</html>
