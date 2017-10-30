USE ClientsTest
GO
IF OBJECT_ID ('dbo.GetTotal', 'P' ) IS NOT NULL 
drop proc dbo.GetTotal
GO
CREATE PROCEDURE dbo.GetTotal @name nvarchar(50) = NULL, @age1 int = NULL,@age2 int = NULL,@operator nvarchar(30) = NULL
AS

CREATE TABLE #Info 
   ( 
   ID int, 
   NAME nvarchar(50),
   EMAIL nvarchar(50),
   CTYPE nvarchar(50),    
   AGE int
   ) 
INSERT INTO #Info (ID,NAME,EMAIL,CTYPE,Age) 
SELECT c.ID,c.NAME,c.EMAIL, t.Cl_Type,DATEDIFF(YY,c.DATEOFBIRTH,GETDATE()) as Age
FROM CLIENTS c join CLIENT_TYPE t on
c.TYPEID=t.TYPEID


IF (@operator='all')
	SELECT COUNT (1) AS TOTAL
	FROM #Info 
	WHERE NAME LIKE '%' + ISNULL(@name ,NAME) + '%'
		
ELSE IF (@operator='less')
    SELECT COUNT (1) AS TOTAL
	FROM #Info 	
	WHERE Age <@age1
	AND NAME LIKE '%' + ISNULL(@name ,NAME) + '%'
ELSE IF (@operator='more')
    SELECT COUNT (1) AS TOTAL
	FROM #Info 	
	WHERE Age >@age2
	AND NAME LIKE '%' + ISNULL(@name ,NAME) + '%'
ELSE IF (@operator='betw')
    SELECT COUNT (1) AS TOTAL
	FROM #Info 	
	WHERE Age between @age1 and @age2
	AND NAME LIKE '%' + ISNULL(@name ,NAME) + '%'
	

DROP TABLE #Info
GO

