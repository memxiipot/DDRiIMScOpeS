USE [ISPROJ1proposed]
GO

/****** Object:  StoredProcedure [dbo].[getListofOrder]    Script Date: 3/17/2015 6:18:06 PM ******/
DROP PROCEDURE [dbo].[getListofOrder]
GO

/****** Object:  StoredProcedure [dbo].[getListofOrder]    Script Date: 3/17/2015 6:18:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getListofOrder]
	@orderID int
AS
BEGIN
SELECT     dbo.Menu.Menu_Name, dbo.Menu.Menu_Price, dbo.Order_Details.Quantity, dbo.Order_Details.Quantity * dbo.Menu.Menu_Price AS Total, 
                      dbo.Order_Details.Order_DetailsID, dbo.Order_Details.IsServed
FROM         dbo.Menu INNER JOIN
                      dbo.Order_Details ON dbo.Menu.MenuID = dbo.Order_Details.MenuID
WHERE     (dbo.Order_Details.OrderID = @orderID)
END

GO

