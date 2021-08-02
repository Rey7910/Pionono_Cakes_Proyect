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
insert into Proveedor (NIT,Nombre,Razon_Social,Ubicacion,Persona_de_contacto,Telefono_de_contacto,Categoria,Terminos_de_Negociacion,email) values('123456789','Super mercado Unimercas','Unimercas S.A.S','Cra 3 #1-24 Bogotá','Alba Rosales','3205488756','Insumos varios','','unimercas@gmail.com');
-- Tabla Inventario

insert into Inventario (idSucursal) values(1);
insert into Inventario (idSucursal) values(2);
insert into Inventario (idSucursal) values(3);
insert into Inventario (idSucursal) values(4);

-- Tabla 'Maquinaria_y_Equipo'

insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (1,'Horno industrial de 3 pisos','01-06-2017',2000000,'Fire Masters','5 años de Garantía',320000,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (2,'Maquina Cafetera profesional','15-07-2021',1200000,'Imusa','2 años de Garantía',192000,'Pendiente',1200000);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (1,'Mesa para pasteleria','10-08-2019',600000,'Kitchen Professional','1 año de Garantía',96000,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (1,'Nevera para pasteles','01-06-2016',1800000,'Kitchen Professional','5 años de Garantía',288000,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (1,'Batidora Kitchen-Aid','01-06-2016',1200000,'Kitchen Aid','3 años de Garantía',192000,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (1,'Batidora Kitchen-Aid Pro','23-03-2018',1600000,'Kitchen Aid','3 años de Garantía',256000,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (1,'Implementos para pasteleria','01-06-2016',300000,'Kitchen Professional','1 año de Garantía',48000,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (1,'Moldes profesionales','21-02-2017',430000,'Sweet Cakes Inc','2 años de Garantía',68800,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (1,'Herramientas pasteleria','01-08-2016',180000,'Sweet Cakes Inc','6 años de Garantía',28800,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (1,'Horno micro-ondas','14-03-2018',275000,'Oster','1 año de Garantía',44000,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (1,'Impresora HP INKjet','18-11-2020',520000,'Hewlett Packard','2 años de Garantía',83200,'Pendiente',520000);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (1,'Silla común','01-01-2016',25000,'HomePro','',4000,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (1,'Base Giratoria','10-06-2016',32000,'SweetCakes','',5120,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (1,'Accesorios para decorado','01-01-2018',74000,'Kitchen Professional','1 año de Garantía',11840,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (2,'Mesa de Madera','18-07-2017',80000,'HomeQuality','6 meses de Garantía',12800,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (2,'Mesa de Madera','18-07-2017',80000,'HomeQuality','6 meses de Garantía',12800,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (2,'Mesa de Madera','18-07-2017',80000,'HomeQuality','6 meses de Garantía',12800,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (2,'Nevera','22-10-2017',1200000,'RefriSans','4 años de Garantía',192000,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (2,'Caja Registradora','12-06-2017',60000,'SecurityIels','10 meses de Garantía',9600,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (2,'Juego de pocillos y platos','18-07-2017',142000,'HomeQuality','6 meses de Garantía',22720,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (2,'Mostrador','20-10-2017',2300000,'InternationalStyle','3 años de Garantía',368000,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (2,'Decoración Rustica','21-04-2017',620000,'InternationalStyle','8 meses de Garantía',99200,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (2,'Computador de escritorio','06-02-2016',800000,'Lenovo','1 año de Garantía',128000,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (2,'Parlantes de sonido','24-03-2017',55000,'Samsung','10 meses de Garantía',8800,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (2,'TV 32 pulgadas','02-10-2018',670000,'LG','2 años de Garantía',107200,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (2,'Horno micro-ondas','14-12-2017',300000,'Oster','8 meses de Garantía',48000,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (3,'Mesa de Madera','20-01-2018',80000,'HomeQuality','6 meses de Garantía',12800,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (3,'Mesa de Madera','20-01-2018',80000,'HomeQuality','6 meses de Garantía',12800,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (3,'Mesa de Madera','20-01-2018',80000,'HomeQuality','6 meses de Garantía',12800,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (3,'Nevera','12-03-2018',1100000,'CoolMaster','2 años de Garantía',176000,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (3,'Caja Registradora','15-01-2018',60000,'SecurityIels','10 meses de Garantía',9600,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (3,'Juego de pocillos y platos','13-01-2018',142000,'HomeQuality','6 meses de Garantía',22720,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (3,'Mostrador','04-06-2018',2300000,'InternationalStyle','1 año de Garantía',368000,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (3,'Decoración Rustica','04-06-2018',620000,'InternationalStyle','1 año de Garantía',99200,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (3,'Computador de escritorio','12-04-2018',860000,'Hewlett Packard','1 año de Garantía',137600,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (3,'Parlantes de sonido','12-04-2018',55000,'Samsung','10 meses de Garantía',8800,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (3,'TV 32 pulgadas','02-10-2018',670000,'LG','2 años de Garantía',107200,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (3,'Horno micro-ondas','10-01-2019',300000,'Imusa','10 meses de Garantía',48000,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (4,'Mesa de Madera','11-06-2019',80000,'HomeQuality','6 meses de Garantía',12800,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (4,'Mesa de Madera','11-06-2019',80000,'HomeQuality','6 meses de Garantía',12800,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (4,'Mesa de Madera','11-06-2019',80000,'HomeQuality','6 meses de Garantía',12800,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (4,'Nevera','22-06-2019',1200000,'RefriSans','4 años de Garantía',192000,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (4,'Caja Registradora','20-06-2019',60000,'SecurityIels','10 meses de Garantía',9600,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (4,'Juego de pocillos y platos','17-06-2019',142000,'HomeQuality','6 meses de Garantía',22720,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (4,'Mostrador','22-04-2019',2300000,'InternationalStyle','3 años de Garantía',368000,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (4,'Decoración Rustica','22-04-2019',620000,'InternationalStyle','8 meses de Garantía',99200,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (4,'Computador de escritorio','16-05-2019',970000,'Asus','1 año de Garantía',155200,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (4,'Parlantes de sonido','20-05-2019',60000,'Samsung','10 meses de Garantía',9600,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (4,'TV 32 pulgadas','30-10-2019',740000,'LG','2 años de Garantía',118400,'Pagado',0);
insert into Maquinaria_y_Equipo (idInventario,Nombre,Fecha_de_compra,Precio,Marca,Garantia,IVA,Estado_de_pago,Cantidad_a_pagar) values (4,'Horno micro-ondas','10-01-2019',300000,'Imusa','10 meses de Garantía',48000,'Pagado',0);

-- Tabla 'Adquisicion_Maquinaria_y_Equipo'

insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,1);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,2);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,3);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,4);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,5);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,6);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,7);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,8);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,9);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,10);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,11);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,12);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,13);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,14);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,15);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,16);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,17);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,18);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,19);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,20);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,21);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,22);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,23);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,24);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,25);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,26);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,27);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,28);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,29);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,30);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,31);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,32);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,33);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,34);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,35);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,36);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,37);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,38);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,39);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,40);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,41);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,42);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,43);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,44);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,45);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,46);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,47);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,48);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,49);
insert into adquisicion_maquinaria_y_equipo (NIT,idmaquinaria_y_equipo) values(258147369,50);

