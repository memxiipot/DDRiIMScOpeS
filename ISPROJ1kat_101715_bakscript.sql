USE [master]
GO
/****** Object:  Database [ISPROJ1kat]    Script Date: 10/18/2015 3:58:19 PM ******/
CREATE DATABASE [ISPROJ1kat]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ISPROJ1proposed', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\ISPROJ1kat.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ISPROJ1proposed_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\ISPROJ1kat_log.ldf' , SIZE = 20096KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ISPROJ1kat] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ISPROJ1kat].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ISPROJ1kat] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ISPROJ1kat] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ISPROJ1kat] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ISPROJ1kat] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ISPROJ1kat] SET ARITHABORT OFF 
GO
ALTER DATABASE [ISPROJ1kat] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ISPROJ1kat] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ISPROJ1kat] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ISPROJ1kat] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ISPROJ1kat] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ISPROJ1kat] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ISPROJ1kat] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ISPROJ1kat] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ISPROJ1kat] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ISPROJ1kat] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ISPROJ1kat] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ISPROJ1kat] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ISPROJ1kat] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ISPROJ1kat] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ISPROJ1kat] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ISPROJ1kat] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ISPROJ1kat] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ISPROJ1kat] SET RECOVERY FULL 
GO
ALTER DATABASE [ISPROJ1kat] SET  MULTI_USER 
GO
ALTER DATABASE [ISPROJ1kat] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ISPROJ1kat] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ISPROJ1kat] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ISPROJ1kat] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [ISPROJ1kat] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ISPROJ1kat', N'ON'
GO
USE [ISPROJ1kat]
GO
/****** Object:  User [katmalea]    Script Date: 10/18/2015 3:58:19 PM ******/
CREATE USER [katmalea] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [kaloy]    Script Date: 10/18/2015 3:58:19 PM ******/
CREATE USER [kaloy] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [carlo]    Script Date: 10/18/2015 3:58:19 PM ******/
CREATE USER [carlo] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  UserDefinedFunction [dbo].[FcnGetQuantity]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Carlo Masayda>
-- Create date: <March 13, 2014>
-- Description:	<Calculate Age base on Birthdate>
-- =============================================
CREATE FUNCTION [dbo].[FcnGetQuantity]
(
	-- Add the parameters for the function here
	@colname as decimal(18,2)
)
RETURNS decimal(18,2)
AS
BEGIN
	---- Declare the return variable here
	--DECLARE @col as decimal(18,2) 
	Declare @SF as varchar(max)
	select @SF = case when sum(Order_Details.Quantity * Ingredients_of_menu.Quantity) is null then 0 else sum(Order_Details.Quantity * Ingredients_of_menu.Quantity) end
from Order_Details inner join Menu on Menu.MenuID = Order_Details.MenuID 
inner join Ingredients_of_menu on Ingredients_of_menu.MenuID = Order_Details.MenuID 
inner join refIngredients on refIngredients.IngredientsID = Ingredients_of_menu.Ingredients_ID 
--inner join Order_Form on Order_Form.Order_Id = Order_Details.OrderID
where refIngredients.IngredientsID = @colname --and Order_CreatedDate = @Date
group by refIngredients.Name
	---- Add the T-SQL statements to compute the return value here
	--Select case when @col is null then 0 else @col end 

	---- Return the result of the function
	return  @SF 
--REPLACE((@colname) , YEAR(@colname) , Year(GETDATE())) > REPLACE((GETDATE()) , YEAR(GETDATE()) , Year(GETDATE())) 
--THEN DATEDIFF(yyyy , @colname , GETDATE()) - 1 
--ELSE DATEDIFF(yyyy , @colname , GETDATE()) END

END



