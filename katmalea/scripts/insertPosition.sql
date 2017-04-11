USE [ISPROJ1proposed]
GO

/****** Object:  StoredProcedure [dbo].[insertPosition]    Script Date: 3/17/2015 6:19:15 PM ******/
DROP PROCEDURE [dbo].[insertPosition]
GO

/****** Object:  StoredProcedure [dbo].[insertPosition]    Script Date: 3/17/2015 6:19:15 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[insertPosition]
		@position varchar(50),@IsActive bit,@createdby int
AS
BEGIN


INSERT INTO [dbo].[refPosition]
           ([PositionName]
           ,[IsActive]
           ,[CreatedDate]
           ,[CreatedBy])
     VALUES
           (@position,@IsActive,CURRENT_TIMESTAMP,@createdby)



END

GO

