--Copyright (C) 2014	Steve Black

CREATE PROCEDURE [dbo].[UpdateAvatar](
	@user_id INT
	)
AS
BEGIN
	IF ((SELECT is_admin FROM [User] WHERE user_id = @user_id) = 0)
		DECLARE @avatar_score INT, @current_avatar_id TINYINT, @new_avatar_id TINYINT
		SET @current_avatar_id = (SELECT avatar_id FROM [User] WHERE user_id = @user_id)
		SET @avatar_score =
			(
				(SELECT COUNT(movie_id) FROM [Movie] WHERE submitter_id = @user_id) * 5
				+
				(SELECT COUNT(tag_id) FROM [Tag] WHERE submitter_id = @user_id) * 4
				+
				(SELECT COUNT(tag_applied_id) FROM [Tag_applied] WHERE user_id = @user_id) * 2
				+
				(SELECT COUNT(vote_id) FROM [Vote] WHERE user_id = @user_id)
			)

		IF (@avatar_score >= 90) 
			SET @new_avatar_id = 4
		ELSE IF (@avatar_score >= 65)
			SET @new_avatar_id = 3
		ELSE IF (@avatar_score >= 40)
			SET @new_avatar_id = 2
		ELSE
			SET @new_avatar_id = 1

		IF (@new_avatar_id <> @current_avatar_id)
			BEGIN
				UPDATE [User]
				SET avatar_id = @new_avatar_id
			END
	ELSE
		PRINT N'User is an admin. No avatar change.'
END