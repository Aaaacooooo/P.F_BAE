DROP DATABASE restaurante;
CREATE DATABASE restaurante;

-- Usamos la base de datos Restaurante
USE restaurante;

-- Creación de la tabla Empleados
CREATE TABLE IF NOT EXISTS Empleados (
  idEmpleado INT NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(45) NOT NULL,
  Apellido1 VARCHAR(45) NOT NULL,
  Apellido2 VARCHAR(45),
  Direccion VARCHAR(45) NOT NULL,
  Puesto ENUM('Encargado', 'Jefe_Cocinero') NOT NULL,
  PRIMARY KEY (idEmpleado),
  CONSTRAINT check_Puesto
    CHECK (Puesto IN ('Encargado', 'Jefe_Cocinero')),
  CONSTRAINT check_Nombre_e
    CHECK (Nombre RLIKE '^[A-Z][a-zA-Z]')
);

-- Creación de la tabla Proveedor
CREATE TABLE IF NOT EXISTS Proveedor (
  idProveedor INT NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(45) NOT NULL,
  Direccion VARCHAR(45) NOT NULL,
  Especializacion VARCHAR(45) NOT NULL,
  PRIMARY KEY (idProveedor),
  CONSTRAINT check_Nombre_p
    CHECK (Nombre RLIKE '^[A-Z][a-zA-Z]')
);

-- Creación de la tabla Pedido
CREATE TABLE IF NOT EXISTS Pedido (
  idPedido INT NOT NULL AUTO_INCREMENT,
  Fecha_actual DATE DEFAULT (CURRENT_DATE()),
  Fecha_pedido DATE NOT NULL,
  Fecha_esperada DATE NOT NULL,
  Fecha_entrega DATE,
  Estado ENUM('Preparandose', 'En_camino', 'Entregado') NOT NULL,
  PRIMARY KEY (idPedido),
  CONSTRAINT check_Estado_p
    CHECK (Estado IN ('Preparandose', 'En_camino', 'Entregado')),
  CONSTRAINT check_Fecha_pedido_p
    CHECK (Fecha_pedido <= Fecha_actual),
  CONSTRAINT check_Fecha_esperada_p
    CHECK (Fecha_esperada >= Fecha_pedido),
  CONSTRAINT check_Fecha_entrega_p
    CHECK (Fecha_entrega IS NULL OR Fecha_entrega >= Fecha_pedido)
);

-- Creación de la tabla Almacen
CREATE TABLE IF NOT EXISTS Almacen (
  idAlmacen INT NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(45) NOT NULL,
  Ubicacion VARCHAR(45) NOT NULL,
  PRIMARY KEY (idAlmacen)
);

-- Creación de la tabla Producto
CREATE TABLE IF NOT EXISTS Producto (
  idProducto INT NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(45) NULL,
  Categoria VARCHAR(45) NULL,
  Fecha_actual DATE DEFAULT (CURRENT_DATE()),
  Fecha_vencimiento DATE NULL,
  Cantidad_en_stock INT NULL,
  Precio_venta FLOAT NULL,
  Proveedor_idProveedor INT NOT NULL,
  PRIMARY KEY (idProducto),
  CONSTRAINT fk_Producto_Proveedor1
    FOREIGN KEY (Proveedor_idProveedor)
    REFERENCES Proveedor (idProveedor),
  CONSTRAINT check_Nombre_producto
    CHECK (Nombre RLIKE '^[A-Z][a-zA-Z]'),
  CONSTRAINT check_Categoria_producto
    CHECK (Categoria RLIKE '^[A-Z][a-zA-Z]'),
  CONSTRAINT check_Fecha_pedido_producto
    CHECK (Fecha_vencimiento <= Fecha_actual),
  CONSTRAINT check_Cantidad_en_stock
    CHECK (Cantidad_en_stock >= 0),
  CONSTRAINT check_Precio_venta
    CHECK (Precio_venta >= 0 AND Precio_venta <= 100 AND Precio_venta LIKE '%%'),
  CONSTRAINT check_Proveedor_idProveedor
    CHECK (Proveedor_idProveedor >= 0)
);

-- Creación de la tabla Realiza_pedido
CREATE TABLE IF NOT EXISTS Realiza_pedido (
  Empleados_idEmpleados INT NOT NULL,
  Pedido_idPedido INT NOT NULL,
  PRIMARY KEY (Empleados_idEmpleados, Pedido_idPedido),
  CONSTRAINT fk_Realiza_pedido_Empleados1
    FOREIGN KEY (Empleados_idEmpleados)
    REFERENCES Empleados (idEmpleado),
  CONSTRAINT fk_Realiza_pedido_Pedido1
    FOREIGN KEY (Pedido_idPedido)
    REFERENCES Pedido (idPedido)
);

