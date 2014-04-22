--Copyright (C) 2014	Steve Black

CREATE PROCEDURE [dbo].[AddMovie](
	@Title NVARCHAR(255),
	@Description NVARCHAR(500),
	@SubmitterID NVARCHAR(128),
	@Year INT
	)
AS
BEGIN
--DECLARE @year_released_date DATE
--SET @year_released_date = CONVERT ( DATE, (@Year + '.01.01'), 102)
IF (SELECT COUNT(MovieID) FROM [Movies]
	WHERE Title = @Title
	AND Year = @Year) = 0
	BEGIN
		INSERT INTO [dbo].[Movies](
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
		BEGIN
			UPDATE [Profiles]
			SET AvatarScore += 10
			WHERE ProfileID = @SubmitterID
		END
		EXEC [UpdateAvatar] @ProfileID = @SubmitterId
	END
END