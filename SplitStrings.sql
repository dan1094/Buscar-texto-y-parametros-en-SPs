

/****** Object:  UserDefinedFunction [dbo].[SplitStrings]    Script Date: 22/11/2023 1:35:13 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[SplitStrings]
(
    @List       nvarchar(max),
    @Delimiter  nvarchar(255)
)
RETURNS TABLE
AS
    RETURN (SELECT value = Item ,
      ordinal = ROW_NUMBER() OVER (ORDER BY Number) 
    FROM (SELECT Number, Item = SUBSTRING(@List, Number, 
      CHARINDEX(@Delimiter, @List + @Delimiter, Number) - Number)
     FROM (SELECT ROW_NUMBER() OVER (ORDER BY s1.[object_id])
      FROM sys.all_objects AS s1 CROSS JOIN sys.all_objects AS s2) AS n(Number)
      WHERE Number <= CONVERT(INT, LEN(@List))
      AND SUBSTRING(@Delimiter + @List, Number, LEN(@Delimiter)) = @Delimiter
    ) AS y);
GO

-- se usa cuando hay multiples valores en un solo campo
--  selec x, x,
--(select value from dbo.SplitStrings(ArrayValoresDatos, ',') where ordinal = 3) as Limit,
--x
--from tabla

