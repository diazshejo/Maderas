
-- Generado por Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   en:        2023-03-08 15:46:21 CST
--   sitio:      Oracle Database 21c
--   tipo:      Oracle Database 21c



DROP TABLE carrito_compra CASCADE CONSTRAINTS;

DROP TABLE catalogo CASCADE CONSTRAINTS;

DROP TABLE categoria CASCADE CONSTRAINTS;

DROP TABLE cliente CASCADE CONSTRAINTS;

DROP TABLE compras CASCADE CONSTRAINTS;

DROP TABLE delivery CASCADE CONSTRAINTS;

DROP TABLE direccion CASCADE CONSTRAINTS;

DROP TABLE empleado CASCADE CONSTRAINTS;

DROP TABLE empresa CASCADE CONSTRAINTS;

DROP TABLE envio CASCADE CONSTRAINTS;

DROP TABLE factura CASCADE CONSTRAINTS;

DROP TABLE factura_det CASCADE CONSTRAINTS;

DROP TABLE inventario CASCADE CONSTRAINTS;

DROP TABLE login CASCADE CONSTRAINTS;

DROP TABLE pedido CASCADE CONSTRAINTS;

DROP TABLE producto CASCADE CONSTRAINTS;

DROP TABLE promociones CASCADE CONSTRAINTS;

DROP TABLE proveedor CASCADE CONSTRAINTS;

DROP TABLE socursal CASCADE CONSTRAINTS;

DROP TABLE valoracion CASCADE CONSTRAINTS;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE carrito_compra (
    id_carrito      INTEGER NOT NULL,
    producto_id_pro INTEGER NOT NULL,
    cantidad        INTEGER NOT NULL,
    estado          NUMBER
);

COMMENT ON COLUMN carrito_compra.estado IS
    'Espera 0
Pagado 1';

ALTER TABLE carrito_compra ADD CONSTRAINT carrito_compra_pk PRIMARY KEY ( id_carrito,
                                                                          cantidad );

CREATE TABLE catalogo (
    id_catalogo        INTEGER NOT NULL,
    producto_id_pro    INTEGER NOT NULL,
    descripcion_estado VARCHAR2(75),
    id_estado          INTEGER NOT NULL
);

ALTER TABLE catalogo ADD CONSTRAINT catalogo_pk PRIMARY KEY ( id_catalogo );

CREATE TABLE categoria (
    id_categoria INTEGER NOT NULL,
    descripcion  VARCHAR2(250),
    estado       NUMBER
);

ALTER TABLE categoria ADD CONSTRAINT categoria_pk PRIMARY KEY ( id_categoria );

CREATE TABLE cliente (
    id_cliente             INTEGER
        CONSTRAINT nnc_cliente_id_cliente NOT NULL,
    direccion_id_direccion INTEGER NOT NULL,
    numero_documento       VARCHAR2(25)
        CONSTRAINT nnc_cliente_numero_documento NOT NULL,
    tipocliente            SMALLINT,
    nombres_cli            VARCHAR2(75)
        CONSTRAINT nnc_cliente_nombres_cli NOT NULL,
    apellidos_cli          VARCHAR2(75),
    tel_cli                VARCHAR2(15),
    celular_cli            VARCHAR2(15),
    direccion_cli          INTEGER
        CONSTRAINT nnc_cliente_direccion_cli NOT NULL,
    profesion_cli          INTEGER,
    email                  VARCHAR2(75),
    direcciones            INTEGER
);

ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( id_cliente );

CREATE TABLE compras (
    id_compras   INTEGER NOT NULL,
    fecha_compra DATE,
    sku          INTEGER,
    cod_cliente  INTEGER,
    id_factura   INTEGER
);

ALTER TABLE compras ADD CONSTRAINT compras_pk PRIMARY KEY ( id_compras );

CREATE TABLE delivery (
    id_delivery INTEGER NOT NULL,
    id_compra   INTEGER,
    direccion   INTEGER,
    comentario  VARCHAR2(250),
    costo_envio NUMBER
);

ALTER TABLE delivery ADD CONSTRAINT delivery_pk PRIMARY KEY ( id_delivery );

CREATE TABLE direccion (
    id_direccion   INTEGER NOT NULL,
    tipo_direccion VARCHAR2(15) NOT NULL,
    municipio      INTEGER NOT NULL,
    departamento   INTEGER NOT NULL,
    pais           INTEGER,
    direccion      VARCHAR2(145)
);

COMMENT ON COLUMN direccion.tipo_direccion IS
    'Fiscal
Envio
Personal';

ALTER TABLE direccion ADD CONSTRAINT direccion_pk PRIMARY KEY ( id_direccion );

CREATE TABLE empleado (
    id_empleado            INTEGER NOT NULL,
    socursal_id_socursal   INTEGER NOT NULL,
    direccion_id_direccion INTEGER NOT NULL,
    nombres                VARCHAR2(50),
    apellidos              VARCHAR2(50)
);

