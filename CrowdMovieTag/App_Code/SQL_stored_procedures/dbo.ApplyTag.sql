--Copyright (C) 2014	Steve Black

CREATE PROCEDURE [dbo].[ApplyTag](
	@TagID BIGINT,
	@SubmitterId INT,
	@MovieID INT
	)
AS
BEGIN
IF (SELECT COUNT(ID) FROM [TagApplication]
	WHERE TagID = @TagID
	AND MovieID = @MovieID) = 0
	BEGIN
		INSERT INTO [dbo].[TagApplication](
			[TagID],
			[SubmitterId],
--			[tagged_datetime],
			[MovieID],
			[Score]
			)
		VALUES (
			@TagID,
			@SubmitterId,
--			GETUTCDATE(),
			@MovieID,
			1
			)
	END
	BEGIN
		UPDATE [Profile]
		SET AvatarScore += 3
		WHERE ProfileID = @SubmitterId
	END
	EXEC [UpdateAvatar] @ProfileID = @SubmitterId
END