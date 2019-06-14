

/****** Object:  UserDefinedFunction [dbo].[Split]    Script Date: 7/24/2018 4:42:33 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*****************************************************************************************
 Uso            : Funcion para separa un string por un caracter especifico
 Entradas		:
		@ItemList = String de elementos
		@delimiter = caracter por el cual se debe separar el string	
 Salidas        : Tabla de valores
****************************************************************************************/
CREATE FUNCTION [dbo].[Split]
(
      @ItemList VARCHAR(max), 
      @delimiter CHAR(1)
)
RETURNS @IDTable TABLE (Item VARCHAR(50))  
AS      

BEGIN   
		--EJEMPLO Uso
			-- DECLARE @LLISTA_PRESTADORES TABLE (DATO INT NOT NULL)
			-- INSERT INTO @LLISTA_PRESTADORES
			-- SELECT Item FROM dbo.Split(@LCITAS, '|')
		

      DECLARE @tempItemList NVARCHAR(max)
      SET @tempItemList = @ItemList

      DECLARE @i INT    
      DECLARE @Item NVARCHAR(4000)

      SET @tempItemList = REPLACE (@tempItemList, ' ', '')
      IF RIGHT(@tempItemList, LEN(@tempItemList)) = @delimiter SET @tempItemList = LEFT(@tempItemList, LEN(@tempItemList) - 1)
      
      --Validar que el primer caracter no sea el delimitador
      IF LEFT(@tempItemList, 1) = @delimiter SET @tempItemList = RIGHT(@tempItemList, LEN(@tempItemList) - 1)     
      
      SET @i = CHARINDEX(@delimiter, @tempItemList)
      
      WHILE (LEN(@tempItemList) > 0)
      BEGIN
            IF @i = 0
                  SET @Item = @tempItemList
            ELSE
                  SET @Item = LEFT(@tempItemList, @i - 1)
                  
            IF ISNUMERIC(@Item) = 1
				BEGIN
            
					INSERT INTO @IDTable(Item) VALUES(@Item)
					
				END
			IF @i = 0
						  SET @tempItemList = ''
					ELSE
						  SET @tempItemList = RIGHT(@tempItemList, LEN(@tempItemList) - @i)
				
            SET @i = CHARINDEX(@delimiter, @tempItemList)
      END      
      
      RETURN
END
GO


