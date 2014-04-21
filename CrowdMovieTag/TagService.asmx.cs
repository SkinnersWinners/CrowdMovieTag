using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Web;
using System.Web.Services;
using AjaxControlToolkit;
using CrowdMovieTag.Logic;
using CrowdMovieTag.Models;

namespace CrowdMovieTag
{
	/// <summary>
	/// Summary description for WebService1
	/// </summary>
	[WebService(Namespace = "http://tempuri.org/")]
	[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
	[System.ComponentModel.ToolboxItem(false)]
	// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
	[System.Web.Script.Services.ScriptService]
	public class TagService : System.Web.Services.WebService
	{
		[WebMethod]
		public string HelloWorld()
		{
			return "Hello World";
		}

		[WebMethod]
		public CascadingDropDownNameValue[] GetTagCategories(string knownCategoryValues, string category)
		{
			List<String> categoryNames = TagFromQuery.TagTypeStringValues;
			List<CascadingDropDownNameValue> values = new List<CascadingDropDownNameValue>();
			for (int ii = 0; ii < categoryNames.Count; ++ii)
			{
				values.Add(new CascadingDropDownNameValue(categoryNames[ii], ii.ToString()));
			}
			return values.ToArray();
		}

		[WebMethod]
		public CascadingDropDownNameValue[] GetTagsForCategory(string knownCategoryValues, string category)
		{
			//Get the dictionary of known category/value pairs
			StringDictionary knownCategoryValuesDictionary = CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues);
			
			// Validate the input
			int categoryID;
			if (!knownCategoryValuesDictionary.ContainsKey("Category") || 
				!Int32.TryParse(knownCategoryValuesDictionary["Category"], out categoryID))
			{
				return null;
			}
			var tagTypeValues  = Enum.GetValues(typeof(TagTypeEnum)).Cast<TagTypeEnum>();

			if (categoryID < (int)tagTypeValues.Min() || categoryID > (int)tagTypeValues.Max())
			{
				return null;
			}

			// Retreive the tags from the database
			List<Tag> tagsInCategory;
			using (var movieActions = new MovieActions())
			{
				tagsInCategory = movieActions.GetTagsForCategoryID(categoryID);
			}

			// Return the values
			List<CascadingDropDownNameValue> values = new List<CascadingDropDownNameValue>();
			foreach (Tag tag in tagsInCategory)
			{
				values.Add(new CascadingDropDownNameValue(tag.Label, tag.TagID.ToString()));
			}
			return values.ToArray();
		}

		

	}
}
