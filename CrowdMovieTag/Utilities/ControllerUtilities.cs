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
			if (elapsed.Days > 30)
			{
				timestamp = String.Format("{0} Months ago", Math.Ceiling(elapsed.Days / (365.25 / 12)));
			}
			else if (elapsed.Days >= 1)
			{
				timestamp = String.Format("{0} Days ago", elapsed.Days);
			}
			else if (elapsed.Hours >= 1)
			{
				timestamp = String.Format("{0} Hours ago", elapsed.Hours);
			}
			else if (elapsed.Minutes >= 1)
			{
				if (elapsed.Minutes == 1)
				{
					timestamp = String.Format("{0} Minute ago", 1);
				}
				else
				{
					timestamp = String.Format("{0} Minutes ago", elapsed.Minutes);
				}
			}
			else
			{
				timestamp = "Just Now";
			}
			return timestamp;
		}

	}
}