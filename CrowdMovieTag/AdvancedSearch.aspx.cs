using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CrowdMovieTag
{
    public partial class AdvancedSearch : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

		public void Search_Click(object sender, EventArgs e)
		{
			var tagNameBoxes = new List<TextBox> { TextBox1, TextBox2, TextBox3, TextBox4, TextBox5 };
			var searchStrings = new List<String>();
			foreach (var textbox in tagNameBoxes)
			{
				if (textbox.Text != null && textbox.Text.Length > 0)
				{
					searchStrings.Add(Server.UrlEncode(textbox.Text));
				}
			}
			if (searchStrings.Count > 0)
			{
				var queryString = String.Join("&", searchStrings);
				Response.Redirect("~/ShowAllMovies?search=" + queryString);
				return;
			}
			else
			{
				ErrorLabel.Text = "You must enter at least one tag!";
				ErrorLabel.Visible = true;
			}

		}
    }
}