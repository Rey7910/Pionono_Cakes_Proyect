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
drop table if exists venta_productos;
drop table if exists venta_insumos;
drop table if exists adquisicion_insumos;
drop table if exists adquisicion_maquinaria_y_equipo;

-- Creación de las tablas
CREATE TABLE Proveedor(
    NIT	varchar(45),
    Nombre varchar(45),
    Razon_Social  varchar(45),
    Ubicacion varchar(45),
    Persona_de_contacto varchar(45), 
    Telefono_de_contacto varchar(45), 
    Categoria varchar(45),
    Terminos_de_Negociacion longtext,
    email varchar(45),
    PRIMARY KEY (NIT)
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
    idCargo int auto_increment not null,
    Nombre varchar(45) not null,
    PRIMARY KEY (idCargo)
);

CREATE TABLE Contrato(
    idContrato int auto_increment,
    NIT  varchar(45),
    idCargo int,
    Fecha_Contratacion varchar(45) not null,
    Salario int not null,
    Fecha_Terminacion varchar(45),
    PRIMARY KEY (idContrato,NIT,idCargo),
    FOREIGN KEY (NIT) REFERENCES Empresa(NIT),
    FOREIGN KEY (idCargo) REFERENCES Cargos(idCargo)
);
-- insert into Contrato values ("2344",2,"01-02-2021","2300","02-03-2021");
CREATE TABLE Empleado(
    idEmpleado int auto_increment not null,
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
    idSucursal int auto_increment not null,
    NIT varchar(45),
    Categoria varchar(45),
    Nombre varchar(45),
    Ubicacion varchar(45),
    Ciudad varchar(45),
    Administrador int,
    PRIMARY KEY (idSucursal,NIT,Administrador),
    FOREIGN KEY (NIT) REFERENCES Empresa(NIT),
    FOREIGN KEY (Administrador) REFERENCES Empleado(idEmpleado)
);

CREATE TABLE Vinculos(
	idSucursal int,
    idEmpleado int,
    PRIMARY KEY (idSucursal, idEmpleado),
    FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal),
    FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado)
);

CREATE TABLE Inventario(
    idInventario int auto_increment not null,
    idSucursal int,
    PRIMARY KEY (idInventario,idSucursal),
    FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal)
);

CREATE TABLE Maquinaria_y_Equipo(
    idMaquinaria_y_Equipo int auto_increment not null,
    idInventario int,
    Nombre  varchar(45),
    Fecha_de_compra varchar(45), 
    Precio decimal, 
    Marca varchar(45),
    Garantia varchar(45),
    IVA decimal,
    Estado_de_pago varchar(45),
    Cantidad_a_pagar decimal,
    PRIMARY KEY (idMaquinaria_y_Equipo,idInventario),
    FOREIGN KEY (idInventario) REFERENCES Inventario(idInventario)
);

CREATE TABLE Insumo(
	idInsumo  int auto_increment not null,
    idInventario int,
    Nombre  varchar(45),
    Cantidad int(3),
    Unidad_de_Medida varchar(2), 
    Precio_por_unidad_de_medida decimal, 
    Marca varchar(45),
    fecha_de_compra varchar(45),
    Estado_de_pago varchar(10),
    Cantidad_a_pagar decimal,
    IVA decimal,
    PRIMARY KEY (idInsumo,idInventario),
    FOREIGN KEY (idInventario) REFERENCES Inventario(idInventario)
);

CREATE TABLE Producto(
    idProducto int auto_increment not null,
    Nombre varchar(45),
    Precio decimal,
    Fecha_de_produccion varchar(45),
    Categoria varchar(45),
    Fecha_de_caducidad varchar(45),
    Punto_de_fabricacion int,
    PRIMARY KEY (idProducto,Punto_de_fabricacion),
    FOREIGN KEY (Punto_de_fabricacion) REFERENCES Sucursal(idSucursal)
    
);
CREATE TABLE Cliente(
    idCliente int auto_increment not null,
    Nombre varchar(45),
    Apellido varchar(45),
    Perfil varchar(45),
    PRIMARY KEY (idCliente)
);
CREATE TABLE Venta(
    idVenta int auto_increment not null,
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
    idDomicilio int auto_increment not null,
    idCliente int,
    idEmpleado int,
    idVenta int,
    Direccion_entrega varchar(45),
    PRIMARY KEY (idDomicilio,idCliente,idEmpleado,idVenta),
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
    FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado),
    FOREIGN KEY (idVenta) REFERENCES Venta(idVenta)
);

