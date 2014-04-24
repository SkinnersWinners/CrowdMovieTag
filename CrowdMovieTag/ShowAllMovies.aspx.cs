using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CrowdMovieTag.Models;
using CrowdMovieTag.Utilities;

namespace CrowdMovieTag
{
    public partial class All_Movies : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
			BindDataControls();
        }

		public void BindDataControls()
		{
			using (var db = new MovieContext())
			{
				int magicNumber = 20;
				List<Movie> topMovies = null;
				List<List<String>> topTagNames = new List<List<String>>();
				try
				{
					var movieQuery = (from m in db.Movies
									  orderby m.DateAdded descending
									  select m).Take(magicNumber);

					if (movieQuery != null)
					{
						topMovies = movieQuery.ToList();
						// For each movie get the top 5 tag names
						foreach (var movie in topMovies)
						{
							var taQuery = (from ta in movie.TagApplications
										   orderby ta.Score descending
										   select ta.Tag.Name).Take(magicNumber);
							if (taQuery != null)
							{
								topTagNames.Add(taQuery.ToList());
							}
						}
					}
				}
				catch (Exception)
				{
					// catch any null reference exceptions
				}

				List<Tuple<Pair, Movie>> bindingValues = new List<Tuple<Pair, Movie>>();
				if (topMovies != null)
				{
					for (int ii = 0; ii < topMovies.Count; ++ii)
					{
						string tagString = String.Join(", ", topTagNames[ii]);
						string timestamp = ControllerUtilities.GetElapsedTimeAsString(topMovies[ii].DateAdded);
						bindingValues.Add(Tuple.Create(new Pair(timestamp, tagString), topMovies[ii]));
					}
				}
				//--------- Bind Recent Movies ------------//
				if (topMovies == null || bindingValues.Count == 0)
				{
					MoviesListRepeater.Visible = false;
					lblNoMoviesAdded.Visible = true;
				}
				else
				{
					MoviesListRepeater.Visible = true;
					lblNoMoviesAdded.Visible = false;
					MoviesListRepeater.DataSource = bindingValues;
					MoviesListRepeater.DataBind();
				}

			}
		}

    }
}