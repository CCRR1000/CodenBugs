 --- MySQL PROYECTO 1

CREATE DATABASE mi_muebleria;

USE mi_muebleria;

CREATE TABLE usuario (
    id_usuario VARCHAR(10) NOT NULL,
    nombre VARCHAR(25),
    apellido VARCHAR(25),
    contraseña VARCHAR(10) NOT NULL,
    tipo_usuario INT NOT NULL,
    CONSTRAINT PK_USUARIO PRIMARY KEY (id_usuario)
);

CREATE TABLE cliente (
    nit VARCHAR(10) NOT NULL,
    nombre VARCHAR(25) NOT NULL,
    apellido VARCHAR(25) NOT NULL,
    dir_domicilio VARCHAR(50) NOT NULL,
    dir_municipio VARCHAR(50),
    dir_departamento VARCHAR(15),
    CONSTRAINT PK_CLIENTE PRIMARY KEY (nit)
);

CREATE TABLE general_mueble (
    nombre_mueble VARCHAR(30) NOT NULL,
    unidades INT NOT NULL,
    vendidos INT,
    devueltos INT,
    ganancias INT,
    CONSTRAINT PK_GENERAL_MUEBLE PRIMARY KEY (nombre_mueble)
);

CREATE TABLE mueble (
    codigo_mueble VARCHAR(10) NOT NULL,
    nombre_mueble VARCHAR(30) NOT NULL,
    costo_mueble DECIMAL NOT NULL,
    precio DECIMAL,
    estado VARCHAR(10) NOT NULL,
    ganancia DECIMAL,
    CONSTRAINT PK_MUEBLE PRIMARY KEY (codigo_mueble),
    CONSTRAINT FK_TO_GENERAL_MUEBLE FOREIGN KEY (nombre_mueble) REFERENCES general_mueble(nombre_mueble)
);

CREATE TABLE pieza (
    codigo_pieza VARCHAR(10) NOT NULL,
    tipo_pieza VARCHAR(20) NOT NULL,
    costo_pieza DECIMAL NOT NULL,
    cantidad INT NOT NULL,
    CONSTRAINT PK_PIEZA PRIMARY KEY (codigo_pieza)
);

CREATE TABLE ensamble_mueble (
    id_usuario VARCHAR(10) NOT NULL,
    codigo_mueble VARCHAR(10) NOT NULL,
    fecha_ensamble DATE NOT NULL,
    CONSTRAINT PK_ENSAMBLE_MUEBLE PRIMARY KEY (id_usuario, codigo_mueble),
    CONSTRAINT FK_TO_USUARIO FOREIGN KEY(id_usuario) REFERENCES usuario(id_usuario),
    CONSTRAINT FK_TO_CODIGO_MUEBLE FOREIGN KEY(codigo_mueble) REFERENCES mueble(codigo_mueble)
);

CREATE TABLE ensamble_pieza (
    codigo_pieza VARCHAR(10) NOT NULL,
    codigo_mueble VARCHAR(10) NOT NULL,
    cantidad INT NOT NULL,
    CONSTRAINT PK_ENSAMBLE_PIEZA PRIMARY KEY (codigo_pieza, codigo_mueble),
    CONSTRAINT FK_TO_PIEZA FOREIGN KEY(codigo_pieza) REFERENCES pieza(codigo_pieza),
    CONSTRAINT FK_TO_MUEBLE_ENSAMBLE FOREIGN KEY(codigo_mueble) REFERENCES mueble(codigo_mueble)
);

CREATE TABLE compra (
    no_factura VARCHAR(10) NOT NULL,
    codigo_mueble VARCHAR(10) NOT NULL,
    nit_cliente VARCHAR(10) NOT NULL,
    fecha_compra DATE NOT NULL,
    ganancia DECIMAL,
    usuario_venta VARCHAR(10) NOT NULL,
    CONSTRAINT PK_COMPRA PRIMARY KEY (no_factura, codigo_mueble, nit_cliente),
    CONSTRAINT FK_TO_CLIENTE FOREIGN KEY(nit_cliente) REFERENCES cliente(nit),
    CONSTRAINT FK_TO_USUARIO_VENTA FOREIGN KEY(usuario_venta) REFERENCES usuario(id_usuario),
    CONSTRAINT FK_TO_MUEBLE_COMPRADO FOREIGN KEY(codigo_mueble) REFERENCES mueble(codigo_mueble)
);

CREATE TABLE devolucion (
    no_factura VARCHAR(10) NOT NULL,
    codigo_mueble VARCHAR(10) NOT NULL,
    fecha_devolucion DATE,
    perdida DECIMAL,
    CONSTRAINT PK_DEVOLUCION PRIMARY KEY (no_factura, codigo_mueble, fecha_devolucion),
    CONSTRAINT FK_TO_MUEBLE_DEVUELTO FOREIGN KEY(codigo_mueble) REFERENCES mueble(codigo_mueble),
    CONSTRAINT FK_TO_COMPRA_FACTURA FOREIGN KEY (no_factura) REFERENCES compra(no_factura)
);