-- Creación de la tabla Zona_almacen
CREATE TABLE IF NOT EXISTS Zona_almacen (
  idZona_almacen INT NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(45) NULL,
  Capacidad INT NULL,
  Almacen_idAlmacen INT NOT NULL,
  Producto_idProducto INT NOT NULL,
  PRIMARY KEY (idZona_almacen, Almacen_idAlmacen),
  CONSTRAINT fk_Zona_almacen_Almacen1
    FOREIGN KEY (Almacen_idAlmacen)
    REFERENCES Almacen (idAlmacen),
  CONSTRAINT fk_Zona_almacen_Producto1
    FOREIGN KEY (Producto_idProducto)
    REFERENCES Producto (idProducto),
  CONSTRAINT check_Capacidad_z
    CHECK (Capacidad >= 0),
  CONSTRAINT check_Nombre_z
	CHECK (Nombre RLIKE '^[A-Z][a-zA-Z]')
);

-- Creación de la tabla Lista_pedidos
CREATE TABLE IF NOT EXISTS Lista_pedidos (
  idLista_pedidos INT NOT NULL AUTO_INCREMENT,
  Cantidad INT NULL,
  Precio_unitario FLOAT NULL,
  Producto_idProducto INT NOT NULL,
  Pedido_idPedido INT NOT NULL,
  PRIMARY KEY (idLista_pedidos),
  CONSTRAINT fk_Lista_pedidos_Producto1
    FOREIGN KEY (Producto_idProducto)
    REFERENCES Producto (idProducto),
  CONSTRAINT fk_Lista_pedidos_Pedido1
    FOREIGN KEY (Pedido_idPedido)
    REFERENCES Pedido (idPedido),
  CONSTRAINT check_Cantidad_l
    CHECK (Cantidad >= 0),
  CONSTRAINT check_Precio_unitario_l
    CHECK (Precio_unitario >= 0)
);

-- Creación de la tabla Telefono_Empleado
CREATE TABLE IF NOT EXISTS Telefono_Empleado (
  Empleados_idEmpleados INT NOT NULL,
  Telefono CHAR(9) NULL,
  IdTelefono_Empleado INT NOT NULL,
  PRIMARY KEY (Empleados_idEmpleados, IdTelefono_Empleado),
  CONSTRAINT fk_Telefono_Empleados1
    FOREIGN KEY (Empleados_idEmpleados)
    REFERENCES Empleados (idEmpleado),
  CONSTRAINT check_Telefono_e
    CHECK (Telefono RLIKE '^[69][0-9]{8}')
);

-- Creación de la tabla Telefono_Proveedor
CREATE TABLE IF NOT EXISTS Telefono_Proveedor (
  Telefono CHAR(9) NULL,
  Proveedor_idProveedor INT NOT NULL ,
  idTelefono_Proveedor INT NOT NULL,
  PRIMARY KEY (Proveedor_idProveedor, idTelefono_Proveedor),
  CONSTRAINT fk_Contacto_copy1_Proveedor1
    FOREIGN KEY (Proveedor_idProveedor)
    REFERENCES Proveedor (idProveedor),
  CONSTRAINT check_Telefono_p
    CHECK (Telefono RLIKE '^[69][0-9]{8}')
);

-- Creación de la tabla Email_Empleado
CREATE TABLE IF NOT EXISTS Email_Empleado (
  Empleados_idEmpleados INT NOT NULL,
  Email VARCHAR(45) NULL,
  idEmail_Empleado INT NOT NULL,
  PRIMARY KEY (Empleados_idEmpleados, idEmail_Empleado),
  CONSTRAINT fk_Telefono_Empleados10
    FOREIGN KEY (Empleados_idEmpleados)
    REFERENCES Empleados (idEmpleado),
  CONSTRAINT check_Email_e
    CHECK (Email LIKE '%@gmailcom')
);

-- Creación de la tabla Email_Proveedor
CREATE TABLE IF NOT EXISTS Email_Proveedor (
  Email VARCHAR(45) NULL,
  Proveedor_idProveedor INT NOT NULL,
  idEmail_Proveedor INT NOT NULL,
  PRIMARY KEY (Proveedor_idProveedor, idEmail_Proveedor),
  CONSTRAINT fk_Contacto_copy1_Proveedor10
    FOREIGN KEY (Proveedor_idProveedor)
    REFERENCES Proveedor (idProveedor),
  CONSTRAINT check_Email_Empleado
    CHECK (Email LIKE '%@gmailcom')
);
