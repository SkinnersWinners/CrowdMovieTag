--Copyright (C) 2014	Steve Black

CREATE PROCEDURE [dbo].[AddTag](
	@Label NVARCHAR(50),
	@SubmitterID INT,
	@TagCategory INT
	)
AS
BEGIN
IF (SELECT COUNT(tag_id) FROM [Tag]
	WHERE Label = @Label) = 0
	BEGIN
		INSERT INTO [dbo].[Tag](
			[Label],
			[SubmitterID],
			-- [ApproverID],
			[approved_status_enum_id],
			[TagCategory],
			[CreatedDateTime]
			)
		VALUES (
			@Label,
			@SubmitterID,
			NULL,
			1,
			@TagCategory,
			GETUTCDATE()
			)
	END
	BEGIN
		UPDATE [Profile]
		SET AvatarScore += 5
		WHERE ProfileID = @SubmitterId
	END
	EXEC [UpdateAvatar] @ProfileID = @SubmitterId
END