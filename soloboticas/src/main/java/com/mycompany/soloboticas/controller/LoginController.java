package com.mycompany.soloboticas.controller;

import com.mycompany.soloboticas.jdbc.JdbcConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginController extends HttpServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String uid1=request.getParameter("userid");
		String pass1=request.getParameter("password");
		String u2=request.getParameter("utype");
		int u=Integer.parseInt(u2);

		HttpSession httpSession = request.getSession();
		httpSession.setAttribute("currentuser", uid1);

		ResultSet rs=null;
		Connection conn=null;
		PreparedStatement ps=null;

		String query2="SELECT sid,pass from Seller WHERE sid=?";
		String query1="SELECT uid,pass from customer WHERE uid=?";
		try{
		
		 conn= JdbcConnection.getConncetion();
		if(u==2)
		{ 
			ps=conn.prepareStatement(query2);
			ps.setString(1,uid1);
		}	
		else if(u==1)
		{ 
			ps=conn.prepareStatement(query1);
			ps.setString(1,uid1);		}
		rs=ps.executeQuery();
		if(rs.next())
		{
			if((rs.getString(2)).equals(pass1))
			{
				if(u==1) 
					response.sendRedirect("Homepage.jsp");
				else 
					if(u==2) 
						response.sendRedirect("SellerHomepage.jsp");
			}
			else
			{
			response.sendRedirect("LoginError1.html");
			}
		}
		else
			response.sendRedirect("LoginError2.html");
	}
	catch(Exception e){ 
		
	}
	finally {
  	  	try { if (rs != null) rs.close(); } catch (Exception e) {};
    	try { if (ps != null) ps.close(); } catch (Exception e) {};
   		try { if (conn != null) conn.close(); } catch (Exception e) {};
}
	}
	

}
