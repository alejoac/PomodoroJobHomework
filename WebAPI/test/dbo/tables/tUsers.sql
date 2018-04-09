CREATE TABLE [dbo].[Users]
(
	[UserId] INT IDENTITY (1, 1)  NOT NULL , 
    [FirstName] VARCHAR(30) NOT NULL, 
    [MiddleName] VARCHAR(30) NULL, 
    [LastName] VARCHAR(50) NOT NULL,
	CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([UserId] ASC)
)
