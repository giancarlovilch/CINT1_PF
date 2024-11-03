package com.mycompany.soloboticas.controller;

import com.mycompany.soloboticas.security.PasswordHashing;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotEquals;

public class PasswordHashingTest {

    @Test
    public void testHashPassword() {
        String password = "a123A";
        String expectedHash = "e3b9c6a1d7611370f98211feb2ef9ddc31c3a38f3dd663cb629dfeb5d98d4d99"; // Precomputed SHA-256 hash of "mySecurePassword"

        String actualHash = PasswordHashing.hashPassword(password);

        assertEquals(expectedHash, actualHash, "El hash de la contraseña no es el esperado.");
    }

    @Test
    public void testHashPasswordDifferentInputs() {
        String password1 = "password123";
        String password2 = "password1234";

        String hash1 = PasswordHashing.hashPassword(password1);
        String hash2 = PasswordHashing.hashPassword(password2);

        // Ensure that different inputs produce different hashes
        assertNotEquals(hash1, hash2, "Las contraseñas diferentes deberían generar hashes diferentes.");
    }
}