-- Tabla 'Insumo'

insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (1,'Harina de trigo',25,'gr',5,'Haz de Oro','02-01-2021','Pagado',0,0.8);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (1,'Azucar glass',25,'gr',5,'Rio Paila','02-01-2021','Pagado',0,0.8);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (1,'Huevos AAA',120,'gr',4,'Kike','02-01-2021','Pagado',0,0.64);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (1,'Mantequilla',50,'gr',6,'La Fina','02-01-2021','Pagado',0,0.96);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (1,'Azucar Morena',25,'gr',4.5,'Rio Paila','02-01-2021','Pagado',0,0.72);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (1,'Escencias liquidas',14,'ml',1.4,'SweetFlavour','03-02-2021','Pagado',0,0.224);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (1,'Colorantes Artificiales',23,'ml',1.6,'SweetFlavour','03-02-2021','Pagado',0,0.256);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (1,'Leche',40,'ml',2,'Alpina','03-02-2021','Pagado',0,0.32);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (1,'Fondant',10,'gr',2.3,'ArtePan','05-02-2021','Pagado',0,0.368);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (1,'Pastillaje',20,'gr',1.7,'ArtePan','05-02-2021','Pagado',0,0.272);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (1,'Chocolate',30,'gr',3.3,'Nacional de Chocolates','05-02-2021','Pagado',0,0.528);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (1,'Fresa',40,'gr',1.2,'Fruver','17-03-2021','Pagado',0,0.192);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (1,'Durazno',30,'gr',1.3,'Fruver','17-03-2021','Pagado',0,0.208);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (1,'Manzana',28,'gr',1.6,'Fruver','17-03-2021','Pagado',0,0.256);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (1,'Limon',35,'gr',1.1,'Fruver','17-03-2021','Pagado',0,0.176);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (1,'Gluten',10,'gr',2.2,'ArtePan','05-02-2021','Pagado',0,0.352);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (1,'Kumis',20,'ml',1.1,'Alpina','22-03-2021','Pagado',0,0.176);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (1,'Cocoa',30,'gr',2,'SweetFlavour','05-02-2021','Pagado',0,0.352);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (2,'Leche',20,'ml',1.8,'Alpina','10-04-2021','Pagado',0,0.288);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (2,'Kumis Personal',30,'ml',2.1,'Alpina','10-04-2021','Pagado',0,0.336);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (2,'Milo',30,'gr',4.2,'Nestle','11-04-2021','Pagado',0,0.672);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (2,'Cafe',30,'gr',2.1,'ColCafe','11-04-2021','Pagado',0,0.336);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (2,'Chocolate en polvo',30,'gr',3.2,'Corona','11-04-2021','Pagado',0,0.512);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (2,'Coca-Cola',27,'ml',3.3,'Coca-Cola Company','10-04-2021','Pagado',0,0.288);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (2,'Coca-Cola Zero',30,'ml',2,'Coca-Cola Company','10-01-2021','Pagado',0,0.32);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (2,'Sprite',30,'ml',2.1,'Coca-Cola Company','10-01-2021','Pagado',0,0.336);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (2,'Jugo del Valle',30,'ml',1.8,'Coca-Cola Company','10-01-2021','Pagado',0,0.288);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (2,'Pastel de pollo',20,'gr',1.4,'La Abuela','12-02-2021','Pagado',0,0.224);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (2,'Empanada de Carne',20,'gr',1.5,'La Abuela','12-02-2021','Pagado',0,0.24);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (2,'Empanada de Pollo',20,'gr',1.6,'La Abuela','12-02-2021','Pagado',0,0.256);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (2,'Papas de Pollo',25,'gr',1,'Margarita','15-02-2021','Pagado',0,0.16);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (2,'Doritos',25,'gr',1.2,'Frito-Lay','15-02-2021','Pagado',0,0.192);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (3,'Leche',20,'ml',1.8,'Alpina','12-06-2021','Pagado',0,0.288);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (3,'Kumis Personal',30,'ml',2.1,'Alpina','12-06-2021','Pagado',0,0.336);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (3,'Milo',30,'gr',4.2,'Nestle','11-06-2021','Pagado',0,0.672);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (3,'Cafe',30,'gr',2.1,'ColCafe','11-06-2021','Pagado',0,0.336);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (3,'Chocolate en polvo',30,'gr',3.2,'Corona','11-06-2021','Pagado',0,0.512);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (3,'Coca-Cola',27,'ml',3.3,'Coca-Cola Company','10-06-2021','Pagado',0,0.288);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (3,'Coca-Cola Zero',30,'ml',2,'Coca-Cola Company','10-06-2021','Pagado',0,0.32);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (3,'Sprite',30,'ml',2.1,'Coca-Cola Company','10-06-2021','Pagado',0,0.336);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (3,'Jugo del Valle',30,'ml',1.8,'Coca-Cola Company','10-06-2021','Pagado',0,0.288);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (3,'Pastel de pollo',20,'gr',1.4,'La Abuela','12-04-2021','Pagado',0,0.224);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (3,'Empanada de Carne',20,'gr',1.5,'La Abuela','12-04-2021','Pagado',0,0.24);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (3,'Empanada de Pollo',20,'gr',1.6,'La Abuela','12-04-2021','Pagado',0,0.256);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (3,'Papas de Pollo',25,'gr',1,'Margarita','15-04-2021','Pagado',0,0.16);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (3,'Doritos',25,'gr',1.2,'Frito-Lay','15-04-2021','Pagado',0,0.192);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (4,'Leche',20,'ml',1.8,'Alpina','10-07-2021','Pagado',0,0.288);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (4,'Kumis Personal',30,'ml',2.1,'Alpina','10-07-2021','Pagado',0,0.336);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (4,'Milo',30,'gr',4.2,'Nestle','11-06-2021','Pagado',0,0.672);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (4,'Cafe',30,'gr',2.1,'ColCafe','11-06-2021','Pagado',0,0.336);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (4,'Chocolate en polvo',30,'gr',3.2,'Corona','11-07-2021','Pagado',0,0.512);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (4,'Coca-Cola',27,'ml',3.3,'Coca-Cola Company','10-07-2021','Pagado',0,0.288);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (4,'Coca-Cola Zero',30,'ml',2,'Coca-Cola Company','10-06-2021','Pagado',0,0.32);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (4,'Sprite',30,'ml',2.1,'Coca-Cola Company','10-06-2021','Pagado',0,0.336);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (4,'Jugo del Valle',30,'ml',1.8,'Coca-Cola Company','10-06-2021','Pagado',0,0.288);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (4,'Pastel de pollo',20,'gr',1.4,'La Abuela','12-07-2021','Pagado',0,0.224);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (4,'Empanada de Carne',20,'gr',1.5,'La Abuela','12-07-2021','Pagado',0,0.24);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (4,'Empanada de Pollo',20,'gr',1.6,'La Abuela','12-07-2021','Pagado',0,0.256);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (4,'Papas de Pollo',25,'gr',1,'Margarita','15-06-2021','Pagado',0,0.16);
insert into Insumo (idInventario,Nombre,Cantidad,Unidad_de_Medida,Precio_por_unidad_de_medida,Marca,fecha_de_compra,Estado_de_pago,Cantidad_a_pagar,IVA) values (4,'Doritos',25,'gr',1.2,'Frito-Lay','15-05-2021','Pagado',0,0.192);


