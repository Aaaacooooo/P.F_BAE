
-- Usamos la base de datos Restaurante
USE restaurante;

 DROP PROCEDURE IF EXISTS MostrarEncargados;

DELIMITER //

CREATE PROCEDURE MostrarEncargados()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE empleado_nombre VARCHAR(45);
  DECLARE empleado_apellido1 VARCHAR(45);
  DECLARE empleado_apellido2 VARCHAR(45);

  -- Declaración del cursor
  DECLARE cur CURSOR FOR SELECT Nombre, Apellido1, Apellido2 FROM Empleados WHERE Puesto = 'Encargado';

  -- Handler para manejar errores
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur;

  read_loop: LOOP
    FETCH cur INTO empleado_nombre, empleado_apellido1, empleado_apellido2;

    IF done THEN
      LEAVE read_loop;
    END IF;

    -- Mostrar el nombre completo del empleado
    SELECT CONCAT(empleado_nombre, ' ', empleado_apellido1, ' ', empleado_apellido2) AS NombreCompleto;

  END LOOP;

  CLOSE cur;
END //

DELIMITER ;


CALL MostrarEncargados;
