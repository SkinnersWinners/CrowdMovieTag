using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CrowdMovieTag.Models
{
	public class UserSearch
	{
		[Key]
		[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
		public int SearchID { get; set; }

		[ForeignKey("Submitter"), StringLength(128)]
		public string SubmitterID { get; set; }
		public virtual Profile Submitter { get; set; }

		[ForeignKey("Tag1")]
		public int TagID1 { get; set; }
		public virtual Tag Tag1 { get; set; }

		[ForeignKey("Tag2")]
		public int TagID2 { get; set; }
		public virtual Tag Tag2 { get; set; }

		[ForeignKey("Tag3")]
		public int TagID3 { get; set; }
		public virtual Tag Tag3 { get; set; }

		[ForeignKey("Tag4")]
		public int TagID4 { get; set; }
		public virtual Tag Tag4 { get; set; }

		[ForeignKey("Tag5")]
		public int TagID5 { get; set; }
		public virtual Tag Tag5 { get; set; }



	}
}