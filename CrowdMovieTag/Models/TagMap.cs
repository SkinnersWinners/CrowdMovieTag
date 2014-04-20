using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CrowdMovieTag.Models
{
	public class TagMap
	{
		[ScaffoldColumn(false)]
		[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
		public int ID { get; set; }
	
		[Required]
		public int TagID { get; set; }

		public virtual Tag Tag { get; set; }
		
		[Required]
		public int MovieID { get; set; }

		public virtual Movie Movie { get; set; }

		[Required]
		public int Score { get; set; }
	}
}