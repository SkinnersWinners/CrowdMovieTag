--Copyright (C) 2014	Steve Black

CREATE PROCEDURE [dbo].[UpdateAvatar](
	@ProfileID NVARCHAR(128)
	)
AS
BEGIN
	DECLARE @AvatarScore INT, @CurrentAvatarID INT, @NewAvatarID INT
	SELECT @AvatarScore = AvatarScore, @CurrentAvatarID = AvatarID
	FROM [Profiles]
	WHERE ProfileID = @ProfileID
	IF (@AvatarScore >= 1000)
		SET @NewAvatarID = 4
	ELSE IF (@AvatarScore >= 500)
		SET @NewAvatarID = 3
	ELSE IF (@AvatarScore >= 250)
		SET @NewAvatarID = 2
	ELSE
		SET @NewAvatarID = 1
	
	IF (@NewAvatarID <> @CurrentAvatarID)
	BEGIN
		UPDATE [Profiles]
		SET AvatarID = @NewAvatarID
		WHERE ProfileID = @ProfileID
	END
END