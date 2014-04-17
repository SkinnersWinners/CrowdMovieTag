--Copyright (C) 2014	Steve Black

CREATE PROCEDURE [dbo].[AddMovie](
	@title NVARCHAR(255),
	@description NVARCHAR(500),
	@year_released NVARCHAR(4)
	)
AS
BEGIN
DECLARE @year_released_date DATE
SET @year_released_date = CONVERT ( DATE, (@year_released + '.01.01'), 102)
IF (SELECT COUNT(movie_id) FROM [Movie]
	WHERE title = @title
	AND year_released = @year_released) = 0
	BEGIN
		PRINT N'This is a new movie!'
		INSERT INTO [dbo].[Movie](
			[title],
			[created_datetime],
			[year_released],
			[description]
			)
		VALUES (
			@title,
			GETUTCDATE(),
			@year_released_date,
			@description
			)
	END
ELSE
	BEGIN
		PRINT N'This movie already exists!'
	END
END