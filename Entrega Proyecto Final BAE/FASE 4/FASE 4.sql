
USE restaurante;

-- ********************************************************************************************************************************************
-- Describe y resuelve al menos 3 consultas haciendo uso de composiciones internas del tipo INNER JOIN o composiciones naturales (NATURAL JOIN)
-- ********************************************************************************************************************************************

-- Obtener varios datos sobre los productos de proveedores de especialización "Carnes frescas y embutidos" y ademas se centre en su lista de pedidos
SELECT p.idProducto, p.Nombre AS Producto, p.Categoria, lp.idLista_pedidos, lp.Cantidad, lp.Precio_unitario
FROM Producto p
JOIN Proveedor pr ON p.Proveedor_idProveedor = pr.idProveedor
JOIN Lista_pedidos lp ON p.Lista_pedidos_idLista_pedidos = lp.idLista_pedidos
WHERE pr.Especializacion IN ('Carnes frescas y embutidos');

-- Obtener los telefonos y los email de esos proveedores
SELECT tp.Telefono_proveedor, ep.Email_proveedor
FROM Proveedor pr
JOIN Telefono_Proveedor tp ON pr.idProveedor = tp.Proveedor_idProveedor
JOIN Email_Proveedor ep ON pr.idProveedor = ep.Proveedor_idProveedor
WHERE pr.Especializacion IN ('Carnes frescas y embutidos');

-- Obtener los telefonos y los emails de los empleados que tengan uno o más de un pedido
SELECT DISTINCT te.Telefono_empleado, ee.Email_empleado
FROM Empleados em
NATURAL JOIN Telefono_Empleado te
NATURAL JOIN Email_Empleado ee
WHERE em.idEmpleado = ANY (
  SELECT rp.Empleados_idEmpleados
  FROM Realiza_pedido rp
  GROUP BY rp.Empleados_idEmpleados
  HAVING COUNT(rp.Pedido_idPedido) >= 1
);


-- ************************************************************************************************************************************************************
-- Describe y resuelve al menos 3 consultas haciendo uso de composiciones externas del tipo LEFT/RIGHT JOIN o composiciones naturales (NATURAL LEFT/RIGHT JOIN).
-- ************************************************************************************************************************************************************

-- Obtener el nombre del empleado y se cuenta el número de pedidos en estado 'Preparandose' que están asociados a cada empleado
SELECT e.Nombre, COUNT(p.idPedido) AS NumPedidos
FROM Empleados e
JOIN realiza_pedido r on r.Empleados_idEmpleados = e.idEmpleado
LEFT JOIN Pedido p ON r.Pedido_idPedido= p.idPedido
WHERE p.Estado = 'Preparandose'
GROUP BY e.Nombre;

-- En este el LEFT no hace nada tengo que hacerlo mejor

-- ***********************************************************************************************************************
-- Describe y resuelve al menos 3 consultas haciendo uso de consultas resumen mediante el uso de funciones de agregado
-- (MAX, MIN, AVG, SUM, COUNT), agrupamiento de registros (GROUP BY) y estableciendo condiciones de agrupamiento (HAVING).
-- ***********************************************************************************************************************

-- Obtener el número total de pedidos realizados por cada empleado y mostrar solo aquellos empleados que hayan realizado más de 5 pedidos
SELECT e.Nombre, COUNT(p.idPedido) AS TotalPedidos
FROM Empleados e
LEFT JOIN Pedido p ON e.idEmpleado = p.idPedido
GROUP BY e.Nombre
HAVING COUNT(p.idPedido) >= 1;

--  Obtener la cantidad total de productos en stock por almacén y mostrar solo aquellos almacenes cuya cantidad total de productos sea inferior a 100
SELECT a.Nombre, SUM(p.Cantidad_en_stock) AS CantidadTotal
FROM Almacen a
LEFT JOIN Producto p ON a.idAlmacen = p.Zona_almacen_Almacen_idAlmacen
GROUP BY a.Nombre
HAVING SUM(p.Cantidad_en_stock) < 100;

-- Calcular el promedio de precios de los productos por categoría y mostrar solo las categorías cuyo promedio de precios sea superior a 50
SELECT Categoria, AVG(Precio_venta) AS PromedioPrecios
FROM Producto
GROUP BY Categoria
HAVING AVG(Precio_venta) > 10;


-- ***********************************************************************************************************************
-- Describe y resuelve al menos 3 consultas haciendo uso de subconsultas que devuelven una fila con una columna mediante el 
-- uso de operadores de comparación, subconsultas que devuelven una fila con varias columnas, o subconsultas que devuelven 
-- múltiples filas haciendo uso de ANY, ALL, IN, NOT IN, EXISTS y NOT EXISTS.
-- ***********************************************************************************************************************

-- Obtener el nombre de los empleados cuyo puesto sea "Encargado" y que tengan al menos un pedido entregado
SELECT Nombre
FROM Empleados
WHERE Puesto = 'Encargado' AND idEmpleado IN (
  SELECT Empleados_idEmpleados
  FROM Realiza_pedido
  INNER JOIN Pedido ON Realiza_pedido.Pedido_idPedido = Pedido.idPedido
  WHERE Estado = 'Entregado'
);

-- Obtener el nombre y la dirección de los proveedores cuya especialización sea "Carnes frescas y embutidos" y que tengan al menos un producto en stock
SELECT Nombre, Direccion
FROM Proveedor
WHERE Especializacion = 'Carnes frescas y embutidos' AND idProveedor IN (
  SELECT Proveedor_idProveedor
  FROM Producto
  WHERE Cantidad_en_stock > 0
);

