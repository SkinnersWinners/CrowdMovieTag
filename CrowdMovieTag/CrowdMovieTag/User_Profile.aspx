<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="User_Profile.aspx.cs" Inherits="CrowdMovieTag.User_Profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<br />
<br />

<div style="float:left; width:1.5in; height:100%">
    <img src="Oscar.png" />
</div>

<div style ="margin-left:1.7in">

<br />
<h2>Oscar Winner: Sam Howes</h2>
<h4>Member since: <label id="userRegDate">2014</label></h4>
<h4>Email Address: <label id="userEmail">ILoveCrowdMovies@bu.edu</label></h4>
<h4>Profile Rank: <label id="userProfileRank"> 1 of 145 </label></h4>
    <div class="form-group">
        <button type="submit" class="btn btn-primary">Edit Profile / Change Password</button>
    </div>
<br />

<!-----------------------Panel Begins----------------------------->
<div class="panel panel-default panel-danger">
    <div class="panel-heading">Last 5 Movies Added:</div>
    <div class="panel-body">
    <table class="table table-striped table-hover ">

<!-----------------------Table Headings----------------------------->
  <thead>
    <tr>
      <th>#</th>
      <th>Movie Title:</th>
      <th>Year:</th>
      <th>Top 5 tags:</th>
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
      <td>Empty</td>
      <td>Empty</td>
      <td>Empty</td>
      <td>
          <button type="submit" class="btn btn-primary btn-xs btn-info">  Description  </button>
      </td>
    </tr>
    
    <tr>
      <td>3</td>
     <td>Empty</td>
      <td>Empty</td>
      <td>Empty</td>
      <td>
          <button type="submit" class="btn btn-primary btn-xs btn-info">  Description  </button>
      </td>
    </tr>

    <tr>
      <td>4</td>
      <td>Empty</td>
      <td>Empty</td>
      <td>Empty</td>
      <td>
          <button type="submit" class="btn btn-primary btn-xs btn-info">  Description  </button>
      </td>
    </tr>
    <tr>
      <td>5</td>
      <td>Empty</td>
      <td>Empty</td>
      <td>Empty</td>
      <td>
          <button type="submit" class="btn btn-primary btn-xs btn-info">  Description  </button>
      </td>
    </tr>
    </tbody>
</table>
</div>
</div>

<!----------------------TAGS APPLIED -------------------->
<div class="panel panel-default panel-warning">
    <div class="panel-heading">Last 10 Movies Tagged:</div>
    <div class="panel-body">
    <table class="table table-striped table-hover ">

<!-----------------------Table Headings----------------------------->
  <thead>
    <tr>
      <th>#</th>
      <th>Movie Title:</th>
      <th>Tag Applied</th>
      <th>Current Tag Score:</th>
      <th>More Information:</th>
    </tr>
  </thead>
  <tbody>

<!-----------------------Table Body-----------------------------> 
    <tr>
      <td>1</td>
      <td>Jobs</td>
      <td>Ashton Kutcher</td>
      <td>23</td>
      <td>
          <button type="submit" class="btn btn-primary btn-xs btn-info">  Description  </button>
      </td>
    </tr>
    
    <tr>
      <td>2</td>
      <td>Empty</td>
      <td>Empty</td>
      <td>Empty</td>
      <td>
          <button type="submit" class="btn btn-primary btn-xs btn-info">  Description  </button>
      </td>
    </tr>
    
    <tr>
      <td>3</td>
     <td>Empty</td>
      <td>Empty</td>
      <td>Empty</td>
      <td>
          <button type="submit" class="btn btn-primary btn-xs btn-info">  Description  </button>
      </td>
    </tr>

    <tr>
      <td>4</td>
      <td>Empty</td>
      <td>Empty</td>
      <td>Empty</td>
      <td>
          <button type="submit" class="btn btn-primary btn-xs btn-info">  Description  </button>
      </td>
    </tr>
    <tr>
      <td>5</td>
      <td>Empty</td>
      <td>Empty</td>
      <td>Empty</td>
      <td>
          <button type="submit" class="btn btn-primary btn-xs btn-info">  Description  </button>
      </td>
    </tr>
    </tbody>
</table>
</div>
</div>

</div>     
    <br />
    <br />
    <br />
</asp:Content>
