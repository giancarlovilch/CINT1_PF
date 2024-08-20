<?php

define("DB_HOST", "localhost");
define("DB_NAME", "sb_db");
define("DB_USER", "root");
define("DB_PASS", "");

// Crear una nueva conexión MySQLi
$conn = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);

// Verificar la conexión
if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

?>
