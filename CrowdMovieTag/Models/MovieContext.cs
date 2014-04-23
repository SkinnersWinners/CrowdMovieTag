using System;
using System.Data.Entity;
using System.Data.Entity.ModelConfiguration.Conventions;

namespace CrowdMovieTag.Models
{
	public class MovieContext : DbContext
	{
		public MovieContext()
			: base("CrowdMovieTag")
		{

		}

		public DbSet<Avatar>			Avatars { get; set; }
		public DbSet<Profile>			Profiles { get; set; }
		public DbSet<Movie>				Movies { get; set; }
		public DbSet<TagCategory>		TagCategories { get; set; }
		public DbSet<Tag>				Tags { get; set; }
		
		public DbSet<TagApplication>	TagApplications { get; set; }
		public DbSet<Vote>				Votes { get; set; }

		public DbSet<UserSearch>		Searches { get; set; }


		protected override void OnModelCreating(DbModelBuilder modelBuilder)
		{
			modelBuilder.Conventions.Remove<OneToManyCascadeDeleteConvention>();
			/*modelBuilder.Entity<Profile>()
				.HasRequired(p => p.TagApplications)
				.WithMany()
				.WillCascadeOnDelete(false);

			modelBuilder.Entity<Movie>()
				.HasRequired(m => m.TagApplications)
				.WithMany()
				.WillCascadeOnDelete(false);

			modelBuilder.Entity<Profile>()
				.HasRequired(p => p.Votes)
				.WithMany()
				.WillCascadeOnDelete(false);

			modelBuilder.Entity<TagApplication>()
				.HasRequired(ta => ta.Votes)
				.WithMany()
				.WillCascadeOnDelete(false);
			*/


		}
	}
}