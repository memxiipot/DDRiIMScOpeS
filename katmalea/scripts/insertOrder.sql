USE [ISPROJ1proposed]
GO

/****** Object:  StoredProcedure [dbo].[insertOrder]    Script Date: 3/17/2015 6:19:08 PM ******/
DROP PROCEDURE [dbo].[insertOrder]
GO

/****** Object:  StoredProcedure [dbo].[insertOrder]    Script Date: 3/17/2015 6:19:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[insertOrder]
		@tableno int,@crew int,@orderRequest varchar(50),@createdby int,@orderid int OUTPUT,@pendingno int
AS
BEGIN

INSERT INTO [dbo].[Order_Form]
           ([Order_TableNo]
		   ,Order_PendingNo
           ,[Order_CrewID]
           ,[Order_Request]
           ,[Order_Status]
           ,[Order_CreatedDate]
           ,[Order_CreatedBy])
     VALUES
           (@tableno,@pendingno,@crew,@orderRequest,1,CURRENT_TIMESTAMP,@createdby);

		   select @orderid=SCOPE_IDENTITY()

END

GO

