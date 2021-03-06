﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.ModelBinding;
using System.Web.Routing;
using CrowdMovieTag.Models;
using CrowdMovieTag.Utilities;

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
					Response.Redirect("UserProfile?username=" + HttpContext.Current.User.Identity.Name);

				}
				else
				{
					Response.Redirect("Account/Login");

				}
				return;
			}


			if (username == HttpContext.Current.User.Identity.Name)
			{
				//ProfileViewForm.FindControl("EditProfileBtn").Visible = true;
				EditProfileBtn.Visible = true;
			}
			using (var db = new MovieContext())
			{
				BindDataControls(username, db);
			}

		}

		public void BindDataControls(string username, MovieContext db)
		{
			// First get the profile
			int magicNumber = 5;
			Profile profile = null;
			List<List<String>> topTagNames = new List<List<String>>();
			List<Movie> topMovies = null;
			List<Tuple<String, TagApplication>> topTagApps = null;
			//List<Tuple<bool, String, String>> topVotes;
			List<Vote> topVotes = null;

			try
			{
				profile = db.Profiles.FirstOrDefault(p => String.Compare(p.Username, username) == 0);

				// Next get the top 5 movies from that profile

				var movieQuery = (from m in profile.AddedMovies
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

				// Next get the top 5 Tag Applications

				var tagAppQuery = (from ta in profile.TagApplications
								   orderby ta.SubmittedDateTime descending
								   select Tuple.Create(
								   ControllerUtilities.GetElapsedTimeAsString(ta.SubmittedDateTime),
								   ta)
										).Take(magicNumber);

				if (tagAppQuery != null)
				{
					topTagApps = tagAppQuery.ToList();
				}

				// Next get the top 5 Votes
				var topVotesQuery = (from vote in profile.Votes
									 orderby vote.VotedDateTime descending
									 select vote).Take(magicNumber);

				if (topVotesQuery != null)
				{
					topVotes = topVotesQuery.ToList();
				}

			}
			catch (Exception)
			{
				// catch any null reference exceptions
			}
			/*
			select Tuple.Create(
									vote.IsUpvote,
									vote.TagApplication.Tag.Name,
									vote.TagApplication.Movie.Title
								)*/
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
				RecentMoviesRepeater.Visible = false;
				lblNoMoviesAdded.Visible = true;
			}
			else
			{
				RecentMoviesRepeater.Visible = true;
				lblNoMoviesAdded.Visible = false;
				RecentMoviesRepeater.DataSource = bindingValues;
				RecentMoviesRepeater.DataBind();
			}
			//--------- Bind Recent Tags ------------//
			// ItemType = Tuple<Movie, Pair(TagName), int(Score))
			if (topTagApps == null || topTagApps.Count == 0)
			{
				RecentTagsRepeater.Visible = false;
				lblNoMoviesTagged.Visible = true;
			}
			else
			{
				RecentTagsRepeater.Visible = true;
				lblNoMoviesTagged.Visible = false;
				RecentTagsRepeater.DataSource = topTagApps;
				RecentTagsRepeater.DataBind();
			}

			//--------- Bind Recent Votes ------------//
			// ItemType = CrowdMovieTag.Models.Vote

			if (topVotes == null || topVotes.Count == 0)
			{
				RecentVotesRepeater.Visible = false;
				lblNoVotesCast.Visible = true;
			}
			else
			{
				var votesBindingValues = new List<Tuple<String, Vote>>();

				foreach (var vote in topVotes)
				{
					string timestamp = ControllerUtilities.GetElapsedTimeAsString(vote.VotedDateTime);
					votesBindingValues.Add(Tuple.Create(timestamp, vote));
				}

				RecentVotesRepeater.Visible = true;
				lblNoVotesCast.Visible = false;
				RecentVotesRepeater.DataSource = votesBindingValues;
				RecentVotesRepeater.DataBind();
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