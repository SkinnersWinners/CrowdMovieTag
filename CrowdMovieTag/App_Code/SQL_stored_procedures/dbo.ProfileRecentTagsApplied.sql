-- This returns 2 tables #TempMovies and #MovieIDs
-- #TempMovies will be used to populate the most recent movies added
-- #MovieIDs will be used to populate the top 5 tags associated with each
-- movie in #TempMovies

CREATE PROCEDURE [dbo].[ProfileRecentTagsApplied](
	@ProfileID NVARCHAR(128)
	)
AS
BEGIN
	SELECT TOP 20
		M.MovieID,
		M.Title,
		T.Name,
		CAST(TA.SubmittedDateTime AS DATE) As DateApplied,
		TA.Score,
		M.Description
	FROM Movies M
	JOIN TagApplications TA
	ON TA.MovieID = M.MovieID
	JOIN Tags T
	ON T.TagID = TA.TagID
	WHERE M.SubmitterID = @ProfileID
	ORDER BY TA.SubmittedDateTime
END