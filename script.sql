USE [master]
GO
/****** Object:  Database [LibraryDB]    Script Date: 08/31/2020 10:08:38 PM ******/
CREATE DATABASE [LibraryDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ProjectPRJ', FILENAME = N'E:\sql\MSSQL14.MSSQLSERVER\MSSQL\DATA\ProjectPRJ.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ProjectPRJ_log', FILENAME = N'E:\sql\MSSQL14.MSSQLSERVER\MSSQL\DATA\ProjectPRJ_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [LibraryDB] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LibraryDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LibraryDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LibraryDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LibraryDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LibraryDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LibraryDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [LibraryDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [LibraryDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LibraryDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LibraryDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LibraryDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LibraryDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LibraryDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LibraryDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LibraryDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LibraryDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [LibraryDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LibraryDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LibraryDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LibraryDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LibraryDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LibraryDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LibraryDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LibraryDB] SET RECOVERY FULL 
GO
ALTER DATABASE [LibraryDB] SET  MULTI_USER 
GO
ALTER DATABASE [LibraryDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LibraryDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LibraryDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LibraryDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LibraryDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'LibraryDB', N'ON'
GO
ALTER DATABASE [LibraryDB] SET QUERY_STORE = OFF
GO
USE [LibraryDB]
GO
/****** Object:  Table [dbo].[Book]    Script Date: 08/31/2020 10:08:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book](
	[bid] [int] IDENTITY(1,1) NOT NULL,
	[status] [int] NOT NULL,
	[tid] [int] NOT NULL,
	[condition] [int] NOT NULL,
 CONSTRAINT [PK_Book] PRIMARY KEY CLUSTERED 
(
	[bid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Condition]    Script Date: 08/31/2020 10:08:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Condition](
	[cid] [int] NOT NULL,
	[cname] [nchar](10) NOT NULL,
	[description] [nchar](150) NOT NULL,
 CONSTRAINT [PK_Condition] PRIMARY KEY CLUSTERED 
(
	[cid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feature]    Script Date: 08/31/2020 10:08:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feature](
	[fid] [int] NOT NULL,
	[fname] [nchar](150) NOT NULL,
 CONSTRAINT [PK_Feature] PRIMARY KEY CLUSTERED 
(
	[fid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Group]    Script Date: 08/31/2020 10:08:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Group](
	[gid] [int] NOT NULL,
	[gname] [nchar](150) NOT NULL,
 CONSTRAINT [PK_Group] PRIMARY KEY CLUSTERED 
(
	[gid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Group_Feature]    Script Date: 08/31/2020 10:08:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Group_Feature](
	[gid] [int] NOT NULL,
	[fid] [int] NOT NULL,
 CONSTRAINT [PK_Group_Feature] PRIMARY KEY CLUSTERED 
(
	[gid] ASC,
	[fid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Title]    Script Date: 08/31/2020 10:08:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Title](
	[tid] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](max) NOT NULL,
	[author] [nvarchar](50) NOT NULL,
	[description] [nvarchar](max) NULL,
	[image] [nvarchar](50) NULL,
 CONSTRAINT [PK_Title] PRIMARY KEY CLUSTERED 
(
	[tid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transaction]    Script Date: 08/31/2020 10:08:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaction](
	[transactionID] [int] IDENTITY(1,1) NOT NULL,
	[username] [nchar](150) NOT NULL,
	[bid] [int] NOT NULL,
	[transactionDate] [date] NOT NULL,
	[dueDate] [date] NOT NULL,
	[status] [bit] NOT NULL,
 CONSTRAINT [PK_Transaction] PRIMARY KEY CLUSTERED 
(
	[transactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 08/31/2020 10:08:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[username] [nchar](150) NOT NULL,
	[password] [nchar](150) NOT NULL,
	[gid] [int] NOT NULL,
	[name] [nchar](150) NOT NULL,
	[phoneNo] [nchar](20) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Book] ON 

INSERT [dbo].[Book] ([bid], [status], [tid], [condition]) VALUES (48, 1, 2, 5)
INSERT [dbo].[Book] ([bid], [status], [tid], [condition]) VALUES (49, 1, 2, 5)
INSERT [dbo].[Book] ([bid], [status], [tid], [condition]) VALUES (50, 1, 2, 5)
INSERT [dbo].[Book] ([bid], [status], [tid], [condition]) VALUES (51, 1, 2, 5)
INSERT [dbo].[Book] ([bid], [status], [tid], [condition]) VALUES (52, 1, 2, 5)
INSERT [dbo].[Book] ([bid], [status], [tid], [condition]) VALUES (53, 1, 2, 5)
INSERT [dbo].[Book] ([bid], [status], [tid], [condition]) VALUES (54, 1, 116, 5)
INSERT [dbo].[Book] ([bid], [status], [tid], [condition]) VALUES (55, 1, 2, 5)
INSERT [dbo].[Book] ([bid], [status], [tid], [condition]) VALUES (56, 1, 2, 5)
INSERT [dbo].[Book] ([bid], [status], [tid], [condition]) VALUES (57, 1, 2, 5)
INSERT [dbo].[Book] ([bid], [status], [tid], [condition]) VALUES (58, 1, 2, 5)
INSERT [dbo].[Book] ([bid], [status], [tid], [condition]) VALUES (59, 1, 2, 5)
INSERT [dbo].[Book] ([bid], [status], [tid], [condition]) VALUES (60, 1, 2, 5)
INSERT [dbo].[Book] ([bid], [status], [tid], [condition]) VALUES (61, 1, 2, 5)
INSERT [dbo].[Book] ([bid], [status], [tid], [condition]) VALUES (62, 1, 2, 5)
INSERT [dbo].[Book] ([bid], [status], [tid], [condition]) VALUES (63, 1, 2, 5)
INSERT [dbo].[Book] ([bid], [status], [tid], [condition]) VALUES (64, 1, 119, 5)
INSERT [dbo].[Book] ([bid], [status], [tid], [condition]) VALUES (65, 1, 119, 5)
INSERT [dbo].[Book] ([bid], [status], [tid], [condition]) VALUES (66, 1, 119, 5)
INSERT [dbo].[Book] ([bid], [status], [tid], [condition]) VALUES (67, 1, 119, 5)
SET IDENTITY_INSERT [dbo].[Book] OFF
INSERT [dbo].[Condition] ([cid], [cname], [description]) VALUES (1, N'Poor      ', N'The book has been wet, lost pages and could not be repaired (unuseable)                                                                               ')
INSERT [dbo].[Condition] ([cid], [cname], [description]) VALUES (2, N'Fair      ', N'The book has been damaged and repaired                                                                                                                ')
INSERT [dbo].[Condition] ([cid], [cname], [description]) VALUES (3, N'Good      ', N'The book has been used many time and look old                                                                                                         ')
INSERT [dbo].[Condition] ([cid], [cname], [description]) VALUES (4, N'Very Good ', N'The book has been used but no bended                                                                                                                  ')
INSERT [dbo].[Condition] ([cid], [cname], [description]) VALUES (5, N'New       ', N'The book has just been bought                                                                                                                         ')
INSERT [dbo].[Feature] ([fid], [fname]) VALUES (1, N'addLibrarian                                                                                                                                          ')
INSERT [dbo].[Feature] ([fid], [fname]) VALUES (2, N'editAccount                                                                                                                                           ')
INSERT [dbo].[Feature] ([fid], [fname]) VALUES (3, N'deleteAccount                                                                                                                                         ')
INSERT [dbo].[Feature] ([fid], [fname]) VALUES (4, N'viewAccount                                                                                                                                           ')
INSERT [dbo].[Feature] ([fid], [fname]) VALUES (5, N'addBook                                                                                                                                               ')
INSERT [dbo].[Feature] ([fid], [fname]) VALUES (6, N'editBook                                                                                                                                              ')
INSERT [dbo].[Feature] ([fid], [fname]) VALUES (7, N'deleteBook                                                                                                                                            ')
INSERT [dbo].[Feature] ([fid], [fname]) VALUES (8, N'rentBook                                                                                                                                              ')
INSERT [dbo].[Feature] ([fid], [fname]) VALUES (9, N'viewRentedBook                                                                                                                                        ')
INSERT [dbo].[Feature] ([fid], [fname]) VALUES (10, N'returnBook                                                                                                                                            ')
INSERT [dbo].[Group] ([gid], [gname]) VALUES (0, N'disable                                                                                                                                               ')
INSERT [dbo].[Group] ([gid], [gname]) VALUES (1, N'admin                                                                                                                                                 ')
INSERT [dbo].[Group] ([gid], [gname]) VALUES (2, N'librarian                                                                                                                                             ')
INSERT [dbo].[Group] ([gid], [gname]) VALUES (3, N'reader                                                                                                                                                ')
INSERT [dbo].[Group_Feature] ([gid], [fid]) VALUES (1, 1)
INSERT [dbo].[Group_Feature] ([gid], [fid]) VALUES (1, 2)
INSERT [dbo].[Group_Feature] ([gid], [fid]) VALUES (1, 3)
INSERT [dbo].[Group_Feature] ([gid], [fid]) VALUES (1, 4)
INSERT [dbo].[Group_Feature] ([gid], [fid]) VALUES (2, 5)
INSERT [dbo].[Group_Feature] ([gid], [fid]) VALUES (2, 6)
INSERT [dbo].[Group_Feature] ([gid], [fid]) VALUES (2, 7)
INSERT [dbo].[Group_Feature] ([gid], [fid]) VALUES (2, 8)
INSERT [dbo].[Group_Feature] ([gid], [fid]) VALUES (2, 10)
INSERT [dbo].[Group_Feature] ([gid], [fid]) VALUES (3, 9)
SET IDENTITY_INSERT [dbo].[Title] ON 

INSERT [dbo].[Title] ([tid], [title], [author], [description], [image]) VALUES (2, N'The Magic Forest', N'Fischer, Ryder X.', N'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Nec ultrices dui sapien eget mi proin. Senectus et netus et malesuada fames. Vitae turpis massa sed elementum. Mattis pellentesque id nibh tortor id. Ornare arcu dui vivamus arcu felis bibendum. At lectus urna duis convallis convallis. Amet aliquam id diam maecenas ultricies mi eget mauris. Eu facilisis sed odio morbi. Nec dui nunc mattis enim ut tellus elementum.

Id aliquet lectus proin nibh nisl condimentum id. Turpis cursus in hac habitasse. Sed lectus vestibulum mattis ullamcorper velit sed ullamcorper morbi. Sit amet consectetur adipiscing elit duis tristique sollicitudin. Commodo odio aenean sed adipiscing diam. Sem et tortor consequat id porta nibh venenatis cras sed. Libero enim sed faucibus turpis in eu mi bibendum neque. Odio tempor orci dapibus ultrices in. Porttitor eget dolor morbi non. Odio pellentesque diam volutpat commodo sed egestas egestas fringilla. Commodo odio aenean sed adipiscing diam donec adipiscing tristique risus. Est pellentesque elit ullamcorper dignissim cras tincidunt lobortis. Tristique et egestas quis ipsum. Maecenas volutpat blandit aliquam etiam erat velit scelerisque in dictum.

Dignissim convallis aenean et tortor at risus viverra adipiscing. Ultrices mi tempus imperdiet nulla malesuada pellentesque elit eget gravida. Ut tortor pretium viverra suspendisse potenti nullam ac tortor vitae. Convallis aenean et tortor at risus viverra. Quis lectus nulla at volutpat diam ut. Id neque aliquam vestibulum morbi blandit. Nisl suscipit adipiscing bibendum est. Ultricies integer quis auctor elit. Egestas sed sed risus pretium quam vulputate dignissim suspendisse in. Ac odio tempor orci dapibus. Tellus id interdum velit laoreet id. Etiam sit amet nisl purus in mollis nunc sed id.', N'Forest.jpg')
INSERT [dbo].[Title] ([tid], [title], [author], [description], [image]) VALUES (3, N'The Tiny  Dragon', N'Harrell, Jaime W.', N'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Nec ultrices dui sapien eget mi proin. Senectus et netus et malesuada fames. Vitae turpis massa sed elementum. Mattis pellentesque id nibh tortor id. Ornare arcu dui vivamus arcu felis bibendum. At lectus urna duis convallis convallis. Amet aliquam id diam maecenas ultricies mi eget mauris. Eu facilisis sed odio morbi. Nec dui nunc mattis enim ut tellus elementum.

Id aliquet lectus proin nibh nisl condimentum id. Turpis cursus in hac habitasse. Sed lectus vestibulum mattis ullamcorper velit sed ullamcorper morbi. Sit amet consectetur adipiscing elit duis tristique sollicitudin. Commodo odio aenean sed adipiscing diam. Sem et tortor consequat id porta nibh venenatis cras sed. Libero enim sed faucibus turpis in eu mi bibendum neque. Odio tempor orci dapibus ultrices in. Porttitor eget dolor morbi non. Odio pellentesque diam volutpat commodo sed egestas egestas fringilla. Commodo odio aenean sed adipiscing diam donec adipiscing tristique risus. Est pellentesque elit ullamcorper dignissim cras tincidunt lobortis. Tristique et egestas quis ipsum. Maecenas volutpat blandit aliquam etiam erat velit scelerisque in dictum.

Dignissim convallis aenean et tortor at risus viverra adipiscing. Ultrices mi tempus imperdiet nulla malesuada pellentesque elit eget gravida. Ut tortor pretium viverra suspendisse potenti nullam ac tortor vitae. Convallis aenean et tortor at risus viverra. Quis lectus nulla at volutpat diam ut. Id neque aliquam vestibulum morbi blandit. Nisl suscipit adipiscing bibendum est. Ultricies integer quis auctor elit. Egestas sed sed risus pretium quam vulputate dignissim suspendisse in. Ac odio tempor orci dapibus. Tellus id interdum velit laoreet id. Etiam sit amet nisl purus in mollis nunc sed id.', N'Dragon.jpg')
INSERT [dbo].[Title] ([tid], [title], [author], [description], [image]) VALUES (4, N'The Booted Cat', N'Aguilar, Cruz G.', N'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Nec ultrices dui sapien eget mi proin. Senectus et netus et malesuada fames. Vitae turpis massa sed elementum. Mattis pellentesque id nibh tortor id. Ornare arcu dui vivamus arcu felis bibendum. At lectus urna duis convallis convallis. Amet aliquam id diam maecenas ultricies mi eget mauris. Eu facilisis sed odio morbi. Nec dui nunc mattis enim ut tellus elementum.

Id aliquet lectus proin nibh nisl condimentum id. Turpis cursus in hac habitasse. Sed lectus vestibulum mattis ullamcorper velit sed ullamcorper morbi. Sit amet consectetur adipiscing elit duis tristique sollicitudin. Commodo odio aenean sed adipiscing diam. Sem et tortor consequat id porta nibh venenatis cras sed. Libero enim sed faucibus turpis in eu mi bibendum neque. Odio tempor orci dapibus ultrices in. Porttitor eget dolor morbi non. Odio pellentesque diam volutpat commodo sed egestas egestas fringilla. Commodo odio aenean sed adipiscing diam donec adipiscing tristique risus. Est pellentesque elit ullamcorper dignissim cras tincidunt lobortis. Tristique et egestas quis ipsum. Maecenas volutpat blandit aliquam etiam erat velit scelerisque in dictum.

Dignissim convallis aenean et tortor at risus viverra adipiscing. Ultrices mi tempus imperdiet nulla malesuada pellentesque elit eget gravida. Ut tortor pretium viverra suspendisse potenti nullam ac tortor vitae. Convallis aenean et tortor at risus viverra. Quis lectus nulla at volutpat diam ut. Id neque aliquam vestibulum morbi blandit. Nisl suscipit adipiscing bibendum est. Ultricies integer quis auctor elit. Egestas sed sed risus pretium quam vulputate dignissim suspendisse in. Ac odio tempor orci dapibus. Tellus id interdum velit laoreet id. Etiam sit amet nisl purus in mollis nunc sed id.3', N'Cat.jpg')
INSERT [dbo].[Title] ([tid], [title], [author], [description], [image]) VALUES (5, N'montes, nascetur', N'Smith, Adria R.', N'et netus et malesuada fames ac turpis egestas. Fusce aliquet magna a neque. Nullam ut', N'Forest.jpg')
INSERT [dbo].[Title] ([tid], [title], [author], [description], [image]) VALUES (6, N'accumsan neque et nunc. Quisque', N'Livingston, Risa F.', N'dictum augue malesuada malesuada. Integer id magna et ipsum cursus vestibulum. Mauris magna. Duis dignissim tempor arcu. Vestibulum ut eros', N'Dragon.jpg')
INSERT [dbo].[Title] ([tid], [title], [author], [description], [image]) VALUES (7, N'nonummy. Fusce fermentum', N'Duran, Garrett Z.', N'pretium aliquet, metus urna convallis erat, eget tincidunt dui augue eu', N'Cat.jpg')
INSERT [dbo].[Title] ([tid], [title], [author], [description], [image]) VALUES (8, N'erat volutpat. Nulla', N'Reed, Colin L.', N'neque tellus, imperdiet non, vestibulum nec, euismod in, dolor. Fusce feugiat. Lorem ipsum', N'Forest.jpg')
INSERT [dbo].[Title] ([tid], [title], [author], [description], [image]) VALUES (9, N'enim. Suspendisse', N'Jarvis, Xena C.', N'consectetuer euismod est arcu ac orci. Ut semper pretium neque. Morbi quis urna. Nunc quis arcu', N'Dragon.jpg')
INSERT [dbo].[Title] ([tid], [title], [author], [description], [image]) VALUES (10, N'tincidunt, nunc ac', N'Mayo, Lars M.', N'tincidunt. Donec vitae erat vel pede blandit congue. In scelerisque scelerisque dui. Suspendisse ac metus', N'Cat.jpg')
INSERT [dbo].[Title] ([tid], [title], [author], [description], [image]) VALUES (11, N'et ultrices posuere cubilia', N'Elliott, Maya I.', N'lacus pede sagittis augue, eu tempor erat neque non quam. Pellentesque habitant morbi tristique senectus et netus et', N'Forest.jpg')
INSERT [dbo].[Title] ([tid], [title], [author], [description], [image]) VALUES (12, N'eleifend non, dapibus rutrum,', N'Parker, Lacota S.', N'lectus quis massa. Mauris vestibulum, neque sed dictum eleifend, nunc risus varius orci,', N'Dragon.jpg')
INSERT [dbo].[Title] ([tid], [title], [author], [description], [image]) VALUES (13, N'at, libero. Morbi accumsan laoreet', N'Pratt, Octavius U.', N'Nam ac nulla. In tincidunt congue turpis. In condimentum. Donec', N'Cat.jpg')
INSERT [dbo].[Title] ([tid], [title], [author], [description], [image]) VALUES (14, N'nisi. Aenean eget metus. In', N'Knowles, Uriah C.', N'in faucibus orci luctus et ultrices posuere cubilia Curae; Donec tincidunt. Donec vitae erat vel pede blandit congue.', N'Forest.jpg')
INSERT [dbo].[Title] ([tid], [title], [author], [description], [image]) VALUES (15, N'porttitor vulputate, posuere vulputate,', N'Cortez, Ahmed R.', N'nascetur ridiculus mus. Proin vel arcu eu odio tristique pharetra.', N'Dragon.jpg')
INSERT [dbo].[Title] ([tid], [title], [author], [description], [image]) VALUES (16, N'non, sollicitudin a, malesuada id,', N'Mullins, Willa F.', N'lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a,', N'Cat.jpg')
INSERT [dbo].[Title] ([tid], [title], [author], [description], [image]) VALUES (17, N'orci luctus et', N'Collier, Kirk N.', N'at pretium aliquet, metus urna convallis erat, eget tincidunt dui augue eu', N'Forest.jpg')
INSERT [dbo].[Title] ([tid], [title], [author], [description], [image]) VALUES (18, N'egestas rhoncus. Proin', N'Cruz, Zenaida N.', N'blandit at, nisi. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus', N'Dragon.jpg')
INSERT [dbo].[Title] ([tid], [title], [author], [description], [image]) VALUES (19, N'est tempor bibendum. Donec felis', N'Puckett, Kermit Y.', N'cursus. Nunc mauris elit, dictum eu, eleifend nec, malesuada ut, sem. Nulla interdum. Curabitur', N'Cat.jpg')
INSERT [dbo].[Title] ([tid], [title], [author], [description], [image]) VALUES (116, N'Test', N'Test', N'Test', N'Cat.jpg')
INSERT [dbo].[Title] ([tid], [title], [author], [description], [image]) VALUES (119, N'Test 2', N'Test 2', N'Test 2', N'Forest.jpg')
SET IDENTITY_INSERT [dbo].[Title] OFF
SET IDENTITY_INSERT [dbo].[Transaction] ON 

INSERT [dbo].[Transaction] ([transactionID], [username], [bid], [transactionDate], [dueDate], [status]) VALUES (6, N'reader1                                                                                                                                               ', 48, CAST(N'2020-05-05' AS Date), CAST(N'2020-06-05' AS Date), 1)
INSERT [dbo].[Transaction] ([transactionID], [username], [bid], [transactionDate], [dueDate], [status]) VALUES (7, N'reader1                                                                                                                                               ', 49, CAST(N'2020-05-05' AS Date), CAST(N'2020-06-05' AS Date), 1)
SET IDENTITY_INSERT [dbo].[Transaction] OFF
INSERT [dbo].[User] ([username], [password], [gid], [name], [phoneNo]) VALUES (N'admin                                                                                                                                                 ', N'admin                                                                                                                                                 ', 1, N'Duc Anh                                                                                                                                               ', N'0123456789          ')
INSERT [dbo].[User] ([username], [password], [gid], [name], [phoneNo]) VALUES (N'lib1                                                                                                                                                  ', N'123                                                                                                                                                   ', 2, N'Librarian 1                                                                                                                                           ', N'0963852741          ')
INSERT [dbo].[User] ([username], [password], [gid], [name], [phoneNo]) VALUES (N'lib2                                                                                                                                                  ', N'123                                                                                                                                                   ', 3, N'Librarian 2                                                                                                                                           ', N'0147258369          ')
INSERT [dbo].[User] ([username], [password], [gid], [name], [phoneNo]) VALUES (N'lib3                                                                                                                                                  ', N'123                                                                                                                                                   ', 2, N'Librarian 3                                                                                                                                           ', N'0963852741          ')
INSERT [dbo].[User] ([username], [password], [gid], [name], [phoneNo]) VALUES (N'reader1                                                                                                                                               ', N'123                                                                                                                                                   ', 3, N'Reader 1                                                                                                                                              ', N'0147258369          ')
INSERT [dbo].[User] ([username], [password], [gid], [name], [phoneNo]) VALUES (N'reader2                                                                                                                                               ', N'123                                                                                                                                                   ', 3, N'Reader 2                                                                                                                                              ', N'0123458687          ')
INSERT [dbo].[User] ([username], [password], [gid], [name], [phoneNo]) VALUES (N'reader3                                                                                                                                               ', N'123                                                                                                                                                   ', 0, N'Reader 3                                                                                                                                              ', N'0112456789          ')
ALTER TABLE [dbo].[Transaction] ADD  CONSTRAINT [DF_Transaction_status]  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [FK_Book_Condition] FOREIGN KEY([condition])
REFERENCES [dbo].[Condition] ([cid])
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [FK_Book_Condition]
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [FK_Book_Title] FOREIGN KEY([tid])
REFERENCES [dbo].[Title] ([tid])
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [FK_Book_Title]
GO
ALTER TABLE [dbo].[Group_Feature]  WITH CHECK ADD  CONSTRAINT [FK_Group_Feature_Feature] FOREIGN KEY([fid])
REFERENCES [dbo].[Feature] ([fid])
GO
ALTER TABLE [dbo].[Group_Feature] CHECK CONSTRAINT [FK_Group_Feature_Feature]
GO
ALTER TABLE [dbo].[Group_Feature]  WITH CHECK ADD  CONSTRAINT [FK_Group_Feature_Group] FOREIGN KEY([gid])
REFERENCES [dbo].[Group] ([gid])
GO
ALTER TABLE [dbo].[Group_Feature] CHECK CONSTRAINT [FK_Group_Feature_Group]
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Transaction_Book] FOREIGN KEY([bid])
REFERENCES [dbo].[Book] ([bid])
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_Book]
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Transaction_User] FOREIGN KEY([username])
REFERENCES [dbo].[User] ([username])
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_User]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Group] FOREIGN KEY([gid])
REFERENCES [dbo].[Group] ([gid])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Group]
GO
USE [master]
GO
ALTER DATABASE [LibraryDB] SET  READ_WRITE 
GO