ALTER TABLE empleado ADD CONSTRAINT empleado_pk PRIMARY KEY ( id_empleado );

CREATE TABLE empresa (
    id_empresa INTEGER NOT NULL,
    nit        VARCHAR2(15) NOT NULL,
    presidente INTEGER NOT NULL,
    direccion  INTEGER
);

ALTER TABLE empresa ADD CONSTRAINT empresa_pk PRIMARY KEY ( id_empresa );

CREATE TABLE envio (
    id_envio             INTEGER NOT NULL,
    delivery_id_delivery INTEGER NOT NULL,
    pedido_id_pedido     INTEGER NOT NULL,
    direccion_envio      INTEGER,
    fecha_envio          DATE,
    id_empleado          INTEGER,
    precio_envio         NUMBER,
    estatus_envio        INTEGER
);

ALTER TABLE envio ADD CONSTRAINT envio_pk PRIMARY KEY ( id_envio );

CREATE TABLE factura (
    id_factura           INTEGER NOT NULL,
    pedido_id_pedido     INTEGER NOT NULL,
    socursal_id_socursal INTEGER NOT NULL,
    cliente_id           INTEGER NOT NULL,
    nit                  VARCHAR2(25) NOT NULL,
    nombre_fiscal        VARCHAR2(175),
    id_direccion         INTEGER
);

ALTER TABLE factura ADD CONSTRAINT factura_pk PRIMARY KEY ( id_factura );

CREATE TABLE factura_det (
    fac_master          INTEGER NOT NULL,
    facturas_id_factura INTEGER NOT NULL,
    sku                 VARCHAR2(10) NOT NULL,
    descripcion_factdet VARCHAR2(150) NOT NULL,
    subtotal_factdet    NUMBER(10, 3)
);

ALTER TABLE factura_det ADD CONSTRAINT factura_det_pk PRIMARY KEY ( fac_master );

CREATE TABLE inventario (
    id_almacen             INTEGER NOT NULL,
    sku                    INTEGER NOT NULL,
    proveedor_id_proveedor INTEGER NOT NULL,
    cantidad_alm           INTEGER,
    precio_compra          NUMBER(10, 3),
    precio_venta           NUMBER,
    descripcion_alm        VARCHAR2(225),
    estado                 NUMBER
);

ALTER TABLE inventario ADD CONSTRAINT inventario_pk PRIMARY KEY ( id_almacen );

CREATE TABLE login (
    cliente_id    INTEGER NOT NULL,
    user_id       VARCHAR2(25),
    pass          VARCHAR2(25),
    fecha_ingreso DATE
);

ALTER TABLE login ADD CONSTRAINT login_pk PRIMARY KEY ( cliente_id );

CREATE TABLE pedido (
    id_pedido                 INTEGER NOT NULL,
    carrito_compra_id_carrito INTEGER NOT NULL,
    carrito_compra_cantidad   INTEGER NOT NULL,
    cliente_cliente_id        INTEGER NOT NULL,
    fecha_pedido              DATE,
    direccion_pedido          INTEGER,
    forma_pago                INTEGER,
    estado_pedido             INTEGER,
    tipo_pago                 INTEGER
);

ALTER TABLE pedido ADD CONSTRAINT pedido_pk PRIMARY KEY ( id_pedido );

CREATE TABLE producto (
    id_pro                 INTEGER NOT NULL,
    categoria_id_categoria INTEGER NOT NULL,
    inventario_id_almacen  INTEGER NOT NULL,
    referencia_pro         VARCHAR2(10),
    nombre_pro             VARCHAR2(75) NOT NULL,
    descripcion_pro        VARCHAR2(150),
    tipo_pro               INTEGER NOT NULL,
    material_pro           INTEGER NOT NULL,
    alto_pro               NUMBER(5, 2) NOT NULL,
    ancho_pro              NUMBER(5, 2) NOT NULL,
    profundidad_pro        NUMBER(5, 2) NOT NULL,
    color_pro              INTEGER,
    peso_pro               NUMBER(5, 2) NOT NULL,
    imagen_pro             BLOB,
    estado_pro             NUMBER,
    descuento_pro          NUMBER,
    porcentaje_desc_pro    NUMBER,
    categoria              INTEGER,
    unidad_medida_pro      VARCHAR2(10),
    estado                 NUMBER
);


CREATE INDEX producto__idx_nombre ON
    producto (
        tipo_pro
    ASC,
        material_pro
    ASC );

ALTER TABLE producto ADD CONSTRAINT productos_pk PRIMARY KEY ( id_pro );

CREATE TABLE promociones (
    id_promocion         INTEGER,
    producto_id_pro      INTEGER NOT NULL,
    fecha_inicio         DATE,
    fecha_fin            DATE,
    descuento_porcentaje INTEGER
);

