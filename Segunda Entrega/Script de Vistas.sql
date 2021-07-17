-- Script de Creación de la Base de Datos de la microempresa Pionono Cakes
-- Desarrolladores:
-- Reinaldo Toledo Leguizamón
-- Santiago Hernández Chaparro

-- Proyecto de Bases de Datos 2021-1
use pionono_cakes;

drop view if exists adm_clientes;
drop view if exists adm_contratos;
drop view if exists info_empleado;
drop view if exists info_contrato;


-- Nota: El Jefe de la microempresa tiene acceso a todas las tablas y vistas de la base de datos

-- 1) VISTAS PARA ADMINISTRADORES DE SUCURSALES

-- Vista de los datos de los clientes, accesible tanto para empleados como administradores,
create view adm_clientes as select Nombre, Apellido, Perfil from cliente;
select * from adm_clientes;

-- Vista de los datos de los contratos de los empleados, accesible para administradores de sucursales
create view adm_contratos as select empleado.Nombre, empleado.Apellido, 
contrato.cargo, contrato.fecha_contratacion, contrato.fecha_terminacion 
from empleado, contrato where empleado.idContrato = contrato.idContrato;

-- 2) VISTAS PARA EMPLEADOS
-- Vista para acceder a la información personal del propio empleada (condicionada desde la interfaz), 
-- en caso de ser administrador de sucursal, puede acceder a la información de todos los empleados 
create view info_empleado as select Nombre, Apellido, Direccion, 
Telefono, EPS, Ciudad, Fecha_de_Nacimiento from empleado;

-- Vista de los datos del contrato de cada empleado, solo tiene acceso al registro del mismo (condicionado desde inerfaz)
create view info_contrato as select empleado.Nombre, empleado.Apellido, 
contrato.cargo, contrato.salario, contrato.fecha_contratacion, contrato.fecha_terminacion 
from empleado, contrato where empleado.idContrato = contrato.idContrato;
