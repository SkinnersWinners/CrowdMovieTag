
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using CrowdMovieTag.Models;
using Microsoft.AspNet.Identity;

namespace CrowdMovieTag.Models
{
	public class TestClass
	{
		public void getuser()
		{
		
		}
	}
}

namespace CrowdMovieTag.Logic
{
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
				var tagMap = _db.TagMaps.Where(tm => tm.TagID == tagID).FirstOrDefault();
				if (tagMap == null) return;
				
				if (isUpvote)
				{
					tagMap.Score += 1;
				}
				else
				{
					tagMap.Score -= 1;
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

			var tagMap = _db.TagMaps.SingleOrDefault(tm => (tm.MovieID == movieID) && (tm.TagID == userTag.TagID));
			if (tagMap == null)
			{
				var newTagMap = new TagMap
				{
					MovieID = movieID,
					Movie = _db.Movies.SingleOrDefault(m => m.MovieID == movieID),
					TagID = userTag.TagID,
					Tag = userTag,
					Score = 0
				};

				_db.TagMaps.Add(newTagMap);
				_db.SaveChanges();
			}
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