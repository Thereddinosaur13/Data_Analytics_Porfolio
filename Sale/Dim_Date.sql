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