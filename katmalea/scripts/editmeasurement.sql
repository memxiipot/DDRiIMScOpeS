USE [ISPROJ1proposed]
GO

/****** Object:  StoredProcedure [dbo].[editmeasurement]    Script Date: 3/17/2015 6:17:35 PM ******/
DROP PROCEDURE [dbo].[editmeasurement]
GO

/****** Object:  StoredProcedure [dbo].[editmeasurement]    Script Date: 3/17/2015 6:17:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[editmeasurement]
		@unit varchar(50),@unitid int
AS
BEGIN


UPDATE [dbo].[Measurement]
   SET [Unit] = @unit
 WHERE MeasurementID=@unitid



END

GO

