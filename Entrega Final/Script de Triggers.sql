-- Script de Triggers de la Base de Datos de la microempresa Pionono Cakes
-- Desarrolladores:
-- Reinaldo Toledo Leguizamón
-- Santiago Hernández Chaparro

-- Proyecto de Bases de Datos 2021-1

use pionono_cakes;

-- Eliminacion de contrato 
drop trigger if exists despido;

DELIMITER |
CREATE TRIGGER despido after delete on empleado
FOR EACH ROW BEGIN
SET @idcontrato_f = old.idcontrato;
delete from contrato where idcontrato = @idcontrato_f;
END; |
DELIMITER ;



