using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CrowdMovieTag.Models
{
	public class Vote
	{
		[ScaffoldColumn(false)]
		[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
		public int ID { get; set; }

		[Required, StringLength(128)]
		public string SubmitterID { get; set; }

		[Required]
		public int TagApplicationID { get; set; }
		public virtual TagApplication TagApplication { get; set; }

		[Required]
		public bool IsUpvote { get; set; }

	}
}