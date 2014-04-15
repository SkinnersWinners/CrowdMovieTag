<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Add_Movie.aspx.cs" Inherits="CrowdMovieTag.Add_Movie" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <h2>Power the Engine:</h2>
    <h5>Add A Movie</h5>
    <br />
 
<div style="margin-top:-50px">
    <div class="form-group">
        <label for="inputTitle" class="col-lg-2 control-label" style="width:60%">Title (Required)</label>
        <div class="col-lg-1">
            <input type="text" required class="form-control" id="inputTitle" placeholder="Title">
        </div>
    </div>
    
    <div class="form-group">
        <label for="inputYear" class="col-lg-2 control-label" style="width:60%">Year Released (Required)</label>
        <div class="col-lg-1">
            <input type="text" required class="form-control" id="inputYear" placeholder="Enter Year...">
        </div>
    </div>
 
    <div class="form-group">
        <label for="textDescription" class="col-lg-2 control-label">Description (Required)</label>
        <div class="col-lg-1" >
            <textarea class="form-control" rows="4" required id="textDescription" style="width:600px" placeholder="Add the movie description here..."></textarea>
            <br />
        </div>
    </div>

    <div class="form-group">
        <div class="col-lg-10 col-lg-offset-2">
            <button class="btn btn-default">Cancel</button>
            <button type="submit" class="btn btn-primary">Submit</button>
        </div>
    </div>

</div>

<br />
<br />
</asp:Content>
