using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using CrowdMovieTag;

namespace CrowdMovieTag.Models
{
	public class Profile
	{
		[ScaffoldColumn(false), Required, StringLength(128)]
		public string ProfileID { get; set; }

		[StringLength(160), DisplayName("Username")]
		public string Username { get; set; }

		[Required]
		public int AvatarID { get; set; }

		[DisplayName("First Name")]
		[StringLength(160)]
		public string FirstName { get; set; }

		[DisplayName("Last Name")]
		[StringLength(160)]
		public string LastName { get; set; }

		[DisplayName("Email Address")]
		[RegularExpression(@"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}",
			ErrorMessage = "Email is is not valid.")]
		[DataType(DataType.EmailAddress)]
		public string Email { get; set; }

		[DisplayName("Member Since")]
		public DateTime DateJoined { get; set; }

	}
}