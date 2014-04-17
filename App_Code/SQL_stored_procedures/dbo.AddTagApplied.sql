--Copyright (C) 2014	Steve Black

CREATE PROCEDURE [dbo].[AddTagApplied](
	@tag_id BIGINT,
	@user_id INT,
	@movie_tagged_id INT
	)
AS
BEGIN
IF (SELECT COUNT(tag_applied_id) FROM [Tag_applied]
	WHERE tag_id = @tag_id
	AND movie_tagged_id = @movie_tagged_id) = 0
	BEGIN
		PRINT N'This is a new movie-tag combination!'
		INSERT INTO [dbo].[Tag_applied](
			[tag_id],
			[user_id],
			[tagged_datetime],
			[movie_tagged_id]
			)
		VALUES (
			@tag_id,
			@user_id,
			GETUTCDATE(),
			@movie_tagged_id
			)
	END
ELSE
	BEGIN
		PRINT N'This tag has already been applied to that movie!'
	END
END