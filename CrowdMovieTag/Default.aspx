<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CrowdMovieTag._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server" >
<!------------- BACKGROUND GRAPHIC ----------------------->
    <div style="background-image: url('/Images/CrowdTagMovieTheater.png'); background-size:100%; height: 650px; width: 975px; margin-top:0px; background-repeat: no-repeat;">
        <div class="form-group" style="position:relative; top: 370px; left: 40px;">
            
			<asp:TextBox 
					CssClass="form-control" 
					ID="TagSearchTextBox" 
					placeholder="Quick Search: Enter a single tag..." 
					runat="server"></asp:TextBox> 
				<asp:RequiredFieldValidator ID="RequiredFieldValidator2" 
					runat="server"
					CssClass="validator" 
					Text="* Tag name is required" 
					ControlToValidate="TagSearchTextBox" 
					SetFocusOnError="true" 
					Display="Dynamic"
					></asp:RequiredFieldValidator>
				<asp:RegularExpressionValidator 
						ID="RegexValidator1" runat="server" 
						Display="Dynamic"
						CssClass="validator"
						Text="* Name must not contain spaces or special characters" 
						ControlToValidate="TagSearchTextBox" 
						ValidationExpression="^[A-Z\-a-z0-9_]+$"
						></asp:RegularExpressionValidator>
			
				<asp:Button CssClass="btn btn-primary" 
					CausesValidation="true" 
					Text="Search"
					runat="server" 
					 OnClick="TagSearch_Click" />        
        </div>
    </div>

<br />
<br />

<!-------------------- QUOTE ----------------------------->
     <blockquote>
        <p>“Alone we can do so little; together we can do so much"</p>
        <small>Helen Keller</small>
     </blockquote>

<!------------ ELEMENTS START HERE ----------------------->
    <div class="row">
        <div class="col-md-4">
            <h2>Earn Profile Points</h2>
            <p>Add Movies, add CrowdTags, and vote on existing CrowdTags, to earn Profile Points!</p>
            <p><a class="btn btn-default" runat="server" href="~/RewardsPoints">Profile Points &raquo;</a></p>
        </div>

        <div class="col-md-4">
            <h2>Become a Tagging Guru</h2>
            <p>Learn how to assign tags what will provide more efficient power to the CrowdTag engine.</p>
            <p><a class="btn btn-default" runat="server" href="~/About">Tagging School &raquo;</a></p>
        </div>
        
        <div class="col-md-4">
            <h2>Advanced Searching</h2>
            <p>Search for multiple CrowdTags to obtain improved results!</p>
			<p><a class="btn btn-default" runat="server" href="~/AdvancedSearch" style="bottom:0px">Advanced Search &raquo;</a></p>
        </div>
    </div>

<br />
<br />
</asp:Content>
