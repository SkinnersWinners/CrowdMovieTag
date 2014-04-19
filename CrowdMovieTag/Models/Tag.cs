using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace CrowdMovieTag.Models
{
	public class Tag
	{
		[ScaffoldColumn(false), Range(0, Int64.MaxValue)]
		public int TagID { get; set; }

		public int TagTypeEnumID { get; set; }

		[Required, StringLength(50), Display(Name = "Tag Name")]
		public string Label { get; set; }

		[Required]
		public DateTime CreatedDateTime { get; set; }

		[Required, Range(0, Int32.MaxValue)]
		public int SubmitterID { get; set; }

		[Range(0, Int32.MaxValue)]
		public int? ApproverID { get; set; }

		[Required, Range(0, Int16.MaxValue)]
		public int ApprovalStatusEnumID { get; set; }

	}
}