GO
/****** Object:  UserDefinedFunction [dbo].[FcnGetQuantitywithOrderDate]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Carlo Masayda>
-- Create date: <March 13, 2014>
-- Description:	<Calculate Age base on Birthdate>
-- =============================================
CREATE FUNCTION [dbo].[FcnGetQuantitywithOrderDate]
(
	-- Add the parameters for the function here
	@colname as decimal(18,2),@DateFrom as datetime
	, @DateTo as datetime
)
RETURNS decimal(18,2)
AS
BEGIN
	---- Declare the return variable here
	--DECLARE @col as decimal(18,2) 
	Declare @SF as varchar(max)
	select @SF = case when sum(Order_Details.Quantity * Ingredients_of_menu.Quantity) is null then 0 else sum(Order_Details.Quantity * Ingredients_of_menu.Quantity) end
from Order_Details inner join Menu on Menu.MenuID = Order_Details.MenuID 
inner join Ingredients_of_menu on Ingredients_of_menu.MenuID = Order_Details.MenuID 
inner join refIngredients on refIngredients.IngredientsID = Ingredients_of_menu.Ingredients_ID 
inner join Order_Form on Order_Form.Order_Id = Order_Details.OrderID
where refIngredients.IngredientsID = @colname and Order_CreatedDate >= @DateFrom and Order_CreatedDate <= @DateTo
group by refIngredients.Name
	---- Add the T-SQL statements to compute the return value here
	--Select case when @col is null then 0 else @col end 

	---- Return the result of the function
	return  @SF 
--REPLACE((@colname) , YEAR(@colname) , Year(GETDATE())) > REPLACE((GETDATE()) , YEAR(GETDATE()) , Year(GETDATE())) 
--THEN DATEDIFF(yyyy , @colname , GETDATE()) - 1 
--ELSE DATEDIFF(yyyy , @colname , GETDATE()) END

END



GO
/****** Object:  Table [dbo].[AuditTrail]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AuditTrail](
	[HistoryID] [int] IDENTITY(1,1) NOT NULL,
	[HistoryAction] [varchar](50) NULL,
	[HistoryDescription] [varchar](100) NULL,
	[New_Value] [varchar](50) NULL,
	[Old_Value] [varchar](50) NULL,
	[ModuleType] [varchar](50) NULL,
	[UserID] [int] NULL,
	[HistoryDate] [datetime] NULL,
 CONSTRAINT [PK_AuditTrail] PRIMARY KEY CLUSTERED 
(
	[HistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ChartofAccounts]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ChartofAccounts](
	[AccountID] [int] IDENTITY(1,1) NOT NULL,
	[AccountName] [varchar](50) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_ChartofAccounts] PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Crew_List]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Crew_List](
	[CrewID] [int] IDENTITY(1,1) NOT NULL,
	[Crew_FullName] [varchar](50) NULL,
	[Crew_Position] [int] NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [date] NULL,
 CONSTRAINT [PK_Crew_List] PRIMARY KEY CLUSTERED 
(
	[CrewID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Equipment_Maintenance]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Equipment_Maintenance](
	[EquipmentMaintenanceID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](50) NULL,
	[DateofMaintenance] [datetime] NULL,
	[EquipmentID] [int] NULL,
	[MaintenanceInterval] [int] NULL,
	[Status] [int] NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_Equipment_Maintenance] PRIMARY KEY CLUSTERED 
(
	[EquipmentMaintenanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Equipments]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Equipments](
	[EquipmentID] [int] IDENTITY(1,1) NOT NULL,
	[EquipmentName] [varchar](50) NULL,
	[EquipmentStatus] [int] NULL,
	[Remarks] [varchar](100) NULL,
	[Addedby] [int] NULL,
	[AddedDate] [datetime] NULL,
 CONSTRAINT [PK_Equipments] PRIMARY KEY CLUSTERED 
(
	[EquipmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Expense]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Expense](
	[ExpenseID] [int] IDENTITY(1,1) NOT NULL,
	[Payee] [varchar](50) NULL,
	[Remarks] [varchar](100) NULL,
	[ModeofPayment] [int] NULL,
	[Total] [decimal](18, 2) NULL,
	[Createdby] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Expense] PRIMARY KEY CLUSTERED 
(
	[ExpenseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ExpenseDetails]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExpenseDetails](
	[ExpenseDetailsID] [int] IDENTITY(1,1) NOT NULL,
	[AccountID] [int] NULL,
	[Debit] [decimal](18, 2) NULL,
	[Credit] [decimal](18, 2) NULL,
	[ExpenseID] [int] NULL,
 CONSTRAINT [PK_ExpenseDetails] PRIMARY KEY CLUSTERED 
(
	[ExpenseDetailsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Ingredients_of_menu]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ingredients_of_menu](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Ingredients_ID] [int] NULL,
	[Quantity] [decimal](18, 2) NULL,
	[MenuID] [int] NULL,
 CONSTRAINT [PK_Ingredients_of_menu] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventory](
	[Inv_ItemID] [int] IDENTITY(1,1) NOT NULL,
	[Inv_IngredientsID] [int] NULL,
	[Inv_Quantity] [decimal](18, 2) NULL,
	[Inv_MeasurementID] [int] NULL,
	[Inv_DateAdded] [datetime] NULL,
	[Inv_AddedBy] [int] NULL,
	[Inv_Limit] [int] NULL,
 CONSTRAINT [PK_Inventory] PRIMARY KEY CLUSTERED 
(
	[Inv_ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Measurement]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Measurement](
	[MeasurementID] [int] IDENTITY(1,1) NOT NULL,
	[Unit] [varchar](50) NULL,
 CONSTRAINT [PK_Measurement] PRIMARY KEY CLUSTERED 
(
	[MeasurementID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Menu]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Menu](
	[MenuID] [int] IDENTITY(1,1) NOT NULL,
	[Menu_Category] [int] NULL,
	[Menu_Name] [varchar](50) NULL,
	[Menu_Price] [decimal](18, 2) NULL,
	[userid] [int] NULL,
 CONSTRAINT [PK_Menu] PRIMARY KEY CLUSTERED 
(
	[MenuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[module]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[module](
	[moduleid] [int] IDENTITY(1,1) NOT NULL,
	[modulename] [varchar](50) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_module] PRIMARY KEY CLUSTERED 
(
	[moduleid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[moduleByUserType]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[moduleByUserType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[moduleId] [int] NULL,
	[userType] [int] NULL,
 CONSTRAINT [PK_moduleByUserType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OR_Details]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OR_Details](
	[OR_DetailsID] [int] IDENTITY(1,1) NOT NULL,
	[ORID] [int] NULL,
	[MenuID] [int] NULL,
	[Quantity] [int] NULL,
	[Item_Cost] [decimal](18, 2) NULL,
 CONSTRAINT [PK_OR_Details] PRIMARY KEY CLUSTERED 
(
	[OR_DetailsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Order_Details]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order_Details](
	[Order_DetailsID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NULL,
	[MenuID] [int] NULL,
	[Quantity] [int] NULL,
	[IsServed] [bit] NULL,
 CONSTRAINT [PK_Order_Details] PRIMARY KEY CLUSTERED 
(
	[Order_DetailsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Order_Form]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Order_Form](
	[Order_Id] [int] IDENTITY(1,1) NOT NULL,
	[Order_TableNo] [int] NULL,
	[Order_PendingNo] [varchar](50) NULL,
	[Order_CrewID] [int] NULL,
	[Order_Request] [varchar](50) NULL,
	[Order_Status] [int] NULL,
	[Order_CreatedDate] [datetime] NULL,
	[Order_CreatedBy] [int] NULL,
	[Order_Type] [bit] NULL,
 CONSTRAINT [PK_Order_Form] PRIMARY KEY CLUSTERED 
(
	[Order_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Order_Receipt]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Order_Receipt](
	[ORID] [int] IDENTITY(1,1) NOT NULL,
	[ReceiptNo]  AS (right('0000'+CONVERT([varchar](5),[ORID]),(5))) PERSISTED,
	[OrderID] [int] NULL,
	[CompanyName] [varchar](50) NULL,
	[CashRendered] [decimal](18, 2) NULL,
	[Total_Cost] [decimal](18, 0) NULL,
	[Discount] [decimal](18, 2) NULL,
	[Service_Charge] [decimal](18, 2) NULL,
	[OrderReceiptStatus] [int] NULL,
	[Received_By] [varchar](50) NULL,
	[IssuedBy] [varchar](50) NULL,
	[IssuedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_Order_Receipt] PRIMARY KEY CLUSTERED 
(
	[ORID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[refCategory]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[refCategory](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [varchar](50) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_refCategory] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[refEqMaintenanceStatus]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[refEqMaintenanceStatus](
	[Main_StatusID] [int] NOT NULL,
	[Main_StatusName] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_refEqMaintenanceStatus] PRIMARY KEY CLUSTERED 
(
	[Main_StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[refIngredients]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[refIngredients](
	[IngredientsID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Ing_Status] [int] NULL,
	[Limit] [int] NULL,
 CONSTRAINT [PK_refIngredients] PRIMARY KEY CLUSTERED 
(
	[IngredientsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[refIngredientStatus]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[refIngredientStatus](
	[Ing_StatusID] [int] IDENTITY(1,1) NOT NULL,
	[Ing_StatusName] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_resIngredientStatus] PRIMARY KEY CLUSTERED 
(
	[Ing_StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[refInventoryStatus]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[refInventoryStatus](
	[Inv_StatusID] [int] NOT NULL,
	[Inv_StatusName] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_refInventoryStatus] PRIMARY KEY CLUSTERED 
(
	[Inv_StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[refMenuStatus]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[refMenuStatus](
	[MenuStatusID] [int] IDENTITY(1,1) NOT NULL,
	[MenuStatusName] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UserID] [int] NULL,
 CONSTRAINT [PK_refStatus] PRIMARY KEY CLUSTERED 
(
	[MenuStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[refOrderStatus]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[refOrderStatus](
	[OrderStatusID] [int] NOT NULL,
	[OrderSatusName] [varchar](50) NULL,
	[CteatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_refOrderStatus] PRIMARY KEY CLUSTERED 
(
	[OrderStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[refPosition]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[refPosition](
	[PositionID] [int] IDENTITY(1,1) NOT NULL,
	[PositionName] [varchar](50) NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_refPosition] PRIMARY KEY CLUSTERED 
(
	[PositionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[refReceiptStatus]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[refReceiptStatus](
	[ReceiptStatusID] [int] NOT NULL,
	[ReceiptStatusName] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_refReceiptStatus] PRIMARY KEY CLUSTERED 
(
	[ReceiptStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[refUserType]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[refUserType](
	[UserTypeID] [int] IDENTITY(1,1) NOT NULL,
	[UserTypeName] [varchar](50) NULL,
	[Modules] [varchar](50) NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_refUserType] PRIMARY KEY CLUSTERED 
(
	[UserTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Users]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](50) NULL,
	[UserPassword] [varchar](50) NULL,
	[FirstName] [varchar](50) NULL,
	[MiddleName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[UserTypeID] [int] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[vwGetExpenseForIncome]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwGetExpenseForIncome]
AS
SELECT        SUM(Total) AS TotalCostExpense, CONVERT(VARCHAR(10), CreatedDate, 101) AS Date, 0 AS TotalCostRev
FROM            dbo.Expense
GROUP BY CONVERT(VARCHAR(10), CreatedDate, 101)

GO
/****** Object:  View [dbo].[vwGetRevenueForIncome]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwGetRevenueForIncome]
AS
SELECT        0 AS TotalCostExpense, CONVERT(VARCHAR(10), IssuedDate, 101) AS Date, SUM(Total_Cost + Service_Charge - Discount) AS TotalCostRev
FROM            dbo.Order_Receipt
GROUP BY CONVERT(VARCHAR(10), IssuedDate, 101)

GO
/****** Object:  View [dbo].[vwgetRev]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwgetRev]
AS
SELECT        *
FROM            dbo.vwGetRevenueForIncome
UNION ALL
SELECT        *
FROM            dbo.vwGetExpenseForIncome

GO
/****** Object:  View [dbo].[vwgetrevenue]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwgetrevenue]
AS
SELECT        TOP (100) PERCENT Date, TotalCostExpense, TotalCostRev, TotalCostRev - TotalCostExpense AS Expr1
FROM            dbo.vwgetRev
ORDER BY Date

GO
/****** Object:  View [dbo].[vwgetRevenue1]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwgetRevenue1]
AS
SELECT        Date, SUM(Expr1) AS Revenue
FROM            dbo.vwgetrevenue
GROUP BY Date

GO
/****** Object:  View [dbo].[vwGetMenu]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwGetMenu]
AS
SELECT        dbo.refIngredients.Name, dbo.Ingredients_of_menu.Ingredients_ID, dbo.Ingredients_of_menu.MenuID
FROM            dbo.refIngredients INNER JOIN
                         dbo.Ingredients_of_menu ON dbo.refIngredients.IngredientsID = dbo.Ingredients_of_menu.Ingredients_ID

GO
/****** Object:  View [dbo].[vwIng]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwIng]
AS
SELECT        SUM(dbo.Order_Details.Quantity) AS TotalQty, CONVERT(VARCHAR(10), dbo.Order_Form.Order_CreatedDate, 101) AS TransactDate, dbo.vwGetMenu.Name
FROM            dbo.Order_Details INNER JOIN
                         dbo.Order_Form ON dbo.Order_Details.OrderID = dbo.Order_Form.Order_Id INNER JOIN
                         dbo.vwGetMenu ON dbo.Order_Details.MenuID = dbo.vwGetMenu.MenuID
GROUP BY CONVERT(VARCHAR(10), dbo.Order_Form.Order_CreatedDate, 101), dbo.vwGetMenu.Name

GO
/****** Object:  View [dbo].[vwGetExpense]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwGetExpense]
AS
SELECT        dbo.Expense.ExpenseID, dbo.Expense.Payee, dbo.Expense.Remarks, dbo.Expense.ModeofPayment, dbo.Expense.Total, dbo.Expense.CreatedDate, 
                         dbo.ExpenseDetails.Debit, dbo.ExpenseDetails.ExpenseID AS a, dbo.ExpenseDetails.Credit
FROM            dbo.Expense LEFT OUTER JOIN
                         dbo.ExpenseDetails ON dbo.Expense.ExpenseID = dbo.ExpenseDetails.ExpenseID
WHERE        (dbo.ExpenseDetails.AccountID = 1)


GO
/****** Object:  View [dbo].[vwGetExpenseForIncomeStatement]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwGetExpenseForIncomeStatement]
AS
SELECT        dbo.Expense.ExpenseID, dbo.Expense.Payee, dbo.Expense.Remarks, dbo.Expense.ModeofPayment, dbo.Expense.Total, dbo.Expense.CreatedDate, 
                         dbo.ExpenseDetails.ExpenseID AS a, SUM(dbo.ExpenseDetails.Credit) AS TotalCredit, SUM(dbo.ExpenseDetails.Debit) AS TotalDebit
FROM            dbo.Expense LEFT OUTER JOIN
                         dbo.ExpenseDetails ON dbo.Expense.ExpenseID = dbo.ExpenseDetails.ExpenseID
WHERE        (dbo.ExpenseDetails.AccountID = 1)
GROUP BY dbo.Expense.ExpenseID, dbo.Expense.Payee, dbo.Expense.Remarks, dbo.Expense.ModeofPayment, dbo.Expense.Total, dbo.Expense.CreatedDate, 
                         dbo.ExpenseDetails.ExpenseID



GO
/****** Object:  View [dbo].[vwGetFoodOrders]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwGetFoodOrders]
AS
SELECT        dbo.OR_Details.MenuID, SUM(dbo.OR_Details.Quantity) AS TotalQuantity, dbo.OR_Details.Item_Cost, dbo.Menu.Menu_Name
FROM            dbo.Menu INNER JOIN
                         dbo.OR_Details ON dbo.Menu.MenuID = dbo.OR_Details.MenuID
GROUP BY dbo.OR_Details.MenuID, dbo.OR_Details.Item_Cost, dbo.Menu.Menu_Name


GO
/****** Object:  View [dbo].[vwGetIncome]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwGetIncome]
AS
SELECT        '' AS Income

GO
/****** Object:  View [dbo].[vwGetInv]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwGetInv]
AS
SELECT        TOP (100) PERCENT dbo.Menu.Menu_Category, dbo.Menu.Menu_Name, SUM(dbo.Order_Details.Quantity) AS OrderDetailsQtySum, dbo.refIngredients.Name, 
                         dbo.Ingredients_of_menu.Quantity, dbo.Inventory.Inv_ItemPrice, SUM(dbo.Order_Details.Quantity) * dbo.Ingredients_of_menu.Quantity AS TotalQty
FROM            dbo.Menu INNER JOIN
                         dbo.Ingredients_of_menu ON dbo.Menu.MenuID = dbo.Ingredients_of_menu.MenuID INNER JOIN
                         dbo.refIngredients ON dbo.Ingredients_of_menu.Ingredients_ID = dbo.refIngredients.IngredientsID INNER JOIN
                         dbo.Inventory ON dbo.refIngredients.IngredientsID = dbo.Inventory.Inv_IngredientsID RIGHT OUTER JOIN
                         dbo.Order_Details ON dbo.Menu.MenuID = dbo.Order_Details.MenuID
GROUP BY dbo.Menu.Menu_Category, dbo.Menu.Menu_Name, dbo.refIngredients.Name, dbo.Ingredients_of_menu.Quantity, dbo.Inventory.Inv_ItemPrice
ORDER BY TotalQty DESC


GO
/****** Object:  View [dbo].[vwGetInventoryMonitory]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwGetInventoryMonitory]
AS
SELECT DISTINCT TOP (100) PERCENT i.Inv_IngredientsID, ri.Name + ' (' + ms.Unit + ')' AS Name, ri.Name AS Name2, CASE WHEN [dbo].[FcnGetQuantity](i.Inv_IngredientsID) IS NULL THEN 0 ELSE [dbo].[FcnGetQuantity](i.Inv_IngredientsID) END AS used,
             (SELECT SUM(Inv_Quantity) AS Expr1
           FROM    dbo.Inventory AS i2
           WHERE  (Inv_IngredientsID = i.Inv_IngredientsID)
           GROUP BY Inv_IngredientsID) - CASE WHEN [dbo].[FcnGetQuantity](i.Inv_IngredientsID) IS NULL THEN 0 ELSE [dbo].[FcnGetQuantity](i.Inv_IngredientsID) END AS Available,
             (SELECT SUM(Inv_Quantity) AS Expr1
           FROM    dbo.Inventory AS i2
           WHERE  (Inv_IngredientsID = i.Inv_IngredientsID)
           GROUP BY Inv_IngredientsID) AS Stock, CASE WHEN
             ((SELECT SUM(i2.Inv_Quantity)
            FROM   Inventory i2
            WHERE  i2.Inv_IngredientsID = i.Inv_IngredientsID
            GROUP BY i2.Inv_IngredientsID) - [dbo].[FcnGetQuantity](i.Inv_IngredientsID)) <= 0 THEN 'Out of Stock' ELSE CASE WHEN
             ((SELECT SUM(i2.Inv_Quantity)
            FROM   Inventory i2
            WHERE  i2.Inv_IngredientsID = i.Inv_IngredientsID
            GROUP BY i2.Inv_IngredientsID) - CASE WHEN [dbo].[FcnGetQuantity](i.Inv_IngredientsID) IS NULL THEN 0 ELSE [dbo].[FcnGetQuantity](i.Inv_IngredientsID) END) BETWEEN 1 AND ri.Limit THEN 'Critical' ELSE 'Good' END END AS Status, CASE WHEN
             ((SELECT SUM(i2.Inv_Quantity)
            FROM   Inventory i2
            WHERE  i2.Inv_IngredientsID = i.Inv_IngredientsID
            GROUP BY i2.Inv_IngredientsID) - [dbo].[FcnGetQuantity](i.Inv_IngredientsID)) <= 0 THEN 'ORANGE' ELSE CASE WHEN
             ((SELECT SUM(i2.Inv_Quantity)
            FROM   Inventory i2
            WHERE  i2.Inv_IngredientsID = i.Inv_IngredientsID
            GROUP BY i2.Inv_IngredientsID) - CASE WHEN [dbo].[FcnGetQuantity](i.Inv_IngredientsID) IS NULL THEN 0 ELSE [dbo].[FcnGetQuantity](i.Inv_IngredientsID) END) BETWEEN 1 AND ri.Limit THEN 'Red' ELSE 'Green' END END AS Color, ri.Limit
FROM   dbo.Inventory AS i RIGHT OUTER JOIN
         dbo.refIngredients AS ri ON i.Inv_IngredientsID = ri.IngredientsID LEFT OUTER JOIN
         dbo.Ingredients_of_menu AS im INNER JOIN
         dbo.Menu AS m ON im.MenuID = m.MenuID INNER JOIN
         dbo.Order_Form AS o INNER JOIN
         dbo.Order_Details AS od ON od.OrderID = o.Order_Id ON m.MenuID = od.MenuID ON i.Inv_IngredientsID = im.Ingredients_ID INNER JOIN
         dbo.Measurement AS ms ON ms.MeasurementID = i.Inv_MeasurementID
GROUP BY im.Ingredients_ID, im.Quantity, ri.Name, i.Inv_Quantity, i.Inv_IngredientsID, ri.Limit, ms.Unit
ORDER BY Name

GO
/****** Object:  View [dbo].[vwgetInventoryStock]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwgetInventoryStock]
AS
SELECT DISTINCT i.Inv_IngredientsID, ri.Name, ms.Unit, CASE WHEN SUM(im.Quantity) IS NULL THEN 0 ELSE SUM(im.Quantity) END AS used,
                             (SELECT        SUM(Inv_Quantity) AS Expr1
                               FROM            dbo.Inventory AS i2
                               WHERE        (Inv_IngredientsID = i.Inv_IngredientsID)
                               GROUP BY Inv_IngredientsID) - CASE WHEN SUM(im.Quantity) IS NULL THEN 0 ELSE SUM(im.Quantity) END AS Available,
                             (SELECT        SUM(Inv_Quantity) AS Expr1
                               FROM            dbo.Inventory AS i2
                               WHERE        (Inv_IngredientsID = i.Inv_IngredientsID)
                               GROUP BY Inv_IngredientsID) AS Stock, CASE WHEN
                             ((SELECT        SUM(i2.Inv_Quantity)
                                 FROM            Inventory i2
                                 WHERE        i2.Inv_IngredientsID = i.Inv_IngredientsID
                                 GROUP BY i2.Inv_IngredientsID) - SUM(im.Quantity)) = 0 THEN 'Out of Stock' ELSE CASE WHEN
                             ((SELECT        SUM(i2.Inv_Quantity)
                                 FROM            Inventory i2
                                 WHERE        i2.Inv_IngredientsID = i.Inv_IngredientsID
                                 GROUP BY i2.Inv_IngredientsID) - CASE WHEN SUM(im.Quantity) IS NULL THEN 0 ELSE SUM(im.Quantity) END) 
                         <= ri.Limit THEN 'Critical' ELSE 'Good' END END AS Status, CASE WHEN
                             ((SELECT        SUM(i2.Inv_Quantity)
                                 FROM            Inventory i2
                                 WHERE        i2.Inv_IngredientsID = i.Inv_IngredientsID
                                 GROUP BY i2.Inv_IngredientsID) - SUM(im.Quantity)) <= 0 THEN 'Red' ELSE CASE WHEN
                             ((SELECT        SUM(i2.Inv_Quantity)
                                 FROM            Inventory i2
                                 WHERE        i2.Inv_IngredientsID = i.Inv_IngredientsID
                                 GROUP BY i2.Inv_IngredientsID) - CASE WHEN SUM(im.Quantity) IS NULL THEN 0 ELSE SUM(im.Quantity) END) 
                         <= ri.Limit THEN 'Red' ELSE 'Green' END END AS Color, ri.Limit, m.MenuID
FROM            dbo.Inventory AS i RIGHT OUTER JOIN
                         dbo.refIngredients AS ri ON i.Inv_IngredientsID = ri.IngredientsID LEFT OUTER JOIN
                         dbo.Ingredients_of_menu AS im INNER JOIN
                         dbo.Menu AS m ON im.MenuID = m.MenuID INNER JOIN
                         dbo.Order_Form AS o INNER JOIN
                         dbo.Order_Details AS od ON od.OrderID = o.Order_Id ON m.MenuID = od.MenuID ON i.Inv_IngredientsID = im.Ingredients_ID INNER JOIN
                         dbo.Measurement AS ms ON ms.MeasurementID = i.Inv_MeasurementID
GROUP BY im.Ingredients_ID, im.Quantity, ri.Name, i.Inv_Quantity, i.Inv_IngredientsID, ri.Limit, ms.Unit, m.MenuID

GO
/****** Object:  View [dbo].[vwGetMaintenance]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwGetMaintenance]
AS
SELECT        dbo.Equipments.EquipmentName, dbo.refEqMaintenanceStatus.Main_StatusName, dbo.Equipment_Maintenance.MaintenanceInterval, CONVERT(VARCHAR(10), 
                         dbo.Equipment_Maintenance.DateofMaintenance, 101) AS DateMaintenance
FROM            dbo.Equipment_Maintenance INNER JOIN
                         dbo.Equipments ON dbo.Equipment_Maintenance.EquipmentID = dbo.Equipments.EquipmentID INNER JOIN
                         dbo.refEqMaintenanceStatus ON dbo.Equipment_Maintenance.Status = dbo.refEqMaintenanceStatus.Main_StatusID

GO
/****** Object:  View [dbo].[vwGetReceipt]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwGetReceipt]
AS
SELECT        dbo.Order_Receipt.ReceiptNo, dbo.Order_Receipt.OrderID, dbo.Order_Receipt.CompanyName, dbo.Order_Receipt.CashRendered, dbo.Order_Receipt.Total_Cost, 
                         dbo.Order_Receipt.Discount, dbo.Order_Receipt.Service_Charge, dbo.Order_Receipt.OrderReceiptStatus, dbo.Order_Receipt.Received_By, 
                         dbo.Order_Receipt.IssuedBy, dbo.Order_Receipt.IssuedDate, dbo.Order_Receipt.CreatedBy, dbo.OR_Details.MenuID, dbo.OR_Details.Quantity, 
                         dbo.OR_Details.Item_Cost, dbo.Menu.Menu_Name, dbo.Menu.Menu_Price
FROM            dbo.Menu RIGHT OUTER JOIN
                         dbo.OR_Details ON dbo.Menu.MenuID = dbo.OR_Details.MenuID RIGHT OUTER JOIN
                         dbo.Order_Receipt ON dbo.OR_Details.ORID = dbo.Order_Receipt.ORID


GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Users]    Script Date: 10/18/2015 3:58:19 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Users] ON [dbo].[Users]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ChartofAccounts]  WITH CHECK ADD  CONSTRAINT [FK_ChartofAccounts_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[ChartofAccounts] CHECK CONSTRAINT [FK_ChartofAccounts_Users]
GO
ALTER TABLE [dbo].[Crew_List]  WITH CHECK ADD  CONSTRAINT [FK_Crew_List_refPosition] FOREIGN KEY([Crew_Position])
REFERENCES [dbo].[refPosition] ([PositionID])
GO
ALTER TABLE [dbo].[Crew_List] CHECK CONSTRAINT [FK_Crew_List_refPosition]
GO
ALTER TABLE [dbo].[Equipment_Maintenance]  WITH CHECK ADD  CONSTRAINT [FK_Equipment_Maintenance_Equipments] FOREIGN KEY([EquipmentID])
REFERENCES [dbo].[Equipments] ([EquipmentID])
GO
ALTER TABLE [dbo].[Equipment_Maintenance] CHECK CONSTRAINT [FK_Equipment_Maintenance_Equipments]
GO
ALTER TABLE [dbo].[Equipment_Maintenance]  WITH CHECK ADD  CONSTRAINT [FK_Equipment_Maintenance_refEqMaintenanceStatus] FOREIGN KEY([Status])
REFERENCES [dbo].[refEqMaintenanceStatus] ([Main_StatusID])
GO
ALTER TABLE [dbo].[Equipment_Maintenance] CHECK CONSTRAINT [FK_Equipment_Maintenance_refEqMaintenanceStatus]
GO
ALTER TABLE [dbo].[Equipment_Maintenance]  WITH CHECK ADD  CONSTRAINT [FK_Equipment_Maintenance_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Equipment_Maintenance] CHECK CONSTRAINT [FK_Equipment_Maintenance_Users]
GO
ALTER TABLE [dbo].[Equipments]  WITH CHECK ADD  CONSTRAINT [FK_Equipments_Users] FOREIGN KEY([Addedby])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Equipments] CHECK CONSTRAINT [FK_Equipments_Users]
GO
ALTER TABLE [dbo].[Expense]  WITH CHECK ADD  CONSTRAINT [FK_Expense_Users] FOREIGN KEY([Createdby])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Expense] CHECK CONSTRAINT [FK_Expense_Users]
GO
ALTER TABLE [dbo].[ExpenseDetails]  WITH CHECK ADD  CONSTRAINT [FK_ExpenseDetails_ChartofAccounts] FOREIGN KEY([AccountID])
REFERENCES [dbo].[ChartofAccounts] ([AccountID])
GO
ALTER TABLE [dbo].[ExpenseDetails] CHECK CONSTRAINT [FK_ExpenseDetails_ChartofAccounts]
GO
ALTER TABLE [dbo].[ExpenseDetails]  WITH CHECK ADD  CONSTRAINT [FK_ExpenseDetails_Expense] FOREIGN KEY([ExpenseID])
REFERENCES [dbo].[Expense] ([ExpenseID])
GO
ALTER TABLE [dbo].[ExpenseDetails] CHECK CONSTRAINT [FK_ExpenseDetails_Expense]
GO
ALTER TABLE [dbo].[Ingredients_of_menu]  WITH CHECK ADD  CONSTRAINT [FK_Ingredients_of_menu_Menu] FOREIGN KEY([MenuID])
REFERENCES [dbo].[Menu] ([MenuID])
GO
ALTER TABLE [dbo].[Ingredients_of_menu] CHECK CONSTRAINT [FK_Ingredients_of_menu_Menu]
GO
ALTER TABLE [dbo].[Ingredients_of_menu]  WITH CHECK ADD  CONSTRAINT [FK_Ingredients_of_menu_refIngredients] FOREIGN KEY([Ingredients_ID])
REFERENCES [dbo].[refIngredients] ([IngredientsID])
GO
ALTER TABLE [dbo].[Ingredients_of_menu] CHECK CONSTRAINT [FK_Ingredients_of_menu_refIngredients]
GO
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD  CONSTRAINT [FK_Inventory_Measurement] FOREIGN KEY([Inv_MeasurementID])
REFERENCES [dbo].[Measurement] ([MeasurementID])
GO
ALTER TABLE [dbo].[Inventory] CHECK CONSTRAINT [FK_Inventory_Measurement]
GO
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD  CONSTRAINT [FK_Inventory_refIngredients] FOREIGN KEY([Inv_IngredientsID])
REFERENCES [dbo].[refIngredients] ([IngredientsID])
GO
ALTER TABLE [dbo].[Inventory] CHECK CONSTRAINT [FK_Inventory_refIngredients]
GO
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD  CONSTRAINT [FK_Inventory_Users] FOREIGN KEY([Inv_AddedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Inventory] CHECK CONSTRAINT [FK_Inventory_Users]
GO
ALTER TABLE [dbo].[Menu]  WITH CHECK ADD  CONSTRAINT [FK_Menu_refCategory] FOREIGN KEY([Menu_Category])
REFERENCES [dbo].[refCategory] ([CategoryID])
GO
ALTER TABLE [dbo].[Menu] CHECK CONSTRAINT [FK_Menu_refCategory]
GO
ALTER TABLE [dbo].[Order_Details]  WITH CHECK ADD  CONSTRAINT [FK_Order_Details_Menu] FOREIGN KEY([MenuID])
REFERENCES [dbo].[Menu] ([MenuID])
GO
ALTER TABLE [dbo].[Order_Details] CHECK CONSTRAINT [FK_Order_Details_Menu]
GO
ALTER TABLE [dbo].[Order_Details]  WITH CHECK ADD  CONSTRAINT [FK_Order_Details_Order_Form] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order_Form] ([Order_Id])
GO
ALTER TABLE [dbo].[Order_Details] CHECK CONSTRAINT [FK_Order_Details_Order_Form]
GO
ALTER TABLE [dbo].[Order_Form]  WITH CHECK ADD  CONSTRAINT [FK_Order_Form_Crew_List] FOREIGN KEY([Order_CrewID])
REFERENCES [dbo].[Crew_List] ([CrewID])
GO
ALTER TABLE [dbo].[Order_Form] CHECK CONSTRAINT [FK_Order_Form_Crew_List]
GO
ALTER TABLE [dbo].[Order_Form]  WITH CHECK ADD  CONSTRAINT [FK_Order_Form_refOrderStatus] FOREIGN KEY([Order_Status])
REFERENCES [dbo].[refOrderStatus] ([OrderStatusID])
GO
ALTER TABLE [dbo].[Order_Form] CHECK CONSTRAINT [FK_Order_Form_refOrderStatus]
GO
ALTER TABLE [dbo].[Order_Receipt]  WITH CHECK ADD  CONSTRAINT [FK_Order_Receipt_Order_Form] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order_Form] ([Order_Id])
GO
ALTER TABLE [dbo].[Order_Receipt] CHECK CONSTRAINT [FK_Order_Receipt_Order_Form]
GO
ALTER TABLE [dbo].[Order_Receipt]  WITH CHECK ADD  CONSTRAINT [FK_Order_Receipt_refReceiptStatus] FOREIGN KEY([OrderReceiptStatus])
REFERENCES [dbo].[refReceiptStatus] ([ReceiptStatusID])
GO
ALTER TABLE [dbo].[Order_Receipt] CHECK CONSTRAINT [FK_Order_Receipt_refReceiptStatus]
GO
ALTER TABLE [dbo].[Order_Receipt]  WITH CHECK ADD  CONSTRAINT [FK_Order_Receipt_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Order_Receipt] CHECK CONSTRAINT [FK_Order_Receipt_Users]
GO
ALTER TABLE [dbo].[refCategory]  WITH CHECK ADD  CONSTRAINT [FK_refCategory_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[refCategory] CHECK CONSTRAINT [FK_refCategory_Users]
GO
ALTER TABLE [dbo].[refIngredients]  WITH CHECK ADD  CONSTRAINT [FK_refIngredients_resIngredientStatus] FOREIGN KEY([Ing_Status])
REFERENCES [dbo].[refIngredientStatus] ([Ing_StatusID])
GO
ALTER TABLE [dbo].[refIngredients] CHECK CONSTRAINT [FK_refIngredients_resIngredientStatus]
GO
ALTER TABLE [dbo].[refIngredientStatus]  WITH CHECK ADD  CONSTRAINT [FK_resIngredientStatus_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[refIngredientStatus] CHECK CONSTRAINT [FK_resIngredientStatus_Users]
GO
ALTER TABLE [dbo].[refInventoryStatus]  WITH CHECK ADD  CONSTRAINT [FK_refInventoryStatus_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[refInventoryStatus] CHECK CONSTRAINT [FK_refInventoryStatus_Users]
GO
ALTER TABLE [dbo].[refOrderStatus]  WITH CHECK ADD  CONSTRAINT [FK_refOrderStatus_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[refOrderStatus] CHECK CONSTRAINT [FK_refOrderStatus_Users]
GO
ALTER TABLE [dbo].[refPosition]  WITH CHECK ADD  CONSTRAINT [FK_refPosition_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[refPosition] CHECK CONSTRAINT [FK_refPosition_Users]
GO
ALTER TABLE [dbo].[refReceiptStatus]  WITH CHECK ADD  CONSTRAINT [FK_refReceiptStatus_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[refReceiptStatus] CHECK CONSTRAINT [FK_refReceiptStatus_Users]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_refUserType] FOREIGN KEY([UserTypeID])
REFERENCES [dbo].[refUserType] ([UserTypeID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_refUserType]
GO
/****** Object:  StoredProcedure [dbo].[editmeasurement]    Script Date: 10/18/2015 3:58:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[getIngredientsofMenu]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getIngredientsofMenu]
				@menuId int
AS
BEGIN
SELECT     TOP (100) PERCENT dbo.refIngredients.Name, dbo.Ingredients_of_menu.Quantity, dbo.Ingredients_of_menu.ID
FROM         dbo.refIngredients INNER JOIN
                      dbo.Ingredients_of_menu ON dbo.refIngredients.IngredientsID = dbo.Ingredients_of_menu.Ingredients_ID
WHERE     (dbo.Ingredients_of_menu.MenuID = @menuId)
ORDER BY dbo.refIngredients.Name ASC
END


GO
/****** Object:  StoredProcedure [dbo].[getIngredientsofMenuExist]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[getIngredientsofMenuExist]
				@menuId int,
				@IngredientsID int
AS
BEGIN
SELECT     TOP (100) PERCENT dbo.refIngredients.Name, dbo.Ingredients_of_menu.Quantity, dbo.Ingredients_of_menu.ID
FROM         dbo.refIngredients INNER JOIN
                      dbo.Ingredients_of_menu ON dbo.refIngredients.IngredientsID = dbo.Ingredients_of_menu.Ingredients_ID
WHERE     (dbo.Ingredients_of_menu.MenuID = @menuId) and dbo.refIngredients.IngredientsID = @IngredientsID
ORDER BY dbo.Ingredients_of_menu.ID DESC
END


GO
/****** Object:  StoredProcedure [dbo].[getListofOrder]    Script Date: 10/18/2015 3:58:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[getordersubtotal]    Script Date: 10/18/2015 3:58:19 PM ******/
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
	@orderid int,@ordertype bit
