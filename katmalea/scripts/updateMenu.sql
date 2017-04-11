USE [ISPROJ1proposed]
GO

/****** Object:  StoredProcedure [dbo].[updateMenu]    Script Date: 3/17/2015 6:20:03 PM ******/
DROP PROCEDURE [dbo].[updateMenu]
GO

/****** Object:  StoredProcedure [dbo].[updateMenu]    Script Date: 3/17/2015 6:20:03 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[updateMenu]
	@menuname varchar(50),@price decimal(18,2),@menuId int,@cat int
AS
BEGIN

	declare @category int 
		if (@cat=0) 
			begin
				set @category=null
			end
		else
			set @category=@cat
UPDATE [dbo].[Menu]
   SET 
      [Menu_Name] = @menuname
      ,[Menu_Price] =@price 
	  ,Menu_Category =@category
 WHERE MenuID=@menuId


 
END

GO

