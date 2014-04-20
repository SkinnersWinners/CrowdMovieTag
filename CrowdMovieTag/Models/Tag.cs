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

	public class Tag
	{
	
		[DatabaseGenerated(DatabaseGeneratedOption.Identity)] 
		[ScaffoldColumn(false)]
		public int TagID { get; set; }

		public int TagTypeEnumID { get; set; }

		[Required, StringLength(50), Display(Name = "Tag Name")]
		public string Label { get; set; }

		[Required]
		public DateTime CreatedDateTime { get; set; }

		//[Required, StringLength(128)]
		public string SubmitterID { get; set; }

		[Range(0, Int32.MaxValue)]
		public int? ApproverID { get; set; }

		[Required, Range(0, Int16.MaxValue)]
		public int ApprovalStatusEnumID { get; set; }
	}
}