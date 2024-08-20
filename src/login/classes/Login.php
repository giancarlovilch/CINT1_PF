<?php
class Login
{
    private $db_connection = null;
    public $errors = array();
    public $messages = array();
    private $session_timeout = 1200;
    public function __construct()
    {
        session_start();
        if (isset($_GET["logout"])) {
            $this->doLogout();
        } elseif ($this->isUserLoggedIn()) {
            $this->checkInactivity();
        } elseif (isset($_POST["login"])) {
            $this->dologinWithPostData();
        }
    }
    private function dologinWithPostData()
    {
        if (empty($_POST['user_name'])) {
            $this->errors[] = "Username field was empty.";
        } elseif (empty($_POST['user_password'])) {
            $this->errors[] = "Password field was empty.";
        } elseif (!empty($_POST['user_name']) && !empty($_POST['user_password'])) {
            $this->db_connection = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);
            if (!$this->db_connection->set_charset("utf8")) {
                $this->errors[] = $this->db_connection->error;
            }
            if (!$this->db_connection->connect_errno) {

                $user_name = $this->db_connection->real_escape_string($_POST['user_name']);

                $sql = "SELECT user_name, user_email, user_password_hash
                        FROM users
                        WHERE user_name = '" . $user_name . "' OR user_email = '" . $user_name . "';";
                $result_of_login_check = $this->db_connection->query($sql);

                if ($result_of_login_check->num_rows == 1) {

                    $result_row = $result_of_login_check->fetch_object();

                    if (password_verify($_POST['user_password'], $result_row->user_password_hash)) {

                        $_SESSION['user_name'] = $result_row->user_name;
                        $_SESSION['user_email'] = $result_row->user_email;
                        $_SESSION['last_activity'] = time();
                        $_SESSION['user_login_status'] = 1;

                        header('Location: index.php');
                        exit();
                    } else {
                        $this->errors[] = "Contraseña incorrecta. Inténtalo de nuevo.";
                    }
                } else {
                    $this->errors[] = "Este usuario no existe.";
                }
            } else {
                $this->errors[] = "Problema de conexión a la base de datos.";
            }
        }
    }
    public function doLogout()
    {
        $_SESSION = array();
        session_destroy();
        $this->messages[] = "Has sido desconectado.";
    }
    public function isUserLoggedIn()
    {
        if (isset($_SESSION['user_login_status']) and $_SESSION['user_login_status'] == 1) {
            return true;
        }
        return false;
    }
    private function checkInactivity()
    {
        if (isset($_SESSION['last_activity']) && (time() - $_SESSION['last_activity'] > $this->session_timeout)) {
            $this->doLogout();
            header("Location: index.php");
            exit();
        } else {
            $_SESSION['last_activity'] = time(); 
        }
    }
}
