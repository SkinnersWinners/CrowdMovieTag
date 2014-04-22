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

		[Required]
		public bool IsUpvote { get; set; }

		[ForeignKey("TagApplication")]
		public int TagApplicationID { get; set; }
		public virtual TagApplication TagApplication {get; set;}


		[ForeignKey("Submitter")]
		public string SubmitterID { get; set; }
		public virtual Profile Submitter { get; set; }

	}
}