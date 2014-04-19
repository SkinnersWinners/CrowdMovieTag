using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.ModelBinding;
using System.Web.Routing;
using CrowdMovieTag.Models;

namespace CrowdMovieTag
{
    public partial class User_Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
			string username = Request["username"];
			if (String.IsNullOrEmpty(username))
			{
				if (!String.IsNullOrEmpty(HttpContext.Current.User.Identity.Name))
				{
					Response.Redirect("User_Profile?username=" + HttpContext.Current.User.Identity.Name);
				}
				else
				{
					Response.Redirect("ErrorPage");
				}
			}
        }

		public IQueryable<Profile> GetProfile([QueryString("username")] string username)
		{
			if (String.IsNullOrEmpty(username))
			{
				return null;
			}

			var _db = new CrowdMovieTag.Models.MovieContext();
			IQueryable<Profile> query = _db.Profiles;
			query = query.Where(p => String.Compare(p.Username, username) == 0);
			return query;
		}
    }
}