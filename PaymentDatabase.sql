USE [master]
GO
/****** Object:  Database [PaymentDatabase]    Script Date: 29.08.2020 14:16:04 ******/
CREATE DATABASE [PaymentDatabase]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PaymentDatabase', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\PaymentDatabase.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PaymentDatabase_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\PaymentDatabase_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [PaymentDatabase] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PaymentDatabase].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PaymentDatabase] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PaymentDatabase] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PaymentDatabase] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PaymentDatabase] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PaymentDatabase] SET ARITHABORT OFF 
GO
ALTER DATABASE [PaymentDatabase] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PaymentDatabase] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PaymentDatabase] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PaymentDatabase] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PaymentDatabase] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PaymentDatabase] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PaymentDatabase] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PaymentDatabase] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PaymentDatabase] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PaymentDatabase] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PaymentDatabase] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PaymentDatabase] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PaymentDatabase] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PaymentDatabase] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PaymentDatabase] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PaymentDatabase] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PaymentDatabase] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PaymentDatabase] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [PaymentDatabase] SET  MULTI_USER 
GO
ALTER DATABASE [PaymentDatabase] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PaymentDatabase] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PaymentDatabase] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PaymentDatabase] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PaymentDatabase] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PaymentDatabase] SET QUERY_STORE = OFF
GO
USE [PaymentDatabase]
GO
/****** Object:  Table [dbo].[Counterparty_T]    Script Date: 29.08.2020 14:16:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Counterparty_T](
	[CustomerId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Counterparty_T] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payments_T]    Script Date: 29.08.2020 14:16:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payments_T](
	[PaymentId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[PaymentDate] [datetime2](7) NOT NULL,
	[Sum] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_Pauments_T] PRIMARY KEY CLUSTERED 
(
	[PaymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Payments_T]  WITH CHECK ADD  CONSTRAINT [FK_Pauments_T_Counterparty_T] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Counterparty_T] ([CustomerId])
GO
ALTER TABLE [dbo].[Payments_T] CHECK CONSTRAINT [FK_Pauments_T_Counterparty_T]
GO
/****** Object:  StoredProcedure [dbo].[GetСounterPayments]    Script Date: 29.08.2020 14:16:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetСounterPayments] 
	@SubCustomerName nvarchar(50),
	@PaymentDate datetime2(7)
AS
	SET NOCOUNT ON;
	SELECT c.CustomerId, c.CustomerName, p.Sum, p.PaymentDate FROM Payments_T AS p
	JOIN Counterparty_T AS c ON p.CustomerId = c.CustomerId
	WHERE p.PaymentDate = @PaymentDate and c.CustomerName Like '%' + @SubCustomerName + '%'
	ORDER BY c.CustomerName
GO
USE [master]
GO
ALTER DATABASE [PaymentDatabase] SET  READ_WRITE 
GO
