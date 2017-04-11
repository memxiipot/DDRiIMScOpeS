USE [ISPROJ1proposed]
GO

/****** Object:  StoredProcedure [dbo].[insertingredients]    Script Date: 3/17/2015 6:18:33 PM ******/
DROP PROCEDURE [dbo].[insertingredients]
GO

/****** Object:  StoredProcedure [dbo].[insertingredients]    Script Date: 3/17/2015 6:18:33 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[insertingredients]
	@ingredname varchar(50),@stat int
AS
BEGIN


INSERT INTO [dbo].[refIngredients]
           ([Name]
           ,[Ing_Status])
     VALUES
			(@ingredname,@stat)


END

GO

