-- Script de Creación de la Base de Datos de la microempresa Pionono Cakes
-- Desarrolladores:
-- Reinaldo Toledo Leguizamón
-- Santiago Hernández Chaparro

-- Proyecto de Bases de Datos 2021-1
use pionono_cakes;

drop view if exists adm_clientes;
drop view if exists adm_contratos;
drop view if exists info_empleados;
drop view if exists info_contratos;
drop view if exists insumos_domicilio;

-- Nota: El Jefe de la microempresa tiene acceso a todas las tablas y vistas de la base de datos

-- 1) VISTAS PARA ADMINISTRADORES DE SUCURSALES

-- Vista de los datos de los clientes, accesible tanto para empleados como administradores,
create view adm_clientes as select Nombre, Apellido, Perfil from cliente;
select * from adm_clientes;

-- Vista de los datos de los contratos de los empleados, accesible para administradores de sucursales (sin acceso a salario)
create view adm_contratos as select empleado.Nombre, empleado.Apellido, 
cargos.Nombre as cargo, contrato.fecha_contratacion, contrato.fecha_terminacion 
from empleado, contrato, cargos where empleado.idContrato = contrato.idContrato and cargos.idCargo=contrato.idCargo;

-- Vista de productos vendidos ### NUEVA
drop view if exists productos_vendidos;
create view productos_vendidos as select producto.nombre as producto, concat(cliente.nombre,' ',cliente.apellido) ,
 concat(empleado.nombre,' ',empleado.apellido), sucursal.nombre, venta.fecha 
from cliente,empleado,venta,sucursal,producto,venta_productos 
where cliente.idcliente = venta.idcliente and empleado.idempleado = venta.idempleado 
and venta_productos.idproducto = producto.idproducto and venta_productos.idventa = venta.idventa
and venta.idsucursal=sucursal.idsucursal;

-- Vista de insumos vendidos 
create view insumos_vendidos as select insumo.nombre, cliente.nombre as cliente_n, cliente.apellido 
as cliente_a, empleado.nombre as empleado_n, empleado.apellido as empleado_a,
sucursal.nombre as sucursal from insumo, empleado, cliente, venta_insumos, sucursal, venta 
where venta.idventa = venta_insumos.idventa
and cliente.idcliente = venta.idventa and venta.idempleado = empleado.idempleado and venta.idsucursal = sucursal.idsucursal
and venta_insumos.idinsumo = insumo.idinsumo;


-- Vista de domicilios de insumos
create view insumos_domicilio as select insumo.nombre, cliente.nombre as cliente_n, cliente.apellido 
as cliente_a, empleado.nombre as empleado_n, empleado.apellido as empleado_a,
sucursal.nombre as sucursal, domicilio.direccion_entrega as direccion from insumo, empleado, cliente, venta_insumos, sucursal, venta, domicilio
where venta.idventa = venta_insumos.idventa
and cliente.idcliente = venta.idcliente and venta.idempleado = empleado.idempleado and venta.idsucursal = sucursal.idsucursal
and venta_insumos.idinsumo = insumo.idinsumo and domicilio.idventa = venta.idventa and domicilio.idventa = venta_insumos.idventa;


-- Vista de domicilios de productos

create view productos_domicilios as select producto.nombre, cliente.nombre as cliente_n, cliente.apellido 
as cliente_a, empleado.nombre as empleado_n, empleado.apellido as empleado_a,
sucursal.nombre as sucursal, domicilio.direccion_entrega as direccion from producto, empleado, cliente, venta_productos, sucursal, venta, domicilio
where venta.idventa = venta_productos.idventa
and cliente.idcliente = venta.idcliente and venta.idempleado = empleado.idempleado and venta.idsucursal = sucursal.idsucursal
and venta_productos.idproducto = producto.idproducto and domicilio.idventa = venta.idventa and domicilio.idventa = venta_productos.idventa;

-- Información de proveedores (sin términos de negociación)

create view proveedores_info as select nombre, razon_social, ubicacion, 
categoria, persona_de_contacto, telefono_de_contacto
from proveedor;

-- 2) VISTAS PARA EMPLEADOS
-- Vista para acceder a la información personal del propio empleado (condicionada desde la interfaz), 
-- en caso de ser administrador de sucursal, puede acceder a la información de todos los empleados 
create view info_empleados as select Nombre, Apellido, Direccion, 
Telefono, EPS, Ciudad, Fecha_de_Nacimiento from empleado;

-- Vista de los datos del contrato de cada empleado, el funcionario solo puede acceder a su propio registro (condicionado desde interfaz)
create view info_contratos as select empleado.Nombre, empleado.Apellido, 
cargos.nombre as cargo, contrato.salario, contrato.fecha_contratacion, contrato.fecha_terminacion 
from empleado, contrato, cargos where empleado.idContrato = contrato.idContrato and cargos.idCargo=contrato.idCargo;



create view sucursales_info as select  sucursal.categoria, sucursal.nombre, sucursal.ubicacion, sucursal.ciudad, 
concat(empleado.nombre,' ', empleado.apellido) 
from sucursal, empleado where empleado.idempleado = sucursal.administrador;

