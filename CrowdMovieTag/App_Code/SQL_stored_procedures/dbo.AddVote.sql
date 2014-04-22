--Copyright (C) 2014	Steve Black

CREATE PROCEDURE [dbo].[AddVote](
	@IsUpVote BIT,
	@SubmitterId INT,
	@TagApplicationID BIGINT
	)
AS
BEGIN
IF (SELECT COUNT(ID) FROM [Vote]
	WHERE SubmitterId = @SubmitterId
	AND TagApplicationID = @TagApplicationID) = 0
	BEGIN
		DECLARE @TagApplicationScore INT
		SET @TagApplicationScore = (
			SELECT Score FROM TagApplication
			WHERE TagApplication.ID = @TagApplicationID)
		IF (@IsUpVote)
			SET @TagApplicationScore += 1
		ELSE
			SET @TagApplicationScore -= 1
		INSERT INTO [dbo].[Vote](
			[IsUpVote],
			[SubmitterId],
			[TagApplicationID]
			-- [VoteDateTime]
			)
		VALUES (
			@IsUpVote,
			@SubmitterId,
			@TagApplicationID
			-- GETUTCDATE()
			)
		BEGIN
			UPDATE [TagApplication]
			SET Score = @TagApplicationScore
		END
	END
	BEGIN	
		UPDATE [Profile]
		SET AvatarScore += 1
		WHERE ProfileID = @SubmitterId
	END
	EXEC [UpdateAvatar] @ProfileID = @SubmitterId
END