CREATE TABLE Venta_Productos(
    idVenta int,
    idProducto int,
    PRIMARY KEY (idVenta,idProducto),
    FOREIGN KEY (idVenta) REFERENCES Venta(idVenta),
    FOREIGN KEY (idProducto) REFERENCES Producto(idProducto)
);

CREATE TABLE Venta_insumos(
    idVenta int,
    idInsumo int,
    PRIMARY KEY (idVenta,idInsumo),
    FOREIGN KEY (idVenta) REFERENCES Venta(idVenta),
    FOREIGN KEY (idInsumo) REFERENCES Insumo(idInsumo)
);
CREATE TABLE Adquisicion_insumos(
    NIT varchar(45),
    idInsumo int,
    PRIMARY KEY (NIT,idInsumo),
    FOREIGN KEY (NIT) REFERENCES Proveedor(NIT),
    FOREIGN KEY (idInsumo) REFERENCES Insumo(idInsumo)
);
CREATE TABLE adquisicion_maquinaria_y_equipo(
    NIT varchar(45),
    idmaquinaria_y_equipo int,
    PRIMARY KEY (NIT,idmaquinaria_y_equipo),
    FOREIGN KEY (NIT) REFERENCES Proveedor(NIT),
    FOREIGN KEY (idmaquinaria_y_equipo) REFERENCES maquinaria_y_equipo(idmaquinaria_y_equipo)
);

-- Inserción de datos en las respectivas tablas

-- Tabla 'Cargos'
insert into Cargos(Nombre) values ("Jefe");
insert into Cargos(Nombre) values ("Administrador");
insert into Cargos(Nombre) values ("Funcionario");
insert into Cargos(Nombre) values ("Domiciliario");

-- Tabla 'Empresa'

insert into Empresa values('123456789','Pionono Cakes','Jeisson Clavijo','Cll 9 #4-07','Colombia');

-- Tabla 'Contrato'

insert into Contrato (NIT,idCargo,Fecha_contratacion,salario,fecha_terminacion) values ('123456789',1,'01-01-2016',4000000,'');
insert into Contrato (NIT,idCargo,Fecha_contratacion,salario,fecha_terminacion) values ('123456789',2,'01-01-2016',2200000,'01-01-2026');
insert into Contrato (NIT,idCargo,Fecha_contratacion,salario,fecha_terminacion) values ('123456789',3,'05-02-2019',1300000,'05-02-2024');
insert into Contrato (NIT,idCargo,Fecha_contratacion,salario,fecha_terminacion) values ('123456789',2,'01-01-2019',2200000,'01-01-2029');
insert into Contrato (NIT,idCargo,Fecha_contratacion,salario,fecha_terminacion) values ('123456789',4,'15-04-2018',900000,'15-04-2023');
insert into Contrato (NIT,idCargo,Fecha_contratacion,salario,fecha_terminacion) values ('123456789',3,'01-04-2018',1300000,'01-04-2023');
insert into Contrato (NIT,idCargo,Fecha_contratacion,salario,fecha_terminacion) values ('123456789',3,'20-01-2020',1300000,'20-01-2025');
insert into Contrato (NIT,idCargo,Fecha_contratacion,salario,fecha_terminacion) values ('123456789',2,'01-01-2020',2200000,'01-01-2030');
insert into Contrato (NIT,idCargo,Fecha_contratacion,salario,fecha_terminacion) values ('123456789',4,'15-02-2020',900000,'15-02-2025');
insert into Contrato (NIT,idCargo,Fecha_contratacion,salario,fecha_terminacion) values ('123456789',3,'01-01-2018',1300000,'01-01-2023');
insert into Contrato (NIT,idCargo,Fecha_contratacion,salario,fecha_terminacion) values ('123456789',3,'25-12-2016',1300000,'25-12-2021');
    

-- Tabla 'Empleado'

