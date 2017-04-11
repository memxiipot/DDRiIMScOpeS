USE [ISPROJ1proposed]
GO

/****** Object:  View [dbo].[vwGetInventoryMonitory]    Script Date: 10/16/2015 3:08:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwGetInventoryMonitory]
AS
SELECT DISTINCT 
                         TOP (100) PERCENT i.Inv_IngredientsID, ri.Name + ' (' + ms.Unit + ')' AS Name, ri.Name AS Name2, CASE WHEN [dbo].[FcnGetQuantity](i.Inv_IngredientsID) IS NULL 
                         THEN 0 ELSE [dbo].[FcnGetQuantity](i.Inv_IngredientsID) END AS used,
                             (SELECT        SUM(Inv_Quantity) AS Expr1
                               FROM            dbo.Inventory AS i2
                               WHERE        (Inv_IngredientsID = i.Inv_IngredientsID)
                               GROUP BY Inv_IngredientsID) - CASE WHEN [dbo].[FcnGetQuantity](i.Inv_IngredientsID) IS NULL THEN 0 ELSE [dbo].[FcnGetQuantity](i.Inv_IngredientsID) 
                         END AS Available,
                             (SELECT        SUM(Inv_Quantity) AS Expr1
                               FROM            dbo.Inventory AS i2
                               WHERE        (Inv_IngredientsID = i.Inv_IngredientsID)
                               GROUP BY Inv_IngredientsID) AS Stock, CASE WHEN
                             ((SELECT        SUM(i2.Inv_Quantity)
                                 FROM            Inventory i2
                                 WHERE        i2.Inv_IngredientsID = i.Inv_IngredientsID
                                 GROUP BY i2.Inv_IngredientsID) - [dbo].[FcnGetQuantity](i.Inv_IngredientsID)) <= 0 THEN 'Out of Stock' ELSE CASE WHEN
                             ((SELECT        SUM(i2.Inv_Quantity)
                                 FROM            Inventory i2
                                 WHERE        i2.Inv_IngredientsID = i.Inv_IngredientsID
                                 GROUP BY i2.Inv_IngredientsID) - CASE WHEN [dbo].[FcnGetQuantity](i.Inv_IngredientsID) IS NULL THEN 0 ELSE [dbo].[FcnGetQuantity](i.Inv_IngredientsID) END) 
                         BETWEEN 1 AND ri.Limit THEN 'Critical' ELSE 'Good' END END AS Status, CASE WHEN
                             ((SELECT        SUM(i2.Inv_Quantity)
                                 FROM            Inventory i2
                                 WHERE        i2.Inv_IngredientsID = i.Inv_IngredientsID
                                 GROUP BY i2.Inv_IngredientsID) - [dbo].[FcnGetQuantity](i.Inv_IngredientsID)) <= 0 THEN 'Yellow' ELSE CASE WHEN
                             ((SELECT        SUM(i2.Inv_Quantity)
                                 FROM            Inventory i2
                                 WHERE        i2.Inv_IngredientsID = i.Inv_IngredientsID
                                 GROUP BY i2.Inv_IngredientsID) - CASE WHEN [dbo].[FcnGetQuantity](i.Inv_IngredientsID) IS NULL THEN 0 ELSE [dbo].[FcnGetQuantity](i.Inv_IngredientsID) END) 
                         BETWEEN 1 AND ri.Limit THEN 'Red' ELSE 'Green' END END AS Color, ri.Limit
FROM            dbo.Inventory AS i RIGHT OUTER JOIN
                         dbo.refIngredients AS ri ON i.Inv_IngredientsID = ri.IngredientsID LEFT OUTER JOIN
                         dbo.Ingredients_of_menu AS im INNER JOIN
                         dbo.Menu AS m ON im.MenuID = m.MenuID INNER JOIN
                         dbo.Order_Form AS o INNER JOIN
                         dbo.Order_Details AS od ON od.OrderID = o.Order_Id ON m.MenuID = od.MenuID ON i.Inv_IngredientsID = im.Ingredients_ID INNER JOIN
                         dbo.Measurement AS ms ON ms.MeasurementID = i.Inv_MeasurementID
GROUP BY im.Ingredients_ID, im.Quantity, ri.Name, i.Inv_Quantity, i.Inv_IngredientsID, ri.Limit, ms.Unit
ORDER BY Name

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "i"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 248
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ri"
            Begin Extent = 
               Top = 6
               Left = 286
               Bottom = 135
               Right = 472
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "im"
            Begin Extent = 
               Top = 6
               Left = 510
               Bottom = 135
               Right = 696
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "m"
            Begin Extent = 
               Top = 6
               Left = 734
               Bottom = 135
               Right = 923
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "o"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 267
               Right = 243
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "od"
            Begin Extent = 
               Top = 138
               Left = 281
               Bottom = 267
               Right = 467
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ms"
            Begin Extent = 
               Top = 138
               Left = 505
               Bottom = 233
               Right = 694
            End
            DisplayFlags = 280
            TopColumn = 0
         End' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwGetInventoryMonitory'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwGetInventoryMonitory'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwGetInventoryMonitory'
GO

