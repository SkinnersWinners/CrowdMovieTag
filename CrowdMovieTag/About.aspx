<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="CrowdMovieTag.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <h3>CrowdTag: Movies </h3>
            <p>CrowdTag: Movies is an online platform where <strong>YOU</strong>, the crowd can affect the movie rankings, recommendations, and suggestions, by adding movies, tagging the movies, and voting on the tags.</p>
        <br />       

        <h3>What is a CrowdTag?</h3>
            <p>A tag is, well, a tag. CrowdTags are assigned to a movie to describe in one word an important part of the film.  Whether the tag is a thematic element, an actor, and actress, the movie's genre, the time period and/or location wherein the movie takes place, or the director or producer.</p>
            <p>Anytime you see a BLUE "Decription" button for a movie, click on it!</p>
                <div style="align-content:center; margin-left:auto; margin-right:auto; background-repeat: no-repeat; width:900px">
                    <img runat="server" src="~/Images/SearchResultsSample.PNG" />
                </div>
        <br />
        <hr />  
        <br />                
        
        <h3>I just clicked on a BLUE "Description" button, now what?</h3>
            <p>First, review each of the CrowdTags that have already been applied to the movie. If you see a CrowdTag that really embodies the movie, VOTE for an upgrade to the CrowdTag.  If the CrowdTag does not apply or is not fitting for the movie, downgrade it. See Below:</p>
                <div style="align-content:center; margin-left:auto; margin-right:auto; background-repeat: no-repeat; width:900px">        
                    <img runat="server" src="~/Images/VoteOnTag.png" />
                </div>
        <br />
        <hr />  
        <br />        
        
        <h3>What if an applicable CrowdTag has not yet been applied?</h3>
            <p>As shown below, you may (and are encouraged) to add new "GOOD" CrowdTags to your favorite movies. Just select a thematic element, an actor, and actress, the movie's genre, the time period and/or location wherein the movie takes place, or the director or producer and add the CrowdTag.</p>
                <div style="align-content:center; margin-left:auto; margin-right:auto; background-repeat: no-repeat; width:900px">        
                    <img runat="server" src="~/Images/AddNewTag.png" />
                </div>
        <br />
        <hr /> 
        <br />
        <h3>What do I get for adding Movies, CrowdTags, and for Voting?</h3>
            <p>In addition to the profile points that you earn, you are POWER'ing the CrowdTag search engine by feeding our top-secret proprietary algorithm with information to make better movie recommendations.  As a result, the world is a happier place!</p>
                <br />
                <div width:100%>        
                    <img style="margin-left:45%" runat="server" src="~/Images/SmileyFace.png" /> 
                </div>
        <br />
        <hr /> 
        <br />
    </div>

<br />
<br />
<br />
</asp:Content>
