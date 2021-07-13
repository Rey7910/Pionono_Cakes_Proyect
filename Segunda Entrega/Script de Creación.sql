-- Script de Creación de la Base de Datos de Pionono Cakes
-- Desarrolladores:
-- Reinaldo Toledo Leguizamón
-- Santiago Hernández Chaparro
-- Johan David Clavijo Rodríguez 

-- Proyecto de Bases de Datos 2021-1

DROP SCHEMA IF EXISTS pionono_cakes;
CREATE SCHEMA pionono_cakes;
USE pionono_cakes;

drop table if exists Proveedor;
drop table if exists Insumo;
drop table if exists Maquinaría_y_Equipo;
drop table if exists Empresa;
drop table if exists Contrato;
drop table if exists Empleado;
drop table if exists Sucursal;
drop table if exists Inventario;
drop table if exists Producto;
drop table if exists Cliente;
drop table if exists Venta;
drop table if exists Domicilio;

-- Creación de las tablas
CREATE TABLE Proveedor(
    NIT	varchar(45),
    Razón_Social  varchar(45),
    Ubicación varchar(45),
    Persona_de_contacto varchar(45), 
    Teléfono_de_contacto varchar(45), 
    Categoría varchar(45),
    Términos_de_Negociación longtext,
    email varchar(45),
    PRIMARY KEY (NIT)
);

CREATE TABLE Insumo(
    idInsumo int,
    Nombre  varchar(45),
    Cantidad int(3),
    Unidad_de_Medida varchar(2), 
    Precio_por_unidad_de_medida decimal, 
    Marca varchar(45),
    Estado_de_pago varchar(10),
    Cantidad_a_pagar decimal,
    IVA decimal,
    PRIMARY KEY (idInsumo)
);

CREATE TABLE Maquinaría_y_Equipo(
    idMaquinaría_y_Equipo int,
    Nombre  varchar(45),
    Cantidad int(3),
    Fecha_de_compra varchar(45), 
    Precio decimal, 
    Marca varchar(45),
    Garantía varchar(45),
    IVA decimal,
    Estado_de_pago varchar(45),
    Cantidad_a_pagar decimal,
    PRIMARY KEY (idMaquinaría_y_Equipo)
);

CREATE TABLE Empresa(
    NIT varchar(45),
    Razón_Social  varchar(45),
    Representante_legal varchar(45),
    Dirección varchar(45),
    País varchar(45),
    PRIMARY KEY (NIT)
);

CREATE TABLE Contrato(
    idContrato int,
    NIT  varchar(45),
    Fecha_Contratación varchar(45),
    Cargo varchar(45),
    Salario varchar(45),
    Fecha_Terminación varchar(45),
    PRIMARY KEY (idContrato,NIT),
    FOREIGN KEY (NIT) REFERENCES Empresa(NIT)
);


CREATE TABLE Empleado(
    idEmpleado int,
    idContrato  int,
    Nombre varchar(45),
    Apellido varchar(45),
    Dirección varchar(45),
    Teléfono varchar(45),
    EPS varchar(45),
    Ciudad varchar(45),
    Fecha_de_nacimiento varchar(45),
    PRIMARY KEY (idEmpleado,idContrato),
    FOREIGN KEY (idContrato) REFERENCES Contrato(idContrato)
);

CREATE TABLE Sucursal(
    idSucursal int,
    NIT varchar(45),
    idEmpleado int,
    Categoría varchar(45),
    Nombre varchar(45),
    Ubicación varchar(45),
    Ciudad varchar(45),
    Inventario varchar(45),
    Administrador varchar(45),
    PRIMARY KEY (idSucursal,NIT,idEmpleado),
    FOREIGN KEY (NIT) REFERENCES Empresa(NIT),
    FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado)
);

CREATE TABLE Inventario(
    idInventario varchar(45),
    idSucursal int,
    PRIMARY KEY (idInventario,idSucursal),
    FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal)
);
CREATE TABLE Producto(
    idProducto int,
    Nombre varchar(45),
    Precio decimal,
    Fecha_de_producción varchar(45),
    Categoría varchar(45),
    Fecha_de_caducidad varchar(45),
    Punto_de_fabricación int,
    PRIMARY KEY (idProducto)
);
CREATE TABLE Cliente(
    idCliente int,
    Nombre varchar(45),
    Apellido varchar(45),
    Perfil varchar(45),
    PRIMARY KEY (idCliente)
);
CREATE TABLE Venta(
    idVenta int,
    idEmpleado int,
    idCliente int,
    idSucursal int,
    Fecha varchar(45),
    PRIMARY KEY (idVenta,idEmpleado,idCliente,idSucursal),
    FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado),
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
    FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal)
);

CREATE TABLE Domicilio(
    idDomicilio int,
    idCliente int,
    idEmpleado int,
    idVenta int,
    Dirección_entrega varchar(45),
    PRIMARY KEY (idDomicilio,idCliente,idEmpleado,idVenta),
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
    FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado),
    FOREIGN KEY (idVenta) REFERENCES Venta(idVenta)
);

