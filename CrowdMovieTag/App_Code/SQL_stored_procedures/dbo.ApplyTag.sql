--Copyright (C) 2014	Steve Black

CREATE PROCEDURE [dbo].[ApplyTag](
	@TagID BIGINT,
	@SubmitterID NVARCHAR(128),
	@MovieID INT
	)
AS
BEGIN
IF (SELECT COUNT(ID) FROM [TagApplications]
	WHERE TagID = @TagID
	AND MovieID = @MovieID) = 0
	BEGIN
		INSERT INTO [dbo].[TagApplications](
			[TagID],
			[SubmitterID],
--			[tagged_datetime],
			[MovieID],
			[Score]
			)
		VALUES (
			@TagID,
			@SubmitterID,
--			GETUTCDATE(),
			@MovieID,
			1
			)
		BEGIN
			UPDATE [Profiles]
			SET AvatarScore += 5
			WHERE ProfileID = @SubmitterID
		END
		EXEC [UpdateAvatar] @ProfileID = @SubmitterID
	END
END