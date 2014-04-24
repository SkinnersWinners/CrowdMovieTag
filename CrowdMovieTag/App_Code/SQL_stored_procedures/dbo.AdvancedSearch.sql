-- This SP handles >= 1 tag search request
-- It takes NVARCHAR arguments so that the user can
-- search with free text
-- If we need to search by TagID (say, a user is choosing
-- from a drop-down), that is easily done before calling
-- this procedure, and then we can pass the Name/name
-- of the tag here.
--
-- At this time, this procedure does not call the AddSearch SP
-- because the AddSearch SP takes integer arguments


CREATE PROCEDURE [dbo].[AdvancedSearch](
	@SubmitterID NVARCHAR(128),
	@Tag1 NVARCHAR(128),
	@Tag2 NVARCHAR(128),
	@Tag3 NVARCHAR(128),
	@Tag4 NVARCHAR(128),
	@Tag5 NVARCHAR(128)
	)
AS
BEGIN
	DECLARE @TemporaryResults TABLE(
		MovieID INT,
		Title NVARCHAR(100),
		Year INT,
		NetUpvotes INT,
		TaggedWith NVARCHAR(50)
	)
	
	-- Only Tag1 is submitted, no others	
	IF (@Tag2 IS NULL AND
		@Tag3 IS NULL AND
		@Tag4 IS NULL AND
		@Tag5 IS NULL)
		BEGIN
			INSERT INTO @TemporaryResults
			SELECT M.MovieID, M.Title, M.Year, TA.Score, T.Name
			FROM Movies M
			INNER JOIN TagApplications TA
			ON M.MovieID = TA.MovieID
			INNER JOIN Tags T
			ON TA.TagID = T.TagID
			WHERE T.Name IN (@Tag1)
		END
	-- Only Tag1 and Tag2 are submitted
	ELSE IF (@Tag3 IS NULL AND
			 @Tag4 IS NULL AND
			 @Tag5 IS NULL)
		BEGIN
			INSERT INTO @TemporaryResults
			SELECT M.MovieID, M.Title, M.Year, TA.Score, T.Name
			FROM Movies M
			INNER JOIN TagApplications TA
			ON M.MovieID = TA.MovieID
			INNER JOIN Tags T
			ON TA.TagID = T.TagID
			WHERE T.Name IN (@Tag1, @Tag2)
		END
	-- Only Tag1, Tag2, Tag3 are submitted
	ELSE IF (@Tag4 IS NULL AND
			 @Tag5 IS NULL)
		BEGIN
			INSERT INTO @TemporaryResults
			SELECT M.MovieID, M.Title, M.Year, TA.Score, T.Name
			FROM Movies M
			INNER JOIN TagApplications TA
			ON M.MovieID = TA.MovieID
			INNER JOIN Tags T
			ON TA.TagID = T.TagID
			WHERE T.Name IN (@Tag1, @Tag2, @Tag3)
		END
	-- Only Tag1, Tag2, Tag3, Tag4 are submitted
	ELSE IF (@Tag5 IS NULL)
		BEGIN
			INSERT INTO @TemporaryResults
			SELECT M.MovieID, M.Title, M.Year, TA.Score, T.Name
			FROM Movies M
			INNER JOIN TagApplications TA
			ON M.MovieID = TA.MovieID
			INNER JOIN Tags T
			ON TA.TagID = T.TagID
			WHERE T.Name IN (@Tag1, @Tag2, @Tag3, @Tag4)
		END
	-- All tags are submitted
	ELSE 
		BEGIN
			INSERT INTO @TemporaryResults
			SELECT M.MovieID, M.Title, M.Year, TA.Score, T.Name
			FROM Movies M
			INNER JOIN TagApplications TA
			ON M.MovieID = TA.MovieID
			INNER JOIN Tags T
			ON TA.TagID = T.TagID
			WHERE T.Name IN (@Tag1, @Tag2, @Tag3, @Tag4, @Tag5)
		END

	-- HERE'S THE BREADWINNER!
	-- Return the MovieID, Title, Year and Score
	SELECT	MovieID,
			Title,
			Year,
			NetUpvotes,
			TaggedWith,
			(1 + .5*(1 - 1/CONVERT(DECIMAL(5,3),NetUpvotes))) AS UpvoteTieBreaker
	INTO #TopResultsByNetUpvotes
	FROM @TemporaryResults
	WHERE NetUpvotes > 0
	ORDER BY MovieID

	SELECT MovieID, SUM(UpvoteTieBreaker) AS Score
	FROM #TopResultsByNetUpvotes
	GROUP BY MovieID
	ORDER BY Score DESC
END
