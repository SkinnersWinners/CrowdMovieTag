<%@ Page Title="Search Results" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SearchResults.aspx.cs" Inherits="CrowdMovieTag.SearchResults" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<br />
<h3>The Crowd Has Spoken:</h3>
<br />

<!-----------------------Panel Begins----------------------------->
<div class="panel panel-default" "margin-top:20px">
    <div class="panel-heading">Search Results:</div>
    <div class="panel-body">
    <table class="table table-striped table-hover ">


<!-----------------------Table Headings----------------------------->
  <thead>
    <tr>
      <th>#</th>
      <th>Movie Title:</th>
      <th>Year:</th>
      <th>Top 5 Tags:</th>
      <th>More Information:</th>
    </tr>
  </thead>
  <tbody>

<!-----------------------Table Body-----------------------------> 
    <tr>
      <td>1</td>
      <td>Shawshank Redemption</td>
      <td>1994</td>
      <td>Drama, Prison, Morgan Freeman, 1940's, Tim Robbins</td>
      <td>
          <button type="submit" class="btn btn-primary btn-xs btn-info">  Description  </button>
      </td>
    </tr>

    <tr>
      <td>2</td>
      <td>Million Dollar Baby</td>
      <td>2004</td>
      <td>Drama, Boxing, Sports, Clint Eastwood, Hillary Swank</td>
      <td>
          <button type="submit" class="btn btn-primary btn-xs btn-info">  Description  </button>
      </td>
    </tr>

    <tr>
      <td>3</td>
      <td>Olympus Has Fallen</td>
      <td>2013</td>
      <td>Drama, Action, President, Politics, Rescue</td>
      <td>
          <button type="submit" class="btn btn-primary btn-xs btn-info">  Description  </button>
      </td>
    </tr>
  
  </tbody>
</table>

</div>
</div>


    <br />
    <br />
</asp:Content>
