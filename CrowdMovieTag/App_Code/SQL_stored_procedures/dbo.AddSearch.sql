--Copyright (C) 2014	Steve Black

CREATE PROCEDURE [dbo].[AddSearch](
	@submitter_id int,
	@tag_1 bigint,
	@tag_2 bigint,
	@tag_3 bigint,
	@tag_4 bigint,
	@tag_5 bigint
	)
AS
BEGIN
	PRINT N'Adding search!'
	INSERT INTO [dbo].[Search](
		[submitter_id],
		[tag_1],
		[tag_2],
		[tag_3],
		[tag_4],
		[tag_5],
		[submitted_datetime]
		)
	VALUES (
		@submitter_id,
		@tag_1,
		@tag_2,
		@tag_3,
		@tag_4,
		@tag_5,
		GETUTCDATE()
		)
END