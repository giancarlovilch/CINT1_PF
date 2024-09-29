# Documentación Técnica del Proyecto - Solo Boticas

![bg](./.Images/bg.png)

[TOC]

## Introducción

### Descripción general del proyecto

El proyecto consiste en el desarrollo de un sistema de gestión de ventas e inventario para una farmacia. Este sistema incluye una intranet donde se gestionarán las ventas, el registro de compradores y vendedores, y la administración de productos mediante una base de datos relacional. El sistema está diseñado para ser accesible tanto para los empleados de la farmacia, quienes podrán registrar productos y gestionar ventas, como para los compradores, que podrán registrarse, iniciar sesión y realizar compras en línea.

El proyecto se desarrollará utilizando tecnologías web como JSP (Java Server Pages), MySQL para la base de datos, y un servidor Tomcat para gestionar las peticiones del lado del servidor. El diseño de la interfaz se manejará con CSS para darle estilo y JavaScript para agregar interactividad y dinamismo a la página. La integración de MySQL se realiza a través de XAMPP, que permite el manejo del servidor de base de datos de manera eficiente.

### Objetivo del sistema

El objetivo principal del sistema es ofrecer una solución centralizada para la gestión de inventarios y ventas en una farmacia, asegurando la integridad de los datos y facilitando el flujo de trabajo entre los empleados y los clientes. Con este sistema, se pretende automatizar tareas críticas como el registro de productos, la actualización del inventario y la realización de órdenes de compra. Asimismo, se permitirá a los vendedores y compradores interactuar a través de una plataforma amigable y segura, optimizando así la eficiencia operativa y mejorando la experiencia del usuario.

### Tecnologías utilizadas

#### MySQL

MySQL es el sistema de gestión de bases de datos relacional utilizado para almacenar y gestionar toda la información relacionada con los usuarios (compradores y vendedores), productos, inventario y órdenes de compra. Su flexibilidad y rendimiento permiten manejar grandes volúmenes de datos, y mediante el uso de triggers y procedimientos almacenados, se asegura la consistencia de las operaciones.

#### Tomcat

Tomcat es el servidor web utilizado para ejecutar las aplicaciones Java y JSP. Actúa como intermediario entre el usuario y la base de datos, procesando las peticiones del lado del servidor y sirviendo las páginas dinámicas al navegador. Tomcat permite la ejecución de servlets y el manejo eficiente de sesiones, garantizando la seguridad y funcionalidad de la plataforma.

#### JSP

JSP (Java Server Pages) es el lenguaje principal para incrustar código Java dentro del HTML, lo que permite crear contenido dinámico en función de las interacciones del usuario. Mediante JSP, el sistema puede realizar consultas a la base de datos MySQL y generar respuestas personalizadas, como la visualización de productos, el registro de usuarios y la realización de compras.

#### CSS y JavaScript

CSS se utiliza para definir el estilo y la apariencia de las páginas web, garantizando una experiencia de usuario coherente y visualmente atractiva. JavaScript añade dinamismo a la interfaz, permitiendo interacciones como la validación de formularios, la actualización de elementos en tiempo real y la mejora de la experiencia general del usuario.

#### XAMPP

XAMPP es una plataforma que incluye un servidor Apache, una base de datos MySQL y herramientas para el desarrollo web. En este proyecto, XAMPP facilita la gestión del servidor de base de datos MySQL y su integración con Tomcat, permitiendo que el sistema funcione de manera fluida en un entorno local. XAMPP es ideal para entornos de desarrollo, ya que proporciona un fácil acceso a los recursos necesarios para ejecutar y probar la aplicación.

## Estructura del Proyecto

### Arquitectura del sistema

El sistema sigue una arquitectura basada en tres capas principales: la capa de presentación (interfaz web), la capa de lógica de negocio (procesamiento de datos y operaciones) y la capa de datos (base de datos MySQL). La integración de estas capas permite un flujo de información eficiente y seguro, garantizando la funcionalidad tanto para los usuarios externos (compradores) como para los internos (vendedores y administradores).

#### Integración de base de datos MySQL

La base de datos MySQL es el corazón del sistema, gestionando la información de productos, usuarios, inventario y órdenes. Se han creado varias tablas interrelacionadas para organizar los datos de manera coherente y eficiente. Además, se han implementado triggers y procedimientos almacenados para automatizar ciertas tareas, como la actualización del inventario tras cada venta y la recuperación de información de pedidos específicos.

