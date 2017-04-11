USE [ISPROJ1proposed]
GO

/****** Object:  StoredProcedure [dbo].[getordersubtotal]    Script Date: 3/17/2015 6:18:15 PM ******/
DROP PROCEDURE [dbo].[getordersubtotal]
GO

/****** Object:  StoredProcedure [dbo].[getordersubtotal]    Script Date: 3/17/2015 6:18:15 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getordersubtotal]
	@orderid int
AS
BEGIN
	declare @temp decimal(18,2)
	declare @subtotal decimal(18,2)
	set @subtotal=(select sum( dbo.Order_Details.Quantity * dbo.Menu.Menu_Price )as subtotal
		FROM            dbo.Menu INNER JOIN
								 dbo.Order_Details ON dbo.Menu.MenuID = dbo.Order_Details.MenuID
		WHERE        (dbo.Order_Details.OrderID = @orderid))

		set @temp=((@subtotal * 0.12) +@subtotal)
	
		select @subtotal as subtotal,@temp as withvat
END

GO

