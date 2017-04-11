USE [ISPROJ1proposed]
GO

/****** Object:  StoredProcedure [dbo].[updateIngredient]    Script Date: 10/16/2015 3:09:00 PM ******/
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
		@name varchar(50),@stat int,@id int,@Limit int
AS
BEGIN


UPDATE [dbo].[refIngredients]
   SET [Name] =@name ,
[Ing_Status] =@stat
,Limit = @Limit
 WHERE IngredientsID=@id


END


GO

