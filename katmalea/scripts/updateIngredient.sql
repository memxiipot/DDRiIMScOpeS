USE [ISPROJ1proposed]
GO

/****** Object:  StoredProcedure [dbo].[updateIngredient]    Script Date: 3/17/2015 6:19:56 PM ******/
DROP PROCEDURE [dbo].[updateIngredient]
GO

/****** Object:  StoredProcedure [dbo].[updateIngredient]    Script Date: 3/17/2015 6:19:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[updateIngredient]
		@name varchar(50),@stat int,@id int
AS
BEGIN


UPDATE [dbo].[refIngredients]
   SET [Name] =@name ,
[Ing_Status] =@stat
 WHERE IngredientsID=@id


END

GO

