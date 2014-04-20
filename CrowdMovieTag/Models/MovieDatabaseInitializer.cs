using System;
using System.Collections.Generic;
using System.Data.Entity;

namespace CrowdMovieTag.Models
{
	public class MovieDatabaseInitializer : DropCreateDatabaseIfModelChanges<MovieContext>
	{
		protected override void Seed(MovieContext context)
		{
			GetProfiles().ForEach(p => context.Profiles.Add(p));
			GetMovies().ForEach(m => context.Movies.Add(m));
			GetTags().ForEach(t => context.Tags.Add(t));
			GetTagMaps().ForEach(tm => context.TagMaps.Add(tm));
		}

		private static List<Movie> GetMovies()
		{
			var movies = new List<Movie> {
				new Movie
				{
					MovieID = 1,
					Title = "The Shawshank Redemption",
					Year = 1994,
					Description = "Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency."
				}
			};
			return movies;
		}

		private static List<Tag> GetTags()
		{
			var tags = new List<Tag> {
				new Tag
				{
					TagID = 1,
					TagTypeEnumID = 0,
					ApprovalStatusEnumID = 0,
					ApproverID = null,
					CreatedDateTime = DateTime.Now,
					SubmitterID = 10,
					Label = "Awesome"
				}
			};
			return tags;
		}

		private static List<Profile> GetProfiles()
		{
			var profiles = new List<Profile> {
				new Profile
				{
					ProfileID = Guid.NewGuid().ToString(),
					Username = "showes",
					AvatarID = 2,
					FirstName = "Sam",
					LastName = "Howes",
					Email = "showes06@gmail.com",
					DateJoined = DateTime.Now
				},
				new Profile	{
					ProfileID = Guid.NewGuid().ToString(),
					Username = "tmerrell",
					AvatarID = 1,
					FirstName = "Trent",
					LastName = "Merrell",
					Email = "trent.merrell@gmail.com",
					DateJoined = DateTime.Now
				}
			};

			return profiles;
		}

		private static List<TagMap> GetTagMaps()
		{
			var tagMaps = new List<TagMap> {
				new TagMap
				{
					ID = 1,
					TagID = 1,
					MovieID = 1 
				}
			};
			return tagMaps;
		}
	}
}