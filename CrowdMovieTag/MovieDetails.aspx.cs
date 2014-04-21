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

namespace CrowdMovieTag
{
    public partial class individual_Movie : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
			NewTagTypeDropDown.DataBind();
        }

		protected override void OnPreRenderComplete(EventArgs e)
		{
			// Make sure that the TagList GridView Header row actually
			// gets rendered in a <thead> element, and not in the <tbody>
			if (TagsList.Rows.Count > 0)
			{
				TagsList.HeaderRow.TableSection = TableRowSection.TableHeader;
			}
		}

		public void AddNewTag_Click(object sender, EventArgs e)
		{
			int movieID = Convert.ToInt32(Request.QueryString["movieID"]);
			if (movieID == 0) return;

			string newTagName = NewTagNameTextBox.Text;
			TagTypeEnum newTagType = (TagTypeEnum)Convert.ToInt32(NewTagTypeDropDown.SelectedValue);
			
			using (var movieActions = new MovieActions())
			{
				if (!movieActions.IsUserAuthenticated())
				{
					Response.Redirect("~/Account/Login");
					return;
				}
				movieActions.AddNewTagAndApply(User.Identity.GetUserId(), (int)newTagType, newTagName, movieID);
			}
			TagsList.DataBind();
			NewTagTypeDropDown.ClearSelection();
			NewTagNameTextBox.Text = "";
			VoteStatusLabel.Visible = false;
		}

		public string EvaluateTagTypeEnum(int enumValue)
		{
			return TagFromQuery.GetStringForEnumValue(enumValue);
		}

		public void VoteWasClicked(object sender, GridViewCommandEventArgs e)
		{
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
				else
				{
					VoteStatusLabel.Text = "Unable to cast new vote.";
				}
				VoteStatusLabel.Visible = true;
			}
			else
			{
				TagsList.DataBind();
				VoteStatusLabel.Visible = false;
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

		public IQueryable<TagFromQuery> GetTagsForMovie([QueryString("movieID")] int? movieID)
		{
			if (!movieID.HasValue)
			{
				return null;
			}

			var _db = new CrowdMovieTag.Models.MovieContext();
			IQueryable<TagFromQuery> tags = from tagApp in _db.TagApplications
											where tagApp.MovieID == movieID
											orderby tagApp.Score descending
											select new TagFromQuery
											{
												TagID = tagApp.Tag.TagID,
												TagTypeEnumID = tagApp.Tag.TagTypeEnumID,
												Label = tagApp.Tag.Label,
												Score = tagApp.Score
											};

			/*IQueryable<TagFromQuery> tags = from tag in _db.Tags
											from tagApp in _db.Votes
											where (vote.MovieID == movieID) && (tag.TagID == vote.TagID)
											orderby vote.Score descending
											select new TagFromQuery 
											{
												 TagID = tag.TagID,
												 TagTypeEnumID = tag.TagTypeEnumID,
												 Label = tag.Label,
												 Score = vote.Score
											 };*/
			return tags;
		}
    }
}