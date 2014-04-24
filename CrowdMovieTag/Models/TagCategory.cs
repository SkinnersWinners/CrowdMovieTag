using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CrowdMovieTag.Models
{
	public class TagCategory
	{
		[Key]
		[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
		public int TagCategoryID {get; set;}

		[Required, StringLength(50)]
		public string Name { get; set; }

		[Required, StringLength(50)]
		public string Description { get; set; }

		public virtual ICollection<Tag> Tags { get; set; }
	}
}