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
			Profile profile;
			List<List<String>> topTagNames = new List<List<String>>();
			List<Movie> topMovies;
			List<Tuple<String, TagApplication>> topTagApps;
			//List<Tuple<bool, String, String>> topVotes;
			List<Vote> topVotes;
			
			profile = db.Profiles.FirstOrDefault(p => String.Compare(p.Username, username) == 0);
			// Next get the top 5 movies from that profile
			topMovies = (from m in profile.AddedMovies
							orderby m.DateAdded descending
							select m).Take(magicNumber).ToList();

				
			// For each movie get the top 5 tag names
			foreach (var movie in topMovies)
			{
				topTagNames.Add((from ta in movie.TagApplications
								orderby ta.Score descending
								select ta.Tag.Name).Take(magicNumber).ToList());
			}

			// Next get the top 5 Tag Applications
			topTagApps = (from ta in profile.TagApplications
								orderby ta.SubmittedDateTime descending
									select Tuple.Create(
									GetElapsedTimeAsString(ta.SubmittedDateTime),
									ta)
									).Take(magicNumber).ToList();

			// Next get the top 5 Votes
			topVotes = (from vote in profile.Votes
							orderby vote.VotedDateTime descending
							select vote).Take(magicNumber).ToList();

			
			/*
			select Tuple.Create(
									vote.IsUpvote,
									vote.TagApplication.Tag.Name,
									vote.TagApplication.Movie.Title
								)*/
			List<Tuple<Pair, Movie>> bindingValues = new List<Tuple<Pair, Movie>>();

			for (int ii = 0; ii < topMovies.Count; ++ii)
			{
				string tagString = topTagNames[ii].FirstOrDefault();
				foreach (var name in topTagNames[ii])
				{
					tagString += ", " + name;
				}
				string timestamp = GetElapsedTimeAsString(topMovies[ii].DateAdded);
				bindingValues.Add(Tuple.Create( new Pair(timestamp, tagString), topMovies[ii]));
			}


			//--------- Bind Recent Movies ------------//
			if (bindingValues.Count == 0)
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
			if (topTagApps.Count == 0)
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

			if (topVotes.Count == 0)
			{
				RecentVotesRepeater.Visible = false;
				lblNoVotesCast.Visible = true;
			}
			else
			{
				var votesBindingValues = new List<Tuple<String, Vote>>();
				
				foreach (var vote in topVotes)
				{
					string timestamp = GetElapsedTimeAsString(vote.VotedDateTime);
					votesBindingValues.Add(Tuple.Create(timestamp, vote));
				}

				RecentVotesRepeater.Visible = true;
				lblNoVotesCast.Visible = false;
				RecentVotesRepeater.DataSource = votesBindingValues;
				RecentVotesRepeater.DataBind();
			}
		}

		public string GetElapsedTimeAsString(DateTime time)
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