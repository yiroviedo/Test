USE ClientsTest
GO
IF OBJECT_ID ('dbo.GetClients', 'P' ) IS NOT NULL 
drop proc dbo.GetClients
GO
CREATE PROCEDURE dbo.GetClients @name nvarchar(50) = NULL, 
                                         @age1 int = NULL,
                                         @age2 int = NULL,
                                         @operator nvarchar(30) = NULL,
                                         @PageNumber int=NULL,
                                         @PageSize   int =NULL
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
      WITH ctepaging AS(
	SELECT ID, Name, Email,Age,
	Row_number() OVER(ORDER BY ID) AS rownum 
	FROM #Info 
	WHERE NAME LIKE '%' + ISNULL(@name ,NAME) + '%'	)
     SELECT ID, Name, Email,Age
     FROM   ctepaging 
     WHERE  rownum BETWEEN ( @PageNumber - 1 ) * @PageSize + 1 
     AND @PageNumber * @PageSize	
ELSE IF (@operator='less')
    WITH ctepaging AS(
	SELECT ID, Name, Email,Age,
	Row_number() OVER(ORDER BY ID) AS rownum 
	FROM #Info 	
	WHERE Age <@age1
	AND NAME LIKE '%' + ISNULL(@name ,NAME) + '%')
     SELECT ID, Name, Email,Age 
     FROM   ctepaging 
     WHERE  rownum BETWEEN ( @PageNumber - 1 ) * @PageSize + 1 
     AND @PageNumber * @PageSize	
ELSE IF (@operator='more')
    WITH ctepaging AS(
	SELECT ID, Name, Email,Age,
	Row_number() OVER(ORDER BY ID) AS rownum 
	FROM #Info 		
	WHERE Age >@age2
	AND NAME LIKE '%' + ISNULL(@name ,NAME) + '%')
     SELECT ID, Name, Email,Age 
     FROM   ctepaging 
     WHERE  rownum BETWEEN ( @PageNumber - 1 ) * @PageSize + 1 
     AND @PageNumber * @PageSize	
ELSE IF (@operator='betw')
    WITH ctepaging AS(
	SELECT ID, Name, Email,Age,
	Row_number() OVER(ORDER BY ID) AS rownum 
	FROM #Info 		
	WHERE Age between @age1 and @age2
	AND NAME LIKE '%' + ISNULL(@name ,NAME) + '%')
     SELECT ID, Name, Email,Age 
     FROM   ctepaging 
     WHERE  rownum BETWEEN ( @PageNumber - 1 ) * @PageSize + 1 
     AND @PageNumber * @PageSize	
	

DROP TABLE #Info
GO

