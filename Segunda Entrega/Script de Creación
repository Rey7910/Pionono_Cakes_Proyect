DROP SCHEMA IF EXISTS pionono_cakes;
CREATE SCHEMA pionono_cakes;
USE pionono_cakes;

CREATE TABLE Proveedor(
    NIT	varchar(45),
    Razón_Social  varchar(45),
    Ubicación varchar(45),
    Persona_de_contacto varchar(45), 
    Teléfono_de_contacto varchar(45), 
    Categoría varchar(45),
    Términos_de_Negociación longtext,
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
    PRIMARY KEY (idInsumo)
);
