using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data;
using System.Data.Entity;

namespace CrowdMovieTag.Models
{
	public class Movie
	{
		[DatabaseGenerated(DatabaseGeneratedOption.Identity)] 
		public int MovieID { get; set; }

		//[Required]
		public DateTime DateAdded { get; set; } 

		[Required, StringLength(255)]
		public string Title { get; set; }

		[Required, Range(1000,10000)]
		public int Year { get; set; }

		[StringLength(1000)]
		public string Description { get; set; }

		[StringLength(100)]
		public string Director { get; set; }

		[Required, StringLength(128), ForeignKey("Submitter")]
		public string SubmitterID { get; set; }
		public virtual Profile Submitter { get; set; }


		public virtual ICollection<TagApplication> TagApplications { get; set; }
	}
}