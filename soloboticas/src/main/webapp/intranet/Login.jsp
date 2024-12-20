<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="org.apache.log4j.Logger" %>
<%@ page import="com.mycompany.soloboticas.jdbc.JdbcConnection" %>
<%@ page import="com.mycompany.soloboticas.security.PasswordHashing" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
<body>
<%
    Logger logger = Logger.getLogger("LoginLogger");
    String uid1 = request.getParameter("userid");
    String pass1 = request.getParameter("password");
    String u2 = request.getParameter("utype");
    int u = Integer.parseInt(u2);

    HttpSession httpSession = request.getSession();
    httpSession.setAttribute("currentuser", uid1);

    ResultSet rs = null;
    Connection conn = null;
    PreparedStatement ps = null;

    String query2 = "SELECT sid,pass from Seller WHERE sid=?";
    String query1 = "SELECT uid,pass from customer WHERE uid=?";

    try {
        conn = JdbcConnection.getConncetion();
        if (conn != null) {
            logger.info("Conexión a la base de datos establecida.");
        }

        if (u == 2) { 
            ps = conn.prepareStatement(query2);
            ps.setString(1, uid1);
        } else if (u == 1) { 
            ps = conn.prepareStatement(query1);
            ps.setString(1, uid1);
        }
        
        rs = ps.executeQuery();
        if (rs.next()) {
            String storedHash = rs.getString("pass");
            String enteredHash = PasswordHashing.hashPassword(pass1); // Hasheando la contraseña ingresada
            
            if (storedHash.equals(enteredHash)) {
                logger.info("Inicio de sesión exitoso para el usuario: " + uid1);

                if (u == 1)
                    response.sendRedirect("Homepage.jsp");
                else if (u == 2) 
                    response.sendRedirect("SellerHomepage.jsp");
            } else {
                logger.warn("Contraseña incorrecta para el usuario: " + uid1);
                response.sendRedirect("LoginError1.html");
            }
        } else {
            logger.warn("Usuario no encontrado: " + uid1);
            response.sendRedirect("LoginError2.html");
        }
    } catch (Exception e) {
        logger.error("Error durante el inicio de sesión para el usuario: " + uid1, e);
        out.println(e);
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) { logger.error("Error cerrando ResultSet", e); }
        try { if (ps != null) ps.close(); } catch (Exception e) { logger.error("Error cerrando PreparedStatement", e); }
        try { if (conn != null) conn.close(); } catch (Exception e) { logger.error("Error cerrando Connection", e); }
    }
%>
</body>
</html>
