-- Script de Perfiles y Usuarios de la microempresa Pionono Cakes
-- Desarrolladores:
-- Reinaldo Toledo Leguizamón
-- Santiago Hernández Chaparro

-- Proyecto de Bases de Datos 2021-1
use pionono_cakes;
SET SQL_SAFE_UPDATES = 0;

drop user if exists 'Jeisson Clavijo'@'localhost';
drop user if exists 'Camila Urrutia'@'localhost';
drop user if exists 'Johan Clavijo'@'localhost';
drop user if exists 'Alberto Gutierrez'@'localhost';
drop user if exists 'Juan Ótero'@'localhost';
drop user if exists 'Juana Parra'@'localhost';
drop user if exists 'Johan Piñeda'@'localhost';
drop user if exists 'Fernando Pinzón'@'localhost';
drop user if exists 'Luz Villamil'@'localhost';
drop user if exists 'Ivan Restrepo'@'localhost' ;
drop user if exists 'Lucia Torres'@'Localhost';

select empleado.nombre, empleado.apellido, cargos.nombre 
from empleado,cargos,contrato where empleado.idcontrato = contrato.idcontrato
and contrato.idcargo = cargos.idcargo;

-- Jefes
create user 'Jeisson Clavijo'@'localhost' identified by '12345';

-- Administradores
create user 'Camila Urrutia'@'localhost' identified by '12345';
create user 'Johan Clavijo'@'localhost' identified by '12345';
create user 'Alberto Gutierrez'@'localhost' identified by '12345';

-- Funcionarios
create user 'Juan Ótero'@'localhost' identified by '12345';
create user 'Juana Parra'@'localhost' identified by '12345';
create user 'Johan Piñeda'@'localhost' identified by '12345';
create user 'Fernando Pinzón'@'localhost' identified by '12345';
create user 'Luz Villamil'@'localhost' identified by '12345';

-- Domiciliarios
create user 'Ivan Restrepo'@'localhost' identified by '12345';
create user 'Lucia Torres'@'Localhost' identified by '12345';



-- Permisos de Jefes
-- Jefe 1
grant all on pionono_cakes.* to "Jeisson Clavijo"@"Localhost";
grant all on mysql.user to "Jeisson Clavijo"@"Localhost";
-- Permisos Administradores

-- Administrador 1
grant select on pionono_cakes.adm_contratos to 'Johan Clavijo'@'Localhost';
grant all on pionono_cakes.adm_clientes to 'Johan Clavijo'@'Localhost';
grant select on pionono_cakes.productos_vendidos to 'Johan Clavijo'@'Localhost';
grant all on pionono_cakes.producto to 'Johan Clavijo'@'Localhost';
grant all on pionono_cakes.maquinaria_y_equipo to 'Johan Clavijo'@'Localhost';
grant all on pionono_cakes.insumo to 'Johan Clavijo'@'Localhost';
grant select on pionono_cakes.insumos_vendidos to 'Johan Clavijo'@'Localhost';
grant select on pionono_cakes.insumos_domicilio to 'Johan Clavijo'@'Localhost';
grant select on pionono_cakes.productos_domicilios to 'Johan Clavijo'@'Localhost';
grant select on pionono_cakes.proveedores_info to 'Johan Clavijo'@'Localhost';
grant all on pionono_cakes.venta to 'Johan Clavijo'@'Localhost';
grant all on pionono_cakes.inventario to 'Johan Clavijo'@'Localhost';
grant select on pionono_cakes.info_empleados to 'Johan Clavijo'@'Localhost';
grant update on pionono_cakes.info_empleados to 'Johan Clavijo'@'Localhost';
grant select on pionono_cakes.info_contratos to 'Johan Clavijo'@'Localhost';
grant select on pionono_cakes.venta_insumos to 'Johan Clavijo'@'Localhost';
grant select on pionono_cakes.venta_productos to 'Johan Clavijo'@'Localhost';
grant all on pionono_cakes.domicilio to 'Johan Clavijo'@'Localhost';
grant all on pionono_cakes.cliente to 'Johan Clavijo'@'Localhost';
grant select on pionono_cakes.sucursal to 'Johan Clavijo'@'Localhost';
grant execute on procedure pionono_cakes.obtener_id to 'Johan Clavijo'@'Localhost';

