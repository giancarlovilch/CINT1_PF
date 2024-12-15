<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Orders</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/orders.css">
</head>
<body>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<div class="container">
    <div class="row mt-4">
        <div class="col-12">
            <div class="text-right mb-3">
                <a href="Logout.jsp" class="btn btn-danger">Logout</a>
            </div>
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <a class="navbar-brand" href="Homepage.jsp">PRINCIPAL</a>
                <a class="nav-item nav-link" href="Buy.jsp">COMPRAR</a>
                <a class="nav-item nav-link" href="Orders.jsp">ORDENES</a>
            </nav>
        </div>
    </div>

    <div class="row mt-4">
        <div class="col-12">
            <form action="SearchOrders.jsp" method="get" class="form-inline mb-3">
                <label for="search" class="sr-only">Buscar Orden</label>
                <input type="text" name="search" id="search" class="form-control mr-2" placeholder="Buscar Orden">
                <button type="submit" class="btn btn-primary">Buscar</button>
            </form>
            
            <%@ page import="java.sql.*" %>
            <%@ page import="javax.sql.*" %>
            <%@ page import="com.mycompany.soloboticas.jdbc.JdbcConnection" %>
            <%
            HttpSession httpSession = request.getSession();
            String gid = (String) httpSession.getAttribute("currentuser");
            
            int flag = 0;
            ResultSet rs = null;
            CallableStatement cs = null;
            java.sql.Connection conn = null;
            try {
                conn = JdbcConnection.getConncetion();
                cs = conn.prepareCall("call getorders(?)");
                cs.setString(1, gid);
                rs = cs.executeQuery();
            %>
            <div class="table-responsive">
                <table class="table table-bordered table-hover">
                    <thead class="thead-dark">
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
                    </thead>
                    <tbody>
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
                                    <button type="submit" class="btn btn-info">Generar Factura/Boleta</button>
                                </form>
                            </td>
                            <td>
                                <div class="d-flex">
                                    <form action="EditOrder.jsp" method="post" class="mr-2">
                                        <input type="hidden" name="orderId" value="<%= rs.getInt("oid")%>">
                                        <button type="submit" class="btn btn-warning">
                                            <i class="fas fa-edit"></i> Editar
                                        </button>
                                    </form>                                    
                                    <form action="DeleteOrder.jsp" method="post">
                                        <input type="hidden" name="orderId" value="<%= rs.getInt("oid")%>">
                                        <button type="submit" class="btn btn-danger" onclick="return confirm('¿Está seguro de que desea eliminar esta orden?');">
                                            <i class="fas fa-trash-alt"></i> Eliminar
                                        </button>
                                    </form>
                                </div>                                
                            </td>

                        </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
            <%
            } catch (Exception e) {
                out.println("error: " + e);
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception e) {}
                try { if (cs != null) cs.close(); } catch (Exception e) {}
                try { if (conn != null) conn.close(); } catch (Exception e) {}
            }
            %>
        </div>
    </div>
</div>
</body>
</html>


