using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CrowdMovieTag.Logic;
using Microsoft.AspNet.Identity;

namespace CrowdMovieTag
{
    public partial class Add_Movie : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

		public void AddMovie_Click(object sender, EventArgs e)
		{
			// Note: This is a restricted page, so we have already authenticated the user
			string newMovieTitle = NewMovieTitleTextBox.Text;
			int newMovieYear = Convert.ToInt32(NewMovieYearTextBox.Text);
			string newMovieDescription = NewMovieDescriptionTextBox.Text;
			int newMovieID = -1;

			using (var movieActions = new MovieActions())
			{
				newMovieID = movieActions.AddNewMovie(User.Identity.GetUserId(), newMovieTitle, newMovieYear, newMovieDescription);
			}

			// if there was an error
			if (newMovieID < 0)
			{
				if (newMovieID == (int)MovieActionsErrorCode.MovieAlreadyExists)
				{
					AddMovieErrorLabel.Text = "Unable to add movie: That Title already exists";
				}
				else
				{
					AddMovieErrorLabel.Text = "We are unable to add that movie. Did you type the correct year?";
				}
				AddMovieErrorLabel.Visible = true;
				return;
			}

			AddMovieErrorLabel.Text = "";
			AddMovieErrorLabel.Visible = false;
			
			// Show the user their new movie page
			Response.Redirect("~/MovieDetails?movieID=" + newMovieID.ToString());
		}
    }
}