-- Tabla 'Adquisicion Insumos'

insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,1);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,2);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,3);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,4);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,5);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,6);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,7);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,8);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,9);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,10);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,11);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,12);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,13);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,14);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,15);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,16);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,17);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,18);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,19);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,20);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,21);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,22);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,23);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,24);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,25);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,26);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,27);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,28);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,29);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,30);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,31);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,32);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,33);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,34);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,35);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,36);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,37);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,38);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,39);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,40);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,41);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,42);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,43);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,44);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,45);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,46);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,47);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,48);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,49);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,50);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,51);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,52);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,53);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,54);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,55);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,56);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,57);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,58);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,59);
insert into Adquisicion_insumos (NIT,idInsumo) values(987456123,60);

-- Tabla 'Producto'

insert into Producto (Nombre,Precio,Fecha_de_produccion,Categoria,Fecha_de_caducidad,Punto_de_fabricacion) values ('Torta de Amapola',15000,'10-01-2021','Pasteleria','30-01-2021',1);
insert into Producto (Nombre,Precio,Fecha_de_produccion,Categoria,Fecha_de_caducidad,Punto_de_fabricacion) values ('Torta de Zanahoria',18000,'20-02-2021','Pasteleria','30-03-2021',1);
insert into Producto (Nombre,Precio,Fecha_de_produccion,Categoria,Fecha_de_caducidad,Punto_de_fabricacion) values ('Torta Red Velvet',12000,'20-01-2021','Pasteleria','30-02-2021',1);
insert into Producto (Nombre,Precio,Fecha_de_produccion,Categoria,Fecha_de_caducidad,Punto_de_fabricacion) values ('Torta de Nuez Brasileña',25000,'15-02-2021','Pasteleria','15-03-2021',1);
insert into Producto (Nombre,Precio,Fecha_de_produccion,Categoria,Fecha_de_caducidad,Punto_de_fabricacion) values ('Torta de Vainilla',10000,'10-01-2021','Pasteleria','30-01-2021',1);
insert into Producto (Nombre,Precio,Fecha_de_produccion,Categoria,Fecha_de_caducidad,Punto_de_fabricacion) values ('Torta de Chocolate',11000,'10-01-2021','Pasteleria','30-01-2021',1);
insert into Producto (Nombre,Precio,Fecha_de_produccion,Categoria,Fecha_de_caducidad,Punto_de_fabricacion) values ('Torta Arcoiris',30000,'30-01-2021','Pasteleria','30-02-2021',1);
insert into Producto (Nombre,Precio,Fecha_de_produccion,Categoria,Fecha_de_caducidad,Punto_de_fabricacion) values ('Pie de Manzana',14000,'21-03-2021','Pasteleria','25-04-2021',1);
insert into Producto (Nombre,Precio,Fecha_de_produccion,Categoria,Fecha_de_caducidad,Punto_de_fabricacion) values ('Pie de Limon',12500,'21-03-2021','Pasteleria','25-04-2021',1);
insert into Producto (Nombre,Precio,Fecha_de_produccion,Categoria,Fecha_de_caducidad,Punto_de_fabricacion) values ('Pie de Durazno',13000,'21-03-2021','Pasteleria','25-04-2021',1);
insert into Producto (Nombre,Precio,Fecha_de_produccion,Categoria,Fecha_de_caducidad,Punto_de_fabricacion) values ('Cheesecake Mora',18000,'12-04-2021','Postres','12-05-2021',1);
insert into Producto (Nombre,Precio,Fecha_de_produccion,Categoria,Fecha_de_caducidad,Punto_de_fabricacion) values ('Cheesecake Oreo',21000,'12-04-2021','Postres','12-05-2021',1);
insert into Producto (Nombre,Precio,Fecha_de_produccion,Categoria,Fecha_de_caducidad,Punto_de_fabricacion) values ('Galleta Pionono',500,'24-01-2021','Pasteleria','24-06-2021',1);
insert into Producto (Nombre,Precio,Fecha_de_produccion,Categoria,Fecha_de_caducidad,Punto_de_fabricacion) values ('Cinammon',1300,'16-02-2021','Panaderia','30-02-2021',1);
insert into Producto (Nombre,Precio,Fecha_de_produccion,Categoria,Fecha_de_caducidad,Punto_de_fabricacion) values ('Pan artesanal Pionono',300,'28-03-2021','Panaderia','28-04-2021',1);


