<?php
// Incluir el archivo de conexión a la base de datos
require_once 'db_contacto.php';

// Obtener datos del formulario
$nombre = $_POST['nombre'] ?? '';
$telefono = $_POST['telefono'] ?? '';
$correo = $_POST['correo'] ?? '';
$mensaje = $_POST['mensaje'] ?? '';

// Preparar la consulta SQL
$sql = "INSERT INTO contactos (nombre, telefono, correo, mensaje) VALUES (?, ?, ?, ?)";
$stmt = $conn->prepare($sql);

if ($stmt) {
    // Enlazar los parámetros
    $stmt->bind_param("ssss", $nombre, $telefono, $correo, $mensaje);
    
    // Ejecutar la consulta
    if ($stmt->execute()) {
        echo 'Mensaje recibido';
    } else {
        echo 'Error: ' . $stmt->error;
    }
    $stmt->close();
} else {
    echo 'Error en la preparación de la consulta: ' . $conn->error;
}

$conn->close();
?>