insert into Empleado (idContrato,nombre,apellido,direccion,telefono,eps,ciudad,fecha_de_nacimiento) values (1,'Jeisson','Clavijo','Cll 9 #4-07','3213633827','Compensar','Sopó','24-06-1996');
insert into Empleado (idContrato,nombre,apellido,direccion,telefono,eps,ciudad,fecha_de_nacimiento) values (2,'Johan','Clavijo','Cll 9 #4-07','3178753777','Compensar','Sopó','02-02-2002');
insert into Empleado (idContrato,nombre,apellido,direccion,telefono,eps,ciudad,fecha_de_nacimiento) values (3,'Juan','Ótero','Cll 8 #3-21','3145876521','Colsanitas','Cájica','05-02-1990');
insert into Empleado (idContrato,nombre,apellido,direccion,telefono,eps,ciudad,fecha_de_nacimiento) values (4,'Camila','Urrutia','Cra 5 #3-24','3123485468','Colsanitas','Cájica','14-08-1992');
insert into Empleado (idContrato,nombre,apellido,direccion,telefono,eps,ciudad,fecha_de_nacimiento) values (5,'Ivan','Restrepo','Cll 12 #12-06','3201484528','Cafesalud','Sopó','29-05-1996');
insert into Empleado (idContrato,nombre,apellido,direccion,telefono,eps,ciudad,fecha_de_nacimiento) values (6,'Juana','Parra','Cra 3 #7-12','3218455687','Colsanitas','Sopó','02-11-1998');
insert into Empleado (idContrato,nombre,apellido,direccion,telefono,eps,ciudad,fecha_de_nacimiento) values (7,'Johan','Piñeda','Cll 7 #1-02','3165849857','Cafesalud','Bogotá','16-08-2000');
insert into Empleado (idContrato,nombre,apellido,direccion,telefono,eps,ciudad,fecha_de_nacimiento) values (8,'Alberto','Gutierrez','Cll 12 #3-22','3102548974','Compensar','Bogotá','04-10-1997');
insert into Empleado (idContrato,nombre,apellido,direccion,telefono,eps,ciudad,fecha_de_nacimiento) values (9,'Lucia','Torres','Cra 6 #80-32','3215478956','Compensar','Bogotá','15-05-1995');
insert into Empleado (idContrato,nombre,apellido,direccion,telefono,eps,ciudad,fecha_de_nacimiento) values (10,'Fernando','Pinzón','Cra 6 #24-05','3102548689','Salud Total','Sopó','02-01-1999');
insert into Empleado (idContrato,nombre,apellido,direccion,telefono,eps,ciudad,fecha_de_nacimiento) values (11,'Luz','Villamil','Cll 4 #5-01','3145462137','Compensar','Sopó','20-08-1992');


-- Tabla 'Sucursal'

insert into Sucursal (NIT,Categoria,Nombre,Ubicacion,Ciudad, Administrador) values ('123456789','Punto de Fabricacion','Fabrica Pionono Cakes','Cll 9 #4-07','Sopó', 1);
insert into Sucursal (NIT,Categoria,Nombre,Ubicacion,Ciudad, Administrador) values ('123456789','Punto de Venta','Pionono Cakes Sopó','Cra 6 #4-12','Sopó',2);
insert into Sucursal (NIT,Categoria,Nombre,Ubicacion,Ciudad, Administrador) values ('123456789','Punto de Venta','Pionono Cakes Cájica','Cll 2 #3-27','Cájica',4);
insert into Sucursal (NIT,Categoria,Nombre,Ubicacion,Ciudad, Administrador) values ('123456789','Punto de Venta','Pionono Cakes Bogotá','Cll 6 #12-07','Bogotá',8);

-- Tabla 'Vinculos'

insert into Vinculos (idSucursal,idEmpleado) values (1,1);
insert into Vinculos (idSucursal,idEmpleado) values (2,2);
insert into Vinculos (idSucursal,idEmpleado) values (3,3);
insert into Vinculos (idSucursal,idEmpleado) values (3,4);
insert into Vinculos (idSucursal,idEmpleado) values (2,5);
insert into Vinculos (idSucursal,idEmpleado) values (2,6);
insert into Vinculos (idSucursal,idEmpleado) values (4,7);
insert into Vinculos (idSucursal,idEmpleado) values (4,8);
insert into Vinculos (idSucursal,idEmpleado) values (4,9);
insert into Vinculos (idSucursal,idEmpleado) values (1,10);
insert into Vinculos (idSucursal,idEmpleado) values (1,11);

-- Tabla 'Proveedor'

