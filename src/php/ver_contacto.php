<?php
// Incluir el archivo de configuración de la base de datos
require 'db_contacto.php';

// Crear conexión
$conn = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);

// Verificar conexión
if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

// Consultar todos los mensajes de la base de datos
$sql = "SELECT id, nombre, telefono, correo, mensaje, fecha FROM contactos ORDER BY fecha DESC";
$result = $conn->query($sql);
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mensajes de Contacto</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="../css/contacto.css">
</head>
<body>
    <header class="logotipo">
        <h1>Mensajes de Contacto</h1>
    </header>
    <div class="contenedor sombra">
        <h2>Lista de Mensajes</h2>
        <table class="tabla-contactos">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Teléfono</th>
                    <th>Correo</th>
                    <th>Mensaje</th>
                    <th>Fecha</th>
                </tr>
            </thead>
            <tbody>
                <?php
                if ($result->num_rows > 0) {
                    // Salida de datos de cada fila
                    while($row = $result->fetch_assoc()) {
                        echo "<tr>";
                        echo "<td>" . $row["id"] . "</td>";
                        echo "<td>" . $row["nombre"] . "</td>";
                        echo "<td>" . $row["telefono"] . "</td>";
                        echo "<td>" . $row["correo"] . "</td>";
                        echo "<td><a href='#' class='ver-mensaje' data-mensaje='" . htmlspecialchars($row["mensaje"]) . "'>Ver</a></td>";
                        echo "<td>" . $row["fecha"] . "</td>";
                        echo "</tr>";
                    }
                } else {
                    echo "<tr><td colspan='6'>No hay mensajes</td></tr>";
                }
                $conn->close();
                ?>
            </tbody>
        </table>
    </div>
    <footer class="footer">
        <p>Todos los derechos reservados &copy; 2024 GRUPO KGyR S.A.C</p>
    </footer>

    <!-- Modal -->
    <div id="mensajeModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <p id="modalMensaje"></p>
        </div>
    </div>

    <script src="../js/mensajes.js"></script>
</body>
</html>
