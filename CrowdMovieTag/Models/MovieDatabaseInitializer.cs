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
		}

		private static List<Movie> GetMovies()
		{
			var movies = new List<Movie> {
				new Movie
				{
					MovieID = 0,
					Title = "Shawshank Redemption"
				}
			};
			return movies;
		}

		private static List<Tag> GetTags()
		{
			var tags = new List<Tag> {
				new Tag
				{
					TagID = 0,
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
					Username = "tmerrel",
					AvatarID = 1,
					FirstName = "Trent",
					LastName = "Merrel",
					Email = "tmerrel@gmail.com",
					DateJoined = DateTime.Now
				}
			};

			return profiles;
		}

	}
}