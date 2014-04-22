--Copyright (C) 2014	Steve Black

CREATE PROCEDURE [dbo].[UpdateAvatar](
	@ProfileID INT
	)
AS
BEGIN
	DECLARE @AvatarScore INT, @CurrentAvatarID INT, @NewAvatarID INT
	SELECT @AvatarScore = AvatarScore, @CurrentAvatarID = AvatarID
	FROM [Profile]
	WHERE ProfileID = @ProfileID

	IF (@AvatarScore NOT NULL && @CurrentAvatarID NOT NULL)
	BEGIN
		IF (@AvatarScore >= 800)
			SET @NewAvatarID = 4
		ELSE IF (@AvatarScore >= 400)
			SET @NewAvatarID = 3
		ELSE IF (@AvatarScore >= 200)
			SET @NewAvatarID = 2
		ELSE
			SET @NewAvatarID = 1
		
		IF (@NewAvatarID <> @CurrentAvatarID)
		BEGIN
			UPDATE [Profile]
			SET AvatarID = @NewAvatarID
			WHERE ProfileID = @ProfileID
		END
	END
END