DECLARE @IsUpvote BIT, @TagApplicationID INT
DECLARE myCursor CURSOR
LOCAL SCROLL STATIC
FOR
SELECT IsUpvote, TagApplicationID FROM Votes
OPEN myCursor
FETCH NEXT FROM myCursor
	INTO @IsUpvote, @TagApplicationID
	IF (@IsUpvote = 1)
		BEGIN
			UPDATE TagApplications
			SET Score += 1
			WHERE TagApplications.ID = @TagApplicationID 
		END
	ELSE
		BEGIN
			UPDATE TagApplications
			SET Score -= 1
			WHERE TagApplications.ID = @TagApplicationID
		END
WHILE @@FETCH_STATUS = 0
BEGIN
	FETCH NEXT FROM myCursor
	INTO @IsUpvote, @TagApplicationID
	IF (@IsUpvote = 1)
		BEGIN
			UPDATE TagApplications
			SET Score += 1
			WHERE TagApplications.ID = @TagApplicationID 
		END
	ELSE
		BEGIN
			UPDATE TagApplications
			SET Score -= 1
			WHERE TagApplications.ID = @TagApplicationID
		END
END
CLOSE myCursor
DEALLOCATE myCursor