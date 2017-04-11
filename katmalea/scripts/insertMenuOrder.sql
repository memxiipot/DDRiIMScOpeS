USE [ISPROJ1proposed]
GO

/****** Object:  StoredProcedure [dbo].[insertMenuOrder]    Script Date: 3/17/2015 6:18:59 PM ******/
DROP PROCEDURE [dbo].[insertMenuOrder]
GO

/****** Object:  StoredProcedure [dbo].[insertMenuOrder]    Script Date: 3/17/2015 6:18:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[insertMenuOrder]
			@orderid int,@menuId int ,@quantity int
AS
BEGIN
	declare @stat int
	begin try
		begin tran
INSERT INTO [dbo].[Order_Details]
           ([OrderID]
           ,[MenuID]
           ,[Quantity],[IsServed])
     VALUES
          (@orderid,@menuId,@quantity,0)
		  --this will check if additional order is made 
		  --this will check if status from completed then set to pending again
		  set @stat=(select Order_Status from Order_Form where Order_Id=@orderid)
		  if (@stat=2)
			begin
				update Order_Form set Order_Status=1 where Order_Id=@orderid;
			end
		  commit tran
		end try
	begin catch
			if @@ERROR<>0
				rollback tran
	end catch

END

GO

