using System;
using System.IO;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using CrowdMovieTag.Models;
using System.Data.Entity;

namespace CrowdMovieTag.Models
{
	public enum ProfileRewardAction
	{
		AddMovie = 1,
		AddOrApplyCrowdTag = 2,
		VoteForCrowdTag = 3
	}

	public enum ProfileAvatars
	{
		Extra = 1,
		SupportingRole = 2,
		MovieStar = 3,
		OscarWinner = 4
	}
}

namespace CrowdMovieTag.Logic
{

	public class MovieResultClass
	{
		public int MovieID { get; set; }
		public Decimal Score { get; set; }
	}

	enum MovieActionsSuccessCode
	{
		VoteValueChanged = 1
	}

	enum MovieActionsErrorCode
	{
		UnknownError = -1,
		MovieAlreadyExists = -2,
		TagAlreadyExists = -3,
		TagApplicationAlreadyExists = -4,
		UserOwnsTagApplication = -5,
		UserAlreadyVoted = -6
	}

	public class MovieActions : IDisposable
	{
		private MovieContext _db = new MovieContext();

		public void Dispose()
		{
		//	LoadStoredProcedures(); COMMENT OUT AND EXECUTE ONLY ONCE TRENT
			if (_db != null)
			{
				_db.Dispose();
				_db = null;
			}
		}

		public List<MovieResultClass> SearchForMovies(string submitterID, List<String> tagList)
		{
			//var parameters = new object[] { new SsubmitterID, tagList[0] };
			var query = _db.Database.SqlQuery<MovieResultClass>("dbo.AdvancedSearch @SubmitterID, @Tag1, @Tag2, @Tag3, @Tag4, @Tag5;",
								new SqlParameter("SubmitterID", submitterID),
								new SqlParameter("Tag1", tagList[0]),
								new SqlParameter("Tag2", ""),
								new SqlParameter("Tag3", ""),
								new SqlParameter("Tag4", ""),
								new SqlParameter("Tag5", "")).AsQueryable();
			
			

			return query.ToList();
		}

		public void AddProfileForUserAfterLoginOrRegister(string userID, string userName)
		{
			var profile = _db.Profiles.FirstOrDefault(p => String.Compare(p.ProfileID, userID) == 0);
			if (profile != null) return;

			var newProfile = new Profile()
			{
				ProfileID = userID,
				Username = userName,
				AvatarID = 1,
				DateJoined = DateTime.Now
			};
			
			_db.Profiles.Add(newProfile);
			_db.SaveChanges();
			
		}

