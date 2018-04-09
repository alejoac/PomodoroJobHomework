CREATE TABLE [dbo].[Tasks]
(
	[TaskId] INT IDENTITY (1, 1)  NOT NULL , 
    [TaskName] VARCHAR(50) NOT NULL, 
    [TaskDescription] VARCHAR(250) NULL, 
    [TaskIsCompleted] BIT NULL DEFAULT ((0)), 
    [TaskIsDiscarded] BIT NULL DEFAULT ((0)), 
    [CreatedDate] DATETIME NULL, 
    [CompletedDate] DATETIME NULL,
	[UserId] INT NOT NULL, 
    CONSTRAINT [PK_Tasks] PRIMARY KEY CLUSTERED ([TaskId] ASC),
	CONSTRAINT [FK_tUsers_tTasks] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])

)
