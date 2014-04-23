<%@ Page Title="All Movies" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ShowAllMovies.aspx.cs" Inherits="CrowdMovieTag.All_Movies" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<br />
<h2>Where We Go One, We Go All:</h2>
<br />

<!-----------------------Panel Begins----------------------------->
    <div class="panel panel-default panel-warning" "margin-top:30px">
        <div class="panel-heading">Movies Belonging to the Crowd:</div>
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

        </tbody>
    </table>

</div>
</div>


<br />
<br />
</asp:Content>
