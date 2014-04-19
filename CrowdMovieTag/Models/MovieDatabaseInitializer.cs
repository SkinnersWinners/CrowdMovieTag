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