/*Creacion de base de datos llamada Sprintfinalm3 con datos de la empresa telovendo*/

create database sprintfinalm3;
use sprintfinalm3; 

/*creamos usuario con todos sus permisos para editar*/

create user 'admin'@'localhost' identified by '123';
grant all privileges on *.* to 'admin'@'localhost';

/*creamos las tablas con los datos de la empresa*/

create table categoria (
id_categoria integer primary key auto_increment,
nombre_categoria varchar (50) not null
);

/*creamos tabla telefono adicionalmente para complementar datos*/

create table telefono (
id_telefono integer primary key auto_increment,
telefono_1 varchar (20) not null,
telefono_2 varchar (20) not null,
telefono_3 varchar (20),
receptor varchar (50) not null
);

create table producto (
id_producto integer primary key auto_increment,
id_categoria integer,
stock integer not null,
precio float not null,
color varchar (50),
foreign key (id_categoria) references categoria(id_categoria)
);

create table cliente (
id_cliente integer primary key auto_increment,
nombre varchar (50) not null,
apellido varchar (50) not null,
direccion varchar (50) not null
);

create table producto_cliente(
id_producto_cliente integer primary key auto_increment,
id_producto integer,
id_cliente integer,
foreign key (id_producto) references producto(id_producto),
foreign key (id_cliente) references cliente(id_cliente)
);

create table proveedor(
id_proveedor integer primary key auto_increment,
id_telefono integer,
representante_legal varchar (50) not null,
correo_electronico varchar (50) not null,
nombre_corporacion varchar (50) not null,
foreign key (id_telefono) references telefono(id_telefono)
);

create table producto_proveedor(
id_producto_proveedor integer primary key auto_increment,
id_producto integer,
id_proveedor integer,
foreign key (id_producto) references producto(id_producto),
foreign key (id_proveedor) references proveedor(id_proveedor)
);

/*registramos datos en las tablas*/

insert into telefono (telefono_1, telefono_2, telefono_3, receptor) values
('+56976543567', '+56987622449', '+56987785465', 'Juan Pérez'),
('+56976556787', '+56966557788', '+56987785465', 'Ricardo Soto'),
('+56965445676', '+56987778216', '-', 'Alberto Plaza'),
('+56980887033', '+56978443322', '+56998876465', 'Luis Miguel'),
('+56967889900', '+56998778077', '+56976669465', 'Marco Antonio');

insert into proveedor (id_telefono, representante_legal, correo_electronico, nombre_corporacion) values 
(1, 'Carlos Tapia', 'carlostapia@gmail.com', 'carlos tapia inc'),
(2, 'Pedro Fuentes', 'pedrofuentes@gmail.com', 'pedrofuentes corp'),
(3, 'Barbara Pino', 'barbarapino@gmail.com', 'barbara pino inc'),
(4, 'Jorge Alvarado', 'jorgea@gmail.com', 'jorge tapia interprice'),
(5, 'Nicole Prado', 'nicoprado@gmail.com', 'nicole exportaciones');

insert into categoria (nombre_categoria) values
('electrodomesticos'),
('vestuario'),
('electronica'),
('dormitorio'),
('hogar');

insert into producto (id_categoria, stock, precio, color) values
(1, 100, 100000, 'blanco'),
(2, 200, 200000, 'negro'),
(3, 300, 300000, 'verde'),
(4, 400, 400000, 'amarillo'),
(5, 500, 500000, 'rosado'),
(3, 600, 600000, 'azul'),
(2, 700, 700000, 'gris'),
(3, 800, 800000, 'rojo'),
(4, 900, 900000, 'amarillo'),
(5, 999, 999999, 'morado');

insert into cliente (nombre, apellido, direccion) values
('Alberto', 'Diaz', 'Avenida mar 123, Valpariso'),
('Roberto', 'Mardones', 'Avenida playa 543, Concepcion'),
('Maria', 'Perez', 'Avenida Rocas 456, Talca'),
('Ruth', 'Alvarado', 'Avenida Plantas 123, Puerto Montt'),
('Pedro', 'Pascal', 'Avenida pelicula 432, Arica');

/*Cuál es la categoría de productos que más se repite*/
select c.nombre_categoria,p.id_categoria, count(*) as repeticiones 
from producto p inner join categoria c on p.id_categoria = c.id_categoria
group by p.id_categoria 
order by repeticiones desc limit 1; 

/*Cuáles son los productos con mayor stock*/
select * from producto where stock =(select max(stock) from producto);

/*Qué color de producto es más común en nuestra tienda.*/
select color, count(*) as repeticiones from producto group by color order by repeticiones desc limit 1;

/*Cual o cuales son los proveedores con menor stock de productos*/
select pr.representante_legal, min(stock) as repeticiones
from producto p inner join producto_proveedor pp on p.id_producto = pp.id_producto
inner join proveedor pr on pr.id_proveedor = pp.id_proveedor
group by pr.representante_legal
order by repeticiones desc limit 1;

/*Cambien la categoría de productos más popular por ‘Electrónica y computación’.*/
update categoria set nombre_categoria = 'electronica_y_computacion' where nombre_categoria = 'electrodomesticos';


/*INTEGRANTES: REBECA GATICA, GABRIEL SILVA, MICHAEL PIZARRO, NELSON TOLEDO*/

