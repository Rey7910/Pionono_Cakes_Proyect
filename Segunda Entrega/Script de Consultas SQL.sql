-- Script de Consultas SQL de la Base de Datos de la microempresa Pionono Cakes
-- Desarrolladores:
-- Reinaldo Toledo Leguizamón
-- Santiago Hernández Chaparro

-- Proyecto de Bases de Datos 2021-1

use pionono_cakes;

-- 1) JOINS 

-- a) Información del contrato de cada empleado.

select empleado.nombre, empleado.apellido, cargos.nombre as cargo, 
salario, contrato.fecha_contratacion, contrato.fecha_terminacion 
from empleado, cargos, contrato where empleado.idContrato = contrato.idContrato 
and cargos.idCargo=contrato.idcargo;

-- b)  Empleados y la respectiva sucursal a la que estan vinculados (puede ser más de una)

select empleado.nombre, empleado.apellido, sucursal.nombre as sucursal
from empleado, sucursal, vinculos where empleado.idEmpleado=vinculos.idempleado 
and sucursal.idsucursal=vinculos.idsucursal;

-- c) Compras de cada cliente y su respectiva fecha
select cliente.nombre, cliente.apellido, producto.nombre as producto,
venta.fecha from cliente, producto, venta, venta_productos 
where venta_productos.idventa=venta.idventa and venta.idcliente=cliente.idcliente
and producto.idProducto=venta_productos.idProducto;

-- d)Ventas de cada empleado en su respectiva sucursal y fecha

select empleado.nombre, empleado.apellido, sucursal.nombre as sucursal,
venta.fecha from empleado, producto, venta, venta_productos, sucursal
where venta_productos.idventa=venta.idventa and venta.idempleado=empleado.idempleado
and producto.idProducto=venta_productos.idProducto and sucursal.idsucursal = venta.idsucursal;

-- e) Administradores de las sucursales de la microempresa

select empleado.nombre, empleado.apellido, sucursal.nombre as sucursal
from empleado, sucursal, contrato, cargos where cargos.nombre = "Administrador"
and empleado.idempleado = sucursal.administrador and contrato.idcargo = cargos.idcargo
and empleado.idcontrato = contrato.idcontrato;

-- f) Domiciliarios de la microempresa y sus respectivos teléfonos

select empleado.nombre, empleado.apellido, empleado.telefono 
from empleado, contrato, cargos where cargos.nombre = "Domiciliario"
and cargos.idCargo = contrato.idcargo and empleado.idcontrato = contrato.idcontrato;

-- g) Maquinaría, su marca y su respectiva sucursal

select maquinaria_y_equipo.nombre , maquinaria_y_equipo.marca , sucursal.nombre as sucursal
from maquinaria_y_equipo, sucursal, inventario where maquinaria_y_equipo.idinventario=inventario.idinventario
and inventario.idsucursal = sucursal.idsucursal;

-- h)
-- i)
-- j) 


-- 2)  Agregaciones

-- a)
-- b)
-- c)
-- d)
-- e)
-- f)
-- g)
-- h)
-- i)
-- j)

-- 3) Agrupaciones

-- a)
-- b)
-- c)
-- d)
-- e)
-- f)
-- g)
-- h)
-- i)
-- j)

-- 4) IN

-- a)
-- b)
-- c)
-- d)
-- e)
-- f)
-- g)
-- h)
-- i)
-- j)

-- 5) HAVING

-- a)
-- b)
-- c)
-- d)
-- e)
-- f)
-- g)
-- h)
-- i)
-- j)