-- Administrador 2
grant select on pionono_cakes.adm_contratos to 'Camila Urrutia'@'localhost';
grant all on pionono_cakes.adm_clientes to 'Camila Urrutia'@'localhost';
grant select on pionono_cakes.productos_vendidos to 'Camila Urrutia'@'localhost';
grant all on pionono_cakes.producto to 'Camila Urrutia'@'localhost';
grant all on pionono_cakes.maquinaria_y_equipo to 'Camila Urrutia'@'localhost';
grant all on pionono_cakes.insumo to 'Camila Urrutia'@'localhost';
grant select on pionono_cakes.insumos_vendidos to 'Camila Urrutia'@'localhost';
grant select on pionono_cakes.insumos_domicilio to 'Camila Urrutia'@'localhost';
grant select on pionono_cakes.productos_domicilios to 'Camila Urrutia'@'localhost';
grant select on pionono_cakes.proveedores_info to 'Camila Urrutia'@'localhost';
grant all on pionono_cakes.venta to 'Camila Urrutia'@'localhost';
grant all on pionono_cakes.inventario to 'Camila Urrutia'@'localhost';
grant select on pionono_cakes.info_empleados to 'Camila Urrutia'@'localhost';
grant update on pionono_cakes.info_empleados to 'Camila Urrutia'@'localhost';
grant select on pionono_cakes.info_contratos to 'Camila Urrutia'@'localhost';
grant select on pionono_cakes.venta_insumos to 'Camila Urrutia'@'localhost';
grant select on pionono_cakes.venta_productos to 'Camila Urrutia'@'localhost';
grant all on pionono_cakes.domicilio to 'Camila Urrutia'@'localhost';
grant all on pionono_cakes.cliente to 'Camila Urrutia'@'localhost';
grant select on pionono_cakes.sucursal to 'Camila Urrutia'@'localhost';
grant execute on procedure pionono_cakes.obtener_id to 'Camila Urrutia'@'localhost';
v

-- Administrador 3
grant select on pionono_cakes.adm_contratos to 'Alberto Gutierrez'@'localhost';
grant all on pionono_cakes.adm_clientes to 'Alberto Gutierrez'@'localhost';
grant select on pionono_cakes.productos_vendidos to 'Alberto Gutierrez'@'localhost';
grant all on pionono_cakes.producto to 'Alberto Gutierrez'@'localhost';
grant all on pionono_cakes.maquinaria_y_equipo to 'Alberto Gutierrez'@'localhost';
grant all on pionono_cakes.insumo to 'Alberto Gutierrez'@'localhost';
grant select on pionono_cakes.insumos_vendidos to 'Alberto Gutierrez'@'localhost';
grant select on pionono_cakes.insumos_domicilio to 'Alberto Gutierrez'@'localhost';
grant select on pionono_cakes.productos_domicilios to 'Alberto Gutierrez'@'localhost';
grant select on pionono_cakes.proveedores_info to 'Alberto Gutierrez'@'localhost';
grant all on pionono_cakes.venta to 'Alberto Gutierrez'@'localhost';
grant all on pionono_cakes.inventario to 'Alberto Gutierrez'@'localhost';
grant select on pionono_cakes.info_empleados to 'Alberto Gutierrez'@'localhost';
grant update on pionono_cakes.info_empleados to 'Alberto Gutierrez'@'localhost';
grant select on pionono_cakes.info_contratos to 'Alberto Gutierrez'@'localhost';
grant select on pionono_cakes.venta_insumos to 'Alberto Gutierrez'@'localhost';
grant select on pionono_cakes.venta_productos to 'Alberto Gutierrez'@'localhost';
grant all on pionono_cakes.domicilio to 'Alberto Gutierrez'@'localhost';
grant all on pionono_cakes.cliente to 'Alberto Gutierrez'@'localhost';
grant execute on procedure pionono_cakes.obtener_id to 'Alberto Gutierrez'@'localhost';


-- Permisos de Funcionarios

-- Funcionario 1
grant all on pionono_cakes.adm_clientes to 'Juan Ótero'@'localhost';
grant select on pionono_cakes.productos_vendidos to 'Juan Ótero'@'localhost';
grant all on pionono_cakes.producto to 'Juan Ótero'@'localhost';
grant select on pionono_cakes.maquinaria_y_equipo to 'Juan Ótero'@'localhost';
grant all on pionono_cakes.insumo to 'Juan Ótero'@'localhost';
grant select on pionono_cakes.insumos_vendidos to 'Juan Ótero'@'localhost';
grant all on pionono_cakes.inventario to 'Juan Ótero'@'localhost';
grant update on pionono_cakes.info_empleados to 'Juan Ótero'@'localhost';
grant select on pionono_cakes.info_empleados to 'Juan Ótero'@'localhost';
grant select on pionono_cakes.info_contratos to 'Juan Ótero'@'localhost';
grant all on pionono_cakes.venta to 'Juan Ótero'@'localhost';
grant all on pionono_cakes.cliente to 'Juan Ótero'@'localhost';
grant execute on procedure pionono_cakes.obtener_id to 'Juan Ótero'@'localhost';
grant select on pionono_cakes.empleado to 'Juan Ótero'@'localhost';
grant select on pionono_cakes.sucursal to 'Juan Ótero'@'localhost';
grant select on pionono_cakes.venta_insumos to 'Juan Ótero'@'localhost';
grant select on pionono_cakes.venta_productos to 'Juan Ótero'@'localhost';
grant select on pionono_cakes.domicilio to 'Juan Ótero'@'localhost';
grant execute on procedure pionono_cakes.mis_vinculos to 'Juan Ótero'@'localhost';



