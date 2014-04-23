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
        }

		protected override void OnPreRenderComplete(EventArgs e)
		{
			// Make sure that the TagList GridView Header row actually
			// gets rendered in a <thead> element, and not in the <tbody>
			if (TagsList.Rows.Count > 0)
			{
				TagsList.HeaderRow.TableSection = TableRowSection.TableHeader;
			}
			base.OnPreRenderComplete(e);
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
			try
			{
				int movieID = Convert.ToInt32(Request.QueryString["movieID"]);
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
				if (result == (int)Logic.MovieActionsErrorCode.TagAlreadyExists)
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
				TagsList.DataBind();
				ClearAllFields();
				ApplyExistingTagStatusLabel.Text = "Applied tag successfully!";
			}
			ApplyExistingTagStatusLabel.Visible = true;
		}

		public void AddNewTag_Click(object sender, EventArgs e)
		{
			ClearStatusLabels();
			int result;
			try
			{
				int movieID = Convert.ToInt32(Request.QueryString["movieID"]);
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
				TagsList.DataBind();
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
				VoteStatusLabel.Visible = true;
			}
			else
			{
				if (result == (int)MovieActionsSuccessCode.VoteValueChanged)
				{
					VoteStatusLabel.Text = "Your vote has been changed.";
					VoteStatusLabel.Visible = true;
				}
				TagsList.DataBind();
			}
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