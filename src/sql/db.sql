-- Configuración inicial
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

-- Crear base de datos
CREATE DATABASE IF NOT EXISTS sb_db;
USE sb_db;

-- Crear tabla 'contactos'
CREATE TABLE IF NOT EXISTS `contactos` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(20) DEFAULT NULL,
  `correo` VARCHAR(100) NOT NULL,
  `mensaje` TEXT NOT NULL,
  `fecha` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Crear tabla 'users'
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Auto incrementing user ID of each user, unique index',
  `user_name` VARCHAR(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User name, unique',
  `user_password_hash` VARCHAR(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User password in salted and hashed format',
  `user_email` VARCHAR(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User email, unique',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_name` (`user_name`),
  UNIQUE KEY `user_email` (`user_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='User data';

-- Confirmar transacción
COMMIT;
