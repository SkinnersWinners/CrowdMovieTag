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

		public int Name { get; set; }

		public string ImageURL { get; set; }

	}
}