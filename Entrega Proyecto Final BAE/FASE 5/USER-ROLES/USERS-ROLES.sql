
-- Usamos la base de datos Restaurante
USE restaurante;

-- Creación de usuarios
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';
CREATE USER 'encargado'@'localhost' IDENTIFIED BY 'encargado';
CREATE USER 'jefe_cocina'@'localhost' IDENTIFIED BY 'jefe_cocina';
CREATE USER 'proveedor'@'localhost' IDENTIFIED BY 'proveedor';

-- Asignación de roles a los usuarios
-- ADMIN --
GRANT ALL PRIVILEGES ON restaurante.* TO 'admin'@'localhost';
-- ENCARGADO --
GRANT SELECT, INSERT, UPDATE, DELETE ON restaurante.Empleados TO 'encargado'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON restaurante.Pedido TO 'encargado'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON restaurante.Lista_pedidos TO 'encargado'@'localhost';
-- JEFE COCINA --
GRANT SELECT, UPDATE ON restaurante.Empleados TO 'jefe_cocina'@'localhost';
GRANT SELECT, UPDATE ON restaurante.Pedido TO 'jefe_cocina'@'localhost';
-- PROVEEDOR --
GRANT SELECT, UPDATE ON restaurante.Proveedor TO 'proveedor'@'localhost';

