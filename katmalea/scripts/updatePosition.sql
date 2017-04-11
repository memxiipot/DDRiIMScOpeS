USE [ISPROJ1proposed]
GO

/****** Object:  StoredProcedure [dbo].[updatePosition]    Script Date: 3/17/2015 6:20:17 PM ******/
DROP PROCEDURE [dbo].[updatePosition]
GO

/****** Object:  StoredProcedure [dbo].[updatePosition]    Script Date: 3/17/2015 6:20:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[updatePosition] 
	@position varchar(50),@stat bit, @posid int
AS
BEGIN


UPDATE [dbo].[refPosition]
   SET [PositionName] =@position
      ,[IsActive] = @stat
      
 WHERE PositionID=@posid



END

GO

