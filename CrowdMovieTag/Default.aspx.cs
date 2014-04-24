using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CrowdMovieTag
{
	public partial class _Default : Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

		}

		public void TagSearch_Click(object sender, EventArgs e)
		{
			string userText = Server.UrlEncode(TagSearchTextBox.Text);
			Response.Redirect("~/ShowAllMovies?search=" + userText);
		}

	}
}