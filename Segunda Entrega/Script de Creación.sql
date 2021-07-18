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
drop table if exists Maquinaria_y_Equipo;
drop table if exists Empresa;
drop table if exists Cargos;
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
    Razon_Social  varchar(45),
    Ubicacion varchar(45),
    Persona_de_contacto varchar(45), 
    Telefono_de_contacto varchar(45), 
    Categoria varchar(45),
    Terminos_de_Negociacion longtext,
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

CREATE TABLE Maquinaria_y_Equipo(
    idMaquinaria_y_Equipo int,
    Nombre  varchar(45),
    Cantidad int(3),
    Fecha_de_compra varchar(45), 
    Precio decimal, 
    Marca varchar(45),
    Garantia varchar(45),
    IVA decimal,
    Estado_de_pago varchar(45),
    Cantidad_a_pagar decimal,
    PRIMARY KEY (idMaquinaria_y_Equipo)
);

CREATE TABLE Empresa(
    NIT varchar(45),
    Razon_Social  varchar(45),
    Representante_legal varchar(45),
    Direccion varchar(45),
    Pais varchar(45),
    PRIMARY KEY (NIT)
);

CREATE TABLE Cargos(
    idCargo int,
    Cargo varchar(45),
    PRIMARY KEY (idCargo)
);

CREATE TABLE Contrato(
    idContrato int,
    NIT  varchar(45),
    idCargo int,
    Fecha_Contratacion varchar(45),
    Salario varchar(45),
    Fecha_Terminacion varchar(45),
    PRIMARY KEY (idContrato,NIT,idCargo),
    FOREIGN KEY (NIT) REFERENCES Empresa(NIT),
    FOREIGN KEY (idCargo) REFERENCES Cargos(idCargo)
);


CREATE TABLE Empleado(
    idEmpleado int,
    idContrato  int,
    Nombre varchar(45),
    Apellido varchar(45),
    Direccion varchar(45),
    Telefono varchar(45),
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
    Categoria varchar(45),
    Nombre varchar(45),
    Ubicacion varchar(45),
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
    Fecha_de_produccion varchar(45),
    Categoria varchar(45),
    Fecha_de_caducidad varchar(45),
    Punto_de_fabricacion int,
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
