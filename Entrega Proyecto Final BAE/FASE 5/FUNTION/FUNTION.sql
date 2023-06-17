
-- Usamos la base de datos Restaurante
USE restaurante;

DROP FUNCTION IF EXISTS ObtenerCantidadStock;

-- Creación de la función ObtenerCantidadStock
DELIMITER //

CREATE FUNCTION ObtenerCantidadStock(idAlmacen INT)
RETURNS INT deterministic
BEGIN
  DECLARE stock INT;
  
  SET stock = ( SELECT SUM(Cantidad_en_stock) 
  FROM Producto
  WHERE Zona_almacen_Almacen_idAlmacen = idAlmacen);
  
  IF stock IS NULL THEN
    SET stock = 0;
  END IF;
  
  RETURN stock;
END //

DELIMITER ;

SELECT ObtenerCantidadStock(1);