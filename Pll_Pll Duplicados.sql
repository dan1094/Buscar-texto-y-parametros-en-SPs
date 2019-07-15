
--borrar duplicados plantilla plantilla
DECLARE @PLL TABLE 
(
	ID INT,
	ID_PLANTILLA_PADRE INT NOT NULL,
	ID_PLANTILLA INT NOT NULL
)
	INSERT INTO @PLL	
	SELECT 
		TP_PLANTILLA_PLANTILLA.ID
		,TP_PLANTILLA_PLANTILLA.ID_PLANTILLA_PADRE
		,TP_PLANTILLA_PLANTILLA.ID_PLANTILLA
	FROM	
		Dinamico.TP_PLANTILLA_PLANTILLA
	INNER JOIN
	(
		SELECT
		 ID_PLANTILLA_PADRE
		 ,ID_PLANTILLA	
		 ,COUNT(ID_PLANTILLA_PADRE) as Cantidad
		FROM Dinamico.TP_PLANTILLA_PLANTILLA
		GROUP BY ID_PLANTILLA_PADRE,ID_PLANTILLA		
		HAVING COUNT(ID_PLANTILLA_PADRE)>1
	)DUPLICA
	ON
	TP_PLANTILLA_PLANTILLA.ID_PLANTILLA = DUPLICA.ID_PLANTILLA
	AND TP_PLANTILLA_PLANTILLA.ID_PLANTILLA_PADRE = DUPLICA.ID_PLANTILLA_PADRE		
	ORDER BY 2,3	
	


DECLARE @ID INT = NULL
DECLARE @FILA INT = NULL
DECLARE @CONTAR INT = 0
DECLARE @CANTIDAD INT = 1
DECLARE @ID_PLANTILLA INT= NULL
DECLARE @ID_PLANTILLA_PADRE INT = NULL

SELECT @FILA = COUNT(ID) FROM @PLL	
WHILE @FILA > 0
BEGIN		
	SELECT TOP(1) @ID = ID, @ID_PLANTILLA_PADRE = ID_PLANTILLA_PADRE,@ID_PLANTILLA = ID_PLANTILLA FROM @PLL					
	
	DELETE FROM Dinamico.TP_PLANTILLA_PLANTILLA
	WHERE TP_PLANTILLA_PLANTILLA.ID_PLANTILLA =@ID_PLANTILLA AND TP_PLANTILLA_PLANTILLA.ID_PLANTILLA_PADRE = @ID_PLANTILLA_PADRE
	AND TP_PLANTILLA_PLANTILLA.ID <> @ID	
	
	DELETE FROM @PLL WHERE ID_PLANTILLA_PADRE = @ID_PLANTILLA_PADRE AND ID_PLANTILLA = @ID_PLANTILLA
	
	SET @FILA =@FILA - @@ROWCOUNT
	
END
	

GO



--borrar duplicados especialidades
DECLARE @PLL TABLE 
(
	ID INT,
	ID_ESPECIALIDAD INT NOT NULL,
	ID_PLANTILLA INT NOT NULL
)
	INSERT INTO @PLL	
	SELECT 
		TP_PLANTILLAS_ESPECIALIDAD.ID
		,TP_PLANTILLAS_ESPECIALIDAD.ID_ESPECIALIDAD
		,TP_PLANTILLAS_ESPECIALIDAD.ID_PLANTILLA
	FROM	
		Dinamico.TP_PLANTILLAS_ESPECIALIDAD
	INNER JOIN
	(
		SELECT
		 ID_ESPECIALIDAD
		 ,ID_PLANTILLA	
		 ,COUNT(ID_ESPECIALIDAD) as Cantidad
		FROM Dinamico.TP_PLANTILLAS_ESPECIALIDAD
		GROUP BY ID_ESPECIALIDAD,ID_PLANTILLA		
		HAVING COUNT(ID_ESPECIALIDAD)>1
	)DUPLICA
	ON
	TP_PLANTILLAS_ESPECIALIDAD.ID_PLANTILLA = DUPLICA.ID_PLANTILLA
	AND TP_PLANTILLAS_ESPECIALIDAD.ID_ESPECIALIDAD = DUPLICA.ID_ESPECIALIDAD		
	ORDER BY 2,3		

