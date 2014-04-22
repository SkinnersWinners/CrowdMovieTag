using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data;
using System.Data.Entity;

namespace CrowdMovieTag.Models
{
	enum ApprovalStatusEnum
	{
		Unapproved = 0
	}

	enum TagTypeEnum
	{
		General = 0,
		Genre,
		Element,
		ThematicElement,
		Actor_Actress,
		TimePeriod_Era,
		Location
	}

	public class Tag
	{
	
		[DatabaseGenerated(DatabaseGeneratedOption.Identity)] 
		public int TagID { get; set; }

		[Required, StringLength(50), Display(Name = "Tag Name")]
		public string Label { get; set; }

		[ForeignKey("Category")]
		public int CategoryID { get; set; }
		public virtual TagCategory Category { get; set; }

		[Required]
		public DateTime CreatedDateTime { get; set; }

		[Required, StringLength(128), ForeignKey("Submitter")]
		public string SubmitterID { get; set; }
		public virtual Profile Submitter { get; set; }

	}
}