insert into Proveedor (NIT,Nombre,Razon_Social,Ubicacion,Persona_de_contacto,Telefono_de_contacto,Categoria,Terminos_de_Negociacion,email) values('987456123','Todo Pan Chia','Todo Pan Chia S.A.S','Cll 13 #3-42 Chía Cundinamarca','Jennifer Grisales','3178756847','Reposteria','Se ofrece un descuento especial del 25% por compras periodicas superiores a $ 500.000 (COP)','todopanchia@outlook.es');
insert into Proveedor (NIT,Nombre,Razon_Social,Ubicacion,Persona_de_contacto,Telefono_de_contacto,Categoria,Terminos_de_Negociacion,email) values('458795216','Super mercado Premier','Premier S.A.S','Cll 1 #5-22 Sopó Cundinamarca','Jorge Ramirez','3178756847','Reposteria','','premiermarket@gmail.com');
insert into Proveedor (NIT,Nombre,Razon_Social,Ubicacion,Persona_de_contacto,Telefono_de_contacto,Categoria,Terminos_de_Negociacion,email) values('258147369','Accesorios de Cocina Viper','Viper S.A','Cra 32 #5-21 Bogotá','Roberto Rodriguez','3215478595','Maquinas de Cocina','','viperaccesorios@outlook.es');
insert into Proveedor (NIT,Nombre,Razon_Social,Ubicacion,Persona_de_contacto,Telefono_de_contacto,Categoria,Terminos_de_Negociacion,email) values('457214587','Coca-Cola','Coca-Cola Company','Cll 10 #12-32 Tocancipa Cundinamarca','Henry Huerfano','3178756847','Bebidas Gaseosas','Se ofrece un descuento especial del 10% por compras periodicas superiores a $ 100.000 (COP)','coca-cola_company@hotmail.com');

-- Tabla Inventario

insert into Inventario (idSucursal) values(1);
insert into Inventario (idSucursal) values(2);
insert into Inventario (idSucursal) values(3);
insert into Inventario (idSucursal) values(4);

-- Tabla 'Maquinaria_y_Equipo'

insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (1,'Horno industrial de 3 pisos','01-06-2017',2000000,'Kitchen Professional','5 años de Garantía',320000,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (2,'Maquina Cafetera profesional','15-07-2021',1200000,'Kitchen Professional','2 años de Garantía',192000,'Pendiente',1200000);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (1,'Mesa para pasteleria','10-08-2019',600000,'Kitchen Professional','1 año de Garantía',96000,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (1,'Nevera para pasteles','01-06-2016',1800000,'Kitchen Professional','5 años de Garantía',288000,'Pagado',0);

-- Tabla 'Adquisicion_Maquinaria_y_Equipo'

insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,1);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,2);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,3);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,4);

-- Tabla 'Insumo'

insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (1,'Harina de trigo',500,'gr',5,'Haz de Oro','02-01-2021','Pagado',0,400);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (1,'Azucar glass',500,'gr',3,'Rio Paila','02-01-2021','Pagado',0,240);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (2,'Coca-cola Zero',1500,'ml',2,'Coca-Cola','10-01-2021','Pagado',0,480);

-- Tabla 'Adquisicion Insumos'

insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,1);

-- Tabla 'Producto'

insert into Producto (Nombre,Precio,Fecha_de_produccion,Categoria,Fecha_de_caducidad,Punto_de_fabricacion) values ('Torta de Amapola',15000,'10-01-2021','Pasteleria','30-01-2021',1);

-- Tabla 'Cliente'

insert into Cliente (Nombre,Apellido,Perfil) values ('John','Sarmiento','Frecuente');
insert into Cliente (Nombre,Apellido,Perfil) values ('Valeria','Gallo','Casual');

-- Tabla 'Venta'

insert into Venta (idEmpleado,idCliente,idSucursal,Fecha) values (3,1,2,'22-06-2021');
insert into Venta (idEmpleado,idCliente,idSucursal,Fecha) values (9,2,4,'14-05-2021');

-- Tabla 'Venta_productos'

insert into Venta_productos (idVenta,idProducto) values (1,1);

-- Tabla 'Venta_insumos'

insert into Venta_insumos (idVenta,idInsumo) values (2,3);

-- Tabla 'Domicilio'

insert into Domicilio (idCliente,idEmpleado,idVenta,Direccion_entrega) values (1,3,1,'Cll 3 # 1-03 Sopó Cundinamarca');

