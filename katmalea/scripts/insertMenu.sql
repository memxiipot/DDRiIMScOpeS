USE [ISPROJ1proposed]
GO

/****** Object:  StoredProcedure [dbo].[insertMenu]    Script Date: 3/17/2015 6:18:48 PM ******/
DROP PROCEDURE [dbo].[insertMenu]
GO

/****** Object:  StoredProcedure [dbo].[insertMenu]    Script Date: 3/17/2015 6:18:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[insertMenu]
		@menuname varchar(50),@price decimal(18,2),@cat int
AS
BEGIN
	declare @category int 
		if (@cat=0) 
			begin
				set @category=null
			end
		else
			set @category=@cat

INSERT INTO [dbo].[Menu]
           (
           [Menu_Name]
           ,[Menu_Price],Menu_Category)
     VALUES
			(@menuname,@price,@category)



END

GO