		public int CastVoteForTagApp(string submitterID, int tagAppID, bool isUpvote)
		{
			try
			{
				// Check if the user owns this tagapp
				var profile = _db.Profiles.FirstOrDefault(p => String.Compare(p.ProfileID, submitterID) == 0);
				var tagApp = _db.TagApplications.Where(ta => ta.TagApplicationID == tagAppID).FirstOrDefault();

				if (String.Compare(tagApp.SubmitterID, submitterID) == 0)
				{
					return (int)MovieActionsErrorCode.UserOwnsTagApplication;
				}

				var vote = profile.Votes.FirstOrDefault(ta => ta.TagApplicationID == tagAppID);
				
				if (vote != null)
				{
					// check if the user wants to change their vote
					if (vote.IsUpvote != isUpvote)
					{
						vote.IsUpvote = isUpvote;

						// Push the score by two to account for the vote changing.
						tagApp.Score = tagApp.Score + (isUpvote ? 2 : -2);
						
						// Commit Changes
						_db.SaveChanges();
						return (int)MovieActionsSuccessCode.VoteValueChanged;
					}
					else
					{
						return (int)MovieActionsErrorCode.UserAlreadyVoted;
					}
				}			
				
				vote = new Vote
				{
					SubmitterID = submitterID,
					IsUpvote = isUpvote,
					TagApplicationID = tagAppID,
					VotedDateTime = DateTime.Now
				};

				tagApp.Score = tagApp.Score + (isUpvote ? 1: -1);
				UpdateScoreForProfile(profile, ProfileRewardAction.VoteForCrowdTag);

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
		
		public int AddNewTagAndApply(string submitterID, int newTagCategoryID, string newTagName, int movieID)
		{
			var userTag = _db.Tags.SingleOrDefault(t => String.Compare(newTagName.ToLower(), t.Name.ToLower()) == 0);
			if (userTag != null) return (int)MovieActionsErrorCode.TagAlreadyExists;

			userTag = new Tag
			{
				Name = newTagName,
				CategoryID = newTagCategoryID,
 				CreatedDateTime = DateTime.Now,
				SubmitterID = submitterID
			};
			_db.Tags.Add(userTag);
			_db.SaveChanges();

			return ApplyExistingTagToMovie(submitterID, userTag.TagID, movieID);
		}

		public int ApplyExistingTagToMovie(string submitterID, int tagID, int movieID)
		{
			var newTagApplication = new TagApplication
			{
				SubmitterID = submitterID,
				SubmittedDateTime = DateTime.Now,
				MovieID = movieID,
				TagID = tagID,
				Score = 0
			};

			if (_db.TagApplications.FirstOrDefault(ta => (ta.TagID == tagID) && (ta.MovieID == movieID)) != null)
			{
				return (int)MovieActionsErrorCode.TagApplicationAlreadyExists;
			}

			var profile = _db.Profiles.FirstOrDefault(p => String.Compare(p.ProfileID, submitterID) == 0);

			if (profile != null)
			{
				UpdateScoreForProfile(profile, ProfileRewardAction.AddOrApplyCrowdTag);
			}
			
			_db.TagApplications.Add(newTagApplication);
			_db.SaveChanges();
			return 0;
		}

		public int AddNewMovie(string submitterID, string newMovieTitle, int newMovieYear, string newMovieDescription)
		{
			var newMovie = new Movie
			{
				Title = newMovieTitle,
				DateAdded = DateTime.Now,
				Year = newMovieYear,
				Description = newMovieDescription,
				SubmitterID = submitterID
			};

			try 
			{
				// Check if it already exists
				var dbMovie = _db.Movies.SingleOrDefault(m => (String.Compare(m.Title, newMovie.Title) == 0) && m.Year == newMovie.Year);

				if (dbMovie != null) return (int)MovieActionsErrorCode.MovieAlreadyExists;

				_db.Movies.Add(newMovie);

				// Update the profile Score and add the movie to the database
				var profile = _db.Profiles.FirstOrDefault(p => String.Compare(p.ProfileID, submitterID) == 0);
				if (profile != null)
				{
					UpdateScoreForProfile(profile, ProfileRewardAction.AddMovie);
				}
			
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
		 
		public void UpdateScoreForProfile(Profile userProfile, ProfileRewardAction action)
		{
			
			switch (action)
			{
				case ProfileRewardAction.AddMovie:
					userProfile.Score += 10;
					break;
				case ProfileRewardAction.AddOrApplyCrowdTag:
					userProfile.Score += 5;
					break;
				case ProfileRewardAction.VoteForCrowdTag:
					userProfile.Score += 1;
					break;
				default:
					break;
			}

			if (userProfile.Score < 250)
			{
				userProfile.AvatarID = (int)ProfileAvatars.Extra;
			}
			else if (userProfile.Score >= 250 && userProfile.Score < 500)
			{
				userProfile.AvatarID = (int)ProfileAvatars.SupportingRole;
			}
			else if (userProfile.Score >= 500 && userProfile.Score < 1000)
			{
				userProfile.AvatarID = (int)ProfileAvatars.MovieStar;
			}
			else if (userProfile.Score >= 1000)
			{
				userProfile.AvatarID = (int)ProfileAvatars.OscarWinner;
			}
			else
			{
				userProfile.AvatarID = (int)ProfileAvatars.Extra;
			}
		}

		public List<Tag> GetTagsForCategoryID(int categoryID)
		{
			return _db.Tags.Where(t => t.CategoryID == categoryID).ToList();
		}

		public void LoadStoredProcedures()
		{
			// Execute our stored procedures:
			var path = HttpContext.Current.Server.MapPath("~/App_Code/SQL_stored_procedures");
			var sqlFiles = Directory.GetFiles(path, "dbo.*.sql").OrderBy(s => s);
			foreach (string fileName in sqlFiles)
			{
				string sqlCode = File.ReadAllText(fileName);
				_db.Database.ExecuteSqlCommand(sqlCode);
			}
		}
	}
}