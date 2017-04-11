USE [ISPROJ1proposed]
GO

/****** Object:  StoredProcedure [dbo].[insertunit]    Script Date: 3/17/2015 6:19:22 PM ******/
DROP PROCEDURE [dbo].[insertunit]
GO

/****** Object:  StoredProcedure [dbo].[insertunit]    Script Date: 3/17/2015 6:19:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[insertunit]
		@unit varchar(50)	
AS
BEGIN

INSERT INTO [dbo].[Measurement]
        
          ( [Unit])
     VALUES
         
       ( @unit )



END

GO