-- Obtener el nombre y apellido de todos los empleados que trabajan como "Encargado" en el mismo almacén que el empleado con nombre "Sabina", utilizando EXISTS
SELECT Nombre, Apellido1, Apellido2
FROM Empleados e1
WHERE Puesto = 'Encargado' 
AND EXISTS (
  SELECT *
  FROM Empleados e2
  WHERE Nombre = 'Sabina' 
  AND e1.idEmpleado = e2.idEmpleado
);

-- Obtener el nombre de todos los productos que están en stock en alguna zona de almacenamiento que tenga una capacidad mayor a 100 unidades, utilizando ANY
SELECT Nombre
FROM Producto
WHERE idProducto = ANY (
  SELECT idProducto
  FROM Zona_almacen
  INNER JOIN Producto ON Zona_almacen.idZona_almacen = Producto.Zona_almacen_idZona_almacen 
  WHERE Capacidad >= 50
);

-- Obtener todos los empleados y su información de contacto, incluso si no tienen información de contacto asociada
SELECT e.Nombre, ce.Telefono, ce.Email
FROM Empleados e
LEFT JOIN Contacto_Empleado ce ON e.idEmpleado = ce.Empleados_idEmpleado;

-- Obtener los empleados que tienen más de 3 pedidos en preparación
SELECT e.Nombre, COUNT(*) AS NumPedidos
FROM Empleados e
INNER JOIN Pedido p ON e.idEmpleado = p.idEmpleado
WHERE p.Estado = 'Preparandose'
GROUP BY e.Nombre
HAVING COUNT(*) > 3;

-- Obtener el nombre y el precio unitario de los productos que hayan sido incluidos en al menos un pedido realizado por el empleado de nombre "Carla"
SELECT p.Nombre, l.Precio_unitario
FROM Producto p
LEFT JOIN Lista_pedidos l on l.idLista_pedidos = p. Lista_pedidos_idLista_pedidos
JOIN pedido pe on pe.idPedido = l.Pedido_idPedido
RIGHT JOIN realiza_pedido r on pe.idPedido = r.Pedido_idPedido
JOIN Empleados e ON r.Empleados_idEmpleados = e.idEmpleado
WHERE (l.Pedido_idPedido, l.idLista_pedidos) IN (
  SELECT l.Pedido_idPedido, l.idLista_pedidos
  FROM Lista_pedidos l
  JOIN pedido p on p.idPedido = l.Pedido_idPedido
  JOIN realiza_pedido r on p.idPedido = r.Pedido_idPedido
  JOIN Empleados e ON r.Empleados_idEmpleados = e.idEmpleado
  WHERE e.Nombre = 'Carla'
);


-- ********************************************************************************************
-- ******************************************* CRUD *******************************************
-- ********************************************************************************************

-- Insertar un nuevo pedido en la tabla Pedido utilizando un empleado existente
INSERT INTO Pedido (Fecha_pedido, Fecha_esperada, Estado, idEmpleado)
VALUES 
('2023-06-12', '2023-06-15', 'Preparandose', 
(SELECT idEmpleado FROM Empleados WHERE Nombre = 'Carla'));

-- Insertar nuevos empleados
INSERT INTO Empleados (idEmpleado, Nombre, Apellido1, Apellido2, Direccion, Puesto)
VALUES (
  (SELECT MAX(idEmpleado) + 1 FROM Empleados),
  'John',
  'Doe',
  NULL,
  '123 Main Street',
  'Encargado'
);

-- Actualizar la especialización de un proveedor basado en su nombre
UPDATE Proveedor
SET Especializacion = 'Nueva tartas artesanales'
WHERE Nombre = 'Productos Congelados S.A.';

--  Queremmos actualizar la dirección de todos los empleados cuyo puesto sea "Jefe_Cocinero".
UPDATE Empleados
SET Direccion = '456 Elm Street'
WHERE idEmpleado IN (
  SELECT idEmpleado
  FROM Empleados
  WHERE Puesto = 'Jefe_Cocinero'
);

-- Eliminar un pedido de la tabla Pedido y todas sus referencias en la tabla Lista_pedidos utilizando el id del pedido:
DELETE FROM Pedido
WHERE idPedido IN (
  SELECT idPedido
  FROM Pedido
  WHERE Fecha_pedido < CURDATE() and Fecha_esperada = '2023-05-03'
);

-- Eliminar la fila donde el valor de la columna "Pedido_idPedido" sea igual a 5
DELETE FROM Lista_pedidos
WHERE Pedido_idPedido = 5;

-- Eliminar las filas de la tabla "Lista_pedidos" donde el valor de la columna "Pedido_idPedido" sea igual al resultado de una subconsulta
DELETE FROM Lista_pedidos
WHERE Pedido_idPedido = (
  SELECT idPedido
  FROM Pedido
  WHERE Fecha_pedido < CURDATE()
  LIMIT 1
);

-- Eliminar la fila donde el valor de la columna "idPedido" sea igual a 4
DELETE FROM Pedido
WHERE idPedido = 4;

-- Eliminar las filas de la tabla "Pedido" donde el valor de la columna "idPedido" esté presente en otra tabla
DELETE FROM Pedido
WHERE idPedido IN (
  SELECT Pedido_idPedido
  FROM Lista_pedidos
  WHERE Cantidad < 10
);




