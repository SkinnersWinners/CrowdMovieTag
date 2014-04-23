using System;
using System.Collections;
using System.Collections.Specialized;
using System.IO;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;
using System.Linq;

namespace CrowdMovieTag.Models
{
	public class MovieDatabaseInitializer : DropCreateDatabaseIfModelChanges<MovieContext>
	{
		protected override void Seed(MovieContext context)
		{

			//AddStoredProcedures(context);

			var avatars = GetAvatars();
			avatars.ForEach(a => context.Avatars.Add(a));

			var categories = GetTagCategories();
			categories.ForEach(c => context.TagCategories.Add(c));

			context.SaveChanges(); 
			//------------------------------Save------------------//
			// Avatar and Category IDs are now valid

			var profiles = GetProfiles(avatars);
			profiles.ForEach(p => context.Profiles.Add(p));

			var tags = GetTags(profiles, categories);
			tags.ForEach(t => context.Tags.Add(t));
			context.SaveChanges();

			var movies = GetMovies(profiles);
			movies.ForEach(m => context.Movies.Add(m));
			context.SaveChanges();

			
			//------------------------------Save------------------//
			// TagIDs and Movie IDs are now valid

			var tagApps = GetTagApplications(profiles, movies, tags);
			tagApps.ForEach(ta => context.TagApplications.Add(ta));
			context.SaveChanges();
			//------------------------------Save------------------//
			// TagAppIDs are now valid

			var votes = GetVotes(profiles, tagApps);
			votes.ForEach(v => context.Votes.Add(v));
			context.SaveChanges();
		}

		private static void AddStoredProcedures(MovieContext context)
		{
			var sqlFiles = Directory.GetFiles(AppDomain.CurrentDomain.BaseDirectory, "*.sql").OrderBy(s => s);
			
			foreach (string file in sqlFiles)
			{
				context.Database.ExecuteSqlCommand(File.ReadAllText(file));
			}

			/*context.Database.Connection.Open();
			var command = context.Database.Connection.CreateCommand();
			command.CommandType = System.Data.CommandType.StoredProcedure;*/

		//	var movieID = 10;
		//	var movieTitle = "shawshank redemption";
		//	object[] parameters = new object[] { movieID, movieTitle }; 
		//	Movie movie = context.Movies.SqlQuery("dbo.GetMovie @movieID @movieTitle", parameters).AsQueryable().FirstOrDefault();
		

		}

		// ---------- No dependencies -----------//
		private static List<Avatar> GetAvatars()
		{
			var avatarNames = new List<String>(new string[] {
				"Extra", "Supporting Role", "Movie Star", "Oscar Winner"
			});

			var avatars = new List<Avatar>();
			foreach (var name in avatarNames)
			{
				avatars.Add(new Avatar
				{
					Name = name,
					ImageURL = "~/Images/Avatars/" + name.Replace(" ", "") + ".png"
				});
			}
			return avatars;
		}

		private static List<TagCategory> GetTagCategories()
		{
			List<String> names = new List<String> {
				"General",
				"Genre",
				"Thematic Element",
				"Actor/Actress",
				"Time Period/Era",
				"Location"
			};

			var categories = new List<TagCategory>();
			foreach (var name in names)
			{
				categories.Add(new TagCategory
				{
					Name = name,
					Description = name
				});
			}
			return categories;
		}

		// ---------- Linear Dependence -----------//
		private static List<Profile> GetProfiles(List<Avatar> avatars)
		{
			var userNames = new List<String>(new string[] {
				"Steve Black", "Sam Howes", "Trent Merrell", "Tom Skinner", "Your Mom", "Ari Trachtenberg", "President Obama", "Steve Jobs", "Ashton Kutcher", "Bill Gates", "Tony Stark", "Tony Hawk"
			});

			int avatarIndex = 0;
			var profiles = new List<Profile>();
			foreach (var name in userNames)
			{
				profiles.Add(new Profile
				{
					ProfileID = Guid.NewGuid().ToString(),
					Username = name.Replace(" ", ""),
					FirstName = name.Split(' ')[0],
					LastName = name.Split(' ')[1],
					Email = name[0].ToString() + name.Split(' ')[1] + "@gmail.com",
 					DateJoined = DateTime.Now,
					AvatarID = avatars[avatarIndex].AvatarID,
					Score = 0
				});

				avatarIndex = (avatarIndex + 1) % avatars.Count;
			}

			var check = false;
			if (check)
			{
				throw new Exception("Check the AvatarID! Is it null?");
			}
			return profiles;
			
		}