-- Funcionario 2
grant all on pionono_cakes.adm_clientes to 'Juana Parra'@'localhost';
grant select on pionono_cakes.productos_vendidos to 'Juana Parra'@'localhost';
grant all on pionono_cakes.producto to 'Juana Parra'@'localhost';
grant select on pionono_cakes.maquinaria_y_equipo to 'Juana Parra'@'localhost';
grant all on pionono_cakes.insumo to 'Juana Parra'@'localhost';
grant select on pionono_cakes.insumos_vendidos to 'Juana Parra'@'localhost';
grant all on pionono_cakes.inventario to 'Juana Parra'@'localhost';
grant update on pionono_cakes.info_empleados to 'Juana Parra'@'localhost';
grant select on pionono_cakes.info_empleados to 'Juana Parra'@'localhost';
grant select on pionono_cakes.info_contratos to'Juana Parra'@'localhost';
grant all on pionono_cakes.venta to 'Juana Parra'@'localhost';
grant all on pionono_cakes.cliente to 'Juana Parra'@'localhost';
grant execute on procedure pionono_cakes.obtener_id to 'Juana Parra'@'localhost';
grant select on pionono_cakes.empleado to 'Juana Parra'@'localhost';
grant select on pionono_cakes.sucursal to 'Juana Parra'@'localhost';
grant select on pionono_cakes.venta_insumos to 'Juana Parra'@'localhost';
grant select on pionono_cakes.venta_productos to 'Juana Parra'@'localhost';
grant select on pionono_cakes.domicilio to 'Juana Parra'@'localhost';
grant execute on procedure pionono_cakes.mis_vinculos to 'Juana Parra'@'localhost';



-- Funcionario 3
grant all on pionono_cakes.adm_clientes to 'Johan Piñeda'@'localhost';
grant select on pionono_cakes.productos_vendidos to 'Johan Piñeda'@'localhost';
grant all on pionono_cakes.producto to 'Johan Piñeda'@'localhost';
grant select on pionono_cakes.maquinaria_y_equipo to 'Johan Piñeda'@'localhost';
grant all on pionono_cakes.insumo to 'Johan Piñeda'@'localhost';
grant select on pionono_cakes.insumos_vendidos to 'Johan Piñeda'@'localhost';
grant all on pionono_cakes.inventario to 'Johan Piñeda'@'localhost';
grant update on pionono_cakes.info_empleados to 'Johan Piñeda'@'localhost';
grant select on pionono_cakes.info_empleados to 'Johan Piñeda'@'localhost';
grant select on pionono_cakes.info_contratos to 'Johan Piñeda'@'localhost';
grant all on pionono_cakes.venta to 'Johan Piñeda'@'localhost';
grant all on pionono_cakes.cliente to 'Johan Piñeda'@'localhost';
grant execute on procedure pionono_cakes.obtener_id to 'Johan Piñeda'@'localhost';
grant select on pionono_cakes.empleado to 'Johan Piñeda'@'localhost';
grant select on pionono_cakes.sucursal to 'Johan Piñeda'@'localhost';
grant select on pionono_cakes.venta_insumos to 'Johan Piñeda'@'localhost';
grant select on pionono_cakes.venta_productos to 'Johan Piñeda'@'localhost';
grant select on pionono_cakes.domicilio to 'Johan Piñeda'@'localhost';
grant execute on procedure pionono_cakes.mis_vinculos to 'Johan Piñeda'@'localhost';



