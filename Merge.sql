-------------------------------------------------------------
--MERGE INSERTA, ACTUALIZA, ELIMINA
-------------------------------------------------------------
	IF (@OPERACION = 0 OR @OPERACION = 1 OR @OPERACION = 2)
	BEGIN
		DECLARE @TEMP TABLE ( ID_PX BIGINT )
		MERGE Hist.TM_DATOS AS TARGET  
		USING (SELECT   @LID_ATENCION,
						@LID_DATO,
						@LID_ESTRUCTURA_PLANTILLA) AS SOURCE (ID_ATENCION,
															  ID_DATO,
															  ID_ESTRUCTURA_PLANTILLA)
		ON 
			(TARGET.ID_ATENCION = SOURCE.ID_ATENCION
				AND TARGET.ID_DATO = SOURCE.ID_DATO
				AND TARGET.ID_ESTRUCTURA_PLANTILLA = SOURCE.ID_ESTRUCTURA_PLANTILLA)
		--Cuando el registro existe en el destino y en el origen y la operacion=2 se eliminar.
		WHEN MATCHED AND @OPERACION=2 THEN 
		DELETE
		--Cuando los registros coinciden actualiza
		WHEN MATCHED AND @OPERACION<2 THEN
		UPDATE SET  TARGET.VALOR = @LVALOR,
					TARGET.USUARIO = @LUSUARIO,
					TARGET.IP_ORIGEN = @LIP_ORIGEN,
					TARGET.ULTIMA_MODIFICACION = GETDATE()
		--Cuando los registros no coinciden, Inserta lo q llega del origen.
		WHEN NOT MATCHED AND @OPERACION<2 THEN 
		INSERT (ID_ATENCION,
				ID_DATO,
				ID_ESTRUCTURA_PLANTILLA,
				VALOR,
				USUARIO,
				IP_ORIGEN,
				ULTIMA_MODIFICACION) 
		VALUES (SOURCE.ID_ATENCION,
				SOURCE.ID_DATO,
				SOURCE.ID_ESTRUCTURA_PLANTILLA,
				@LVALOR,
				@LUSUARIO,
				@LIP_ORIGEN,
				GETDATE())
		OUTPUT INSERTED.ID INTO @TEMP;
		SET @ID = (SELECT ID_PX AS Id FROM @TEMP)
	END
-------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

	MERGE CITY_PRICE_ZONE AS TARGET
		USING (SELECT   @CPZ_CITY_ID,
						@CPZ_PRICE_ZONE	) AS SOURCE (CPZ_CITY_ID, CPZ_PRICE_ZONE)
		ON 
		(TARGET.CPZ_CITY_ID = SOURCE.CPZ_CITY_ID)			
		--Cuando los registros coinciden actualiza
		WHEN MATCHED THEN
		UPDATE SET 
			TARGET.CPZ_PRICE_ZONE = @CPZ_PRICE_ZONE

		--Cuando los registros no coinciden, Inserta lo q llega del origen.
		WHEN NOT MATCHED THEN 
		INSERT (CPZ_CITY_ID,
				CPZ_PRICE_ZONE) 
		VALUES (SOURCE.CPZ_CITY_ID,
				SOURCE.CPZ_PRICE_ZONE);
