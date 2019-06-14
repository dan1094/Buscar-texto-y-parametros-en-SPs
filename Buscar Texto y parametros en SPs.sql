
-------------------

--Buscar texto en SPs

SELECT 
	ROUTINE_NAME,
	ROUTINE_DEFINITION
FROM 
	INFORMATION_SCHEMA.ROUTINES
WHERE 
	ROUTINE_DEFINITION LIKE '%COMPANY_USER%'
	AND ROUTINE_TYPE ='PROCEDURE'
ORDER BY
	ROUTINE_NAME

--Buscar parametros en SPs
select distinct name from sys.all_parameters
where object_id in (
select object_id from sys.objects where name like 'spr%awb%' ) order by 1

--Buscar objetos en SPs
select NAME from sys.objects where name like 'spr%awb%'


	--ALTER DATABASE [Comply] SET TRUSTWORTHY ON;
	GO
