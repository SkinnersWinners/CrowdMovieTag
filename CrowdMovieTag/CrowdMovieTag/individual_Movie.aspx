<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="individual_Movie.aspx.cs" Inherits="CrowdMovieTag.individual_Movie" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <br />
    <h1>This is where the title goes + (Year in parenthesis)</h1>
    <hr style="margin-top:10px">

<!-----------------------Movie Description Panel----------------------------->
<div class="panel panel-default">
    <div class="panel-heading">Movie Description:</div>
    <div class="panel-body">
        <label class="control-label" style="width:100%" id="displayDescription">Insert the movie description in this space</label>
    </div>
</div>
<hr style="margin-top:10px" />

<!-----------------------Tag Panel----------------------------->
<div class="panel panel-default">
    <div class="panel-heading">Tags:</div>
    <div class="panel-body">
    <table class="table table-striped table-hover ">
  <thead>
<!-----------------------Table Headings----------------------------->
    <tr>
      <th>Score:</th>
      <th>Type:</th>
      <th>Tag:</th>
      <th>Vote:</th>
    </tr>
  </thead>
  <tbody>

<!-----------------------Table Body-----------------------------> 
    <tr>
      <td>11</td>
      <td>Genre</td>
      <td>Baseball</td>
      <td>
          <button type="submit" class="btn btn-primary btn-xs btn-success">  +1  </button>
          <button type="submit" class="btn btn-primary btn-xs btn-danger">  -1  </button>
      </td>
    </tr>

    <tr>
      <td>2</td>
      <td>Element</td>
      <td>Action</td>
      <td><button type="submit" class="btn btn-primary btn-xs btn-success">  +1  </button>
          <button type="submit" class="btn btn-primary btn-xs btn-danger">  -1  </button>
      </td>
    </tr>
  </tbody>
</table>
</div>
</div>

<!-----------------------Add a New Tag to Movie ----------------------------->
<div class="panel panel-default">
    <div class="panel-heading">Add a New Tag:</div>
    <div class="panel-body" style="height:150px">
        <div class="form-group" style="margin-left:0px; margin-top:0px">
            <select class="form-control" id="newTagType" style="width:175px">
                      <option>Select One...</option>
                      <option>Genre</option>
                      <option>Thematic Element</option>
                      <option>Actor/Actress</option>
                      <option>Director/Producer</option>
                      <option>Time Period/Era</option>
                      <option>Location</option>
            </select>
         </div>

    <div class="form-group" style="margin-top:-54px; margin-left:200px">
         <input type="text" class="form-control" id="NewTag" placeholder="Enter new tag...">
    </div>

<!-----------------------Buttons----------------------------->
    <div class="form-group">
        <button class="btn btn-default">Cancel</button>
        <button type="submit" class="btn btn-primary">Submit</button>
      </div>

</div>
</div>
  
<br />
<br />      

</asp:Content>
