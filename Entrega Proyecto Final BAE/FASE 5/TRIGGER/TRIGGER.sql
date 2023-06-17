
-- Usamos la base de datos Restaurante
USE restaurante;

DROP TRIGGER IF EXISTS ActualizarFechaModificacion;

-- Trigger que actualiza la fecha de modificación de un pedido al actualizarlo
DELIMITER //
CREATE TRIGGER ActualizarFechaModificacion AFTER UPDATE ON Pedido
FOR EACH ROW
BEGIN
  UPDATE Pedido SET FechaModificacion = NOW() WHERE idPedido = NEW.idPedido;
END //
DELIMITER ;