-- Tabla 'Cliente'

insert into Cliente (Nombre,Apellido,Perfil) values ('John','Sarmiento','Frecuente');
insert into Cliente (Nombre,Apellido,Perfil) values ('Valeria','Gallo','Casual');
insert into Cliente (Nombre,Apellido,Perfil) values ('Ana','Ortega','Común');
insert into Cliente (Nombre,Apellido,Perfil) values ('Jenny','Osorio','Común');
insert into Cliente (Nombre,Apellido,Perfil) values ('Felipe','Otálora','Común');
insert into Cliente (Nombre,Apellido,Perfil) values ('Juan','Pinzón','Frecuente');
insert into Cliente (Nombre,Apellido,Perfil) values ('Zandra','Castillo','Casual');
insert into Cliente (Nombre,Apellido,Perfil) values ('Danna','Osorio','Casual');
insert into Cliente (Nombre,Apellido,Perfil) values ('Jose','Medrano','Común');
insert into Cliente (Nombre,Apellido,Perfil) values ('Armando','Guerra','Frecuente');
insert into Cliente (Nombre,Apellido,Perfil) values ('Diana','Rodríguez','Frecuente');
insert into Cliente (Nombre,Apellido,Perfil) values ('Paula','Moreno','Común');
insert into Cliente (Nombre,Apellido,Perfil) values ('Jorge','Gutierrez','Común');
insert into Cliente (Nombre,Apellido,Perfil) values ('Jessy','Otero','Común');
insert into Cliente (Nombre,Apellido,Perfil) values ('Liliana','Quintero','Común');

