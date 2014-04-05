<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CrowdMovieTag._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1></h1>
        <p class="lead">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp THIS CONTAINER IS GOING TO BE AN IMAGE OF OUR TRADEMARK/SYMBOL</p>
        <br />
        <br />
        <br />
        <br />
        <br />

        <div class="form-group">
                <input type="text" class="form-control" id="quickSearch" placeholder="Quick Search: Enter a single tag...">
                <button type="button" class="btn btn-primary">Search</button>        
        </div>
    </div>
    
    <br />
    <blockquote>
        <p>“Alone we can do so little; together we can do so much"</p>
        <small>Helen Keller</small>
    </blockquote>
    <br />

    <div class="row">
        <div class="col-md-4">
            <h2>Earn Rewards Points</h2>
            <p>
                Add Movies, upgrade and/or downgrade tags, complete your profile, to earn CrowdTag Points and one of many prizes!
            </p>
            <p>
                <a class="btn btn-default" href="~/Rewards_Points">Rewards &raquo;</a>
            </p>
        </div>

        <div class="col-md-4">
            <h2>Getting Started</h2>
            <p>
                Become a tagging guru.
            </p>
            <p>
                <a class="btn btn-default" href="~/About">Tagging School &raquo;</a>
            </p>
        </div>
        
        <div class="col-md-4">
            <h2>Advanced Searching</h2>
            <p>
                Search for multiple tags to obtain improved results!
            </p>
            <p>
                <a class="btn btn-default" href="~/Advanced_Search">Advanced Search &raquo;</a>
            </p>
        </div>
    </div>

</asp:Content>
