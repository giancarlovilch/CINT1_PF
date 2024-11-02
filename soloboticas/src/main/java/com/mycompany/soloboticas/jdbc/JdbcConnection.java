package com.mycompany.soloboticas.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;

public class JdbcConnection {

    static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost:3306/sb_db";
    static final String USER = "root";
    static final String PASS = "root";

    public static Connection getConncetion() {
        Connection con = null;
        try {
            Class.forName(DRIVER).newInstance();
            con = DriverManager.getConnection(DB_URL, USER, PASS);
            System.out.println("Conexion a la base de datos establecida con exito.");
        } catch (Exception e) {
            System.err.println("Cannot connect to database server:");
            System.out.println(e.getMessage());
        }
        return con;
    }
}