--Copyright (C) 2014	Steve Black

CREATE PROCEDURE [dbo].[AddSearch](
	@SubmitterID NVARCHAR(128),
	@Tag1 BIGINT,
	@Tag2 BIGINT,
	@Tag3 BIGINT,
	@Tag4 BIGINT,
	@Tag5 BIGINT
	)
AS
BEGIN
	PRINT N'Adding search!'
	INSERT INTO [dbo].[Search](
		[SubmitterID],
		[Tag1],
		[Tag2],
		[Tag3],
		[Tag4],
		[Tag5],
		[SubmittedDateTime]
		)
	VALUES (
		@SubmitterID,
		@Tag1,
		@Tag2,
		@Tag3,
		@Tag4,
		@Tag5,
		GETUTCDATE()
		)
END