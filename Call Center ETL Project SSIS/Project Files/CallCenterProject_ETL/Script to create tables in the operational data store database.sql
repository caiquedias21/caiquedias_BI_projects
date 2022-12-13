/** Script to create tables in the operational data store database **/
/*****************************************************/

/** Create CallCharges table **/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CallCharges]') AND type in (N'U'))
DROP TABLE [dbo].[CallCharges]
GO


CREATE TABLE [dbo].[CallCharges](
	[CallTypeID] [int] NULL,
	[CallTypeLabel] [nvarchar](20) NULL,
	[Year] [int] NULL,
	[CallChargesPerMin] [numeric](5, 2) NULL
) ON [PRIMARY]
GO




/** Create Employees table **/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Employees]') AND type in (N'U'))
DROP TABLE [dbo].[Employees]
GO

CREATE TABLE [dbo].[Employees](
	[EmployeeID] [nvarchar](7) NULL,
	[EmployeeName] [nvarchar](20) NULL,
	[StateCD] [nvarchar](2) NULL,
	[StateName] [nvarchar](20) NULL,
	[CityName] [nvarchar](20) NULL,
	[Region] [nvarchar](20) NULL,
	[ManagerName] [nvarchar](20) NULL
) ON [PRIMARY]
GO


/** Create CallTypes table **/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CallTypes]') AND type in (N'U'))
DROP TABLE [dbo].[CallTypes]
GO

CREATE TABLE [dbo].[CallTypes](
	[CallTypeID] [int] NULL,
	[CallTypeLabel] [nvarchar](20) NULL
) ON [PRIMARY]
GO



/** Create CallData table **/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CallData]') AND type in (N'U'))
DROP TABLE [dbo].[CallData]
GO

CREATE TABLE [dbo].[CallData](
	[DateOfCall] [date] NULL,
	[StartTimeOfCall] [time](0) NULL,
	[CallTypeID] [int] NULL,
	[EmployeeID] [nvarchar](7) NULL,
	[CallDuration] [int] NULL,
	[WaitTime] [int] NULL,
	[CallAbandoned] [bit] NULL
) ON [PRIMARY]
GO