		private static List<Tag> GetTags(List<Profile> profiles, List<TagCategory> categories)
		{
			var tagNames = new List<String>(new string[] {
				"Action","Drama", "Comedy", "Romance", "Adventure", "Crime", "Faction", "Fantasy", "Sci-Fi", "Awesomeness", "Terror", "Awe", "GoodPhotography"
			});

			int profileIndex = 0;
			var tags = new List<Tag>();
			foreach (var name in tagNames)
			{
				tags.Add(new Tag
				{
					SubmitterID = profiles[profileIndex].ProfileID,
					CategoryID = (int)TagTypeEnum.Genre,
					Name = name,
					CreatedDateTime = DateTime.Now
				});
				profileIndex = (profileIndex + 1) % profiles.Count;
			}
			var check = false;
			if (check)
			{
				throw new Exception("Check the TagID! Is it null?");
			}
			return tags;
		}

		// ---------- Depends on Unsaved Profiles -----------//
		private static List<Movie> GetMovies(List<Profile> profiles)
		{
			var titles = new List<String>(new string[] {
				"Star Wars: Return of the Jedi","The Hobbit", "The Lord of The Rings: The Two Towers", "Buffy the Vampire Slayer", "Safe House", "The Lion King", "Spiderman", "The Avengers", "Iron Man"
			});

			var movies = new List<Movie> {
				new Movie
				{
					Title = "The Shawshank Redemption",
					DateAdded = DateTime.Now,
					Year = 1994,
					Description = "Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency."
				}
			};

			Random rand = new Random();
			foreach (var title in titles)
			{
				int year = rand.Next(1800, 2014);
				movies.Add(new Movie
				{
					Title = title,
					DateAdded = DateTime.Now,
					Year = year,
					Description = "Default Description"
				});
			}

			// Assign a submitterID to all the movies
			int profileIndex = 0;
			foreach (var movie in movies)
			{
				movie.SubmitterID = profiles[profileIndex].ProfileID;
				profileIndex = (profileIndex + 1) % profiles.Count;
			}

			return movies;
		}

		// ---------- Depends on TagID, MovieID and unsaved Profile -----------//
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
					SubmitterID			= profiles[profileIndex].ProfileID,
					Score				= 0,
					SubmittedDateTime	= DateTime.Now,
					TagID				= tags[tagIndex].TagID,
					MovieID				= movies[movieIndex].MovieID
				});

				profileIndex = (profileIndex + 1) % profiles.Count;
				movieIndex = (movieIndex + 1) % movies.Count;
				tagIndex = (tagIndex + 1) % tags.Count;
			}
			return tagApps;
		}

		// ---------- Depends on TagAppID -----------//
		private static List<Vote> GetVotes(List<Profile> profiles, List<TagApplication> tagApps)
		{
			
			var votes = new List<Vote>();

			int currentScore = profiles.Count - 1;
			int increment = 2;

			foreach (var tagApp in tagApps)
			{
				bool isUpVote = true;
				for (int ii = 0; ii < profiles.Count;  ++ii)
				{
					if (ii == currentScore)
					{
						isUpVote = !isUpVote;
					}
					var profile = profiles[ii];
					if (String.Compare(profile.ProfileID, tagApp.SubmitterID) == 0) continue;

					votes.Add(new Vote
					{
						SubmitterID		= profile.ProfileID,
						VotedDateTime	= DateTime.Now,
						IsUpvote		= isUpVote,
						TagApplicationID= tagApp.TagApplicationID,
					});

					tagApp.Score += (isUpVote ? 1 : -1);
				}
				currentScore -= increment;
			}
			return votes;
		}
	}
}