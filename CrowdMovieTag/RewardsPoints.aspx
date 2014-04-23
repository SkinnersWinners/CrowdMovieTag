<%@ Page Title="Rewards Points" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RewardsPoints.aspx.cs" Inherits="CrowdMovieTag.RewardsPoints" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <h2>CrowdTag Profile Points:</h2>
    <h3>Add + CrowdTag + Vote = Awards! </h3>
    <hr />
 
        <!--    ADD MOVIE POINTS  -->
        <div class="panel panel-default" style="width:100%">
            <div class="panel-body">
                <div style="float:left" width:100%><img runat="server" src="~/Images/AddMoviePoints.png" /></div>
                <div style="margin-left:55%" width: 100%><h2><u><strong>Add a Movie:</strong></u></h2></div>
                <div style="margin-left:55%; margin-top:0px" width: 100%>To add a movie, click <a runat="server" href="~/PowerTheEngine/AddMovie">HERE </a>and watch your rewards points grow! </div>
            </div>
        </div>
        <br />

        <!--    ADD CrowdTag POINTS  -->
        <div class="panel panel-default" style="width:100%">
            <div class="panel-body">
                <div style="float:left" width:100%><h2><u><strong>Add a CrowdTag:</strong></u></h2></div>
                <div style="margin-left:0px; margin-top:70px" width:100%>Find a movie <a runat="server" href="~/ShowAllMovies">HERE </a>and add a CrowdTag!</div>
                <div style="margin-left:53%; margin-top:-75px" width: 100%><img runat="server" src="~/Images/TagPoints.png" /></div>
            </div>
        </div>
        <br />



        <!--    VOTE POINTS  -->
        <div class="panel panel-default" style="width:100%">
            <div class="panel-body">
                <div style="float:left" width:100%><img runat="server" src="~/Images/VotePoints.png" /></div>
                <div style="margin-left:55%" width: 100%><h2><u><strong>Vote for a CrowdTag:</strong></u></h2></div>
                <div style="margin-left:55%; margin-top:0px" width: 100%>Find a movie <a runat="server" href="~/ShowAllMovies">HERE </a>either upgrade or downgrade a CrowdTag!</div>
            </div>
        </div>
        <br />
    
        <div>
            <div style="width:100%; margin-left:22%"><img runat="server" src="~/Images/PointsExplained.png" /></div>
        </div>
        
    <br />
    
    
    <br />
    
    
<br />
<br />
<br />
</asp:Content>
