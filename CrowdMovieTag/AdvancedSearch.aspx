<%@ Page Title="Advanced Search" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdvancedSearch.aspx.cs" Inherits="CrowdMovieTag.AdvancedSearch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
<br />		
<h2>Advanced Search</h2>
<br />

<!-----------------------Panel Begins----------------------------->
<div class="panel panel-default">
    <div class="panel-heading">Search For Up To 5 Tags:</div>
    <div class="panel-body">
    <table class="table table-striped table-hover ">
          <thead>
            <tr>
              <th>#</th>
              <th>Type:</th>
              <th>Tag:</th>
              <th>Message:  (if applicable)</th>
            </tr>
          </thead>
          <tbody>
           

<!-----------------------SEARCH TAG 1----------------------------->
              <tr>
              <td style="vertical-align:middle">1</td>
              <td>
                  <select class="form-control" id="searchTag1_type" style="width:175px">
                      <option>Select One...</option>
                      <option>Genre</option>
                      <option>Thematic Element</option>
                      <option>Actor/Actress</option>
                      <option>Director/Producer</option>
                      <option>Time Period/Era</option>
                      <option>Location</option>
                   </select>
              </td>
              <td>
                  <input type="text" class="form-control" id="searchTag1" placeholder="Enter first tag...">
              </td>
              <td style="vertical-align:middle">
                  <label id="searchTag1_error" style="color:#FF6600"">Print Tag 1 errors here...</label>
              </td>
            </tr>

<!-----------------------SEARCH TAG 2----------------------------->
            <tr>
              <td style="vertical-align:middle">2</td>
              <td>
                  <select class="form-control" id="searchTag2_type" style="width:175px">
                      <option>Select One...</option>
                      <option>Genre</option>
                      <option>Thematic Element</option>
                      <option>Actor/Actress</option>
                      <option>Director/Producer</option>
                      <option>Time Period/Era</option>
                      <option>Location</option>
                   </select>
              </td>
              <td>
                  <input type="text" class="form-control" id="searchTag2" placeholder="Enter second tag...">
              </td>
              <td style="vertical-align:middle">
                  <label id="searchTag2_error" style="color:#FF6600"">Print Tag 2 errors here...</label>
              </td>
            </tr>

<!-----------------------SEARCH TAG 3----------------------------->
            <tr>
              <td style="vertical-align:middle">3</td>
              <td>
                  <select class="form-control" id="searchTag3_type" style="width:175px">
                      <option>Select One...</option>
                      <option>Genre</option>
                      <option>Thematic Element</option>
                      <option>Actor/Actress</option>
                      <option>Director/Producer</option>
                      <option>Time Period/Era</option>
                      <option>Location</option>
                   </select>
              </td>
              <td>
                  <input type="text" class="form-control" id="searchTag3" placeholder="Enter third tag...">
              </td>
              <td style="vertical-align:middle">
                  <label id="searchTag3_error" style="color:#FF6600"">Print Tag 3 errors here...</label>
              </td>
            </tr>

<!-----------------------SEARCH TAG 4----------------------------->
            <tr>
              <td style="vertical-align:middle">4</td>
              <td>
                  <select class="form-control" id="searchTag4_type" style="width:175px">
                      <option>Select One...</option>
                      <option>Genre</option>
                      <option>Time Period</option>
                      <option>Actor/Actress</option>
                      <option>Producer</option>
                      <option>Thematic Elements</option>
                      <option>Movie Title</option>
                   </select>
              </td>
              <td>
                  <input type="text" class="form-control" id="searchTag4" placeholder="Enter fourth tag...">
              </td>
              <td style="vertical-align:middle">
                  <label id="searchTag4_error" style="color:#FF6600"">Print Tag 4 errors here...</label>
              </td>
            </tr>

<!-----------------------SEARCH TAG 5----------------------------->
            <tr>
              <td style="vertical-align:middle">5</td>
              <td>
                  <select class="form-control" id="searchTag5_type" style="width:175px">
                      <option>Select One...</option>
                      <option>Genre</option>
                      <option>Thematic Element</option>
                      <option>Actor/Actress</option>
                      <option>Director/Producer</option>
                      <option>Time Period/Era</option>
                      <option>Location</option>
                   </select>
              </td>
              <td>
                  <input type="text" class="form-control" id="searchTag5" placeholder="Enter fifth tag...">
              </td>
              <td style="vertical-align:middle">
                  <label id="searchTag5_error" style="color:#FF6600"">Print Tag 5 errors here...</label>
              </td>
            </tr>
          </tbody>
    </table>
    </div>
</div>
 
<div class="form-group" style="margin-top:20px">
       <button class="btn btn-default">Cancel</button>
       <button type="submit" class="btn btn-primary">Search</button>
</div>

<br />
<br />
</asp:Content>
