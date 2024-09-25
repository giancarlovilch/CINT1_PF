package com.mycompany.soloboticas.jdbc;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

@WebServlet("/testConnection")
public class TestConnectionServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            // Aquí puedes probar la conexión a la base de datos
            Connection conn = JdbcConnection.getConncetion();
            if (conn != null) {
                out.println("Conexión exitosaaa a la base de datos.");
            } else {
                out.println("Error en la conexión a la base de datos.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}