CREATE TABLE proveedor (
    id_proveedor       INTEGER NOT NULL,
    nombre             VARCHAR2(75) NOT NULL,
    nit                VARCHAR2(15) NOT NULL,
    telefono           VARCHAR2(15),
    correo_electronico VARCHAR2(25),
    estado             NUMBER
);

ALTER TABLE proveedor ADD CONSTRAINT proveedor_pk PRIMARY KEY ( id_proveedor );

CREATE TABLE socursal (
    id_socursal            INTEGER NOT NULL,
    empresa_id_empresa     INTEGER NOT NULL,
    direccion_id_direccion INTEGER NOT NULL,
    gerente                INTEGER,
    nombre                 VARCHAR2(150),
    telefono               VARCHAR2(15)
);

ALTER TABLE socursal ADD CONSTRAINT socursal_pk PRIMARY KEY ( id_socursal );

CREATE TABLE valoracion (
    id_valoracion      INTEGER NOT NULL,
    cliente_id_cliente INTEGER NOT NULL,
    estrellas          SMALLINT,
    comentarios        VARCHAR2(512),
    fecha              DATE,
    id_pro             INTEGER
);

ALTER TABLE valoracion ADD CONSTRAINT valoracion_pk PRIMARY KEY ( id_valoracion );

ALTER TABLE inventario
    ADD CONSTRAINT almacen_proveedor_fk FOREIGN KEY ( proveedor_id_proveedor )
        REFERENCES proveedor ( id_proveedor );

ALTER TABLE carrito_compra
    ADD CONSTRAINT carrito_compra_producto_fk FOREIGN KEY ( producto_id_pro )
        REFERENCES producto ( id_pro );

ALTER TABLE catalogo
    ADD CONSTRAINT catalogo_producto_fk FOREIGN KEY ( producto_id_pro )
        REFERENCES producto ( id_pro );

ALTER TABLE cliente
    ADD CONSTRAINT cliente_direccion_fk FOREIGN KEY ( direccion_id_direccion )
        REFERENCES direccion ( id_direccion );

ALTER TABLE empleado
    ADD CONSTRAINT empleado_direccion_fk FOREIGN KEY ( direccion_id_direccion )
        REFERENCES direccion ( id_direccion );

ALTER TABLE empleado
    ADD CONSTRAINT empleado_socursal_fk FOREIGN KEY ( socursal_id_socursal )
        REFERENCES socursal ( id_socursal );

ALTER TABLE envio
    ADD CONSTRAINT envios_delivery_fk FOREIGN KEY ( delivery_id_delivery )
        REFERENCES delivery ( id_delivery );

ALTER TABLE envio
    ADD CONSTRAINT envios_pedido_fk FOREIGN KEY ( pedido_id_pedido )
        REFERENCES pedido ( id_pedido );

ALTER TABLE factura_det
    ADD CONSTRAINT factura_det_facturas_fk FOREIGN KEY ( facturas_id_factura )
        REFERENCES factura ( id_factura );

ALTER TABLE factura
    ADD CONSTRAINT facturas_pedido_fk FOREIGN KEY ( pedido_id_pedido )
        REFERENCES pedido ( id_pedido );

ALTER TABLE factura
    ADD CONSTRAINT facturas_socursal_fk FOREIGN KEY ( socursal_id_socursal )
        REFERENCES socursal ( id_socursal );

ALTER TABLE pedido
    ADD CONSTRAINT pedido_carrito_compra_fk FOREIGN KEY ( carrito_compra_id_carrito,
                                                          carrito_compra_cantidad )
        REFERENCES carrito_compra ( id_carrito,
                                    cantidad );

ALTER TABLE pedido
    ADD CONSTRAINT pedido_cliente_fk FOREIGN KEY ( cliente_cliente_id )
        REFERENCES cliente ( id_cliente );

ALTER TABLE producto
    ADD CONSTRAINT productos_categoria_fk FOREIGN KEY ( categoria_id_categoria )
        REFERENCES categoria ( id_categoria );

ALTER TABLE producto
    ADD CONSTRAINT productos_inventario_fk FOREIGN KEY ( inventario_id_almacen )
        REFERENCES inventario ( id_almacen );

ALTER TABLE promociones
    ADD CONSTRAINT promociones_producto_fk FOREIGN KEY ( producto_id_pro )
        REFERENCES producto ( id_pro );

ALTER TABLE socursal
    ADD CONSTRAINT socursal_direccion_fk FOREIGN KEY ( direccion_id_direccion )
        REFERENCES direccion ( id_direccion );

ALTER TABLE socursal
    ADD CONSTRAINT socursal_empresa_fk FOREIGN KEY ( empresa_id_empresa )
        REFERENCES empresa ( id_empresa );

ALTER TABLE valoracion
    ADD CONSTRAINT valoracion_cliente_fk FOREIGN KEY ( cliente_id_cliente )
        REFERENCES cliente ( id_cliente );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            20
-- CREATE INDEX                             2
-- ALTER TABLE                             38
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
