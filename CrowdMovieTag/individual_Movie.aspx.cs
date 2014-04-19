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
    public partial class individual_Movie : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

		public IQueryable<Movie> GetMovie([QueryString("movieID")] int? movieID)
		{
			if (!movieID.HasValue)
			{
				return null;
			}

			var _db = new CrowdMovieTag.Models.MovieContext();
			IQueryable<Movie> query = _db.Movies.Where(m => m.MovieID == movieID);
			return query;
		}

		public IQueryable<Tag> GetTagsForMovie([QueryString("movieID")] int? movieID)
		{
			if (!movieID.HasValue)
			{
				return null;
			}

			var _db = new CrowdMovieTag.Models.MovieContext();
			IQueryable<Tag> tags = from tag in _db.Tags
								   from tagMap in _db.TagMaps
								   where (tagMap.MovieID == movieID) && (tag.TagID == tagMap.TagID)
								   select tag;
			return tags;
		}
    }
}