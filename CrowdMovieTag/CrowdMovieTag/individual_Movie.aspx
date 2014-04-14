<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="individual_Movie.aspx.cs" Inherits="CrowdMovieTag.individual_Movie" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <h2>Update Movie Information</h2>
    <br />

<div>
 
      <label class="col-lg-1 control-label">Title:</label>
      <div class="col-lg-10">
        <label class="col-lg-2 control-label" id="displayTitle">//Show Title Here</label>
        <br />
      </div>
 

 
      <label class="col-lg-1 control-label">Year Released:</label>
      <div class="col-lg-10">
        <label class="col-lg-2 control-label" id="displayYear">//Show Year Here</label>
        <br />
      </div>


      <label class="col-lg-1 control-label">Description:</label>
      <div class="col-lg-10">
        <label class="col-lg-2 control-label" id="displayDescription">//Show Description Here</label>
        <br />
      </div>

<div>
 <div class="form-group" style="margin-left:145px; margin-top:-35px">
       <div class="col-lg-1">
       <select class="form-control" id="newTagType" style="width:175px">
          <option>Select One...</option>
          <option>Genre</option>
          <option>Time Period</option>
          <option>Actor/Actress</option>
          <option>Producer</option>
          <option>Thematic Elements</option>
          <option>Movie Title</option>
       </select>
       </div>
    </div>

    <div class="form-group" style="margin-top:-53px; margin-left:350px">
        <div class="col-lg-10">
            <input type="text" class="form-control" id="NewTag" placeholder="Enter new tag...">
        </div>
    </div>

    <div class="form-group">
      <div class="col-lg-10 col-lg-offset-2">
        <button class="btn btn-default">Cancel</button>
        <button type="submit" class="btn btn-primary">Submit</button>
      </div>
    </div>
</div>
    

</div>

</asp:Content>