DECLARE @ID INT = NULL
DECLARE @FILA INT = NULL
DECLARE @CONTAR INT = 0
DECLARE @CANTIDAD INT = 1
DECLARE @ID_PLANTILLA INT= NULL
DECLARE @ID_ESPECIALIDAD INT = NULL

SELECT @FILA = COUNT(ID) FROM @PLL	
WHILE @FILA > 0
BEGIN		
	SELECT TOP(1) @ID = ID, @ID_ESPECIALIDAD = ID_ESPECIALIDAD,@ID_PLANTILLA = ID_PLANTILLA FROM @PLL					
	
	DELETE FROM Dinamico.TP_PLANTILLAS_ESPECIALIDAD
	WHERE TP_PLANTILLAS_ESPECIALIDAD.ID_PLANTILLA =@ID_PLANTILLA AND TP_PLANTILLAS_ESPECIALIDAD.ID_ESPECIALIDAD = @ID_ESPECIALIDAD
	AND TP_PLANTILLAS_ESPECIALIDAD.ID <> @ID	
	
	DELETE FROM @PLL WHERE ID_ESPECIALIDAD = @ID_ESPECIALIDAD AND ID_PLANTILLA = @ID_PLANTILLA
	
	SET @FILA =@FILA - @@ROWCOUNT
	
END

GO

--borrar duplicados procedimientos
DECLARE @PLL TABLE 
(
	ID INT,
	ID_PROCEDIMIENTO INT NOT NULL,
	ID_PLANTILLA INT NOT NULL
)
	INSERT INTO @PLL	
	SELECT 
		TP_PLANTILLAS_PROCEDIMIENTO.ID
		,TP_PLANTILLAS_PROCEDIMIENTO.ID_PROCEDIMIENTO
		,TP_PLANTILLAS_PROCEDIMIENTO.ID_PLANTILLA
	FROM	
		Dinamico.TP_PLANTILLAS_PROCEDIMIENTO
	INNER JOIN
	(
		SELECT
		 ID_PROCEDIMIENTO
		 ,ID_PLANTILLA	
		 ,COUNT(ID_PROCEDIMIENTO) as Cantidad
		FROM Dinamico.TP_PLANTILLAS_PROCEDIMIENTO
		GROUP BY ID_PROCEDIMIENTO,ID_PLANTILLA		
		HAVING COUNT(ID_PROCEDIMIENTO)>1
	)DUPLICA
	ON
	TP_PLANTILLAS_PROCEDIMIENTO.ID_PLANTILLA = DUPLICA.ID_PLANTILLA
	AND TP_PLANTILLAS_PROCEDIMIENTO.ID_PROCEDIMIENTO = DUPLICA.ID_PROCEDIMIENTO		
	ORDER BY 2,3		

DECLARE @ID INT = NULL
DECLARE @FILA INT = NULL
DECLARE @CONTAR INT = 0
DECLARE @CANTIDAD INT = 1
DECLARE @ID_PLANTILLA INT= NULL
DECLARE @ID_PROCEDIMIENTO INT = NULL

SELECT @FILA = COUNT(ID) FROM @PLL	
WHILE @FILA > 0
BEGIN		
	SELECT TOP(1) @ID = ID, @ID_PROCEDIMIENTO = ID_PROCEDIMIENTO,@ID_PLANTILLA = ID_PLANTILLA FROM @PLL					
	
	DELETE FROM Dinamico.TP_PLANTILLAS_PROCEDIMIENTO
	WHERE TP_PLANTILLAS_PROCEDIMIENTO.ID_PLANTILLA =@ID_PLANTILLA AND TP_PLANTILLAS_PROCEDIMIENTO.ID_PROCEDIMIENTO = @ID_PROCEDIMIENTO
	AND TP_PLANTILLAS_PROCEDIMIENTO.ID <> @ID	
	
	DELETE FROM @PLL WHERE ID_PROCEDIMIENTO = @ID_PROCEDIMIENTO AND ID_PLANTILLA = @ID_PLANTILLA
	
	SET @FILA =@FILA - @@ROWCOUNT
	
END



	






