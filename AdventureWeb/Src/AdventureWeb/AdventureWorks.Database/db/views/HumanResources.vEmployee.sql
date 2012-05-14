
DECLARE @Name VarChar(100),@Type VarChar(20), @Schema VarChar(20)
            SELECT @Name = 'vEmployee', @Type = 'VIEW', @Schema = 'HumanResources'

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(@Schema + '.' +  @Name))
BEGIN
  DECLARE @SQL varchar(1000)
  SET @SQL = 'CREATE ' + @Type + ' ' + @Schema + '.' + @Name + ' AS SELECT * FROM sys.objects'
  EXECUTE(@SQL)
END 
PRINT 'Updating ' + @Type + ' ' + @Schema + '.' + @Name
GO


ALTER VIEW [HumanResources].[vEmployee] 
AS 
SELECT 
    e.[BusinessEntityID]
    ,p.[Title]
    ,p.[FirstName]
    ,p.[MiddleName]
    ,p.[LastName]
    ,p.[Suffix]
    ,e.[JobTitle]  
    ,pp.[PhoneNumber]
    ,pnt.[Name] AS [PhoneNumberType]
    ,ea.[EmailAddress]
    ,p.[EmailPromotion]
    ,a.[AddressLine1]
    ,a.[AddressLine2]
    ,a.[City]
    ,sp.[Name] AS [StateProvinceName] 
    ,a.[PostalCode]
    ,cr.[Name] AS [CountryRegionName] 
    ,p.[AdditionalContactInfo]
FROM [HumanResources].[Employee] e
	INNER JOIN [Person].[Person] p
	ON p.[BusinessEntityID] = e.[BusinessEntityID]
    INNER JOIN [Person].[BusinessEntityAddress] bea 
    ON bea.[BusinessEntityID] = e.[BusinessEntityID] 
    INNER JOIN [Person].[Address] a 
    ON a.[AddressID] = bea.[AddressID]
    INNER JOIN [Person].[StateProvince] sp 
    ON sp.[StateProvinceID] = a.[StateProvinceID]
    INNER JOIN [Person].[CountryRegion] cr 
    ON cr.[CountryRegionCode] = sp.[CountryRegionCode]
    LEFT OUTER JOIN [Person].[PersonPhone] pp
    ON pp.BusinessEntityID = p.[BusinessEntityID]
    LEFT OUTER JOIN [Person].[PhoneNumberType] pnt
    ON pp.[PhoneNumberTypeID] = pnt.[PhoneNumberTypeID]
    LEFT OUTER JOIN [Person].[EmailAddress] ea
    ON p.[BusinessEntityID] = ea.[BusinessEntityID];

