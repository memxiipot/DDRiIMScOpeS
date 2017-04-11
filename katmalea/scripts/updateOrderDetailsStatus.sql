USE [ISPROJ1proposed]
GO

/****** Object:  StoredProcedure [dbo].[updateOrderDetailsStatus]    Script Date: 3/17/2015 6:20:10 PM ******/
DROP PROCEDURE [dbo].[updateOrderDetailsStatus]
GO

/****** Object:  StoredProcedure [dbo].[updateOrderDetailsStatus]    Script Date: 3/17/2015 6:20:10 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[updateOrderDetailsStatus]
		@orderdetailsid int, @orderid int
AS
BEGIN
	begin try
			begin tran
	update Order_Details set IsServed=1 where Order_DetailsID=@orderdetailsid;
	if exists(SELECT IsServed FROM dbo.Order_Details WHERE        (OrderID = @orderid) AND (IsServed = 1))
		begin
			update Order_Form set Order_Status=2 where Order_Id=@orderid
		end
	commit tran
	end try
		begin catch
			if @@ERROR<>0
			rollback tran
		end catch
END

GO

