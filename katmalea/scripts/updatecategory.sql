USE [ISPROJ1proposed]
GO

/****** Object:  StoredProcedure [dbo].[updatecategory]    Script Date: 3/17/2015 6:19:49 PM ******/
DROP PROCEDURE [dbo].[updatecategory]
GO

/****** Object:  StoredProcedure [dbo].[updatecategory]    Script Date: 3/17/2015 6:19:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[updatecategory]
	@catname varchar(50),@catid int
AS
BEGIN

UPDATE [dbo].[refCategory]
   SET [CategoryName] = @catname
      
      
 WHERE CategoryID=@catid


END

GO

