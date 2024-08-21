<?php
if (isset($registration)) {
    if ($registration->errors) {
        foreach ($registration->errors as $error) {
            echo '<p class="error-message">' . $error . '</p>';
        }
    }
    if ($registration->messages) {
        foreach ($registration->messages as $message) {
            echo '<p class="success-message">' . $message . '</p>';
        }
    }
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Form</title>
    <link rel="stylesheet" href="/src/css/register_form.css"> <!-- Cambia la ruta si es necesario -->

</head>

<body>
    <form method="post" action="register.php" name="registerform">

        <label for="login_input_username">NOMBRE DE USUARIO</label>
        <input id="login_input_username" class="login_input" type="text" pattern="[a-zA-Z0-9]{2,64}" name="user_name" required />

        <label for="login_input_email">CORREO ELECTRÓNICO DEL USUARIO</label>
        <input id="login_input_email" class="login_input" type="email" name="user_email" required />

        <label for="login_input_password_new">CONTRASEÑA (MIN. 6 CARACTERES)</label>
        <input id="login_input_password_new" class="login_input" type="password" name="user_password_new" pattern=".{6,}" required autocomplete="off" />

        <label for="login_input_password_repeat">REPITA LA CONTRASEÑA</label>
        <input id="login_input_password_repeat" class="login_input" type="password" name="user_password_repeat" pattern=".{6,}" required autocomplete="off" />
        <input type="submit" name="register" value="REGISTRAR" />

        <a href="index.php">VOLVER A LA PÁGINA DE INICIO DE SESIÓN</a>

    </form>


</body>