-- Tabla 'Venta'

insert into Venta (idEmpleado,idCliente,idSucursal,Fecha) values (2,1,2,'22-06-2021');
insert into Venta (idEmpleado,idCliente,idSucursal,Fecha) values (1,2,2,'14-05-2021');
insert into Venta (idEmpleado,idCliente,idSucursal,Fecha) values (3,12,3,'11-04-2021');
insert into Venta (idEmpleado,idCliente,idSucursal,Fecha) values (6,3,2,'10-05-2021');
insert into Venta (idEmpleado,idCliente,idSucursal,Fecha) values (9,5,4,'21-06-2021');
insert into Venta (idEmpleado,idCliente,idSucursal,Fecha) values (5,7,2,'04-04-2021');
insert into Venta (idEmpleado,idCliente,idSucursal,Fecha) values (1,9,2,'17-07-2021');
insert into Venta (idEmpleado,idCliente,idSucursal,Fecha) values (8,15,4,'12-05-2021');
insert into Venta (idEmpleado,idCliente,idSucursal,Fecha) values (4,14,3,'21-04-2021');
insert into Venta (idEmpleado,idCliente,idSucursal,Fecha) values (2,13,2,'30-06-2021');
insert into Venta (idEmpleado,idCliente,idSucursal,Fecha) values (3,8,3,'24-04-2021');
insert into Venta (idEmpleado,idCliente,idSucursal,Fecha) values (5,11,2,'11-05-2021');
insert into Venta (idEmpleado,idCliente,idSucursal,Fecha) values (8,12,4,'19-04-2021');
insert into Venta (idEmpleado,idCliente,idSucursal,Fecha) values (4,4,3,'10-06-2021');
insert into Venta (idEmpleado,idCliente,idSucursal,Fecha) values (5,6,2,'16-04-2021');
insert into Venta (idEmpleado,idCliente,idSucursal,Fecha) values (5,10,2,'23-07-2021');
insert into Venta (idEmpleado,idCliente,idSucursal,Fecha) values (1,2,2,'14-05-2021');
insert into Venta (idEmpleado,idCliente,idSucursal,Fecha) values (8,12,4,'11-04-2021');
insert into Venta (idEmpleado,idCliente,idSucursal,Fecha) values (7,11,4,'10-05-2021');
insert into Venta (idEmpleado,idCliente,idSucursal,Fecha) values (4,10,3,'14-05-2021');


