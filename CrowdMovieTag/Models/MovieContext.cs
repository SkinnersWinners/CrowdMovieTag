using System;
using System.Data.Entity;

namespace CrowdMovieTag.Models
{
	public class MovieContext : DbContext
	{
		public MovieContext() : base("CrowdMovieTag")
		{
		
		}
		public DbSet<Profile> Profiles { get; set; }
		public DbSet<Movie> Movies { get; set; }
		
		public DbSet<Tag> Tags { get; set; }
		public DbSet<TagApplication> TagApplications { get; set; }

		public DbSet<Vote> Votes { get; set; }

	}
}