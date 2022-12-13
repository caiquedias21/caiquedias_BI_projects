/** Script to create tables in the staging database **/
/*****************************************************/

/** Create CallCharges table **/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CallCharges]') AND type in (N'U'))
DROP TABLE [dbo].[CallCharges]
GO


CREATE TABLE [dbo].[CallCharges](
	[Call Type ] [nvarchar](255) NULL,
	[Call Charges (2018)] [nvarchar](255) NULL,
	[Call Charges (2019)] [nvarchar](255) NULL,
	[Call Charges (2020)] [nvarchar](255) NULL,
	[Call Charges (2021)] [nvarchar](255) NULL
) ON [PRIMARY]
GO


/** Create USStates table **/

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USStates]') AND type in (N'U'))
DROP TABLE [dbo].[USStates]
GO


CREATE TABLE [dbo].[USStates](
	[StateCD] [nvarchar](255) NULL,
	[Name] [nvarchar](255) NULL,
	[Region] [nvarchar](255) NULL
) ON [PRIMARY]
GO


/** Create Employees table **/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Employees]') AND type in (N'U'))
DROP TABLE [dbo].[Employees]
GO

CREATE TABLE [dbo].[Employees](
	[EmployeeID] [nvarchar](255) NULL,
	[EmployeeName] [nvarchar](255) NULL,
	[Site] [nvarchar](255) NULL,
	[ManagerName] [nvarchar](255) NULL
) ON [PRIMARY]
GO



/** Create CallTypes table **/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CallTypes]') AND type in (N'U'))
DROP TABLE [dbo].[CallTypes]
GO

CREATE TABLE [dbo].[CallTypes](
	[CallTypeID] [nvarchar](255) NULL,
	[CallTypeLabel] [nvarchar](255) NULL,
	[CallTypeLabelLKPKey] [nvarchar](255) NULL
) ON [PRIMARY]
GO


/** Create CallData table **/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CallData]') AND type in (N'U'))
DROP TABLE [dbo].[CallData]
GO

CREATE TABLE [dbo].[CallData](
	[CallTimestamp] [nvarchar](255) NULL,
	[Call Type] [nvarchar](255) NULL,
	[EmployeeID] [nvarchar](255) NULL,
	[CallDuration] [nvarchar](255) NULL,
	[WaitTime] [nvarchar](255) NULL,
	[CallAbandoned] [nvarchar](255) NULL
) ON [PRIMARY]
GO
