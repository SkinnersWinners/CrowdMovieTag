<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Advanced_Search.aspx.cs" Inherits="CrowdMovieTag.Advanced_Search" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <h3>Search for up to 5 tags:</h3>
    <br />

<!---------------------------------------------------------------->
<!-----------------------SEARCH TAG 1----------------------------->
<!---------------------------------------------------------------->
<div>
    <div style="margin-left:0px; margin-top:0px">
        <label for="searchTag1_type" class="col-lg-2 control-label">First Search Tag:</label>
    </div>

    <div class="form-group" style="margin-left:145px; margin-top:-35px">
       <div class="col-lg-1">
       <select class="form-control" id="searchTag1_type" style="width:175px">
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
            <input type="text" class="form-control" id="searchTag1" placeholder="Enter first tag...">
        </div>
    </div>

    <div style="margin-left:565px; margin-top:-42px">
        <label id="searchTag1_error" class="col-lg-5 control-label" style="color: #FF6600">Print Tag1 errors here...</label>
    </div>
</div>
    <br />
    <hr style="margin-top:50px">

<!---------------------------------------------------------------->
<!-----------------------SEARCH TAG 2----------------------------->
<!---------------------------------------------------------------->
<div>
    <div style="margin-left:0px; margin-top:-35px">
        <label for="searchTag2_type" class="col-lg-2 control-label">Second Search Tag:</label>
    </div>

    <div class="form-group" style="margin-left:145px; margin-top:-35px">
       <div class="col-lg-1">
       <select class="form-control" id="searchTag2_type" style="width:175px">
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
            <input type="text" class="form-control" id="searchTag2" placeholder="Enter second tag...">
        </div>
    </div>

    <div style="margin-left:565px; margin-top:-42px">
        <label id="searchTag2_error" class="col-lg-5 control-label" style="color: #FF6600">Print Tag2 errors here...</label>
    </div>
</div>
    <br />
    <hr style="margin-top:55px">

<!---------------------------------------------------------------->
<!-----------------------SEARCH TAG 3----------------------------->
<!---------------------------------------------------------------->

<div>
    <div style="margin-left:0px; margin-top:-35px">
        <label for="searchTag3_type" class="col-lg-2 control-label">Third Search Tag:</label>
    </div>

    <div class="form-group" style="margin-left:145px; margin-top:-35px">
       <div class="col-lg-1">
       <select class="form-control" id="searchTag3_type" style="width:175px">
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
            <input type="text" class="form-control" id="searchTag3" placeholder="Enter third tag...">
        </div>
    </div>

    <div style="margin-left:565px; margin-top:-42px">
        <label id="searchTag3_error" class="col-lg-5 control-label" style="color: #FF6600">Print Tag3 errors here...</label>
    </div>
</div>
    <br />
    <hr style="margin-top:55px">    

<!---------------------------------------------------------------->
<!-----------------------SEARCH TAG 4----------------------------->
<!---------------------------------------------------------------->
    
<div>
    <div style="margin-left:0px; margin-top:-35px">
        <label for="searchTag4_type" class="col-lg-2 control-label">Fourth Search Tag:</label>
    </div>

    <div class="form-group" style="margin-left:145px; margin-top:-35px">
       <div class="col-lg-1">
       <select class="form-control" id="searchTag4_type" style="width:175px">
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
            <input type="text" class="form-control" id="searchTag4" placeholder="Enter fourth tag...">
        </div>
    </div>

    <div style="margin-left:565px; margin-top:-42px">
        <label id="searchTag4_error" class="col-lg-5 control-label" style="color: #FF6600">Print Tag4 errors here...</label>
    </div>
</div>
    <br />
    <hr style="margin-top:55px">   
    
<!---------------------------------------------------------------->
<!-----------------------SEARCH TAG 5----------------------------->
<!---------------------------------------------------------------->    

<div>
    <div style="margin-left:0px; margin-top:-35px">
        <label for="searchTag5_type" class="col-lg-2 control-label">Fifth Search Tag:</label>
    </div>

    <div class="form-group" style="margin-left:145px; margin-top:-35px">
       <div class="col-lg-1">
       <select class="form-control" id="searchTag5_type" style="width:175px">
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
            <input type="text" class="form-control" id="searchTag5" placeholder="Enter fifth tag...">
        </div>
    </div>

    <div style="margin-left:565px; margin-top:-42px">
        <label id="searchTag5_error" class="col-lg-5 control-label" style="color: #FF6600">Print Tag5 errors here...</label>
    </div>
</div>
    <br />
    
<!---------------------------------------------------------------->
<!------------------SUBMIT/CANCEL BUTTONS------------------------->
<!---------------------------------------------------------------->   

<div class="form-group" style="margin-top:20px">
    <div class="col-lg-10 col-lg-offset-2">
       <button class="btn btn-default">Cancel</button>
       <button type="submit" class="btn btn-primary">Search</button>
    </div>
</div>

<br />
<br />
</asp:Content>
