package com.mycompany.soloboticas.controller;

import com.mycompany.soloboticas.jdbc.JdbcConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SellerRegisterController extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String name1=request.getParameter("name");
		String phno1=request.getParameter("phno");
		String uid1=request.getParameter("uid");
		long phno2=Long.parseLong(phno1);
		String address1=request.getParameter("address");
		String pass1=request.getParameter("pass1");
		String pass2=request.getParameter("pass2");
		PreparedStatement ps1=null;
		PreparedStatement ps2=null;
		Connection conn=null;
		String query1="SELECT sid from seller WHERE sid=?";
		String query2="INSERT INTO seller(sid,pass,sname,address,phno) VALUES(?,?,?,?,?)";
		ResultSet rs=null;
		try{		
			
			conn= JdbcConnection.getConncetion();
			ps1=conn.prepareStatement(query1);
			ps1.setString(1,uid1);
			rs=ps1.executeQuery();
			if(rs.next())
				{
					response.sendRedirect("SellerRegisterError1.html");
				}
			else
			{
				if(pass1.equals(pass2))
				{
					ps2=conn.prepareStatement(query2);
					ps2.setString(1,uid1);
					ps2.setString(2,pass1);
					ps2.setString(3,name1);
					ps2.setString(4,address1);
					ps2.setLong(5,phno2);
					int i=ps2.executeUpdate();
					response.sendRedirect("Login.html");
				}
				else
					response.sendRedirect("SellerRegisterError2.html");
		}
	}
	catch(Exception e){ 
		
	}
		finally {
	  	  	try { if (rs != null) rs.close(); } catch (Exception e) {};
	    	try { if (ps1 != null) ps1.close(); } catch (Exception e) {};
	    	try { if (ps2 != null) ps2.close(); } catch (Exception e) {};
	   		try { if (conn != null) conn.close(); } catch (Exception e) {};
	}
		
	}

}

