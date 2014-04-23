using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CrowdMovieTag.Models
{
	public class Avatar
	{
		[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
		public int AvatarID { get; set; }

		[Required, StringLength(50)]
		public string Name { get; set; }

		[StringLength(500)]
		public string ImageURL { get; set; }

	}
}