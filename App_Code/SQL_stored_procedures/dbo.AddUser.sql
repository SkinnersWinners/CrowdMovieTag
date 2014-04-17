--Copyright (C) 2014	Steve Black

CREATE PROCEDURE [dbo].[AddUser](
	@first_name NVARCHAR(50),
	@last_name NVARCHAR(50),
	@email NVARCHAR(254),
	@username NVARCHAR(20),
	@password NVARCHAR(20), 
	@is_admin BIT
	)
AS
BEGIN
IF ((SELECT COUNT(username) FROM [User] WHERE username = @username) = 0
		AND (SELECT COUNT(email) FROM [User] WHERE email = @email) = 0)
	BEGIN
		PRINT N'This is a new user!'
		DECLARE @avatar_id TINYINT
		IF @is_admin = 1
			BEGIN
				SET @avatar_id = 5
			END
		ELSE
			BEGIN
				SET @avatar_id = 1
			END
		INSERT INTO [dbo].[User](
			[first_name],
			[last_name],
			[email],
			[username],
			[password],
			[is_admin],
			[created_datetime],
			[avatar_id]
			)
		VALUES (
			@first_name,
			@last_name,
			@email, 
			@username, 
			@password,
			@is_admin,
			GETUTCDATE(),
			@avatar_id
			)
	END
ELSE
	BEGIN
		PRINT N'This user already exists!'
	END
END