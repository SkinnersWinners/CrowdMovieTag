-- This returns 2 tables #TempMovies and #MovieIDs
-- #TempMovies will be used to populate the most recent movies added
-- #MovieIDs will be used to populate the top 5 tags associated with each
-- movie in #TempMovies

CREATE PROCEDURE [dbo].[ProfileRecentMoviesAdded](
	@ProfileID NVARCHAR(128)
	)
AS
BEGIN
	SELECT TOP 20
		MovieID,
		CAST(DateAdded AS DATE) As DateAdded,
		Title,
		Year,
		STUFF((
			SELECT TOP 5 ',' + T.Name
			FROM TagApplications TA
			JOIN Tags T
			ON TA.TagID = T.TagID
			WHERE TA.MovieID = M.MovieID
			ORDER BY TA.Score DESC 
			FOR
				XML PATH('')
					), 1, 1, '')
		AS Top5Tags,
		Description
	FROM Movies M
	WHERE M.SubmitterID = @ProfileID
	ORDER BY M.DateAdded
END