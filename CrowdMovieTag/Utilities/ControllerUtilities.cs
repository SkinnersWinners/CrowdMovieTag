using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CrowdMovieTag.Utilities
{
	public class ControllerUtilities
	{
		public static string GetElapsedTimeAsString(DateTime time)
		{
			TimeSpan elapsed = DateTime.Now - time;
			string timestamp;
			string unit = "";
			int number = -1;

			if (elapsed.Days > 30)
			{
				number = (int)Math.Ceiling(elapsed.Days / (365.25 / 12));
				if (number < 12)
				{
					unit = "Month";
				}
				else
				{
					number = number / 12;
					unit = "Year";
				}
				
			}
			else if (elapsed.Days >= 1)
			{
				number = elapsed.Days;
				unit = "Day";
			}
			else if (elapsed.Hours >= 1)
			{
				number = elapsed.Hours;
				unit = "Hour";
			}
			else if (elapsed.Minutes >= 1)
			{
				number = elapsed.Minutes;
				unit = "Minute";
			}

			if (number != -1)
			{
				if (number > 1) unit += "s";
				timestamp = String.Format("{0} {1} ago", number, unit);
			}
			else
			{
				timestamp = "Just Now";
			}
			return timestamp;
		}

	}
}