AS
BEGIN
	declare @temp decimal(18,2)
	declare @subtotal decimal(18,2)
	declare @svcCharge decimal(18,2)
	declare @grandtotal decimal(18,2)
	set @subtotal=(select sum( dbo.Order_Details.Quantity * dbo.Menu.Menu_Price )as subtotal
		FROM            dbo.Menu INNER JOIN
								 dbo.Order_Details ON dbo.Menu.MenuID = dbo.Order_Details.MenuID
		WHERE        (dbo.Order_Details.OrderID = @orderid))

		set @temp=(@subtotal * 0.12) 
		if( @ordertype=1) --if dine in
			begin 
				set @svcCharge=(@subtotal * 0.10)	
			
			end
		else
			begin 
				set @svcCharge=0;
			end
		set @grandtotal=(@subtotal + @svcCharge)
		select @subtotal as subtotal,@temp as withvat,@svcCharge ,@grandtotal as total
END


GO
/****** Object:  StoredProcedure [dbo].[insertcategory]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[insertcategory]
	@category varchar(50),@userId int
AS
BEGIN

INSERT INTO [dbo].[refCategory]
           ([CategoryName]
           ,[CreatedBy]
           ,[CreatedDate])
     VALUES
           (@category,@userId,CURRENT_TIMESTAMP)

END


GO
/****** Object:  StoredProcedure [dbo].[insertCrew]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[insertCrew]
		@crew varchar(50),@position int,@stat bit,@createdby int
AS
BEGIN


INSERT INTO [dbo].[Crew_List]
           ([Crew_FullName]
           ,[Crew_Position]
           ,[IsActive]
           ,[CreatedBy],CreatedDate)
     VALUES
           ( @crew,@position,@stat,@createdby,CURRENT_TIMESTAMP	)



END

GO
/****** Object:  StoredProcedure [dbo].[insertEquipment]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[insertEquipment]
@EquipmentName as varchar (50)
,@EquipmentStatus as int
,@Remarks as varchar (100)
,@Addedby as int

AS
BEGIN

INSERT INTO Equipments(
EquipmentName
,Remarks
,EquipmentStatus
,Addedby
,AddedDate

)VALUES (@EquipmentName
,@Remarks
,@EquipmentStatus
,@Addedby
,CURRENT_TIMESTAMP

)

END

GO
/****** Object:  StoredProcedure [dbo].[insertExpense]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[insertExpense]

@Payee as varchar (50)
,@Remarks as varchar (100)
,@ModeofPayment as int
--,@Total as decimal
,@Createdby as int


AS
BEGIN


begin try
begin transaction
INSERT INTO Expense(
Payee
,Remarks
,ModeofPayment
--,Total
,Createdby
,CreatedDate
,Status

)VALUES (
@Payee
,@Remarks
,@ModeofPayment
--,@Total
,@Createdby
,CURRENT_TIMESTAMP
,0
)
 commit transaction
end try
begin catch
if @@Error<>0
rollback transaction
 end catch



END


GO
/****** Object:  StoredProcedure [dbo].[insertExpenseDetails]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[insertExpenseDetails]
@AccountID as int
,@Debit as decimal(18,2)
,@Credit as decimal(18,2)
,@ExpenseID as int

AS
BEGIN

begin try
begin transaction
INSERT INTO ExpenseDetails(
AccountID
,Debit
,Credit
,ExpenseID

)VALUES (
@AccountID
,@Debit
,@Credit
,@ExpenseID

)

update Expense set Total = (select sum(debit) from ExpenseDetails where Expense.ExpenseID =@ExpenseID)
where ExpenseID = @ExpenseID
 commit transaction
end try
begin catch
if @@Error<>0
rollback transaction
 end catch
END


GO
/****** Object:  StoredProcedure [dbo].[insertingredients]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[insertingredients]
	@ingredname varchar(50),@stat int,@limit int
AS
BEGIN


INSERT INTO [dbo].[refIngredients]
           ([Name]
           ,[Ing_Status]
		   ,Limit)
     VALUES
			(@ingredname,@stat,@limit)


END


GO
/****** Object:  StoredProcedure [dbo].[insertIngredToMenu]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[insertIngredToMenu]
	@ingredId int,@quantity decimal(18,2),@menuid int
AS
BEGIN

INSERT INTO [dbo].[Ingredients_of_menu]
           (
           [Ingredients_ID]
           ,[Quantity]
           ,[MenuID])
     VALUES
			(@ingredId,@quantity,@menuid)



END


GO
/****** Object:  StoredProcedure [dbo].[InsertInventory]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertInventory]
		@ingredientid int,@quantity decimal(18,2),@unit int--,@invlimit int
		,@userid int
AS
BEGIN


INSERT INTO [dbo].[Inventory]
           ([Inv_IngredientsID]

           ,[Inv_Quantity]
           ,[Inv_MeasurementID]
           ,[Inv_DateAdded]
           ,[Inv_AddedBy])
           --,[Inv_Limit])
     VALUES
           (@ingredientid,@quantity,@unit,CURRENT_TIMESTAMP,@userid)



END

GO
/****** Object:  StoredProcedure [dbo].[insertMaintenance]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[insertMaintenance]

@Description as varchar (50)
,@DateofMaintenance as datetime
,@EquipmentID as int
,@MaintenanceInterval as int
,@Status as int
,@CreatedBy as int

AS
BEGIN

begin try
begin transaction
INSERT INTO Equipment_Maintenance(
Description
,DateofMaintenance
,EquipmentID
,MaintenanceInterval
,Status
,CreatedBy

)VALUES (
@Description
,@DateofMaintenance
,@EquipmentID
,@MaintenanceInterval
,@Status
,@CreatedBy

)
 commit transaction
end try
begin catch
if @@Error<>0
rollback transaction
 end catch
END


GO
/****** Object:  StoredProcedure [dbo].[insertMenu]    Script Date: 10/18/2015 3:58:19 PM ******/
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
		@menuname varchar(50),@price decimal(18,2),@cat int, @userid int
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
           ,[Menu_Price],Menu_Category,userid)
     VALUES
			(@menuname,@price,@category,@userid)



