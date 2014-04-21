using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using CrowdMovieTag.Models;

namespace CrowdMovieTag.Logic
{
	enum MovieActionsErrorCode
	{
		UnknownError = -1,
		MovieAlreadyExists = -2,
		TagAlreadyExists = -3,
		UserOwnsTagApplication = -4,
		UserAlreadyVoted = -5
	}

	public class MovieActions : IDisposable
	{
		private MovieContext _db = new MovieContext();

		public void Dispose()
		{
			if (_db != null)
			{
				_db.Dispose();
				_db = null;
			}
		}

		public int CastVoteForTagApp(string submitterID, int tagAppID, bool isUpvote)
		{
			try
			{
				// Check if the user has already voted for this tagapp
				var vote = _db.Votes.FirstOrDefault(v => String.Compare(v.SubmitterID, submitterID) == 0);

				if (vote != null) return (int)MovieActionsErrorCode.UserAlreadyVoted;

				vote = new Vote
				{
					SubmitterID = submitterID,
					IsUpvote = isUpvote,
					TagApplicationID = tagAppID,
					TagApplication = _db.TagApplications.Where(ta => ta.ID == tagAppID).FirstOrDefault()
				};
				// Add the new vote and commit
				_db.Votes.Add(vote);
				_db.SaveChanges();

			}
			catch (Exception)
			{
				// Log exception
			}
			return 0;
		}
		
		public int AddNewTagAndApply(string submitterID, int newTagType, string newTagName, int movieID)
		{
			var userTag = _db.Tags.SingleOrDefault(t => String.Compare(newTagName.ToLower(), t.Label.ToLower()) == 0);
			if (userTag != null) return (int)MovieActionsErrorCode.TagAlreadyExists;

			userTag = new Tag
			{
				Label = newTagName,
				TagTypeEnumID = newTagType,
				ApprovalStatusEnumID = (int)ApprovalStatusEnum.Unapproved,
 				CreatedDateTime = DateTime.Now,
				SubmitterID = submitterID
			};

			_db.Tags.Add(userTag);
			_db.SaveChanges();

			var newTagApplication = new TagApplication
			{
				SubmitterID = submitterID,
				MovieID = movieID,
				Movie = _db.Movies.SingleOrDefault(m => m.MovieID == movieID),
				TagID = userTag.TagID,
				Tag = userTag,
				Score = 0
			};

			_db.TagApplications.Add(newTagApplication);
			_db.SaveChanges();
			return 0;
		}

		public int AddNewMovie(string submitterID, string newMovieTitle, int newMovieYear, string newMovieDescription)
		{
			var newMovie = new Movie
			{
				Title = newMovieTitle,
				Year = newMovieYear,
				Description = newMovieDescription,
				SubmitterID = submitterID
			};

			try 
			{
				// Check if it already exists
				var dbMovie = _db.Movies.SingleOrDefault(m => String.Compare(m.Title, newMovie.Title) == 0);
				
				if (dbMovie != null) return (int)MovieActionsErrorCode.MovieAlreadyExists;

				// Else, add it to the database
				_db.Movies.Add(newMovie);
				_db.SaveChanges();
			}
			catch (Exception)
			{
				return (int)MovieActionsErrorCode.UnknownError;
			}

			return newMovie.MovieID; // No error occurred
		}

		public bool IsUserAuthenticated()
		{
			if (!String.IsNullOrWhiteSpace(HttpContext.Current.User.Identity.Name))
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	}
}