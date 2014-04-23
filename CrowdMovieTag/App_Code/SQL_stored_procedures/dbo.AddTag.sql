--Copyright (C) 2014	Steve Black

CREATE PROCEDURE [dbo].[AddTag](
	@Name NVARCHAR(50),
	@SubmitterID NVARCHAR(128),
	@TagCategory INT
	)
AS
BEGIN
IF (SELECT COUNT(TagID) FROM [Tags]
	WHERE Name = @Name) = 0
	BEGIN
		INSERT INTO [dbo].[Tags](
			[Name],
			[SubmitterID],
			-- [ApproverID],
--			[approved_status_enum_id],
			[TagTypeEnumID],
			[CreatedDateTime]
			)
		VALUES (
			@Name,
			@SubmitterID,
--			NULL,
--			1,
			@TagCategory,
			GETUTCDATE()
			)
		BEGIN
			UPDATE [Profiles]
			SET AvatarScore += 5
			WHERE ProfileID = @SubmitterId
		END
		EXEC [UpdateAvatar] @ProfileID = @SubmitterId
	END
END