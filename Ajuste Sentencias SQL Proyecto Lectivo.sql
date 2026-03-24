-- =========================================
-- CREACIÓN BASE DE DATOS
-- =========================================
CREATE DATABASE deliweB;
USE deliweB;

-- =========================================
-- TABLA ROLES (LOGIN / ADMIN)
-- =========================================
CREATE TABLE roles (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO roles (nombre_rol) VALUES
('Administrador'),
('Usuario');

-- =========================================
-- TABLA USUARIOS (LOGIN / PERFIL)
-- =========================================
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    foto VARCHAR(255),
    telefono VARCHAR(20),
    acepta_terminos BOOLEAN DEFAULT FALSE,
    id_rol INT NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_rol) REFERENCES roles(id_rol)
);

-- =========================================
-- TABLA TERMINOS Y CONDICIONES
-- =========================================
CREATE TABLE terminos (
    id_termino INT AUTO_INCREMENT PRIMARY KEY,
    descripcion TEXT NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO terminos (descripcion) VALUES
('El usuario acepta el uso de la plataforma DELIWEB y el tratamiento de sus datos personales.');

-- =========================================
-- TABLA CATEGORIAS (CATALOGO)
-- =========================================
CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

INSERT INTO categorias (nombre) VALUES
('Donas'),
('Cupcakes'),
('Tortas'),
('Postres');

-- =========================================
-- TABLA PRODUCTOS (CATALOGO + BUSCADOR)
-- =========================================
CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL,
    imagen VARCHAR(255),
    stock INT DEFAULT 0,
    id_categoria INT,

    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

-- PRODUCTOS (PRECIOS COLOMBIA 6000 - 10000)
INSERT INTO productos (nombre, descripcion, precio, stock, id_categoria) VALUES
('Dona Chocolate','Dona cubierta de chocolate',6000,50,1),
('Dona Glaseada','Dona con glaseado dulce',7000,40,1),
('Cupcake Vainilla','Cupcake suave',8000,30,2),
('Cupcake Chocolate','Cupcake relleno',8500,25,2),
('Torta Fresa','Porción de torta',10000,20,3),
('Cheesecake','Postre cremoso',9500,15,4);

-- =========================================
-- TABLA CARRITO (CARRITO)
-- =========================================
CREATE TABLE carrito (
    id_carrito INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    estado VARCHAR(50) DEFAULT 'Activo',
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- =========================================
-- DETALLE CARRITO
-- =========================================
CREATE TABLE carrito_detalle (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_carrito INT,
    id_producto INT,
    cantidad INT NOT NULL,
    precio DECIMAL(10,2),

    FOREIGN KEY (id_carrito) REFERENCES carrito(id_carrito),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- =========================================
-- TABLA PEDIDOS (COMPRA)
-- =========================================
CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    total DECIMAL(10,2),
    estado VARCHAR(50) DEFAULT 'Pendiente',
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- =========================================
-- DETALLE PEDIDOS
-- =========================================
CREATE TABLE detalle_pedido (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_producto INT,
    cantidad INT,
    precio DECIMAL(10,2),

    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- =========================================
-- TABLA CONTACTO (CONTACTANOS)
-- =========================================
CREATE TABLE contacto (
    id_contacto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    correo VARCHAR(100),
    mensaje TEXT,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================================
-- USUARIO ADMIN INICIAL
-- =========================================
INSERT INTO usuarios (nombre, email, password, id_rol, acepta_terminos)
VALUES ('Daniel Admin','admin@deliweb.com','123456',1,TRUE);