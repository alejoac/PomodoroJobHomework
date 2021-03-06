﻿/*
Deployment script for ScioDb_Workstation

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "ScioDb_Workstation"
:setvar DefaultFilePrefix "ScioDb_Workstation"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL11.SQL2012\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL11.SQL2012\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Rename refactoring operation with key ab534a76-e68d-49b6-a160-79a3d7d298af is skipped, element [dbo].[Users].[Id] (SqlSimpleColumn) will not be renamed to UserId';


GO
PRINT N'Rename refactoring operation with key b2305502-021d-4108-ade6-3bac611aa5b0 is skipped, element [dbo].[Tasks].[Id] (SqlSimpleColumn) will not be renamed to TaskId';


GO
PRINT N'Rename refactoring operation with key 681edb66-25d3-464c-b531-f0508153b7e7 is skipped, element [dbo].[Tasks].[TaskCompleted] (SqlSimpleColumn) will not be renamed to TaskIsCompleted';


GO
PRINT N'Creating [dbo].[Tasks]...';


GO
CREATE TABLE [dbo].[Tasks] (
    [TaskId]          INT           NOT NULL,
    [TaskName]        VARCHAR (50)  NOT NULL,
    [TaskDescription] VARCHAR (250) NULL,
    [TaskIsCompleted] BIT           NULL,
    [TaskIsDiscarded] BIT           NULL,
    [CreatedDate]     DATETIME      NULL,
    [CompletedDate]   DATETIME      NULL,
    [UserId]          INT           NOT NULL,
    CONSTRAINT [PK_Tasks] PRIMARY KEY CLUSTERED ([TaskId] ASC)
);


GO
PRINT N'Creating [dbo].[tUsers]...';


GO
CREATE TABLE [dbo].[tUsers] (
    [UserId]     INT          NOT NULL,
    [FirstName]  VARCHAR (30) NOT NULL,
    [MiddleName] VARCHAR (30) NULL,
    [LastName]   VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([UserId] ASC)
);


GO
PRINT N'Creating [dbo].[FK_tUsers_tTasks]...';


GO
ALTER TABLE [dbo].[Tasks] WITH NOCHECK
    ADD CONSTRAINT [FK_tUsers_tTasks] FOREIGN KEY ([UserId]) REFERENCES [dbo].[tUsers] ([UserId]);


GO
-- Refactoring step to update target server with deployed transaction logs
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'ab534a76-e68d-49b6-a160-79a3d7d298af')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('ab534a76-e68d-49b6-a160-79a3d7d298af')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'b2305502-021d-4108-ade6-3bac611aa5b0')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('b2305502-021d-4108-ade6-3bac611aa5b0')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '681edb66-25d3-464c-b531-f0508153b7e7')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('681edb66-25d3-464c-b531-f0508153b7e7')

GO

GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Tasks] WITH CHECK CHECK CONSTRAINT [FK_tUsers_tTasks];


GO
PRINT N'Update complete.';


GO
