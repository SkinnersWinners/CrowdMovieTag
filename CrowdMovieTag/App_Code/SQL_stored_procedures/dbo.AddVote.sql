--Copyright (C) 2014	Steve Black

CREATE PROCEDURE [dbo].[AddVote](
	@is_upvote BIT,
	@user_id INT,
	@tag_app_voted_on BIGINT
	)
AS
BEGIN
IF (SELECT COUNT(vote_id) FROM [Vote]
	WHERE user_id = @user_id
	AND tag_app_voted_on = @tag_app_voted_on) = 0
	BEGIN
		PRINT N'This is a new vote!'
		INSERT INTO [dbo].[Vote](
			[is_upvote],
			[user_id],
			[tag_app_voted_on],
			[vote_datetime]
			)
		VALUES (
			@is_upvote,
			@user_id,
			@tag_app_voted_on,
			GETUTCDATE()
			)
	END
ELSE
	BEGIN
		PRINT N'This vote already exists!'
	END
END