package com.mycompany.soloboticas.jdbc;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

@WebServlet("/testConnection")
public class TestConnectionServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(TestConnectionServlet.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");

        // Parámetros de conexión
        String url = "jdbc:mysql://localhost:3306/sb_db";
        String user = "root";
        String password = "";

        try (Connection conn = DriverManager.getConnection(url, user, password)) {
            if (conn != null && !conn.isClosed()) {
                logger.info("Conexión exitosa a la base de datos.");
                response.getWriter().println("Conexión exitosa a la base de datos.");
            } else {
                logger.warn("Conexión fallida: la conexión devuelta es nula o está cerrada.");
                response.getWriter().println("Error en la conexión a la base de datos.");
            }
        } catch (SQLException e) {
            logger.error("Error al conectar con la base de datos.", e);
            response.getWriter().println("Error al conectar con la base de datos.");
        }
    }
}
