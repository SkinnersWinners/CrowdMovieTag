using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace CrowdMovieTag.Models
{
	public class Movie
	{
		[ScaffoldColumn(false)]
		public int movie_id { get; set; }

		[Required, StringLength(100), Display(Name = "Title")]
		public string title { get; set; }
/*
		[Required, Range(1000,10000), Display(Name = "Year")]
		public int Year { get; set; }

		[Required, StringLength(10000), Display(Name = "Movie Description")]
		public string Description { get; set; }

		[DisplayName("Movie Poster URL"), StringLength(1024)]
		public string MoviePosterURL { get; set; } */
	}
}