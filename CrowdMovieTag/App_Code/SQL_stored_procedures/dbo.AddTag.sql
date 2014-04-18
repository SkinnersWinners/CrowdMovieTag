--Copyright (C) 2014	Steve Black

CREATE PROCEDURE [dbo].[AddTag](
	@label NVARCHAR(50),
	@submitter_id INT,
	@tag_type_enum_id INT
	)
AS
BEGIN
IF (SELECT COUNT(tag_id) FROM [Tag]
	WHERE label = @label) = 0
	BEGIN
		PRINT N'This is a new tag!'
		INSERT INTO [dbo].[Tag](
			[label],
			[submitter_id],
			[approver_id],
			[approved_status_enum_id],
			[tag_type_enum_id],
			[created_datetime]
			)
		VALUES (
			@label,
			@submitter_id,
			NULL,
			1,
			@tag_type_enum_id,
			GETUTCDATE()
			)
	END
ELSE
	BEGIN
		PRINT N'This tag already exists!'
	END
END