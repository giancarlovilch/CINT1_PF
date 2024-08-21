<?php
if (isset($login)) {
    if ($login->errors) {
        foreach ($login->errors as $error) {
            echo '<p class="error-message">' . $error . '</p>';
        }
    }
    if ($login->messages) {
        foreach ($login->messages as $message) {
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
    <link rel="stylesheet" href="/src/css/login_form.css"> <!-- Cambia la ruta si es necesario -->

</head>

<body>
    <form method="post" action="index.php" name="loginform">
        <label for="login_input_username">USUARIO</label>
        <input id="login_input_username" class="login_input" type="text" name="user_name" required />

        <label for="login_input_password">CONTRASEÑA</label>
        <input id="login_input_password" class="login_input" type="password" name="user_password" autocomplete="off" required />

        <input type="submit" name="login" value="ENTRAR" />
        <a href="/index.php" class="register-link">VOLVER</a>
        <a href="register.php" class="register-link">REGISTRATE</a>
        
    </form>

</body>

</html>