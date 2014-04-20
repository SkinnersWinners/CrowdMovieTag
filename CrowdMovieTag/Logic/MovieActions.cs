
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using CrowdMovieTag.Models;
using Microsoft.AspNet.Identity;

namespace CrowdMovieTag.Logic
{
	enum MovieActionsErrorCode
	{
		UnknownError = -1,
		MovieAlreadyExists = -2
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

		public void CastVoteForTag(int tagID, bool isUpvote)
		{
			try
			{
				var vote = _db.Votes.Where(tm => tm.TagID == tagID).FirstOrDefault();
				if (vote == null) return;
				
				if (isUpvote)
				{
					vote.Score += 1;
				}
				else
				{
					vote.Score -= 1;
				}
				// Commit the changes to the database
				_db.SaveChanges();

			}
			catch (Exception)
			{
				// Log exception
			}
		}
		
		public void AddNewTag(int newTagType, string newTagName, int movieID)
		{
			var userTag = _db.Tags.SingleOrDefault(t => String.Compare(newTagName.ToLower(), t.Label.ToLower()) == 0);
			if (userTag == null)
			{
				userTag = new Tag
				{
					Label = newTagName,
					TagTypeEnumID = newTagType,
					ApprovalStatusEnumID = (int)ApprovalStatusEnum.Unapproved,
					ApproverID = null,
 					CreatedDateTime = DateTime.Now,
					SubmitterID = HttpContext.Current.User.Identity.GetUserId()
				};
				_db.Tags.Add(userTag);
				_db.SaveChanges();
			}

			var vote = _db.Votes.SingleOrDefault(tm => (tm.MovieID == movieID) && (tm.TagID == userTag.TagID));
			if (vote == null)
			{
				var newVote = new Vote
				{
					MovieID = movieID,
					Movie = _db.Movies.SingleOrDefault(m => m.MovieID == movieID),
					TagID = userTag.TagID,
					Tag = userTag,
					Score = 0
				};

				_db.Votes.Add(newVote);
				_db.SaveChanges();
			}
		}

		public int AddNewMovie(string newMovieTitle, int newMovieYear, string newMovieDescription, string submitterID)
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