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
		public int ID { get; set; }

		[Required, StringLength(128)]
		public string SubmitterID { get; set; }

		[Required]
		public int TagID { get; set; }
		public virtual Tag Tag { get; set; }

		[Required]
		public int MovieID { get; set; }
		public virtual Movie Movie { get; set; }

		// A cached version of a computed score, mainly so we can
		// See it in the tables
		public int Score { get; set; }

	}
}