using System;
using System.Globalization;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CrowdMovieTag.Models;

namespace CrowdMovieTag.PowerTheEngine
{
	public partial class EditProfile : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
        {
        }

		public IQueryable<Profile> GetProfile()
		{
			string username = HttpContext.Current.User.Identity.Name;
			var _db = new CrowdMovieTag.Models.MovieContext();
			IQueryable<Profile> query = _db.Profiles; 
			query = query.Where(p => String.Compare(p.Username, username) == 0);
			return query;
		}

		public void UpdateProfile_Click(object sender, EventArgs e)
		{
			//LabelUpdateProfileStatus;
			string profileID = ((HiddenField)EditProfileForm.FindControl("HiddenProfileID")).Value;
			string newFirstName = ((TextBox)EditProfileForm.FindControl("FirstName")).Text;
			string newLastName = ((TextBox)EditProfileForm.FindControl("LastName")).Text;
			string newEmail = ((TextBox)EditProfileForm.FindControl("Email")).Text;
			
		
			using (var _db = new MovieContext())
			{

				var profileToUpdate = (from p in _db.Profiles
									   where p.ProfileID == profileID
									   select p).FirstOrDefault();
				
				if (profileToUpdate == null)
				{
					LabelUpdateProfileStatus.Text = "Error while updating profile";
					return;
				}

				profileToUpdate.FirstName = CultureInfo.CurrentUICulture.TextInfo.ToTitleCase(newFirstName); 				
				profileToUpdate.LastName = CultureInfo.CurrentUICulture.TextInfo.ToTitleCase(newLastName);
				profileToUpdate.Email = newEmail;
				
				// profileToUpdate is a reference to an item in the database,
				// so we only need to say "save changes"
				_db.SaveChanges();
			}
			LabelUpdateProfileStatus.Text = "Your profile was updated successfuly!";
		}

	}
}