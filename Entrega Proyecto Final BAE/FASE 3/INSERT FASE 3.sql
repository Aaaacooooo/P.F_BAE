use restaurante;

-- Inserción de datos en la tabla Empleados
INSERT INTO Empleados (Nombre, Apellido1, Apellido2, Direccion, Puesto)
VALUES
('Carla', 'Sedano', 'Marin', 'Calle Principal 123', 'Encargado'),
('Merche', 'Becerra', 'Urrutia', 'Avenida Central 456', 'Jefe_Cocinero'),
('María Luisa', 'Rodriguez', 'Zamora', 'Calle Secundaria 789', 'Encargado'),
('Amaro', 'Vega', 'Sobrino', 'Avenida Central 321', 'Jefe_Cocinero'),
('Sabina', 'Fernandez', NULL, 'Calle Principal 987', 'Encargado');

INSERT INTO Proveedor (Nombre, Direccion, Especializacion)
VALUES 
('Distribuidora Pizzas S.A.', 'Avenida Comercial 123', 'Pizzas de todo tipo'),
('Productos Congelados S.A.', 'Calle Congelados 456', 'Alimentos congelados'),
('Distribuidora Frutas Frescas', 'Avenida Frutal 789', 'Frutas y verduras frescas'),
('Distribuidora Panadería S.A.', 'Calle Panadera 567', 'Pan y productos de panadería'),
('Carnicería Don Carlos', 'Avenida Carnes 890', 'Carnes frescas y embutidos');


-- Inserción de datos en la tabla Pedido
INSERT INTO Pedido (Fecha_pedido, Fecha_esperada, Fecha_entrega, Estado)
VALUES
('2023-01-01', '2023-01-03', '2023-01-04', 'Entregado'),
('2023-02-01', '2023-02-03', NULL, 'Preparandose'),
('2023-03-01', '2023-03-03', NULL, 'En_camino'),
('2023-04-01', '2023-04-03', NULL, 'Preparandose'),
('2023-05-01', '2023-05-03', NULL, 'En_camino');

-- Inserción de datos en la tabla Realiza_pedido
INSERT INTO Realiza_pedido (Empleados_idEmpleados, Pedido_idPedido)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Inserción de datos en la tabla Almacen
INSERT INTO Almacen (Nombre, Ubicacion, Capacidad)
VALUES
('Congelador', 'Ubicacion1', 100),
('Almacen1', 'Ubicacion2', 150),
('Almacen2', 'Ubicacion3', 150);

-- Inserción de datos en la tabla Zona_almacen
 INSERT INTO Zona_almacen (Nombre, Almacen_idAlmacen, Capacidad)
VALUES
('Congeladosdos', 1, 50), -- POSTRES, PIZZAS, PANES ...
('Congeladosdos', 1, 50), -- CARNES, PESCADOS ...
('Frutas', 2, 50), --  FRUTAS ...
('Hortalizas', 2, 100), -- HORTALIZAS ...
('Especias', 3, 75), -- ESPECIAS ...
('Utencilios de cocina', 3, 75); -- UTENCILIOS DE COCINA

-- Inserciones en la tabla Producto
INSERT INTO Producto (Nombre, Categoria, Fecha_vencimiento, Cantidad_en_stock, Precio_venta, Proveedor_idProveedor, Lista_pedidos_idLista_pedidos, Lista_pedidos_Pedido_idPedido, Zona_almacen_idZona_almacen, Zona_almacen_Almacen_idAlmacen)
VALUES

('Pizza Margarita', 'Pizzas', '2023-03-01', 15, 11.99,      1,   4, 4, 4, 2),
('Salmón a la Parrilla', 'Pescados', NULL, 20, 14.99,       2,   3, 3, 3, 2),
('Tarta de Chocolate', 'Postres', '2023-04-01', 8, 7.99,    2,   5, 5, 1, 1),
('Ensalada de la Casa', 'Ensaladas', '2023-02-01', 5, 9.99, 3,   2, 2, 2, 1),
('Filete de Ternera', 'Carnes', '2023-01-01', 10, 19.99,    5,   1, 1, 1, 1);

-- Inserción de datos en la tabla Lista_pedidos
INSERT INTO Lista_pedidos (Cantidad, Precio_unitario, Producto_idProducto, Pedido_idPedido)
VALUES
(5, 19.99, 1, 1),
(3, 9.99, 1, 2),
(2, 14.99, 2, 3),
(4, 11.99, 3, 4),
(6, 7.99, 3, 5);

-- Inserción de datos en la tabla Telefono_Empleado
INSERT INTO Telefono_Empleado (Empleados_idEmpleado, Telefono_empleado)
VALUES
(1, '623456789'),
(2, '634567890'),
(3, '945678901'),
(4, '656789012'),
(5, '967890123');

-- Inserción de datos en la tabla Email_Empleado
INSERT INTO Email_Empleado (Empleados_idEmpleado, Email_empleado)
VALUES
(1, 'carla@gmail.com'),
(2, 'merche@gmail.com'),
(3, 'maria@gmail.com'),
(4, 'amaro@gmail.com'),
(5, 'sabina@gmail.com');

-- Inserción de datos en la tabla Telefono_Proveedor
INSERT INTO Telefono_Proveedor (Proveedor_idProveedor, Telefono_proveedor)
VALUES
(1, '611111111'),
(2, '622222222'),
(3, '633333333'),
(4, '644444444'),
(5, '955555555');

-- Inserción de datos en la tabla Email_Proveedor
INSERT INTO Email_Proveedor (Proveedor_idProveedor, Email_proveedor)
VALUES
(1, 'distribuidora_pizzas@gmail.com'),
(2, 'productos_congelados@gmail.com'),
(3, 'distribuidora_frutas@gmail.com'),
(4, 'distribuidora_panaderia@gmail.com'),
(5, 'carniceria_doncarlos@gmail.com');
	