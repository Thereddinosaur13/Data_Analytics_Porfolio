SELECT c.CustomerKey AS CustomerKey,
       c.FirstName AS FirstName,
       c.LastName AS LastName,
       c.FirstName + ' ' + c.LastName AS [Full name],
       CASE
           WHEN c.Gender = 'M' THEN 'Male'
           ELSE 'Female'
       END,
       c.DateFirstPurchase AS DateFirstPurchase,
       g.City AS [Customer City]
FROM [AdventureWorksDW2019].[dbo].[DimCustomer] AS c
LEFT JOIN [AdventureWorksDW2019].[dbo].[DimGeography] AS g ON g.GeographyKey = c.GeographyKey
ORDER BY CustomerKey ASC