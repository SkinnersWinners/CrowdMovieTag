--Copyright (C) 2014	Steve Black

CREATE PROCEDURE [dbo].[AddVote](
	@IsUpvote BIT,
	@SubmitterID NVARCHAR(128),
	@TagApplicationID BIGINT
	)
AS
BEGIN
IF (SELECT COUNT(ID) FROM [Votes]
	WHERE SubmitterID = @SubmitterID
	AND TagApplicationID = @TagApplicationID) = 0
	BEGIN
		DECLARE @TagApplicationScore INT
		SET @TagApplicationScore = (
			SELECT Score FROM TagApplications
			WHERE ID = @TagApplicationID)
		IF (@IsUpvote = 1)
			SET @TagApplicationScore += 1
		ELSE
			SET @TagApplicationScore -= 1
		INSERT INTO [dbo].[Votes](
			[IsUpvote],
			[SubmitterID],
			[TagApplicationID]
			-- [VoteDateTime]
			)
		VALUES (
			@IsUpvote,
			@SubmitterID,
			@TagApplicationID
			-- GETUTCDATE()
			)
		BEGIN
			UPDATE [TagApplications]
			SET Score = @TagApplicationScore
		END
		BEGIN	
			UPDATE [Profiles]
			SET AvatarScore += 1
			WHERE ProfileID = @SubmitterID
		END
		EXEC [UpdateAvatar] @ProfileID = @SubmitterID
	END
END