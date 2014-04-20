<%@ Page Title="AddMovie" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddMovie.aspx.cs" Inherits="CrowdMovieTag.Add_Movie" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <br />
    <h2>Power the Engine:</h2>
    <br />

 
	<!-----------------------Panel----------------------------->
	<div class="panel panel-default panel-info">
		<div class="panel-heading" style="margin-top:-0px">
			<h3>Add A Movie:</h3>
		</div>
		<div class="panel-body">

			<!-----------------------Enter Title----------------------------->
			<div class="form-group">    
				<label>Title:</label>
				<br />
				<asp:TextBox ID="NewMovieTitleTextBox" runat="server"
					placeholder="Enter Title..."
					CssClass="form-control"
					Width="300"></asp:TextBox>
				<asp:RequiredFieldValidator runat="server"
					ControlToValidate="NewMovieTitleTextBox"
					ErrorMessage="You must enter a title"
					CssClass="validator"
					Display="Dynamic"></asp:RequiredFieldValidator>
			</div>
 
			<!-----------------------Enter Year-----------------------------> 
			<div class="form-group">
				<label>Year Released:</label>
				<br />
				<asp:TextBox ID="NewMovieYearTextBox" runat="server"
					placeholder="Enter Year Released..."
					CssClass="form-control"
					Width="300"></asp:TextBox>
				<asp:RequiredFieldValidator runat="server"
					ControlToValidate="NewMovieYearTextBox"
					ErrorMessage="You must enter a Year"
					CssClass="validator"
					Display="Dynamic"></asp:RequiredFieldValidator>
				<asp:RegularExpressionValidator runat="server"
					ControlToValidate="NewMovieYearTextBox"
					ErrorMessage="Year must be in the format: YYYY"
					ValidationExpression="[0-9]{4}"
					CssClass="validator"
					Display="Dynamic"></asp:RegularExpressionValidator>
			</div>

			<!------------------Enter Description------------------------> 
			<div class="form-group">
				<label>Description:</label>
				<br />
				<asp:TextBox ID="NewMovieDescriptionTextBox" runat="server"
					TextMode="MultiLine"
					placeholder="Enter Movie's Description..."
					CssClass="form-control"
					Width="600px"
					Rows="6"></asp:TextBox>
				<asp:RequiredFieldValidator runat="server"
					ControlToValidate="NewMovieDescriptionTextBox"
					ErrorMessage="You must enter a Description"
					CssClass="validator"
					Display="Dynamic"
					></asp:RequiredFieldValidator>
			</div>

			<!-----------------------Buttons----------------------------->
			<div class="form-group">
				<button class="btn btn-default">Reset</button>
				<asp:Button CssClass="btn btn-primary" CausesValidation="true" Text="Submit" runat="server"
					 OnClick="AddMovie_Click" 	/>
				<asp:ValidationSummary runat="server"
					 ID="ValidationSummary1" 
					 DisplayMode="BulletList"
					 CssClass="validator"
					 HeaderText="Form is not complete:" />
				<br />
				<asp:Label runat="server" 
					ID="AddMovieErrorLabel" 
					Text=""
					Visible="false" 
					CssClass="validator"></asp:Label>
			</div>
  
		</div>
	</div>

	<br />
	<br />
</asp:Content>
