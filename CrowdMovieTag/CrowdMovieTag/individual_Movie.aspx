<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="individual_Movie.aspx.cs" Inherits="CrowdMovieTag.individual_Movie" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <h2>Update Movie Information</h2>
    <br />

<fieldset>
    <div class="form-group">
      <label class="col-lg-1 control-label">Title:</label>
      <div class="col-lg-10">
        <label class="col-lg-2 control-label" id="displayTitle">//Show Title Here</label>
        <br />
      </div>
    </div>

   <div class="form-group">
      <label class="col-lg-1 control-label">Year Released:</label>
      <div class="col-lg-10">
        <label class="col-lg-2 control-label" id="displayYear">//Show Year Here</label>
        <br />
      </div>
    </div>

   <div class="form-group">
      <label class="col-lg-1 control-label">Description:</label>
      <div class="col-lg-10">
        <label class="col-lg-2 control-label" id="displayDescription">//Show Description Here</label>
        <br />
      </div>
    </div>

        <div class="form-group">
      <label for="tag1_type" class="col-lg-2 control-label">First Tag Type</label>
      <div class="col-lg-10">
        <select class="form-control" id="tag1_type">
          <option>Select One...</option>
          <option>Genre</option>
          <option>Time Period</option>
          <option>Actor/Actress</option>
          <option>Producer</option>
          <option>Thematic Elements</option>
        </select>       
      </div>
    </div>

    <div class="form-group">
        <label for="inputTag1" class="col-lg-2 control-label">First Tag</label>
        <div class="col-lg-10">
            <input type="text" class="form-control" id="inputTag1" placeholder="Enter first tag...">
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
