<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GRUPO KGyR S.A.C</title>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Krub:wght@400;700&display=swap" rel="stylesheet">
    <link rel="preload" href="/src/css/normalize.css" as="style">
    <link href="/src/css/normalize.css" rel="stylesheet">
    <link rel="preload" href="/src/css/intranet.css" as="style">
    <link rel="stylesheet" href="/src/css/intranet.css">
    <link rel="icon" type="image/x-icon" href="../../img_1/SB007.ico">
    <meta property="og:description" content="Salud y cuidado de familia a familia. ¡Bienvenidos a SoloBoticas!" />
</head>

<body>
    <header>
        <h1 class="titulo">Grupo KGyR S.A.C
            <br>
            <span>Solo Boticas</span>
        </h1>
    </header>
    <div class="contenedor contenedor-grid">
        <nav class="nav">
            <ul class="list">
                <li class="list__item">
                    <div class="list__button">
                        <img src="assets/homemedicine.svg" class="list__img">
                        <a href="../../index.php" class="nav__link">Home</a>
                    </div>
                </li>

                <li class="list__item">
                    <div class="list__button">
                        <img src="assets/schedulee.svg" class="list__img">
                        <a href="index.php?page=horarios#sidebar-1" class="nav__link">Horarios</a>
                    </div>
                </li>

                <li class="list__item">
                    <div class="list__button">
                        <img src="assets/message.svg" class="list__img">
                        <a href="index.php?page=info#sidebar-1" class="nav__link">Información</a>
                    </div>
                </li>
                <li class="list__item">
                    <div class="list__button">
                        <img src="assets/message.svg" class="list__img">
                        <a href="index.php?logout" class="nav__link">Salir</a>
                    </div>
                </li>
            </ul>
        </nav>
        
        <aside class="sidebar-1" id="sidebar-1">
            <?php
            $allowed_pages = ['horarios', 'info'];

            if (isset($_GET['page']) && in_array($_GET['page'], $allowed_pages)) {
                $page = $_GET['page'];
                switch ($page) {
                    case 'horarios':
                        include('views/intranet/horarios.php');
                        break;
                    case 'info':
                        include('views/intranet/info.php');
                        break;
                    case 'reporte_ventas':
                        include('views/reporte_ventas.php');
                        break;
                    case 'resumen':
                        include('views/resumen.html');
                        break;
                }
            } else {
                include('views/intranet/mensaje.php');
            }
            ?>
        </aside>
    </div>

    <script src="/src/js/intranet.js"></script>
</body>

</html>
<a href="index.php?logout">Logout</a>
<a href="register.php" class="register-link">REGISTRATE</a>
<a href="infograma.php" class="register-link">REGISTRATE</a>