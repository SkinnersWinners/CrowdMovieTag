<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Add_Movie.aspx.cs" Inherits="CrowdMovieTag.Add_Movie" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <h2>Add Movies:</h2>
    <h3>Power the Engine </h3>
    <br />
 
  <fieldset>
    <legend>Add a Movie</legend>
    <div class="form-group">
      <label for="inputTitle" class="col-lg-2 control-label">Title</label>
      <div class="col-lg-10">
        <input type="text" class="form-control" id="inputTitle" placeholder="Title">
        <br />
      </div>
    </div>
    
    <div class="form-group">
      <label for="inputYear" class="col-lg-2 control-label">Year Released</label>
      <div class="col-lg-10">
        <input type="text" class="form-control" id="inputYear" placeholder="Enter Year...">
         <br />
      </div>
    </div>
 
    <div class="form-group">
      <label for="textDescription" class="col-lg-2 control-label">Description</label>
      <div class="col-lg-10">
        <textarea class="form-control" rows="4" id="textDescription" placeholder="Add the movie description here..."></textarea>
         <br />
      </div>
    </div>

    <div class="form-group">
      <div class="col-lg-10 col-lg-offset-2">
        <button class="btn btn-default">Cancel</button>
        <button type="submit" class="btn btn-primary">Submit</button>
      </div>
    </div>
  </fieldset>
</asp:Content>