END


GO
/****** Object:  StoredProcedure [dbo].[insertMenuOrder]    Script Date: 10/18/2015 3:58:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[insertOrder]    Script Date: 10/18/2015 3:58:19 PM ******/
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
		@tableno int,@crew int,@orderRequest varchar(50),@createdby int,@orderid int OUTPUT,@pendingno varchar(50),
		@orderType bit
AS
BEGIN

INSERT INTO [dbo].[Order_Form]
           ([Order_TableNo]
		   ,Order_PendingNo
           ,[Order_CrewID]
           ,[Order_Request]
           ,[Order_Status]
           ,[Order_CreatedDate]
           ,[Order_CreatedBy]
		   ,Order_Type)
     VALUES
           (@tableno,@pendingno,@crew,@orderRequest,1,CURRENT_TIMESTAMP,@createdby,@orderType);

		   select @orderid=SCOPE_IDENTITY()

END


GO
/****** Object:  StoredProcedure [dbo].[InsertOrOrder]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE	[dbo].[InsertOrOrder]
                    @orderid int,@companyname varchar(50),
                        @cashrendered decimal(18,2),@totalcost decimal(18,2),
                        @discount decimal(18,2),@servicecharge decimal(18,2),
                        @customername varchar(50),@issuedby varchar(50),
                        @createdby int,@orid varchar(10) out
AS
BEGIN
	begin try
		begin tran
	declare @temporderid int
INSERT INTO [dbo].[Order_Receipt]
           (

           [OrderID]
           ,[CompanyName]
           ,[CashRendered]
           ,[Total_Cost]
           ,[Discount]
           ,[Service_Charge]
           ,[OrderReceiptStatus]
           ,[Received_By]
           ,[IssuedBy]
           ,[IssuedDate]
           ,[CreatedBy])
     VALUES
           (	@orderid,@companyname,@cashrendered,@totalcost,@discount,@servicecharge,1,@customername,@issuedby,CURRENT_TIMESTAMP,
		   @createdby)

		set @temporderid=  @@IDENTITY
		
		--INSERT ALL ORDER MENU TO OR DETAILS

					INSERT INTO OR_Details(ORID, MenuID, Quantity,Item_Cost)
					SELECT  distinct @temporderid,  dbo.Menu.MenuID, dbo.Order_Details.Quantity, dbo.Order_Details.Quantity * dbo.Menu.Menu_Price AS Total 
									FROM         dbo.Menu INNER JOIN 
														   dbo.Order_Details ON dbo.Menu.MenuID = dbo.Order_Details.MenuID 
									 WHERE     (dbo.Order_Details.OrderID =@orderid)

					--UPDATE STATUS OF ORDER FORM TO 3 MEANS PAID AND TABLE IS NOW ALREADY AVAILABLE

						update Order_Form set Order_Status=3 where Order_Id=@orderid

						set @orid=(select ReceiptNo from  Order_Receipt where ORID=@temporderid)
						select @orid
			commit tran
		end try
		begin catch
				if @@ERROR<>0
					rollback tran
		end catch
END

GO
/****** Object:  StoredProcedure [dbo].[insertPosition]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[insertPosition]
		@position varchar(50),@IsActive bit,@createdby int
AS
BEGIN


INSERT INTO [dbo].[refPosition]
           ([PositionName]
           ,[IsActive]
           ,[CreatedDate]
           ,[CreatedBy])
     VALUES
           (@position,@IsActive,CURRENT_TIMESTAMP,@createdby)



END


GO
/****** Object:  StoredProcedure [dbo].[insertunit]    Script Date: 10/18/2015 3:58:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[insertUser]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[insertUser]
			@username varchar(50),@password varchar(50),@firstname varchar(50),@lastname varchar(50),@middlename varchar(50),
				@usertype int ,@stat bit
AS
BEGIN


INSERT INTO [dbo].[Users]
           ([UserName]
           ,[UserPassword]
           ,[FirstName]
           ,[MiddleName]
           ,[LastName]
           ,[UserTypeID]
           ,[IsActive])
     VALUES
			(@username,@password,@firstname,@middlename,@lastname,@usertype,@stat)



END

GO
/****** Object:  StoredProcedure [dbo].[isuserloginok]    Script Date: 10/18/2015 3:58:19 PM ******/
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
/****** Object:  StoredProcedure [dbo].[prcRptBestsellingdishes]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[prcRptBestsellingdishes]
		
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT sum(Menu_Price) as TotalSales,count(dbo.OR_Details.Quantity) AS OrderedByTable,sum(dbo.OR_Details.Quantity) AS TotalQuantity, dbo.Menu.Menu_Name FROM dbo.Menu INNER JOIN dbo.OR_Details ON dbo.Menu.MenuID = dbo.OR_Details.MenuID GROUP BY dbo.Menu.Menu_Name order by sum(dbo.OR_Details.Quantity) desc

END




GO
/****** Object:  StoredProcedure [dbo].[prcRptDailyReportExpense]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[prcRptDailyReportExpense]
	@DateToday as date
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT  * FROM      vwGetExpense
WHERE        cast(CreatedDate as date) =  @DateToday
END


GO
/****** Object:  StoredProcedure [dbo].[prcRptDailyReportExpenseForIncomeStatement]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[prcRptDailyReportExpenseForIncomeStatement]
	@DateToday as datetime
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT  * FROM      vwGetExpenseForIncomeStatement
WHERE        (CreatedDate = @DateToday)
END


GO
/****** Object:  StoredProcedure [dbo].[prcRptDailyReportIncomeStatement]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[prcRptDailyReportIncomeStatement]
	@IssuedDate as datetime
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT  * FROM            Order_Receipt
WHERE        (IssuedDate = @IssuedDate)

END


GO
/****** Object:  StoredProcedure [dbo].[prcRptInv]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[prcRptInv]
	 
AS
BEGIN
SELECT   *  from vwGetInv order by TotalQty desc
END


GO
/****** Object:  StoredProcedure [dbo].[prcRptleastsellingdishes]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[prcRptleastsellingdishes]
		
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
select top 10 * from vwGetFoodOrders order by TotalQuantity asc

END




GO
/****** Object:  StoredProcedure [dbo].[prcRptReceipt]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[prcRptReceipt]
		@ORNo varchar(50)
AS
BEGIN
	SELECT     dbo.Order_Receipt.ReceiptNo, dbo.Order_Receipt.OrderID, dbo.Order_Receipt.CompanyName, dbo.Order_Receipt.CashRendered, dbo.Order_Receipt.Total_Cost, 
                      dbo.Order_Receipt.Discount, dbo.Order_Receipt.Service_Charge, dbo.Order_Receipt.OrderReceiptStatus, dbo.Order_Receipt.Received_By, 
                      dbo.Order_Receipt.IssuedBy, dbo.Order_Receipt.IssuedDate, dbo.Order_Receipt.CreatedBy, dbo.OR_Details.MenuID, dbo.OR_Details.Quantity, 
                      dbo.OR_Details.Item_Cost, dbo.Menu.Menu_Name, dbo.Menu.Menu_Price
FROM         dbo.Menu RIGHT OUTER JOIN
                      dbo.OR_Details ON dbo.Menu.MenuID = dbo.OR_Details.MenuID RIGHT OUTER JOIN
                      dbo.Order_Receipt ON dbo.OR_Details.ORID = dbo.Order_Receipt.ORID
WHERE     (dbo.Order_Receipt.ReceiptNo = @ORNo)
END

GO
/****** Object:  StoredProcedure [dbo].[prcRptWeeklyMonthlyReportIncomeStatement]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[prcRptWeeklyMonthlyReportIncomeStatement]
	@StartDate as datetime,
	@EndDate as datetime
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT  * FROM            Order_Receipt
WHERE         IssuedDate  between @StartDate and @EndDate 

END


GO
/****** Object:  StoredProcedure [dbo].[prcWeekly/MonthyReportExpense]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[prcWeekly/MonthyReportExpense]
	@DateFrom as date,
	@DateTo as date
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT  * FROM  vwGetExpense
WHERE    cast (CreatedDate as date)   between  @DateFrom and @DateTo

END




GO
/****** Object:  StoredProcedure [dbo].[removeMenuFromCategory]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[removeMenuFromCategory]
		@menuId int
AS
BEGIN


UPDATE [dbo].[Menu]
   SET [Menu_Category] =null

 WHERE MenuID=@menuId



END


GO
/****** Object:  StoredProcedure [dbo].[rptInventoryMonitor]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[rptInventoryMonitor]
	@DateFrom as date
	, @DateTo as date
AS
BEGIN
SELECT DISTINCT i.Inv_IngredientsID,ri.Name,ms.Unit as Unit, 
case when [dbo].[FcnGetQuantitywithOrderdate](i.Inv_IngredientsID,@DateFrom,@DateTo) is null then 0 else [dbo].[FcnGetQuantitywithOrderdate](i.Inv_IngredientsID,@DateFrom,@DateTo)  end AS used,
(SELECT SUM(Inv_Quantity) AS Expr1 FROM dbo.Inventory AS i2 WHERE (Inv_IngredientsID = i.Inv_IngredientsID and Inv_DateAdded >= @DateFrom and Inv_DateAdded <= @DateTo) GROUP BY Inv_IngredientsID) - case when [dbo].[FcnGetQuantitywithOrderdate](i.Inv_IngredientsID,'2015-01-30','2015-6-01') is null then 0 else [dbo].[FcnGetQuantitywithOrderdate](i.Inv_IngredientsID,@DateFrom,@DateTo) end AS Available,
--(SELECT        SUM(Inv_Quantity) AS Expr1 FROM dbo.Inventory AS i2 WHERE        (Inv_IngredientsID = i.Inv_IngredientsID)GROUP BY Inv_IngredientsID) AS Stock, 
--CASE WHEN ((SELECT SUM(i2.Inv_Quantity) FROM Inventory i2 WHERE        i2.Inv_IngredientsID = i.Inv_IngredientsID GROUP BY i2.Inv_IngredientsID) - [dbo].[FcnGetQuantity](i.Inv_IngredientsID)) = 0 THEN 'Out of Stock' ELSE CASE WHEN ((SELECT  SUM(i2.Inv_Quantity) FROM Inventory i2 WHERE        i2.Inv_IngredientsID = i.Inv_IngredientsID GROUP BY i2.Inv_IngredientsID) - case when [dbo].[FcnGetQuantity](i.Inv_IngredientsID) is null then 0 else [dbo].[FcnGetQuantity](i.Inv_IngredientsID) end) <= ri.Limit THEN 'Critical' ELSE 'Good' END END AS Status, 
--CASE WHEN ((SELECT        SUM(i2.Inv_Quantity)FROM Inventory i2 WHERE i2.Inv_IngredientsID = i.Inv_IngredientsID GROUP BY i2.Inv_IngredientsID) - [dbo].[FcnGetQuantity](i.Inv_IngredientsID)) <= 0 THEN 'Red' ELSE CASE WHEN ((SELECT        SUM(i2.Inv_Quantity)FROM Inventory i2 WHERE i2.Inv_IngredientsID = i.Inv_IngredientsID GROUP BY i2.Inv_IngredientsID) - case when [dbo].[FcnGetQuantity](i.Inv_IngredientsID) is null then 0 else [dbo].[FcnGetQuantity](i.Inv_IngredientsID) end) <= ri.Limit THEN 'Red' ELSE 'Green' END END AS Color,
ri.Limit           FROM dbo.Inventory AS i RIGHT OUTER JOIN dbo.refIngredients AS ri ON i.Inv_IngredientsID = ri.IngredientsID LEFT OUTER JOIN dbo.Ingredients_of_menu AS im INNER JOIN dbo.Menu AS m ON im.MenuID = m.MenuID INNER JOIN dbo.Order_Form AS o INNER JOIN dbo.Order_Details AS od ON od.OrderID = o.Order_Id ON m.MenuID = od.MenuID ON i.Inv_IngredientsID = im.Ingredients_ID inner join Measurement ms on ms.MeasurementID = i.Inv_MeasurementID 
inner join Order_Form ofd on ofd.Order_Id = od.OrderID
where i.Inv_DateAdded >= @DateFrom and cast(i.Inv_DateAdded as date) <= @DateTo
GROUP BY im.Ingredients_ID, im.Quantity, ri.Name, i.Inv_Quantity, i.Inv_IngredientsID, ri.Limit,ms.Unit

end



GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-10fb70d7-86b8-408d-9703-59d757039cb2]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-10fb70d7-86b8-408d-9703-59d757039cb2] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-10fb70d7-86b8-408d-9703-59d757039cb2]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-10fb70d7-86b8-408d-9703-59d757039cb2] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-10fb70d7-86b8-408d-9703-59d757039cb2') > 0)   DROP SERVICE [SqlQueryNotificationService-10fb70d7-86b8-408d-9703-59d757039cb2]; if (OBJECT_ID('SqlQueryNotificationService-10fb70d7-86b8-408d-9703-59d757039cb2', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-10fb70d7-86b8-408d-9703-59d757039cb2]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-10fb70d7-86b8-408d-9703-59d757039cb2]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[updatecategory]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[updatecategory]
	@catname varchar(50),@catid int
AS
BEGIN

UPDATE [dbo].[refCategory]
   SET [CategoryName] = @catname
      
      
 WHERE CategoryID=@catid


END


GO
/****** Object:  StoredProcedure [dbo].[updatecrew]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[updatecrew]
		@crewname varchar(50),@position int,@stat bit,@crewid int
AS
BEGIN

UPDATE [dbo].[Crew_List]
   SET [Crew_FullName] = @crewname
      ,[Crew_Position] = @position
      ,[IsActive] = @stat

 WHERE CrewID=@crewid


END

GO
/****** Object:  StoredProcedure [dbo].[updateEquipment]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[updateEquipment]
	@EquipmentID as int
,@EquipmentName as varchar (50)
,@EquipmentStatus as int
,@Remarks as varchar (100)


AS
BEGIN

begin try
begin transaction
UPDATE Equipments SET 
EquipmentName=@EquipmentName
,EquipmentStatus=@EquipmentStatus
,Remarks=@Remarks
where EquipmentID=@EquipmentID

 commit transaction
end try
begin catch
if @@Error<>0
rollback transaction
 end catch
 
END


GO
/****** Object:  StoredProcedure [dbo].[updateEquipmentMaintenance]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[updateEquipmentMaintenance]
	@EquipmentMaintenanceID as int
	,@Description varchar (50)
	,@DateofMaintenance as datetime
	,@MaintenanceInterval as int
,@EquipmentID as int
,@Status as int


AS
BEGIN

begin try
begin transaction
UPDATE Equipment_Maintenance SET 
EquipmentID=@EquipmentID
,Description=@Description
,DateofMaintenance = @DateofMaintenance
,MaintenanceInterval = @MaintenanceInterval
,Status = @Status
where EquipmentMaintenanceID=@EquipmentMaintenanceID

 commit transaction
end try
begin catch
if @@Error<>0
rollback transaction
 end catch
 
END


GO
/****** Object:  StoredProcedure [dbo].[updateExpense]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[updateExpense]
@ExpenseID as int
,@Payee as varchar (50)
,@Remarks as varchar (100)
,@ModeofPayment as int
--,@Total as decimal
--,@Createdby as int


AS
BEGIN


begin try
begin transaction
UPDATE Expense SET 
Payee=@Payee
,Remarks=@Remarks
,ModeofPayment=@ModeofPayment
--,Total=@Total
where ExpenseID=@ExpenseID

 commit transaction
end try
begin catch
if @@Error<>0
rollback transaction
 end catch

END


GO
/****** Object:  StoredProcedure [dbo].[updateIngredient]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[updateIngredient]
		@name varchar(50),@stat int,@id int,@Limit int
AS
BEGIN


UPDATE [dbo].[refIngredients]
   SET [Name] =@name ,
[Ing_Status] =@stat
,Limit = @Limit
 WHERE IngredientsID=@id


END



GO
/****** Object:  StoredProcedure [dbo].[updateInventory]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[updateInventory]
@InvItemID as int
,@Qty as int 

--,@Total as decimal
--,@Createdby as int


AS
BEGIN


begin try
begin transaction
UPDATE Inventory  SET 
Inv_Quantity=@Qty

--,Total=@Total
where Inv_ItemID=@InvItemID

 commit transaction
end try
begin catch
if @@Error<>0
rollback transaction
 end catch

END


GO
/****** Object:  StoredProcedure [dbo].[updateMenu]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[updateMenu]
	@menuname varchar(50),@price decimal(18,2),@menuId int,@cat int
AS
BEGIN

	declare @category int 
		if (@cat=0) 
			begin
				set @category=null
			end
		else
			set @category=@cat
UPDATE [dbo].[Menu]
   SET 
      [Menu_Name] = @menuname
      ,[Menu_Price] =@price 
	  ,Menu_Category =@category
 WHERE MenuID=@menuId


 
END


GO
/****** Object:  StoredProcedure [dbo].[updateOrderDetailsStatus]    Script Date: 10/18/2015 3:58:19 PM ******/
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
	if not exists(SELECT IsServed FROM dbo.Order_Details WHERE        (OrderID = @orderid) AND (IsServed = 0))
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
/****** Object:  StoredProcedure [dbo].[updatePosition]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[updatePosition] 
	@position varchar(50),@stat bit, @posid int
AS
BEGIN


UPDATE [dbo].[refPosition]
   SET [PositionName] =@position
      ,[IsActive] = @stat
      
 WHERE PositionID=@posid



END


GO
/****** Object:  StoredProcedure [dbo].[updateuser]    Script Date: 10/18/2015 3:58:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[updateuser]
		@username varchar(50),@password varchar(50),@firstname varchar(50),
			@middlename varchar(50),@lastname varchar(50),@usertypeid int,
			@isactive bit,@UserId int
AS
BEGIN


UPDATE [dbo].[Users]
   SET [UserName] =@username
      ,[UserPassword] =@password
      ,[FirstName] = @firstname
      ,[MiddleName] = @middlename
      ,[LastName] = @lastname
      ,[UserTypeID] = @usertypeid
      ,[IsActive] =@isactive
 WHERE UserID=@UserId


END

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
         Configuration = "(H (1[50] 4[25] 3) )"
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
      ActivePaneConfig = 1
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Expense"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 186
               Right = 239
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ExpenseDetails"
            Begin Extent = 
               Top = 19
               Left = 386
               Bottom = 209
               Right = 563
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 11
         Width = 284
         Width = 1500
         Width = 1500
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
      Begin ColumnWidths = 11
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwGetExpense'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwGetExpense'
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
         Begin Table = "Expense"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 232
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwGetExpenseForIncome'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwGetExpenseForIncome'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[36] 4[25] 2[20] 3) )"
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
         Begin Table = "Expense"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 216
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ExpenseDetails"
            Begin Extent = 
               Top = 6
               Left = 254
               Bottom = 135
               Right = 431
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 1755
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwGetExpenseForIncomeStatement'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwGetExpenseForIncomeStatement'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[36] 4[26] 2[21] 3) )"
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
         Begin Table = "OR_Details"
            Begin Extent = 
               Top = 75
               Left = 304
               Bottom = 227
               Right = 566
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Menu"
            Begin Extent = 
               Top = 41
               Left = 50
               Bottom = 170
               Right = 223
            End
            DisplayFlags = 280
            TopColumn = 0
         End
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
         Width = 2085
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwGetFoodOrders'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwGetFoodOrders'
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
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwGetIncome'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwGetIncome'
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
         Configuration = "(H (1[50] 4[19] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[64] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4[50] 3) )"
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
         Configuration = "(H (1[75] 4) )"
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
      ActivePaneConfig = 1
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Order_Details"
            Begin Extent = 
               Top = 87
               Left = 74
               Bottom = 239
               Right = 244
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Menu"
            Begin Extent = 
               Top = 110
               Left = 304
               Bottom = 239
               Right = 477
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "refIngredients"
            Begin Extent = 
               Top = 171
               Left = 882
               Bottom = 301
               Right = 1052
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Ingredients_of_menu"
            Begin Extent = 
               Top = 159
               Left = 586
               Bottom = 288
               Right = 781
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Inventory"
            Begin Extent = 
               Top = 180
               Left = 1193
               Bottom = 390
               Right = 1429
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1530
         Width = 1680
         Width = 2100
         Width = 1500
         Width = 1500
         Width = 1635
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwGetInv'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'     Column = 7620
         Alias = 2160
         Table = 4005
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwGetInv'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwGetInv'
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
               Right = 479
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "im"
            Begin Extent = 
               Top = 6
               Left = 510
               Bottom = 135
               Right = 703
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "m"
            Begin Extent = 
               Top = 6
               Left = 734
               Bottom = 135
               Right = 927
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
               Right = 474
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ms"
            Begin Extent = 
               Top = 138
               Left = 505
               Bottom = 233
               Right = 698
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
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[21] 2[13] 3) )"
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
         End' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwgetInventoryStock'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 12
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwgetInventoryStock'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwgetInventoryStock'
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
         Begin Table = "Equipment_Maintenance"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 265
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Equipments"
            Begin Extent = 
               Top = 6
               Left = 303
               Bottom = 135
               Right = 482
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "refEqMaintenanceStatus"
            Begin Extent = 
               Top = 6
               Left = 520
               Bottom = 135
               Right = 705
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwGetMaintenance'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwGetMaintenance'
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
         Begin Table = "refIngredients"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Ingredients_of_menu"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 135
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwGetMenu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwGetMenu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[49] 4[12] 2[21] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[53] 4[12] 3) )"
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
      ActivePaneConfig = 1
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Order_Receipt"
            Begin Extent = 
               Top = 0
               Left = 579
               Bottom = 256
               Right = 769
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "OR_Details"
            Begin Extent = 
               Top = 44
               Left = 298
               Bottom = 201
               Right = 482
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Menu"
            Begin Extent = 
               Top = 22
               Left = 24
               Bottom = 151
               Right = 197
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 20
         Width = 284
         Width = 1020
         Width = 810
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
      Begin ColumnWidths = 11
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
         Or = 13' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwGetReceipt'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'50
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwGetReceipt'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwGetReceipt'
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
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwgetRev'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwgetRev'
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
         Begin Table = "vwgetRev"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 118
               Right = 220
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwgetrevenue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwgetrevenue'
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
         Begin Table = "vwgetrevenue"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 236
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwgetRevenue1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwgetRevenue1'
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
         Begin Table = "Order_Receipt"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 244
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwGetRevenueForIncome'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwGetRevenueForIncome'
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
         Begin Table = "Order_Details"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 224
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Order_Form"
            Begin Extent = 
               Top = 6
               Left = 262
               Bottom = 135
               Right = 467
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vwGetMenu"
            Begin Extent = 
               Top = 6
               Left = 505
               Bottom = 67
               Right = 691
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwIng'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwIng'
GO
USE [master]
GO
ALTER DATABASE [ISPROJ1kat] SET  READ_WRITE 
GO
