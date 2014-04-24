using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using CrowdMovieTag.Models;
using CrowdMovieTag.Utilities;
using CrowdMovieTag.Logic;

namespace CrowdMovieTag
{
    public partial class All_Movies : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
			
			
			if (!IsPostBack)
			{
				string searchText = Request.QueryString["search"];
				if (searchText != null)
				{
					searchText = Request.QueryString.ToString().Split('=')[1];
					List<string> tagsToSearchOn = searchText.Split('&').ToList();
					var searchCriteria = new List<String>();
					foreach (var tag in tagsToSearchOn)
					{
						searchCriteria.Add(Server.UrlDecode(tag));
					}

					if (searchCriteria.Count > 5)
					{
						SearchedForLabel.Text = "Error: Invalid search, you can only search for 5 tags!";
						SearchResultsLabel.Text = "";
						SearchLabelsPanel.Visible = true;
						return;
					}

					List<MovieResultClass> results;
					using (var movieActions = new MovieActions())
					{
						results = movieActions.SearchForMovies(User.Identity.GetUserId().ToString(), searchCriteria);
					}

					BindDataControls(results, null);
					SearchedForLabel.Text = "Your search for: " + String.Join(", ", searchCriteria);
					SearchResultsLabel.Text = "Returned " + results.Count.ToString() + " results";
					SearchLabelsPanel.Visible = true;
				}
				else
				{
					int magicNumber = 20;
					BindDataControls(null, 20);
					SearchedForLabel.Visible = false;
					SearchResultsLabel.Text = "Showing " + magicNumber.ToString() + " recently added movies";
					SearchLabelsPanel.Visible = true;
				}
			}
        }

		public void BindDataControls(List<MovieResultClass> searchResults, int? magicNumberParameter)
		{
			int magicNumber = (magicNumberParameter == null ? 0: (int)magicNumberParameter);
			using (var db = new MovieContext())
			{
				List<Movie> topMovies = null;
				List<List<String>> topTagNames = new List<List<String>>();
				try
				{
					if (searchResults != null)
					{
						topMovies = new List<Movie>();
						foreach (var result in searchResults)
						{
							var movie = db.Movies.FirstOrDefault(m => m.MovieID == result.MovieID);
							
							if (movie != null) topMovies.Add(movie);
						}
					}
					else
					{
						var movieQuery = (from m in db.Movies
									  orderby m.DateAdded descending
									  select m).Take(magicNumber);
						if (movieQuery != null)
						{
							topMovies = movieQuery.ToList();
						}
					}
					 

					if (topMovies != null && topMovies.Count != 0)
					{
						// For each movie get the top 5 tag names
						foreach (var movie in topMovies)
						{
							var taQuery = (from ta in movie.TagApplications
										   orderby ta.Score descending
										   select ta.Tag.Name).Take(5);
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