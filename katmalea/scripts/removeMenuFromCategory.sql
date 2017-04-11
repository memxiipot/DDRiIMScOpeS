USE [ISPROJ1proposed]
GO

/****** Object:  StoredProcedure [dbo].[removeMenuFromCategory]    Script Date: 3/17/2015 6:19:37 PM ******/
DROP PROCEDURE [dbo].[removeMenuFromCategory]
GO

/****** Object:  StoredProcedure [dbo].[removeMenuFromCategory]    Script Date: 3/17/2015 6:19:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[removeMenuFromCategory]
		@menuId int
AS
BEGIN


UPDATE [dbo].[Menu]
   SET [Menu_Category] =null

 WHERE MenuID=@menuId



END

GO

