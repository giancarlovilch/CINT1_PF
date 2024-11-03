package com.mycompany.soloboticas.controller;

import static org.mockito.Mockito.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

class LoginControllerTest {

    private LoginController loginController;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private HttpSession session;

    @BeforeEach
    public void setUp() {
        loginController = new LoginController();
        request = mock(HttpServletRequest.class);
        response = mock(HttpServletResponse.class);
        session = mock(HttpSession.class);

        when(request.getSession()).thenReturn(session);
    }

    @Test
    void testLoginWithValidCredentials() throws ServletException, IOException {
        // Configura los mocks
        when(request.getParameter("userid")).thenReturn("giancarlovilch");
        when(request.getParameter("password")).thenReturn("a123A");
        when(request.getParameter("utype")).thenReturn("1");

        // Simulando la lógica interna (puedes hacer esto de manera sencilla)
        // Aquí debes simular que el usuario existe y la contraseña es correcta.
        // Para simplificar, podrías ignorar la base de datos y llamar a la lógica directamente.

        // Llama al método doPost
        loginController.doPost(request, response);

        // Verifica que se haya redirigido a la página de inicio
        verify(response).sendRedirect("Homepage.jsp");
    }

    @Test
    void testLoginWithInvalidCredentials() throws ServletException, IOException {
        // Configura los mocks
        when(request.getParameter("userid")).thenReturn("wrongUser");
        when(request.getParameter("password")).thenReturn("wrongPassword");
        when(request.getParameter("utype")).thenReturn("1");

        // Simulando que el usuario no existe
        // Puedes hacer que el método de verificación de contraseña falle o que no retorne un usuario

        // Llama al método doPost
        loginController.doPost(request, response);

        // Verifica que se haya redirigido a la página de error
        verify(response).sendRedirect("LoginError2.html");
    }
}
