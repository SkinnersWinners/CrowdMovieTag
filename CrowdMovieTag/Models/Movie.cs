using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CrowdMovieTag.Models
{
	public class Movie
	{
		[ScaffoldColumn(false)]
		[DatabaseGenerated(DatabaseGeneratedOption.Identity)] 
		public int MovieID { get; set; }

		[Required, StringLength(100), Display(Name = "Title")]
		public string Title { get; set; }

		[Required, Range(1000,10000), Display(Name = "Year")]
		public int Year { get; set; }

		[Required, StringLength(10000), Display(Name = "Movie Description")]
		public string Description { get; set; }

		[Required, StringLength(128)]
		public string SubmitterID { get; set; }

/*		[DisplayName("Movie Poster URL"), StringLength(1024)]
		public string MoviePosterURL { get; set; } */
	}
}