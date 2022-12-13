/** Script to create tables in the administration database **/
/*****************************************************/

/** Create Functional_Rejects table **/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Functional_Rejects]') AND type in (N'U'))
DROP TABLE [dbo].[Functional_Rejects]
GO


CREATE TABLE [dbo].[Functional_Rejects](
	[Error_Date] [datetime] NULL,
	[Error_Package] [nvarchar](255) NULL,
	[Error_TaskName] [nvarchar](255) NULL,
	[Error_Column] [nvarchar](25) NULL,
	[Error_Message] [nvarchar](50) NULL
) ON [PRIMARY]
GO


/** Create Technical_Rejects table **/

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Technical_Rejects]') AND type in (N'U'))
DROP TABLE [dbo].[Technical_Rejects]
GO


CREATE TABLE [dbo].[Technical_Rejects](
	[Error_Date] [datetime] NULL,
	[Error_Package] [nvarchar](255) NULL,
	[Error_TaskName] [nvarchar](255) NULL,
	[Error_Column] [nvarchar](30) NULL,
	[Error_Message] [nvarchar](400) NULL
) ON [PRIMARY]
GO


