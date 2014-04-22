--Copyright (C) 2014	Steve Black

CREATE PROCEDURE [dbo].[AddMovie](
	@Title NVARCHAR(255),
	@Description NVARCHAR(500),
	@SubmitterID INT,
	@Year NVARCHAR(4)
	)
AS
BEGIN
DECLARE @year_released_date DATE
SET @year_released_date = CONVERT ( DATE, (@Year + '.01.01'), 102)
IF (SELECT COUNT(MovieID) FROM [Movie]
	WHERE Title = @Title
	AND Year = @Year) = 0
	BEGIN
		INSERT INTO [dbo].[Movie](
			[Title],
			-- [CreatedDateTime],
			[Year],
			[Description],
			[SubmitterID]
			)
		VALUES (
			@Title,
			-- GETUTCDATE(),
			@Year,
			@Description,
			@SubmitterID
			)
	END
	BEGIN
		UPDATE [Profile]
		SET AvatarScore += 10
		WHERE ProfileID = @SubmitterID
	END
	EXEC [UpdateAvatar] @ProfileID = @SubmitterId
END