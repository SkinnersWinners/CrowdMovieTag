--Copyright (C) 2014	Steve Black

CREATE PROCEDURE [dbo].[AddProfile](
	@FirstName NVARCHAR(50),
	@LastName NVARCHAR(50),
	@Email NVARCHAR(254),
	@UserName NVARCHAR(20),
	@PassWord NVARCHAR(20), 
	@IsAdmin BIT
	)
AS
BEGIN
IF ((SELECT COUNT(UserName) FROM [Profiles] WHERE UserName = @UserName) = 0
		AND (SELECT COUNT(Email) FROM [Profiles] WHERE Email = @Email) = 0)
	BEGIN
		PRINT N'This is a new user!'
		DECLARE @AvatarID TINYINT
		IF @IsAdmin = 1
			BEGIN
				SET @AvatarID = 5
			END
		ELSE
			BEGIN
				SET @AvatarID = 1
			END
		INSERT INTO [dbo].[User](
			[FirstName],
			[LastName],
			[Email],
			[UserName],
			[PassWord],
			[IsAdmin],
			[CreatedDateTime],
			[AvatarID]
			)
		VALUES (
			@FirstName,
			@LastName,
			@Email, 
			@UserName, 
			@PassWord,
			@IsAdmin,
			GETUTCDATE(),
			@AvatarID
			)
	END
ELSE
	BEGIN
		PRINT N'This user already exists!'
	END
END