<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="User_Profile.aspx.cs" Inherits="CrowdMovieTag.User_Profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	<br />
	<br />

	<div style ="margin-left:1.7in">
		<asp:FormView ID="ProfileViewForm" runat="server" ItemType="CrowdMovieTag.Models.Profile" SelectMethod="GetProfile">
			<EmptyDataTemplate>
				<h2>User not found</h2>
				<p>Did you type the username properly?</p>
			</EmptyDataTemplate>
			<ItemTemplate>		
				<div style="float:left; width:1.5in; height:100%">
					<img runat="server" src="~/Images/Oscar.png" />
				</div>

				<br />

				<h2>Oscar Winner: <%#: Item.FirstName + " " + Item.LastName %></h2>
				<h4>Username: <label id="userName"><%#: Item.Username %></label></h4>
				<h4>Member since: <label id="userRegDate"><%#: Item.DateJoined.Year %></label></h4>
				
				<h4>Profile Rank: <label id="userProfileRank"> 1 of 145 </label></h4>
				<div class="form-group">
					<asp:Button runat="server" ID="EditProfileBtn" OnClientClick="window.location.href='PowerTheEngine/EditProfile'; return false;" Visible="false" Text="Edit Profile" />
				</div>
				<br />
			</ItemTemplate>
		</asp:FormView> 
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
	  
					<!-----------------------Table Body-----------------------------> 
						<tbody>
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
					<!-----------------------Table Body-----------------------------> 
					<tbody>
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
