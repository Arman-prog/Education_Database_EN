USE [master]
GO


CREATE DATABASE [EducationDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Education', FILENAME = N'C:\Users\arami\OneDrive\Documents\SQL\EducationDB\EducationDB.mdf' , SIZE = 10MB , MAXSIZE = 100MB, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Education_log', FILENAME = N'C:\Users\arami\OneDrive\Documents\SQL\EducationDB\EducationDB.ldf' , SIZE = 1024KB , MAXSIZE = 50MB , FILEGROWTH = 10%)
GO

USE [EducationDB]

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EducationDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [EducationDB] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [EducationDB] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [EducationDB] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [EducationDB] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [EducationDB] SET ARITHABORT OFF 
GO

ALTER DATABASE [EducationDB] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [EducationDB] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [EducationDB] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [EducationDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [EducationDB] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [EducationDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [EducationDB] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [EducationDB] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [EducationDB] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [EducationDB] SET  DISABLE_BROKER 
GO

ALTER DATABASE [EducationDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [EducationDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [EducationDB] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [EducationDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [EducationDB] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [EducationDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [EducationDB] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [EducationDB] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [EducationDB] SET  MULTI_USER 
GO

ALTER DATABASE [EducationDB] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [EducationDB] SET DB_CHAINING OFF 
GO

ALTER DATABASE [EducationDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [EducationDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO

ALTER DATABASE [EducationDB] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [EducationDB] SET  READ_WRITE 
GO



SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Address](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Country] [nvarchar](50) NULL,
	[Region] [nvarchar](50) NOT NULL,
	[City] [nvarchar](50) NOT NULL,
	[StreetOrDistrict] [nvarchar](50) NOT NULL,
	[House] [nvarchar](10) NOT NULL,
	[Apartment] [int] NULL,
 CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Address] ADD  CONSTRAINT [DF_Address_Country]  DEFAULT (N'Armenia') FOR [Country]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[University](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[PhoneNumber] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[AddressId] [int] NULL,
	[DestroyDate] [date] NULL,
 CONSTRAINT [PK_University] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO



SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Student](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](10) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[PhoneNumber] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NULL,
	[Gender] [tinyint] NOT NULL,
	[UniversityId] [int] NULL,
	[AddressId] [int] NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_University] FOREIGN KEY([UniversityId])
REFERENCES [dbo].[University] ([Id])
GO

ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_University]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Teacher](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](10) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[PhoneNumber] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NULL,
	[AddressId] [int] NOT NULL,
	[Gender] [tinyint] NOT NULL,
 CONSTRAINT [PK_Teacher] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO



SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Teacher_University](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TeacherId] [int] NOT NULL,
	[UniversityId] [int] NOT NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[Hour] [int] NULL,
 CONSTRAINT [PK_Teacher_University] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Teacher_University] ADD  DEFAULT (getdate()) FOR [StartDate]
GO

ALTER TABLE [dbo].[Teacher_University]  WITH CHECK ADD  CONSTRAINT [FK_Teacher_University_Teacher] FOREIGN KEY([TeacherId])
REFERENCES [dbo].[Teacher] ([Id])
GO

ALTER TABLE [dbo].[Teacher_University] CHECK CONSTRAINT [FK_Teacher_University_Teacher]
GO

ALTER TABLE [dbo].[Teacher_University]  WITH CHECK ADD  CONSTRAINT [FK_Teacher_University_University] FOREIGN KEY([UniversityId])
REFERENCES [dbo].[University] ([Id])
GO

ALTER TABLE [dbo].[Teacher_University] CHECK CONSTRAINT [FK_Teacher_University_University]
GO



SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[TeacherView]
AS
select T.FirstName,T.LastName, U.[Name] as University,A.City from Teacher_University
inner join Teacher as T on Teacher_University.TeacherId=T.Id
inner join University as U on Teacher_University.UniversityId=U.Id
inner join [Address] as A on U.AddressId=A.Id
GO



