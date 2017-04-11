USE [ISPROJ1proposed]
GO

/****** Object:  StoredProcedure [dbo].[insertcategory]    Script Date: 3/17/2015 6:18:24 PM ******/
DROP PROCEDURE [dbo].[insertcategory]
GO

/****** Object:  StoredProcedure [dbo].[insertcategory]    Script Date: 3/17/2015 6:18:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[insertcategory]
	@category varchar(50),@userId int
AS
BEGIN

INSERT INTO [dbo].[refCategory]
           ([CategoryName]
           ,[CreatedBy]
           ,[CreatedDate])
     VALUES
           (@category,@userId,CURRENT_TIMESTAMP)

END

GO