-- Tabla 'Venta_productos'

insert into Venta_productos (idVenta,idProducto) values (1,1);
insert into Venta_productos (idVenta,idProducto) values (3,15);
insert into Venta_productos (idVenta,idProducto) values (5,12);
insert into Venta_productos (idVenta,idProducto) values (6,7);
insert into Venta_productos (idVenta,idProducto) values (7,4);
insert into Venta_productos (idVenta,idProducto) values (8,13);
insert into Venta_productos (idVenta,idProducto) values (10,2);
insert into Venta_productos (idVenta,idProducto) values (11,3);
insert into Venta_productos (idVenta,idProducto) values (12,11);
insert into Venta_productos (idVenta,idProducto) values (13,5);
insert into Venta_productos (idVenta,idProducto) values (14,8);
insert into Venta_productos (idVenta,idProducto) values (15,6);
insert into Venta_productos (idVenta,idProducto) values (16,9);
insert into Venta_productos (idVenta,idProducto) values (17,10);
insert into Venta_productos (idVenta,idProducto) values (20,14);

-- Tabla 'Venta_insumos'

insert into Venta_insumos (idVenta,idInsumo) values (2,25);
insert into Venta_insumos (idVenta,idInsumo) values (9,34);
insert into Venta_insumos (idVenta,idInsumo) values (18,57);
insert into Venta_insumos (idVenta,idInsumo) values (19,60);
insert into Venta_insumos (idVenta,idInsumo) values (4,27);

-- Tabla 'Domicilio'

insert into Domicilio (idCliente,idEmpleado,idVenta,Direccion_entrega) values (1,3,20,'Cll 3 # 1-03 Sopó Cundinamarca');
insert into Domicilio (idCliente,idEmpleado,idVenta,Direccion_entrega) values (7,3,12,'Cra 5 # 2-45 Sopó Cundinamarca');
insert into Domicilio (idCliente,idEmpleado,idVenta,Direccion_entrega) values (11,5,1,'Cll 2 # 3-32 Cajica Cundinamarca');
insert into Domicilio (idCliente,idEmpleado,idVenta,Direccion_entrega) values (6,9,3,'Cra 13 # 2-05  Bogotá');
insert into Domicilio (idCliente,idEmpleado,idVenta,Direccion_entrega) values (5,5,7,'Cll 2 # 3-21 Cajica Cundinamarca');
insert into Domicilio (idCliente,idEmpleado,idVenta,Direccion_entrega) values (11,3,13,'Cra 5 # 4-27  Sopó Cundinamarca');
insert into Domicilio (idCliente,idEmpleado,idVenta,Direccion_entrega) values (11,5,15,'Cll 10 # 2-63 Cajica Cundinamarca');
insert into Domicilio (idCliente,idEmpleado,idVenta,Direccion_entrega) values (6,3,5,'Cll 3 # 50-13  Sopó Cundinamarca');
