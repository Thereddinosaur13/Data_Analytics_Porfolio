
# Internet Sale Report from AdventureWorks databases 

## About project
- A company need to improve  their internet sales reports and want to move from static reports to visual dashboards.
- [Source Dataset](https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=ssms): The project use database backups (.bak) files that you can use to install the AdventureWorks (OLTP) and AdventureWorksDW (data warehouse) sample databases to your SQL Server instance.
## Business request
- Focus on how much the company have sold of what products, to which clients and how it has been over time.
- Each sales person may be responsible for different products and customers. Using criteria such as products and customers to search, organize, or categorize employees more easily helps with performance analysis and resource optimization.
- Compare and update the comparative figures between internet sale revenue and budget for the past three years (2022, 2023, 2024).
## Tools and techniques:

<img src="https://logonoid.com/images/sql-server-logo.png" width="200"> <img src="https://seeklogo.com/images/P/power-bi-microsoft-logo-E4FC8DE4A9-seeklogo.com.png" width="200">

## Implementation
### 1. Extract data and Transformation
⭐ Extracted data file:

- [Sales_Dim_Date.csv](https://github.com/Thereddinosaur13/Data_Analytics_Porfolio/blob/main/Sale/Sales_Dim_Date.csv) - HTML enhanced for web apps!
- [Sale_Dim_Customer.csv](https://github.com/Thereddinosaur13/Data_Analytics_Porfolio/blob/main/Sale/Sale_Dim_Customer.csv) - awesome web-based text editor
- [Sale_Dim_Product.csv](https://github.com/Thereddinosaur13/Data_Analytics_Porfolio/blob/main/Sale/Sale_Dim_Product.csv) - Markdown parser done right. Fast and easy to extend.
- [Sale_Dim_FactInternetSale.csv](https://github.com/Thereddinosaur13/Data_Analytics_Porfolio/blob/main/Sale/Sale_Dim_FactInternetSale.csv) - Fact table about internet sale revenue, [click](**[AdventureWorksDW2019].[dbo].[DimDate]**)
- [SalesBudget.xlsx](https://github.com/Thereddinosaur13/Data_Analytics_Porfolio/blob/main/Sale/SalesBudget.xlsx): sales budget in the years 2022, 2023, 2024 provided by the company

Extract information about datetime in dimension table **[AdventureWorksDW2019].[dbo].[DimDate]**:
 
```sh
SELECT [DateKey] ,
       [FullDateAlternateKey] AS Date ,
       [EnglishDayNameOfWeek] AS DAY ,
       [WeekNumberOfYear] AS WeekNum ,
       [EnglishMonthName] AS MONTH ,
       LEFT(EnglishMonthName, 3) AS MonthShort ,
       [MonthNumberOfYear] AS MonthNo ,
       [CalendarQuarter] AS QUARTER ,
       [CalendarYear] AS YEAR
FROM [AdventureWorksDW2019].[dbo].[DimDate]
```
Extract necessary information about customers from table **[AdventureWorksDW2019].[dbo].[DimCustomer]** and **[AdventureWorksDW2019].[dbo].[DimGeography]**
> Extracted info: *name, gender, where they live, purchase date*.
```sh
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
```
Extract necessary information about customers from table **[AdventureWorksDW2019].[dbo].[DimCustomer]** and **[AdventureWorksDW2019].[dbo].[DimGeography]**
> Extracted info: *name, gender, where they live, purchase date*.
```sh
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
```
Extract necessary information about company's products from table **[AdventureWorksDW2019].[dbo].[DimProduct]**, **[DimProductSubcategory]** and **[DimProductCategory]**
> Extracted info: *key, product code, product name, subcategory, category, color, status,...*.
```sh
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
```
From fact table [AdventureWorksDW2019].[dbo].[FactInternetSales], extract data about internet sale revenue for the past three years (2022, 2023, 2024).
> Extracted info: *product key, OrderDateKey, DueDateKey, ShipDateKey, CustomerKey, Sales amount,...*.
```
SELECT [ProductKey] ,
       [OrderDateKey] ,
       [DueDateKey] ,
       [ShipDateKey] ,
       [CustomerKey] ,
       [SalesAmount]
FROM [AdventureWorksDW2019].[dbo].[FactInternetSales]
WHERE LEFT(OrderDateKey, 4) >= (YEAR(GETDATE())-2)
ORDER BY [OrderDateKey] ASC
```
## Results and Findings

 
