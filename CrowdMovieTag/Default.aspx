<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CrowdMovieTag._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server" >
<!------------- BACKGROUND GRAPHIC ----------------------->
    <div style="background-image: url('/Images/CrowdTagMovieTheater.png'); background-size:100%; height: 650px; width: 975px; margin-top:0px; background-repeat: no-repeat;">
        <div class="form-group" style="position:relative; top: 370px; left: 40px;">
            <input type="text" class="form-control" id="quickSearch" placeholder="Quick Search: Enter a single tag...">
            <button type="button" class="btn btn-primary">Search</button>        
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
            <h2>Earn Rewards Points</h2>
            <p>Add Movies, upgrade and/or downgrade tags, complete your profile, to earn CrowdTag Points and one of many prizes!</p>
            <p><a class="btn btn-default" runat="server" href="~/Rewards_Points">Rewards &raquo;</a></p>
        </div>

        <div class="col-md-4">
            <h2>Become a Tagging Guru</h2>
            <p>Learn how to assign tags what will provide more efficient power to the crowdtag engine.</p>
            <p><a class="btn btn-default" runat="server" href="~/About">Tagging School &raquo;</a></p>
        </div>
        
        <div class="col-md-4">
            <h2>Advanced Searching</h2>
            <p>Search for multiple tags to obtain improved results!</p>
			<p><a class="btn btn-default" runat="server" href="~/Advanced_Search" style="bottom:0px">Advanced Search &raquo;</a></p>
        </div>
    </div>

<br />
<br />
</asp:Content>
