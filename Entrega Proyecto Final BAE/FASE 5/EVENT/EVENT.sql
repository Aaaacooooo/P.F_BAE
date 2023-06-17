-- Usamos la base de datos Restaurante
USE restaurante;

DROP EVENT IF EXISTS EnviarCorreoProveedores;

-- Creación del evento EnviarCorreoProveedores
DELIMITER //

CREATE EVENT EnviarCorreoProveedores
ON SCHEDULE EVERY 10 SECOND
STARTS CURRENT_DATE() + INTERVAL 8 HOUR
DO
BEGIN
  -- Declaración de variables
  DECLARE proveedor_email VARCHAR(45);
  DECLARE done BOOL DEFAULT FALSE;
  DECLARE asunto VARCHAR(100);
  DECLARE cuerpo VARCHAR(500);
  DECLARE cur CURSOR FOR SELECT Email_proveedor FROM Email_Proveedor;
  -- Para los errores
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;


  -- Abrir el cursor
  OPEN cur;

  -- Leer los correos electrónicos de los proveedores
  read_loop: LOOP
    FETCH cur INTO proveedor_email;

    IF done THEN
      LEAVE read_loop;
    END IF;

    SET asunto = 'Recordatorio de pedido';
    SET cuerpo = 'Estimado proveedor, le recordamos que tenemos pendiente un pedido. Por favor, contáctenos para confirmar la entrega.';

 END LOOP;

  -- Cerrar el cursor
  CLOSE cur;
END //

DELIMITER ;