USE [ISPROJ1proposed]
GO

/****** Object:  StoredProcedure [dbo].[insertIngredToMenu]    Script Date: 3/17/2015 6:18:41 PM ******/
DROP PROCEDURE [dbo].[insertIngredToMenu]
GO

/****** Object:  StoredProcedure [dbo].[insertIngredToMenu]    Script Date: 3/17/2015 6:18:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[insertIngredToMenu]
	@ingredId int,@quantity decimal(18,2),@menuid int
AS
BEGIN

INSERT INTO [dbo].[Ingredients_of_menu]
           (
           [Ingredients_ID]
           ,[Quantity]
           ,[MenuID])
     VALUES
			(@ingredId,@quantity,@menuid)



END

GO

