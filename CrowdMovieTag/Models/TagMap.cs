using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace CrowdMovieTag.Models
{
	public class TagMap
	{
		[ScaffoldColumn(false)]
		public int ID { get; set; }

		public int TagID { get; set; }

		public int MovieID { get; set; }
	}
}