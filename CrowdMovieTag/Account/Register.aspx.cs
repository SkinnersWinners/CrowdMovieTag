using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using CrowdMovieTag.Models;

namespace CrowdMovieTag.Account
{
    public partial class Register : Page
    {
        protected void CreateUser_Click(object sender, EventArgs e)
        {
            var manager = new UserManager();
            var user = new ApplicationUser() { UserName = UserName.Text };
            IdentityResult result = manager.Create(user, Password.Text);
            if (result.Succeeded)
            {
                IdentityHelper.SignIn(manager, user, isPersistent: false);
				// showes Added: Create an entry in the Profiles table for this user
				var newProfile = new Profile()
				{
					ProfileID = user.Id,
					Username = user.UserName,
					AvatarID = 0,
					FirstName = null,
					LastName = null,
					Email = null,
					DateJoined = DateTime.Now
				};
				using (MovieContext _db = new MovieContext())
				{
					_db.Profiles.Add(newProfile);
					_db.SaveChanges();
				}

                IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
            }
            else 
            {
                ErrorMessage.Text = result.Errors.FirstOrDefault();
            }
        }
    }
}