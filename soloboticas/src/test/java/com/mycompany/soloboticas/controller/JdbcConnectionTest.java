package com.mycompany.soloboticas.controller;

import com.mycompany.soloboticas.jdbc.JdbcConnection;
import org.junit.jupiter.api.Test;

import java.sql.Connection;

import static org.junit.jupiter.api.Assertions.assertNotNull;

public class JdbcConnectionTest {

    @Test
    public void testGetConnection() {
        Connection connection = JdbcConnection.getConncetion();
        assertNotNull(connection, "La conexión no debería ser nula.");
    }
}
