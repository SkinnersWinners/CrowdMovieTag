using System;
using System.Collections.Generic;
using System.Data.Entity;

namespace CrowdMovieTag.Models
{
	public class MovieDatabaseInitializer : CreateDatabaseIfNotExists<MovieContext>
	{
		protected override void Seed(MovieContext context)
		{
			var profiles = GetProfiles();
			var movies = GetMovies(profiles);
			var tags = GetTags(profiles);
			var tagApps = GetTagApplications(profiles, movies, tags);
			var votes = GetVotes(profiles, tagApps);


			profiles.ForEach(p => context.Profiles.Add(p));
			movies.ForEach(m => context.Movies.Add(m));
			tags.ForEach(t => context.Tags.Add(t));
			tagApps.ForEach(ta => context.TagApplications.Add(ta));
			votes.ForEach(v => context.Votes.Add(v));
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
				new Profile	
				{
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

		private static List<Movie> GetMovies(List<Profile> profiles)
		{
			var titles = new List<String>(new string[] {
				"Star Wars: Return of the Jedi","The Hobbit", "The Lord of The Rings: The Two Towers", "Buffy the Vampire Slayer", "Safe House", "The Lion King", "Spiderman", "The Avengers", "Iron Man"
			});

			var movies = new List<Movie> {
				new Movie
				{
					Title = "The Shawshank Redemption",
					Year = 1994,
					Description = "Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency."
				}
			};

			foreach (var title in titles)
			{
				movies.Add(new Movie
				{
					Title = title,
					Year = 1992,
					Description = "Default Description"
				});
			}

			// Assign a submitter ID to all the movies
			int profileIndex = 0;
			int profileCount = profiles.Count;
			foreach (var movie in movies)
			{
				movie.SubmitterID = profiles[profileIndex].ProfileID;
				profileIndex = (profileIndex + 1) % profileCount;
			}

			return movies;
		}

		private static List<Tag> GetTags(List<Profile> profiles)
		{
			var genreLabels = new List<String>(new string[] {
				"Action","Drama", "Comedy", "Romance", "Adventure", "Crime", "Faction", "Fantasy", "Sci-Fi"
			});

			var elementLabels = new List<String>(new string[] {
				"Awesomeness", "Terror", "Awe", "GoodPhotography"
			});

			var tags = new List<Tag>();
			foreach (var label in genreLabels)
			{
				tags.Add(new Tag
				{
					TagTypeEnumID = (int)TagTypeEnum.Genre,
					Label = label
				});
			}

			foreach (var label in elementLabels)
			{
				tags.Add(new Tag
				{
					TagTypeEnumID = (int)TagTypeEnum.Element,
					Label = label
				});
			}


			int profileIndex = 0;
			foreach (var tag in tags)
			{
				tag.SubmitterID = profiles[profileIndex].ProfileID;
				tag.CreatedDateTime = DateTime.Now;
				tag.ApprovalStatusEnumID = profileIndex % 2;
				profileIndex = (profileIndex + 1) % profiles.Count;
			}

			return tags;
		}

		private static List<TagApplication> GetTagApplications(List<Profile> profiles, List<Movie> movies, List<Tag> tags)
		{
			int profileIndex = 0;
			int movieIndex = 0;
			int tagIndex = 0;

			var tagApps = new List<TagApplication>();

			for (int ii = 0; ii < tags.Count*3; ++ii)
			{
				tagApps.Add(new TagApplication
				{
					SubmitterID = profiles[profileIndex].ProfileID,
					TagID		= tags[tagIndex].TagID,
					Tag			= tags[tagIndex],
					MovieID		= movies[movieIndex].MovieID,
					Movie		= movies[movieIndex],
					Score		= 0
				});

				profileIndex = (profileIndex + 1) % profiles.Count;
				movieIndex = (movieIndex + 1) % movies.Count;
				tagIndex = (tagIndex + 1) % tags.Count;
			}
			return tagApps;
		}

		private static List<Vote> GetVotes(List<Profile> profiles, List<TagApplication> tagApps)
		{
			int profileIndex = 0;
			int upVoteCount = 0;
			bool isUpVote = true;

			var votes = new List<Vote>();

			foreach (var tagApp in tagApps)
			{
				if (profiles[profileIndex].ProfileID == tagApp.SubmitterID)
				{
					profileIndex = (profileIndex + 1) % profiles.Count;
				}
				
				votes.Add(new Vote
				{
					SubmitterID = profiles[profileIndex].ProfileID,
					IsUpvote = isUpVote,
					TagApplicationID = tagApp.ID,
					TagApplication = tagApp
				});

				upVoteCount = (upVoteCount + 1) % 3;
				if (upVoteCount == 0) isUpVote = !isUpVote;
				
				profileIndex = (profileIndex + 1) % profiles.Count;
			}

			return votes;
		}
	}
}