```mysql
CREATE SCHEMA sb_db;

USE sb_db;

CREATE TABLE cliente (
  uid varchar(20) NOT NULL,
  pass varchar(20) DEFAULT NULL,
  fname varchar(15) DEFAULT NULL,
  lname varchar(15) DEFAULT NULL,
  email varchar(30) DEFAULT NULL,
  address varchar(128) DEFAULT NULL,
  phno bigint DEFAULT NULL,
  PRIMARY KEY (uid)
);

CREATE TABLE vendedor (
  sid varchar(15) NOT NULL,
  sname varchar(20) DEFAULT NULL,
  pass varchar(20) DEFAULT NULL,
  address varchar(128) DEFAULT NULL,
  phno bigint DEFAULT NULL,
  PRIMARY KEY (sid)
);

CREATE TABLE producto (
  pid varchar(15) NOT NULL,
  pname varchar(20) DEFAULT NULL,
  manufacturer varchar(20) DEFAULT NULL,
  mfg date DEFAULT NULL,
  exp date DEFAULT NULL,
  price int DEFAULT NULL,
  PRIMARY KEY (pid),
  UNIQUE KEY pname (pname)
);

CREATE TABLE inventario (
  pid varchar(15) NOT NULL,
  pname varchar(20) DEFAULT NULL,
  quantity int unsigned DEFAULT NULL,
  sid varchar(15) NOT NULL,
  PRIMARY KEY (pid,sid),
  CONSTRAINT fk01 FOREIGN KEY (pid) REFERENCES product (pid) ON DELETE CASCADE,
  CONSTRAINT fk02 FOREIGN KEY (pname) REFERENCES product (pname) ON DELETE CASCADE,
  CONSTRAINT fk03 FOREIGN KEY (sid) REFERENCES seller (sid) ON DELETE CASCADE
);

CREATE TABLE ordenes (
 oid int NOT NULL AUTO_INCREMENT,
 pid varchar(15) DEFAULT NULL,
 sid varchar(15) DEFAULT NULL,
 uid varchar(15) DEFAULT NULL,
 orderdatetime datetime DEFAULT NULL,
 quantity int unsigned DEFAULT NULL,
 price int unsigned DEFAULT NULL,
 PRIMARY KEY (oid),
 CONSTRAINT fk04 FOREIGN KEY (pid) REFERENCES product (pid) ON DELETE CASCADE,
 CONSTRAINT fk05 FOREIGN KEY (sid) REFERENCES seller (sid) ON DELETE CASCADE,
 CONSTRAINT fk06 FOREIGN KEY (uid) REFERENCES customer (uid) ON DELETE CASCADE
);

ALTER TABLE orders AUTO_INCREMENT=1000;
```

#### Servidor Tomcat y JSP

El servidor Tomcat actúa como el intermediario entre los usuarios y el sistema de backend. Utilizando JSP (Java Server Pages), se generan dinámicamente páginas web en función de las interacciones del usuario. Tomcat permite el procesamiento de solicitudes HTTP, manteniendo la lógica de la aplicación separada de la presentación de la misma.

![image-20240929024543598](./.Images/image-20240929024543598.png)

#### Interfaz web dinámica con CSS y JavaScript

La interfaz del sistema está diseñada para ser intuitiva y atractiva, utilizando CSS para definir los estilos y el diseño de la página. JavaScript añade interactividad, permitiendo una experiencia de usuario fluida mediante la validación de formularios, la manipulación de elementos dinámicos y el uso de AJAX para la actualización de datos sin recargar la página. Este enfoque mejora la experiencia del usuario al reducir el tiempo de respuesta y aumentar la interactividad.

### Descripción de los módulos principales

#### Módulo de ventas

Este módulo gestiona todo lo relacionado con la venta de productos. Los compradores pueden navegar por el inventario, seleccionar productos y realizar pedidos. El sistema calcula automáticamente los precios en función de las cantidades seleccionadas, y se registra cada venta en la base de datos, actualizando el inventario en tiempo real mediante triggers.

#### Módulo de gestión de usuarios (compradores y vendedores)

El sistema permite el registro y la gestión tanto de compradores como de vendedores. Los compradores pueden crear cuentas para realizar pedidos, mientras que los vendedores pueden gestionar los productos que venden y revisar sus órdenes a través de la intranet. Cada usuario tiene credenciales únicas para acceder al sistema de manera segura.

#### Intranet (gestión interna de productos)

La intranet está diseñada para los empleados y administradores de la farmacia. Aquí, los vendedores pueden agregar nuevos productos al inventario, actualizar información existente y monitorear el estado de las órdenes. También se pueden generar informes sobre las ventas y la disponibilidad de productos.

#### Ventanas básicas (Nosotros, Contacto, etc.)

El sistema también incluye ventanas básicas accesibles desde la interfaz pública, como las secciones de "Nosotros" y "Contacto", que proporcionan información general sobre la empresa y permiten la comunicación con los administradores del sistema. Estas ventanas están diseñadas de manera estática, pero con un estilo coherente con el resto del sistema.

## Diseño de la Base de Datos

### Estructura de la base de datos

#### Esquema `sb_db`

#### Descripción de las tablas

##### Tabla `comprador`

##### Tabla `vendedor`

##### Tabla `productos`

##### Tabla `inventario`

##### Tabla `ordenes`

#### Relaciones y claves foráneas

##### Relaciones entre `product`, `inventory` y `orders`

##### Restricciones y claves primarias/foráneas

## Manejo de Eventos en la Base de Datos

### Triggers en la base de datos

#### `actualizartime`: Actualización automática de fechas en órdenes

#### `inventariotrigger`: Actualización automática del inventario

## Implementación en el Servidor

### Configuración del servidor Tomcat

#### Conexión de JSP con la base de datos MySQL

#### Integración con XAMPP para manejo de MySQL

### Gestión de sesiones en JSP

#### Registro y autenticación de usuarios

#### Acceso a la intranet

#### Manejo de roles (compradores vs vendedores)

## Interfaz de Usuario

### Diseño de la interfaz con CSS y JavaScript

#### Estilo de la página principal (Index)

#### Ventanas secundarias (Nosotros, Contacto)

### Interactividad con JavaScript

#### Validación de formularios

#### Dinamismo en la gestión de productos

### Responsividad y diseño adaptativo

## Casos de Uso

### Registro de un nuevo comprador o vendedor

### Realización de una compra

### Actualización automática de inventario

### Visualización de pedidos (usuarios y vendedores)

### Gestión de productos en la intranet

## Pruebas y Depuración

### Pruebas unitarias de la base de datos

### Pruebas funcionales de la interfaz

### Pruebas de integración entre servidor y base de datos

### Manejo de errores y depuración

## Conclusiones y Futuras Mejoras

### Resumen del proyecto

### Posibles mejoras

#### Implementación de un sistema de reportes

#### Mejora de la seguridad en la gestión de usuarios

#### Expansión a un sistema multi-sucursal
