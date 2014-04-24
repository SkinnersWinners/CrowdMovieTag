using System;
using System.Text.RegularExpressions;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.ModelBinding;
using System.Web.Routing;
using CrowdMovieTag.Models;
using CrowdMovieTag.Logic;
using Microsoft.AspNet.Identity;
using AjaxControlToolkit;

namespace CrowdMovieTag
{
    public partial class individual_Movie : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
			/*
			List<ListItem> tagTypes = new List<ListItem>();
			tagTypes.Add(new ListItem("-- Select One--", "-1"));
			for (int ii = 0; ii < TagFromQuery.TagTypeStringValues.Count; ++ii)
			{
				string text = TagFromQuery.TagTypeStringValues[ii];
				tagTypes.Add(new ListItem(text, ii.ToString()));
			}
			NewTagTypeDropDown.DataTextField = "Text";
			NewTagTypeDropDown.DataValueField = "Value";
			NewTagTypeDropDown.DataSource = tagTypes;
			NewTagTypeDropDown.DataBind();*/
			if (!IsPostBack)
			{
				int movieID = Convert.ToInt32(Request.QueryString["movieID"]);
				
				BindDataControls(movieID);
				
			}

        }

		public void BindDataControls(int movieID)
		{
			using (var db = new MovieContext())
			{
				Movie movie = db.Movies.FirstOrDefault(m => m.MovieID == movieID);
				List<TagApplication> topTagApps = null;
				if (movie != null)
				{
					// Next get the top 5 Tag Applications
					var tagAppQuery =
							   (from tagApp in movie.TagApplications
								orderby tagApp.Score descending
								select tagApp);

					if (tagAppQuery != null)
					{
						topTagApps = tagAppQuery.ToList();
					}
				}

				/*
				List<Tuple<String, TagApplication>> topTagApps =
							(from tagApp in movie.TagApplications
							 orderby tagApp.Score descending
							 select Tuple.Create(
									   GetElapsedTimeAsString(tagApp.SubmittedDateTime),
									   tagApp)).ToList(); */

				//--------- Bind Top Tags ------------//
				// ItemType = Tuple<Movie, Pair(TagName), int(Score))
				if (topTagApps == null || topTagApps.Count == 0)
				{
					TagsList.Visible = false;
					lblNoTagsForMovie.Visible = true;
				}
				else
				{
					var bindingValues = new List<Tuple<Pair, TagApplication>>();
					foreach (var tagApp in topTagApps)
					{
						string lastVoteString;
						if (tagApp.Votes.Count < 1)
						{
							lastVoteString = "Never";
						}
						else
						{
							DateTime lastVoteTime = (from v in tagApp.Votes
													 orderby v.VotedDateTime descending
													 select v.VotedDateTime).FirstOrDefault();
							lastVoteString = GetElapsedTimeAsString(lastVoteTime);
						}

						bindingValues.Add(Tuple.Create(
							new Pair(
								GetElapsedTimeAsString(tagApp.SubmittedDateTime),
								lastVoteString
							),
							tagApp)
						);
					}

					TagsList.Visible = true;
					lblNoTagsForMovie.Visible = false;
					TagsList.DataSource = bindingValues;
					TagsList.DataBind();

					// Make sure that the TagList GridView Header row actually
					// gets rendered in a <thead> element, and not in the <tbody>
					TagsList.HeaderRow.TableSection = TableRowSection.TableHeader;
				
				}
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
	
		public void ClearStatusLabels()
		{
			ApplyExistingTagStatusLabel.Visible = false;
			AddNewTagStatusLabel.Visible = false;
			VoteStatusLabel.Visible = false;
		}

		public void ClearAllFields()
		{
			NewTagNameTextBox.Text = "";
			NewTagDynamicDropDown.ClearSelection();
			ddlApplyTagCategory.ClearSelection();
			ddlApplyTagName.ClearSelection();
		}

		public void AddExistingTag_Click(object sender, EventArgs e)
		{
			ClearStatusLabels();
			int result;
			int movieID = 0;
			try
			{
				movieID = Convert.ToInt32(Request.QueryString["movieID"]);
				if (movieID == 0) return;

			
				int tagCategoryID = Convert.ToInt32(ddlApplyTagCategory.SelectedValue);
				int tagID =			Convert.ToInt32(ddlApplyTagName.SelectedValue);
				

				using (var movieActions = new MovieActions())
				{
					if (!movieActions.IsUserAuthenticated())
					{
						Response.Redirect("~/Account/Login");
						return;
					}
					result = movieActions.ApplyExistingTagToMovie(User.Identity.GetUserId().ToString(), tagID, movieID);
				}
			}
			catch (Exception)
			{
				result = -1000; // trigger the if statement below
			}

			if (result < 0)
			{
				if (result == (int)Logic.MovieActionsErrorCode.TagApplicationAlreadyExists)
				{
					ApplyExistingTagStatusLabel.Text = "That tag is already applied to this movie!";
				}
				else
				{
					ApplyExistingTagStatusLabel.Text = "Unable to Add New Tag.";
				}
			}
			else
			{
				BindDataControls(movieID);
				ClearAllFields();
				ApplyExistingTagStatusLabel.Text = "Applied tag successfully!";
			}
			ApplyExistingTagStatusLabel.Visible = true;
		}

		public void AddNewTag_Click(object sender, EventArgs e)
		{
			ClearStatusLabels();
			int result;
			int movieID = 0;
			try
			{
				movieID = Convert.ToInt32(Request.QueryString["movieID"]);
				if (movieID == 0) return;

				string newTagName = NewTagNameTextBox.Text;
				int newTagType = Convert.ToInt32(NewTagDynamicDropDown.SelectedValue);

				
				using (var movieActions = new MovieActions())
				{
					if (!movieActions.IsUserAuthenticated())
					{
						Response.Redirect("~/Account/Login");
						return;
					}
					result = movieActions.AddNewTagAndApply(User.Identity.GetUserId(), newTagType, newTagName, movieID);
				}	
			}
			catch (Exception)
			{
				AddNewTagStatusLabel.Text = "Unable to Add New Tag.";
				AddNewTagStatusLabel.Visible = true;
				return;
			}

			if (result < 0)
			{
				if (result == (int)Logic.MovieActionsErrorCode.TagAlreadyExists)
				{
					AddNewTagStatusLabel.Text = "A tag with that name already exists!";
				}
				else 
				{
					AddNewTagStatusLabel.Text = "Unable to Add New Tag.";
				}
			}
			else
			{
				BindDataControls(movieID);
				ClearAllFields();
				AddNewTagStatusLabel.Text = "Added tag successfully!";
			}
			AddNewTagStatusLabel.Visible = true;
		}

		public void VoteWasClicked(object sender, GridViewCommandEventArgs e)
		{
			ClearStatusLabels();
			bool isUpVote = false;
			int tagID = Convert.ToInt32(e.CommandArgument);
			if (tagID == 0) return;

			if (e.CommandName == "UpVote")
			{
				isUpVote = true;
			}
			else if (e.CommandName == "DownVote")
			{
				isUpVote = false;
			}
			else
			{
				return;
			}
			int result;
			// Execute query to upvote here.
			using (var movieActions = new MovieActions())
			{
				if (!movieActions.IsUserAuthenticated())
				{
					Response.Redirect("~/Account/Login");
					return;
				}
				else
				{
					
					result = movieActions.CastVoteForTagApp(User.Identity.GetUserId(), tagID, isUpVote);
				}
			}
			
			if (result < 0)
			{
				if (result == (int)MovieActionsErrorCode.UserAlreadyVoted)
				{
					VoteStatusLabel.Text = "You have already voted on that tag.";
				}
				else if (result == (int)MovieActionsErrorCode.UserOwnsTagApplication)
				{
					VoteStatusLabel.Text = "You cannot vote on your own tag!";
				}
				else
				{
					VoteStatusLabel.Text = "Unable to cast new vote.";
				}
			}
			else
			{
				if (result == (int)MovieActionsSuccessCode.VoteValueChanged)
				{
					VoteStatusLabel.Text = "Your vote has been changed.";
				}
				else
				{
					VoteStatusLabel.Text = "Vote submitted successfully!";
				}
				int movieID = Convert.ToInt32(Request.QueryString["movieID"]);
				BindDataControls(movieID);
			}
			VoteStatusLabel.Visible = true;
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

		public IQueryable<TagCategory> GetTagCategories()
		{
			return new CrowdMovieTag.Models.MovieContext().TagCategories.AsQueryable();
		}

		public IEnumerable<TagFromQuery> GetTagsForMovie([QueryString("movieID")] int? movieID)
		{
			if (!movieID.HasValue)
			{
				return null;
			}

			var _db = new CrowdMovieTag.Models.MovieContext();

				
				

			ICollection<TagApplication> tagApps = _db.Movies.FirstOrDefault(m => m.MovieID == movieID).TagApplications;
			
			

			var queryTags =
												(from t in tagApps
												 where true
												 orderby t.Score descending
												 select new TagFromQuery
												 {
														TagApplicationID = t.TagApplicationID,
														TagName = t.Tag.Name,
														TagCategoryName = t.Tag.Category.Name,
														Score = t.Score
													});
			
			/*IQueryable<TagFromQuery> tags = from tagApp in _db.TagApplications
											where tagApp.MovieID == movieID
											orderby tagApp.Score descending
											select new TagFromQuery
											{
												TagID = tagApp.Tag.TagID,
												TagTypeEnumID = tagApp.Tag.CategoryID,
												Label = tagApp.Tag.Name,
												Score = tagApp.Score
											}; */

			return queryTags;
		}

	}
}