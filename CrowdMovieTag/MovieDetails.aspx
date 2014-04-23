<%@ Page Title="Movie Details" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MovieDetails.aspx.cs" Inherits="CrowdMovieTag.individual_Movie"  EnableEventValidation="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	<br />
	<asp:FormView ID="FormView1" ItemType="CrowdMovieTag.Models.Movie" SelectMethod="GetMovie" runat="server" BackColor="Transparent">
		<EmptyDataTemplate>
			<h1>Movie Not Found</h1>
			<p>Did you type the name correctly?</p>		
		</EmptyDataTemplate>
		<ItemTemplate>
			<h1><%#:Item.Title %> (<%#:Item.Year %>)</h1>

			<hr style="margin-top:10px">

			<!-----------------------Movie Description Panel----------------------------->
			<div class="panel panel-default">
				<div class="panel-heading">Movie Description:</div>
				<div class="panel-body">
					<label class="control-label" style="width:100%" id="displayDescription"><%#:Item.Description %></label>
				</div>
			</div>

		</ItemTemplate>
	</asp:FormView>
	  
    <hr style="margin-top:10px" />

	<!-----------------------Tag Panel----------------------------->
	<div class="panel panel-default">
		<div class="panel-heading">
			Tags:
		</div>
		<div class="panel-body">
			<asp:GridView ID="TagsList" ItemType="CrowdMovieTag.Models.TagFromQuery" AutoGenerateColumns="false" 
				SelectMethod="GetTagsForMovie" 
				CssClass="table table-striped table-hover" 
				ShowHeader="true"
				GridLines="None" 
				AllowSorting="true"
				OnRowCommand="VoteWasClicked"
				runat="server">
				<Columns>
					<asp:BoundField HeaderText="Score" DataField="Score" />
					<asp:TemplateField HeaderText="Type">
						<ItemTemplate>
							<%#: Item.TagCategoryName %>
						</ItemTemplate>
					</asp:TemplateField>
					<asp:BoundField HeaderText="Tag" DataField="TagName" />
					<asp:TemplateField HeaderText="Vote">
						<ItemTemplate>
							<asp:Button ID="UpVote" runat="server"
								CommandName="UpVote"
								CommandArgument="<%#: Item.TagApplicationID %>" 
								Text="+1"
								CssClass="btn btn-primary btn-xs btn-success" />
							<asp:Button ID="DownVote" runat="server"
								CommandName="DownVote"
								CommandArgument="<%#: Item.TagApplicationID %>" 
								Text="-1"
								CssClass="btn btn-primary btn-xs btn-danger" />
						</ItemTemplate>
					</asp:TemplateField>
				</Columns>
			</asp:GridView>
			<asp:Label ID="VoteStatusLabel" CssClass="validator" Text="" Visible="false" runat="server"></asp:Label>
		</div>
	</div>

	<!-----------------------Apply Existing Tag to Movie ----------------------------->
	<div class="panel panel-default">
		<div class="panel-heading">
			Apply Existing Tag:
		</div>
		<div class="form-group">
			<label>Category:</label>
				
			<asp:DropDownList runat="server" 
				ID="ddlApplyTagCategory" 
				CssClass="form-control"></asp:DropDownList>
			<asp:RequiredFieldValidator runat="server"
				ControlToValidate="ddlApplyTagCategory"
				SetFocusOnError="true"
				ErrorMessage="You must select a category"
				CssClass="validator"
				Display="Dynamic"
				 ValidationGroup="ExistingTag"></asp:RequiredFieldValidator> 

		</div>
		<div class="form-group">
			<label>Tag:</label>
			<asp:DropDownList runat="server" 
				ID="ddlApplyTagName" 
				CssClass="form-control"></asp:DropDownList>
			<asp:RequiredFieldValidator runat="server"
				ControlToValidate="ddlApplyTagName"
				ErrorMessage="You must select a tag name"
				SetFocusOnError="true"
				CssClass="validator"
				Display="Dynamic"
				ValidationGroup="ExistingTag"></asp:RequiredFieldValidator> 

		</div>
			
		<ajaxToolkit:CascadingDropDown ID="CascadingDropDown1" runat="server" 
				TargetControlID="ddlApplyTagCategory" 
				Category="Category"
				LoadingText="LoadingCategories..." 
				PromptText="Select a Tag Category"
				ServicePath="TagService.asmx"
				ServiceMethod="GetTagCategories"/>

		<ajaxToolkit:CascadingDropDown ID="CascadingDropDown2" runat="server" 
				ParentControlID="ddlApplyTagCategory"
				TargetControlID="ddlApplyTagName" 
				Category="Category"
				LoadingText="LoadingCategories..." 
				PromptText="Select a Tag Name"
				ServicePath="TagService.asmx"
				ServiceMethod="GetTagsForCategory"/>		
			<!-----------------------Buttons----------------------------->
		<div class="form-group">
			<asp:Button CssClass="btn btn-primary" CausesValidation="true"
				Text="Submit"
				runat="server" 
				ValidationGroup="ExistingTag" 
				OnClick="AddExistingTag_Click" />
		
		</div>
		<asp:Label runat="server" ID="ApplyExistingTagStatusLabel" Visible="false" Text="" CssClass="validator"></asp:Label>
	</div>
	
	<!-----------------------Add a New Tag to Movie ----------------------------->
	<div class="panel panel-default">
		<div class="panel-heading">
			Add a New Tag:
		</div>
		<div class="panel-body" style="height:150px">
			<div class="form-group" style="margin-left:0px; margin-top:0px">
				
				<asp:DropDownList runat="server" 
					ID="NewTagDynamicDropDown" 
					CssClass="form-control"></asp:DropDownList>
				<asp:RequiredFieldValidator runat="server"
					ControlToValidate="NewTagDynamicDropDown"
					SetFocusOnError="true"
					ErrorMessage="You must select a category"
					CssClass="validator"
					Display="Dynamic"
					ValidationGroup="NewTag"></asp:RequiredFieldValidator> 
				
			</div>
			<ajaxToolkit:CascadingDropDown ID="CascadingDropDown3" runat="server" 
				TargetControlID="NewTagDynamicDropDown" 
				Category="Category"
				LoadingText="LoadingCategories..." 
				PromptText="Select a Tag Category"
				ServicePath="TagService.asmx"
				ServiceMethod="GetTagCategories"/>

			<div class="form-group" style="margin-top:-54px; margin-left:262px">
				<asp:TextBox 
					CssClass="form-control" 
					ID="NewTagNameTextBox" 
					placeholder="Enter new tag..." 
					runat="server"></asp:TextBox> 
				<asp:RequiredFieldValidator ID="RequiredFieldValidator2" 
					runat="server"
					CssClass="validator" 
					Text="* Tag name is required" 
					ControlToValidate="NewTagNameTextBox" 
					SetFocusOnError="true" 
					Display="Dynamic"
					 ValidationGroup="NewTag" ></asp:RequiredFieldValidator>
				<asp:RegularExpressionValidator 
					ID="RegexValidator1" runat="server" 
					CssClass="validator"
					Text="* Name must not contain spaces or special characters" 
					ControlToValidate="NewTagNameTextBox" 
					ValidationExpression="^[A-Z\-a-z0-9_]+$"
					ValidationGroup="NewTag"></asp:RegularExpressionValidator>
			</div>

			<!-----------------------Buttons----------------------------->
			
			<div class="form-group">
				<asp:Button CssClass="btn btn-primary" 
					CausesValidation="true"
					 ValidationGroup="NewTag" 
					Text="Submit"
					runat="server" 
					OnClick="AddNewTag_Click" />
				<asp:ValidationSummary runat="server" 
					 DisplayMode="BulletList"
					 ValidationGroup="NewTag"
					 CssClass="validator"
					 HeaderText="Form is not complete:" />
			</div>
			<asp:Label runat="server" ID="AddNewTagStatusLabel" Visible="false" Text="" CssClass="validator"></asp:Label>
		</div>
	</div>
  
	<br />
	<br />      

</asp:Content>
