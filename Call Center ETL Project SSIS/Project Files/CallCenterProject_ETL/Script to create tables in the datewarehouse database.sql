/** Script to create tables in the datawarehouse database **/
/*****************************************************/

/** Create DimEmployees table **/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DimEmployees]') AND type in (N'U'))
DROP TABLE [dbo].[DimEmployees]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DimEmployees](
	[EmployeeKey] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [nvarchar](7) NULL,
	[EmployeeName] [nvarchar](20) NULL,
	[StateCD] [nvarchar](2) NULL,
	[StateName] [nvarchar](20) NULL,
	[CityName] [nvarchar](20) NULL,
	[Region] [nvarchar](20) NULL,
	[ManagerName] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



/** Create DimCallTypes table **/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DimCallTypes]') AND type in (N'U'))
DROP TABLE [dbo].[DimCallTypes]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DimCallTypes](
	[CallTypeKey] [int] IDENTITY(1,1) NOT NULL,   -- Technical Key
	[CallTypeID] [int] NULL,					  -- Source Key
	[CallTypeLabel] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[CallTypeKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


/** Create FactCallData table **/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FactCallData]') AND type in (N'U'))
DROP TABLE [dbo].[FactCallData]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[FactCallData](
	[CallDataKey] [int] IDENTITY(1,1) NOT NULL,
	[DateOfCall] [date] NULL,
	[DateKey] [int] NULL,
	[StartTimeOfCall] [time](0) NULL,
	[TimeKey] [int] NULL,
	[CallTypeKey] [int] NULL,
	[EmployeeKey] [int] NULL,
	[CallDuration(s)] [int] NULL,
	[WaitTime(s)] [int] NULL,
	[CallAbandoned] [bit] NULL,
	[CallChargesPerMin] [numeric](5, 2) NULL,
	[ServiceLevelAgreement] [nvarchar](11) NULL,
	[CallPrice] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[CallDataKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



/** Create and Populate DimDate table **/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DimDate]') AND type in (N'U'))
DROP TABLE [dbo].[DimDate]
GO

SET LANGUAGE English;

CREATE TABLE dbo.DimDate (
   DateKey INT NOT NULL PRIMARY KEY,
   [Date] DATE NOT NULL,
   [Day] TINYINT NOT NULL,
   [DaySuffix] CHAR(2) NOT NULL,
   [Weekday] TINYINT NOT NULL,
   [WeekDayName] VARCHAR(10) NOT NULL,
   [WeekDayName_Short] CHAR(3) NOT NULL,
   [WeekDayName_FirstLetter] CHAR(1) NOT NULL,
   [DOWInMonth] TINYINT NOT NULL,
   [DayOfYear] SMALLINT NOT NULL,
   [WeekOfMonth] TINYINT NOT NULL,
   [WeekOfYear] TINYINT NOT NULL,
   [Month] TINYINT NOT NULL,
   [MonthName] VARCHAR(10) NOT NULL,
   [MonthName_Short] CHAR(3) NOT NULL,
   [MonthName_FirstLetter] CHAR(1) NOT NULL,
   [Quarter] TINYINT NOT NULL,
   [QuarterName] VARCHAR(6) NOT NULL,
   [Year] INT NOT NULL,
   [MMYYYY] CHAR(6) NOT NULL,
   [MonthYear] CHAR(7) NOT NULL,
   IsWeekend BIT NOT NULL,
   )

  
   GO


   SET NOCOUNT ON

TRUNCATE TABLE DimDate

DECLARE @CurrentDate DATE = '2018-01-01'
DECLARE @EndDate DATE = '2021-12-31'

WHILE @CurrentDate < @EndDate
BEGIN
   INSERT INTO [dbo].[DimDate] (
      [DateKey],
      [Date],
      [Day],
      [DaySuffix],
      [Weekday],
      [WeekDayName],
      [WeekDayName_Short],
      [WeekDayName_FirstLetter],
      [DOWInMonth],
      [DayOfYear],
      [WeekOfMonth],
      [WeekOfYear],
      [Month],
      [MonthName],
      [MonthName_Short],
      [MonthName_FirstLetter],
      [Quarter],
      [QuarterName],
      [Year],
      [MMYYYY],
      [MonthYear],
      [IsWeekend]
      )
   SELECT DateKey = YEAR(@CurrentDate) * 10000 + MONTH(@CurrentDate) * 100 + DAY(@CurrentDate),
      DATE = @CurrentDate,
      Day = DAY(@CurrentDate),
      [DaySuffix] = CASE 
         WHEN DAY(@CurrentDate) = 1
            OR DAY(@CurrentDate) = 21
            OR DAY(@CurrentDate) = 31
            THEN 'st'
         WHEN DAY(@CurrentDate) = 2
            OR DAY(@CurrentDate) = 22
            THEN 'nd'
         WHEN DAY(@CurrentDate) = 3
            OR DAY(@CurrentDate) = 23
            THEN 'rd'
         ELSE 'th'
         END,
      WEEKDAY = DATEPART(dw, @CurrentDate),
      WeekDayName = DATENAME(dw, @CurrentDate),
      WeekDayName_Short = UPPER(LEFT(DATENAME(dw, @CurrentDate), 3)),
      WeekDayName_FirstLetter = LEFT(DATENAME(dw, @CurrentDate), 1),
      [DOWInMonth] = DAY(@CurrentDate),
      [DayOfYear] = DATENAME(dy, @CurrentDate),
      [WeekOfMonth] = DATEPART(WEEK, @CurrentDate) - DATEPART(WEEK, DATEADD(MM, DATEDIFF(MM, 0, @CurrentDate), 0)) + 1,
      [WeekOfYear] = DATEPART(wk, @CurrentDate),
      [Month] = MONTH(@CurrentDate),
      [MonthName] = DATENAME(mm, @CurrentDate),
      [MonthName_Short] = UPPER(LEFT(DATENAME(mm, @CurrentDate), 3)),
      [MonthName_FirstLetter] = LEFT(DATENAME(mm, @CurrentDate), 1),
      [Quarter] = DATEPART(q, @CurrentDate),
      [QuarterName] = CASE 
         WHEN DATENAME(qq, @CurrentDate) = 1
            THEN 'First'
         WHEN DATENAME(qq, @CurrentDate) = 2
            THEN 'second'
         WHEN DATENAME(qq, @CurrentDate) = 3
            THEN 'third'
         WHEN DATENAME(qq, @CurrentDate) = 4
            THEN 'fourth'
         END,
      [Year] = YEAR(@CurrentDate),
      [MMYYYY] = RIGHT('0' + CAST(MONTH(@CurrentDate) AS VARCHAR(2)), 2) + CAST(YEAR(@CurrentDate) AS VARCHAR(4)),
      [MonthYear] = CAST(YEAR(@CurrentDate) AS VARCHAR(4)) + UPPER(LEFT(DATENAME(mm, @CurrentDate), 3)),
      [IsWeekend] = CASE 
         WHEN DATENAME(dw, @CurrentDate) = 'Sunday'
            OR DATENAME(dw, @CurrentDate) = 'Saturday'
            THEN 1
         ELSE 0
         END

   SET @CurrentDate = DATEADD(DD, 1, @CurrentDate)
END



/** Create and Populate DimTime table **/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DimTime]') AND type in (N'U'))
DROP TABLE [dbo].[DimTime]
GO

CREATE TABLE [dbo].[DimTime] (
	[TimeKey] INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	[Time] Time NOT NULL,
    [Hour] SMALLINT NOT NULL,
	[Minute] SMALLINT NOT NULL,
    [PartOfDay] NVARCHAR(10) NOT NULL,
	[AMPM] NVARCHAR(2) NOT NULL,
	[BusinessHours] TINYINT NOT NULL
	)
GO


DECLARE @CurrentTime TIME; 
SET @CurrentTime = '0:00';

DECLARE @Inc INT;
SET @Inc = 0;


WHILE @Inc < 1440
BEGIN
	INSERT INTO [DimTime] (
		[Time],
		[Hour],
		[Minute],
		[PartOfDay],
		[AMPM],
		[BusinessHours]
	)
	SELECT
		[Time] = @CurrentTime,
		[Hour] = DATEPART(Hour,@CurrentTime),
		[Minute] = DATEPART(Minute,@CurrentTime),
		[PartOfDay] = CASE
			WHEN (DATEPART(Hour,@CurrentTime) >= 6 AND DATEPART(Hour,@CurrentTime) < 12) THEN 'Morning'
			WHEN (DATEPART(Hour,@CurrentTime) >=12 AND DATEPART(Hour,@CurrentTime) < 18) THEN 'Afternoon'
			WHEN (DATEPART(Hour,@CurrentTime) >=18 ) THEN 'Evening'
			ELSE 'Night' END,
		[AMPM] = CASE
			WHEN (DATEPART(Hour,@CurrentTime) < 12) THEN 'AM'
			ELSE 'PM' END,
		[BusinessHours] = CASE
			WHEN (DATEPART(Hour,@CurrentTime) >= 9 AND DATEPART(Hour,@CurrentTime) < 17 ) THEN 1
			ELSE 0 END

	SET @CurrentTime = DATEADD(minute, 1, @CurrentTime);
	SET @Inc = @Inc + 1;

END
GO