-- Funcionario 4
grant all on pionono_cakes.adm_clientes to 'Fernando Pinzón'@'localhost';
grant select on pionono_cakes.productos_vendidos to 'Fernando Pinzón'@'localhost';
grant all on pionono_cakes.producto to 'Fernando Pinzón'@'localhost';
grant select on pionono_cakes.maquinaria_y_equipo to 'Fernando Pinzón'@'localhost';
grant all on pionono_cakes.insumo to 'Fernando Pinzón'@'localhost';
grant select on pionono_cakes.insumos_vendidos to 'Fernando Pinzón'@'localhost';
grant all on pionono_cakes.inventario to 'Fernando Pinzón'@'localhost';
grant update on pionono_cakes.info_empleados to 'Fernando Pinzón'@'localhost';
grant select on pionono_cakes.info_empleados to 'Fernando Pinzón'@'localhost';
grant select on pionono_cakes.info_contratos to 'Fernando Pinzón'@'localhost';
grant all on pionono_cakes.venta to 'Fernando Pinzón'@'localhost';
grant all on pionono_cakes.cliente to 'Fernando Pinzón'@'localhost';
grant execute on procedure pionono_cakes.obtener_id to 'Fernando Pinzón'@'localhost';
grant select on pionono_cakes.empleado to 'Fernando Pinzón'@'localhost';
grant select on pionono_cakes.sucursal to 'Fernando Pinzón'@'localhost';
grant select on pionono_cakes.venta_insumos to 'Fernando Pinzón'@'localhost';
grant select on pionono_cakes.venta_productos to 'Fernando Pinzón'@'localhost';
grant select on pionono_cakes.domicilio to 'Fernando Pinzón'@'localhost';
grant execute on procedure pionono_cakes.mis_vinculos to 'Fernando Pinzón'@'localhost';



-- Funcionario 5
grant all on pionono_cakes.adm_clientes to 'Luz Villamil'@'localhost';
grant select on pionono_cakes.productos_vendidos to 'Luz Villamil'@'localhost';
grant all on pionono_cakes.producto to 'Luz Villamil'@'localhost';
grant select on pionono_cakes.maquinaria_y_equipo to 'Luz Villamil'@'localhost';
grant all on pionono_cakes.insumo to 'Luz Villamil'@'localhost';
grant select on pionono_cakes.insumos_vendidos to 'Luz Villamil'@'localhost';
grant all on pionono_cakes.inventario to 'Luz Villamil'@'localhost';
grant update on pionono_cakes.info_empleados to 'Luz Villamil'@'localhost';
grant select on pionono_cakes.info_empleados to 'Luz Villamil'@'localhost';
grant select on pionono_cakes.info_contratos to 'Luz Villamil'@'localhost';
grant all on pionono_cakes.venta to 'Luz Villamil'@'localhost';
grant all on pionono_cakes.cliente to 'Luz Villamil'@'localhost';
grant select on pionono_cakes.empleado to 'Luz Villamil'@'localhost';
grant execute on procedure pionono_cakes.obtener_id to 'Luz Villamil'@'localhost';
grant select on pionono_cakes.sucursal to 'Luz Villamil'@'localhost';
grant select on pionono_cakes.venta_insumos to 'Luz Villamil'@'localhost';
grant select on pionono_cakes.venta_productos to 'Luz Villamil'@'localhost';
grant select on pionono_cakes.domicilio to 'Luz Villamil'@'localhost';
grant execute on procedure pionono_cakes.mis_vinculos to 'Luz Villamil'@'localhost';


-- Permisos Domiciliarios

-- Domiciliario 1
grant select on pionono_cakes.productos_vendidos to 'Ivan Restrepo'@'localhost';
grant select on pionono_cakes.insumos_vendidos to 'Ivan Restrepo'@'localhost';
grant select on pionono_cakes.insumos_domicilio to 'Ivan Restrepo'@'localhost';
grant select on pionono_cakes.productos_domicilios to 'Ivan Restrepo'@'localhost';
grant update on pionono_cakes.info_empleados to 'Ivan Restrepo'@'localhost';
grant select on pionono_cakes.info_empleados to 'Ivan Restrepo'@'localhost';
grant select on pionono_cakes.info_contratos to 'Ivan Restrepo'@'localhost';
grant all on pionono_cakes.domicilio to 'Ivan Restrepo'@'localhost';
grant execute on procedure pionono_cakes.obtener_id to 'Ivan Restrepo'@'localhost';

-- Domiciliario 2
grant select on pionono_cakes.productos_vendidos to 'Lucia Torres'@'Localhost';
grant select on pionono_cakes.insumos_vendidos to 'Lucia Torres'@'Localhost';
grant select on pionono_cakes.insumos_domicilio to 'Lucia Torres'@'Localhost';
grant select on pionono_cakes.productos_domicilios to 'Lucia Torres'@'Localhost';
grant update on pionono_cakes.info_empleados to 'Lucia Torres'@'Localhost';
grant select on pionono_cakes.info_empleados to 'Lucia Torres'@'Localhost';
grant select on pionono_cakes.info_contratos to 'Lucia Torres'@'Localhost';
grant all on pionono_cakes.domicilio to 'Lucia Torres'@'Localhost';
grant execute on procedure pionono_cakes.obtener_id to 'Lucia Torres'@'Localhost';



