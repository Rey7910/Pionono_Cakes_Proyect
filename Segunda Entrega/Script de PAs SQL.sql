-- Script de PAs SQL de la Base de Datos de la microempresa Pionono Cakes
-- Desarrolladores:
-- Reinaldo Toledo Leguizamón
-- Santiago Hernández Chaparro

-- Proyecto de Bases de Datos 2021-1

use pionono_cakes;

DELIMITER $$
CREATE PROCEDURE informacion_contrato_empleado_id (id_empleado int)
BEGIN
select empleado.nombre, empleado.apellido, cargos.nombre as cargo, salario, contrato.fecha_contratacion, 
contrato.fecha_terminacion from empleado, cargos, contrato where empleado.idContrato = contrato.idContrato 
and cargos.idCargo=contrato.idcargo and id_empleado = empleado.idContrato;
END;
$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE informacion_contrato_empleado_nombre (nombre_empleado char(45), apellido_empleado char(45))
BEGIN
select empleado.nombre, empleado.apellido, cargos.nombre as cargo, salario, contrato.fecha_contratacion, 
contrato.fecha_terminacion from empleado, cargos, contrato where empleado.idContrato = contrato.idContrato 
and cargos.idCargo=contrato.idcargo and nombre_empleado = empleado.Nombre and apellido_empleado = empleado.Apellido;
END;
$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE historial_cliente_id (id_cliente int)
BEGIN
select cliente.nombre, cliente.apellido, producto.nombre as producto,
venta.fecha from cliente, producto, venta, venta_productos 
where venta_productos.idventa=venta.idventa and venta.idcliente=cliente.idcliente
and producto.idProducto=venta_productos.idProducto and id_cliente = cliente.idcliente;
END;
$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE historial_cliente_nombre (nombre_cliente char(45), apellido_cliente char(45))
BEGIN
select cliente.nombre, cliente.apellido, producto.nombre as producto,
venta.fecha from cliente, producto, venta, venta_productos 
where venta_productos.idventa=venta.idventa and venta.idcliente=cliente.idcliente
and producto.idProducto=venta_productos.idProducto and nombre_cliente = cliente.Nombre
and apellido_empleado = cliente.Apellido;
END;
$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE historial_cliente_nombre (nombre_cliente char(45), apellido_cliente char(45))
BEGIN
select cliente.nombre, cliente.apellido, producto.nombre as producto,
venta.fecha from cliente, producto, venta, venta_productos 
where venta_productos.idventa=venta.idventa and venta.idcliente=cliente.idcliente
and producto.idProducto=venta_productos.idProducto and nombre_cliente = cliente.Nombre
and apellido_empleado = cliente.Apellido;
END;
$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE historial_ventas_empleado_nombre (nombre_empleado char(45), apellido_empleado char(45))
BEGIN
select empleado.nombre, empleado.apellido, sucursal.nombre as sucursal,
venta.fecha from empleado, producto, venta, venta_productos, sucursal
where venta_productos.idventa=venta.idventa and venta.idempleado=empleado.idempleado
and producto.idProducto=venta_productos.idProducto and sucursal.idsucursal = venta.idsucursal
and nombre_empleado = empleado.Nombre and apellido_empleado = empleado.Apellido;
END;
$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE historial_ventas_empleado_id (id_empleado char(45))
BEGIN
select empleado.nombre, empleado.apellido, sucursal.nombre as sucursal,
venta.fecha from empleado, producto, venta, venta_productos, sucursal
where venta_productos.idventa=venta.idventa and venta.idempleado=empleado.idempleado
and producto.idProducto=venta_productos.idProducto and sucursal.idsucursal = venta.idsucursal
and id_empleado = empleado.idEmpleado;
END;
$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE informacion_cliente_id (id_cliente int)
BEGIN
select cliente.nombre, cliente.apellido, cliente.perfil, domicilio.direccion_entrega 
from cliente, domicilio where cliente.idCliente = domicilio.idCliente and cliente.idCliente = id_cliente;
END;
$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE informacion_cliente_nombre (nombre_cliente char(45), apellido_cliente char(45))
BEGIN
select cliente.nombre, cliente.apellido, cliente.perfil, domicilio.direccion_entrega 
from cliente, domicilio where cliente.idCliente = domicilio.idCliente and cliente.Nombre = nombre_cliente
and cliente.Apellido = apellido_cliente;
END;
$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE numero_trabajadores_sucursal_id (id_sucursal int)
BEGIN
select sucursal.nombre as sucursal, count(vinculos.idempleado) from sucursal, vinculos 
where vinculos.idsucursal = sucursal.idsucursal and sucursal.idSucursal = id_sucursal;
END;
$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE numero_trabajadores_sucursal_nombres (nombre_sucursal char(45))
BEGIN
select sucursal.nombre as sucursal, count(vinculos.idempleado) from sucursal, vinculos 
where vinculos.idsucursal = sucursal.idsucursal and sucursal.Nombre = nombre_sucursal;
END;
$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sucursales_ciudad (ciudad char(45))
BEGIN
select sucursal.nombre as sucursal, sucursal.idSucursal as Id from sucursal where ciudad = sucursal.Ciudad;
END;
$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE deuda_insumos ()
BEGIN
select sum(precio_por_unidad_de_medida*unidad_de_medida*cantidad) as deuda_insumos 
from insumo where Estado_de_pago = "Pendiente";
END;
$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE deuda_maquinaria ()
BEGIN
select sum(Cantidad_a_pagar) as deuda_maquinaria from maquinaria_y_equipo 
where Estado_de_pago = "Pendiente";
END;
$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE ventas_sucursal_id (id_sucursal int)
BEGIN
select sucursal.nombre as sucursal, count(venta.idventa) from venta, sucursal
where sucursal.idsucursal = venta.idsucursal and sucursal.idSucursal = id_sucursal;
END;
$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE ventas_sucursal_nombre (nombre_sucursal int)
BEGIN
select sucursal.nombre as sucursal, count(venta.idventa) from venta, sucursal
where sucursal.idsucursal = venta.idsucursal and sucursal.Nombre = nombre_sucursal;
END;
$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE disponibilidad_producto_categoria (categoria_producto char(45))
BEGIN
select Categoria, sum(idproducto) from producto WHERE categoria_producto = producto.Categoria; 
END;
$$
DELIMITER ;


DELIMITER $$
drop procedure if exists obtener_id;
CREATE PROCEDURE obtener_id(nombre_u varchar(45),apellido_u varchar (45))
BEGIN
select idempleado from empleado where nombre=nombre_u and apellido=apellido_u;
END;
$$
DELIMITER ;


