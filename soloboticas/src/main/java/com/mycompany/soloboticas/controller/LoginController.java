package com.mycompany.soloboticas.controller;

import com.mycompany.soloboticas.jdbc.JdbcConnection;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String uid1 = request.getParameter("userid");
		String pass1 = request.getParameter("password");
		String u2 = request.getParameter("utype");
		
		// Validación de entrada
		if (uid1 == null || pass1 == null || u2 == null) {
			response.sendRedirect("LoginError.html");
			return;
		}
		
		int u;
		try {
			u = Integer.parseInt(u2);
		} catch (NumberFormatException e) {
			response.sendRedirect("LoginError.html");
			return;
		}

		HttpSession httpSession = request.getSession();
		httpSession.setAttribute("currentuser", uid1);

		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement ps = null;

		String query2 = "SELECT sid, pass FROM Seller WHERE sid = ?";
		String query1 = "SELECT uid, pass FROM Customer WHERE uid = ?";
		try {
			conn = JdbcConnection.getConncetion();
			if (u == 2) { 
				ps = conn.prepareStatement(query2);
				ps.setString(1, uid1);
			} else if (u == 1) { 
				ps = conn.prepareStatement(query1);
				ps.setString(1, uid1);
			}
			
			rs = ps.executeQuery();
			if (rs.next()) {
				if (verifyPassword(pass1, rs.getString("pass"))) {
					if (u == 1) {
						response.sendRedirect("Homepage.jsp");
					} else if (u == 2) {
						response.sendRedirect("SellerHomepage.jsp");
					}
				} else {
					response.sendRedirect("LoginError1.html");
				}
			} else {
				response.sendRedirect("LoginError2.html");
			}
		} catch (SQLException | NoSuchAlgorithmException e) {
			e.printStackTrace();
			response.sendRedirect("LoginError.html");
		} finally {
			try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
			try { if (ps != null) ps.close(); } catch (Exception e) { e.printStackTrace(); }
			try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
		}
	}
	
	private boolean verifyPassword(String enteredPassword, String storedPassword) throws NoSuchAlgorithmException {
		// Aquí se puede usar un algoritmo de hash adecuado para comparar contraseñas
		return hashPassword(enteredPassword).equals(storedPassword);
	}
	
	private String hashPassword(String password) throws NoSuchAlgorithmException {
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		byte[] hash = md.digest(password.getBytes());
		StringBuilder hexString = new StringBuilder();
		for (byte b : hash) {
			hexString.append(String.format("%02x", b));
		}
		return hexString.toString();
	}
}

