using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace CrowdMovieTag.Models
{
	public class Tag
	{
		[ScaffoldColumn(false), Range(0, Int64.MaxValue)]
		public int tag_id { get; set; }

		public int tag_type_enum_id { get; set; }

		[Required, StringLength(50), Display(Name = "Tag Name")]
		public string label { get; set; }

		[Required]
		public DateTime created_datetime { get; set; }

		[Required, Range(0, Int32.MaxValue)]
		public int submitter_id { get; set; }

		[Range(0, Int32.MaxValue)]
		public int? approver_id { get; set; }

		[Required, Range(0, Int16.MaxValue)]
		public int approval_status_enum_id { get; set; }

	}
}