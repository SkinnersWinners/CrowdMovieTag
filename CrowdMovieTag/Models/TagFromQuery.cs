using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CrowdMovieTag.Models
{
	enum TagTypeEnum
	{
		General =0,
		Genre,
		Element,
		ThematicElement,
		Actor_Actress,
		TimePeriod_Era,
		Location
	}

	public class TagFromQuery
	{
		public int TagID { get; set; }

		public int TagTypeEnumID { get; set; }

		public string Label { get; set; }

		public int Score { get; set; }

		public static List<String> TagTypeStringValues = new List<String> {
				"General",
				"Genre",
				"Thematic Element",
				"Actor/Actress",
				"Time Period/Era",
				"Location"
		};

		public static string GetStringForEnumValue(int value)
		{
			if (value < 0 || value >= TagTypeStringValues.Count) return null;

			return TagTypeStringValues[value];
		}
	}
}