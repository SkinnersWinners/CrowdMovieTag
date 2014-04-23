using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CrowdMovieTag.Models
{
	public class TagFromQuery
	{
		public int TagApplicationID { get; set; }

		public string TagName { get; set; }

		public string TagCategoryName { get; set; }

		public int Score { get; set; }

		public static string GetStringForEnumValue(int value)
		{
			//if (value < 0 || value >= TagTypeStringValues.Count) return null;

			return "THIS NEEDS REVIEW: TagFromQuery.cs:22";
		}
	}
}