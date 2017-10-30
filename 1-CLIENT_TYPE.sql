USE [ClientsTest]
GO

/****** Object:  Table [dbo].[CLIENT_TYPE]    Script Date: 27/10/2017 09:53:30 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CLIENT_TYPE](
	[TYPEID] [int] IDENTITY(1,1) NOT NULL,
	[Cl_Type] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_CLIENT_TYPE] PRIMARY KEY CLUSTERED 
(
	[TYPEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


