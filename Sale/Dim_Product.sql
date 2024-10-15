SELECT p.ProductKey AS ProductKey ,
       p.ProductAlternateKey AS [Product Item Code] ,
       p.EnglishProductName AS [Product Name] ,
       ps.EnglishProductSubcategoryName AS [Product Subcategory] ,
       pc.EnglishProductCategoryName AS Category ,
       p.Color AS [Product Color] ,
       p.Size AS [Product Size] ,
       p.weight AS [Product Weight] ,
       p.ProductLine AS [Product Line] ,
       p.ModelName AS [Product Model Name] ,
       p.EnglishDescription AS [Product Discription] ,
       ISNULL(p.Status, 'Out of date') AS [Product Status]
FROM [AdventureWorksDW2019].[dbo].[DimProduct] AS p
LEFT JOIN [AdventureWorksDW2019].[dbo].[DimProductSubcategory] AS ps ON ps.ProductSubcategoryKey = p.ProductSubcategoryKey
LEFT JOIN [AdventureWorksDW2019].[dbo].[DimProductCategory] AS pc ON ps.ProductCategoryKey = pc.ProductCategoryKey
ORDER BY p.ProductKey ASC