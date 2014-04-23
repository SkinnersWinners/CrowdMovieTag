using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using CrowdMovieTag;

namespace CrowdMovieTag.Models
{
	public class Profile
	{
		[StringLength(128)]
		public string ProfileID { get; set; }

		[StringLength(160), DisplayName("Username")]
		public string Username { get; set; }

		[ForeignKey("Avatar")]
		public int AvatarID { get; set; }
		public virtual Avatar Avatar {get; set;}

	
		[Required]
		public int Score { get; set; } // updated with every action a user makes

		[StringLength(100)]
		public string FirstName { get; set; }
		
		[StringLength(100)]
		public string LastName { get; set; }

		[RegularExpression(@"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}",
			ErrorMessage = "Email is is not valid.")]
		[DataType(DataType.EmailAddress)]
		public string Email { get; set; }

		public DateTime DateJoined { get; set; }

		public virtual ICollection<UserSearch>		SearchHistory { get; set; }
		public virtual ICollection<TagApplication>	TagApplications { get; set; }
		public virtual ICollection<Movie>			AddedMovies { get; set; }
		public virtual ICollection<Tag>				AddedTags { get; set; }
		public virtual ICollection<Vote>			Votes { get; set; }

	}
}