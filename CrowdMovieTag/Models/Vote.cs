using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CrowdMovieTag.Models
{
	public class Vote
	{
		[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
		public int VoteID { get; set; }

		[Required]
		public System.DateTime VotedDateTime { get; set; }

		[Required]
		public bool IsUpvote { get; set; }

		[ForeignKey("TagApplication")]
		public int TagApplicationID { get; set; }
		public virtual TagApplication TagApplication {get; set;}


		[ForeignKey("Submitter"), StringLength(128)]
		public string SubmitterID { get; set; }
		public virtual Profile Submitter { get; set; }

	}
}