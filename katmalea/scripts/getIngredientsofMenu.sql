USE [ISPROJ1proposed]
GO

/****** Object:  StoredProcedure [dbo].[getIngredientsofMenu]    Script Date: 3/17/2015 6:17:56 PM ******/
DROP PROCEDURE [dbo].[getIngredientsofMenu]
GO

/****** Object:  StoredProcedure [dbo].[getIngredientsofMenu]    Script Date: 3/17/2015 6:17:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getIngredientsofMenu]
				@menuId int
AS
BEGIN
SELECT     TOP (100) PERCENT dbo.refIngredients.Name, dbo.Ingredients_of_menu.Quantity, dbo.Ingredients_of_menu.ID
FROM         dbo.refIngredients INNER JOIN
                      dbo.Ingredients_of_menu ON dbo.refIngredients.IngredientsID = dbo.Ingredients_of_menu.Ingredients_ID
WHERE     (dbo.Ingredients_of_menu.MenuID = @menuId)
ORDER BY dbo.Ingredients_of_menu.ID DESC
END

GO

