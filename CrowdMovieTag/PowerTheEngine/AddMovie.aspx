<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddMovie.aspx.cs" Inherits="CrowdMovieTag.Add_Movie" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <h2>Power the Engine:</h2>
    <br />

 
<!-----------------------Panel----------------------------->
<div class="panel panel-default">
    <div class="panel-heading" style="margin-top:-0px">Add A Movie:</div>
    <div class="panel-body">


<!-----------------------Enter Title----------------------------->
    <div class="form-group">    
        <input type="text" required class="form-control" id="inputTitle" style="width:300px" placeholder="Enter Title...">
    </div>
 
<!-----------------------Enter Year-----------------------------> 
    <div class="form-group">
        <input type="text" required class="form-control" id="inputYear" style="width:300px" placeholder="Enter Year Released...">
    </div>

<!-----------------------Enter Description-----------------------------> 
    <div class="form-group">
        <textarea class="form-control" rows="6" required id="textDescription" style="width:600px" placeholder="Enter Movie's Description..."></textarea>
    </div>

<!-----------------------Buttons----------------------------->
    <div class="form-group">
            <button class="btn btn-default">Cancel</button>
            <button type="submit" class="btn btn-primary">Submit</button>
            <br />
    </div>
  
    </div>
</div>

<br />
<br />
</asp:Content>
