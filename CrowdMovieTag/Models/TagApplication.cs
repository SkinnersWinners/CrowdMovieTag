using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CrowdMovieTag.Models
{
	public class TagApplication
	{
		[Required, Key]
		[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
		public int TagApplicationID { get; set; }

		// Updated every time a vote is cast
		[Required]
		public int Score { get; set; }

		[Required]
		public DateTime SubmittedDateTime { get; set; }

		[Required]
		public int MovieID { get; set; }
		public virtual Movie Movie { get; set; }

		//[Required]
		public int TagID { get; set; }
		public virtual Tag Tag { get; set; }

		[StringLength(128), ForeignKey("Submitter")]
		public string SubmitterID { get; set; }
		public virtual Profile Submitter { get; set; }

		public virtual ICollection<Vote> Votes { get; set; }

	}
}