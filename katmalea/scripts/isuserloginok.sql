USE [ISPROJ1proposed]
GO

/****** Object:  StoredProcedure [dbo].[isuserloginok]    Script Date: 3/17/2015 6:19:31 PM ******/
DROP PROCEDURE [dbo].[isuserloginok]
GO

/****** Object:  StoredProcedure [dbo].[isuserloginok]    Script Date: 3/17/2015 6:19:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[isuserloginok]
	-- Add the parameters for the stored procedure here
	@username varchar(50),
	@password varchar(50)
AS
BEGIN
		select * from dbo.Users where UserName=@username and UserPassword=@password
END

GO

