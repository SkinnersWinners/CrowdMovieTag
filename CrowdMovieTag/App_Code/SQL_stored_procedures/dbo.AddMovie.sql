--Copyright (C) 2014	Steve Black

CREATE PROCEDURE [dbo].[AddMovie](
	@Title NVARCHAR(255),
	@Description NVARCHAR(500),
	@SubmitterID NVARCHAR(128),
	@Year INT,
	@DateAdded DATETIME
	)
AS
BEGIN
IF (SELECT COUNT(MovieID) FROM [Movies]
	WHERE Title = @Title
	AND Year = @Year) = 0
	BEGIN
		INSERT INTO [dbo].[Movies](
			[Title],
			[Year],
			[Description],
			[SubmitterID],
			[DateAdded]
			)
		VALUES (
			@Title,
			@Year,
			@Description,
			@SubmitterID,
			GETUTCDATE()
			)
		BEGIN
			UPDATE [Profiles]
			SET AvatarScore += 10
			WHERE ProfileID = @SubmitterID
		END
		EXEC [UpdateAvatar] @ProfileID = @SubmitterId
	END
END