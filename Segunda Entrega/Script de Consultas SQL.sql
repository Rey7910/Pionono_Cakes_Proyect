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

-- f) Domiciliarios y sus respectivos teléfonos

select empleado.nombre, empleado.apellido, empleado.telefono 
from empleado, contrato, cargos where cargos.nombre = "Domiciliario"
and cargos.idCargo = contrato.idcargo and empleado.idcontrato = contrato.idcontrato;

-- g) Maquinaría, su marca y su respectiva sucursal

select maquinaria_y_equipo.nombre , maquinaria_y_equipo.marca , sucursal.nombre as sucursal
from maquinaria_y_equipo, sucursal, inventario where maquinaria_y_equipo.idinventario=inventario.idinventario
and inventario.idsucursal = sucursal.idsucursal;

-- h) Insumos adquiridos con su respectivo proveedor y fecha de compra

select insumo.nombre, proveedor.nombre as provedor, insumo.fecha_de_compra 
from insumo, proveedor, adquisicion_insumos
where insumo.idinsumo=adquisicion_insumos.idinsumo and proveedor.NIT = adquisicion_insumos.NIT;

-- i)Clientes con sus perfiles y sus respectivas direcciones

select cliente.nombre, cliente.apellido, cliente.perfil, domicilio.direccion_entrega 
from cliente, domicilio where cliente.idcliente = domicilio.idcliente;

-- j) Funcionarios de la empresa con su dirección y EPS

select empleado.nombre, empleado.apellido, empleado.direccion, empleado.EPS
from empleado, contrato, cargos where cargos.nombre = "Funcionario"
and cargos.idCargo = contrato.idcargo and empleado.idcontrato = contrato.idcontrato;

-- 2)  Agregaciones y Agrupaciones

-- a) Número de empleados por cada sucursal

select sucursal.nombre as sucursal, count(vinculos.idempleado) from sucursal, vinculos 
where vinculos.idsucursal = sucursal.idsucursal group by sucursal.nombre;

-- b) Promedio salarial de los empleados por sucursal

select sucursal.nombre as sucursal, avg(contrato.salario) from sucursal, vinculos, contrato, empleado
where sucursal.idsucursal = vinculos.idsucursal and contrato.idcontrato = empleado.idempleado
and vinculos.idempleado = empleado.idempleado group by sucursal.nombre;

-- c) Cantidad de maquinaría presente en cada sucursal

select sucursal.nombre as sucursal, count(maquinaria_y_equipo.idmaquinaria_y_equipo) from sucursal, inventario, 
maquinaria_y_equipo where maquinaria_y_equipo.idinventario = inventario.idinventario 
and inventario.idsucursal = sucursal.idsucursal group by sucursal.nombre;

-- d) Deuda de la microempresa referente a insumos 

select sum(precio_por_unidad_de_medida*unidad_de_medida*cantidad) as deuda_insumos 
from insumo where Estado_de_pago = "Pendiente";

-- e) Deuda de la microempresa referente a maquinaría

select sum(Cantidad_a_pagar) as deuda_maquinaria from maquinaria_y_equipo 
where Estado_de_pago = "Pendiente";

-- f) Cantidad de sucursales vinculadas a cada empleado 

select empleado.nombre, empleado.apellido, sum(vinculos.idsucursal) 
from empleado, vinculos where empleado.idempleado = vinculos.idempleado 
group by empleado.nombre ;

-- g) Cantidad de ventas por cada sucursal

select sucursal.nombre as sucursal, count(venta.idventa) from venta,sucursal
where sucursal.idsucursal = venta.idsucursal group by sucursal.nombre;

-- h) Cantidad de productos disponibles por categoria

select categoria, sum(idproducto) from producto group by categoria; 

-- i) Salario promedio de todos los empleados

select avg(salario) from contrato;
select salario from contrato;
-- j) Promedio salarial de cada uno de los cargos

select cargos.nombre as cargo, avg(contrato.salario) from cargos, contrato
where cargos.idcargo = contrato.idcargo group by cargos.nombre;

-- 4) IN

-- a) Maquinaria presente en Sopó y bogotá

select maquinaria_y_equipo.nombre, maquinaria_y_equipo.marca from maquinaria_y_equipo, inventario,
sucursal where maquinaria_y_equipo.idinventario=inventario.idinventario and inventario.idsucursal=sucursal.idsucursal
and ciudad in ('Sopó','Bogotá');

-- b) Empleados cuyas EPS son Colsanitas, Compensar o Cafesalud

select nombre, apellido from empleado where EPS in ('Colsanitas','Compensar','Cafesalud');
select * from empleado;

-- c) Proveedores ubicados en Bogotá, Zipaquirá y Fusagasugá
select nombre as proveedores from proveedor where ubicacion like '%Bogotá%' or '%Fusagasugá%' or '%Zipaquirá%' ; 

-- d) Ventas realizadas entre el 10 de junio al 20 de junio de 2021

select count(idVenta) from venta 
where fecha 
in (
'10-06-2021',
'11-06-2021',
'12-06-2021',
'13-06-2021',
'14-06-2021',
'15-06-2021',
'16-06-2021',
'17-06-2021',
'18-06-2021',
'19-06-2021',
'20-06-2021'
);

-- 5) HAVING

-- a) Promedio salarial de cada sucursal cuando son menores a 2500000

select sucursal.nombre as sucursal, avg(contrato.salario) as promedio from sucursal, vinculos, contrato, empleado
where sucursal.idsucursal = vinculos.idsucursal and contrato.idcontrato = empleado.idempleado
and vinculos.idempleado = empleado.idempleado group by sucursal.nombre having promedio < 2500000;

-- b) Suma de salarios de las sucursales que son mayores a 30000000

select sucursal.nombre as sucursal, sum(contrato.salario) as total_salarios from sucursal, vinculos, contrato, empleado
where sucursal.idsucursal = vinculos.idsucursal and contrato.idcontrato = empleado.idempleado
and vinculos.idempleado = empleado.idempleado group by sucursal.nombre having total_salarios > 30000000;

-- c) Cantidad de maquinaria sin pagar por sucursal cuando es mayor a 5

select sucursal.nombre as sucursal, sum(maquinaria_y_equipo.idmaquinaria_y_equipo) as cantidad from maquinaria_y_equipo, sucursal,
inventario where maquinaria_y_equipo.idinventario = inventario.idinventario and sucursal.idsucursal = inventario.idsucursal
group by sucursal.nombre having cantidad > 5;




