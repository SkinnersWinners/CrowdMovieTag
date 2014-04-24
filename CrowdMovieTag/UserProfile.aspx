<%@ Page Title="Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserProfile.aspx.cs" Inherits="CrowdMovieTag.User_Profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	<br />
	<br />

	<div style ="margin-top:20px" >

		<asp:FormView ID="ProfileViewForm" runat="server" style="width:50%" BackColor="Transparent" ItemType="CrowdMovieTag.Models.Profile" SelectMethod="GetProfile">
			<EmptyDataTemplate>
				<h2>User not found</h2>
				<p>Did you type the username properly?</p>
			</EmptyDataTemplate>
			<ItemTemplate>
				<br />	      		
				<div style="float:left; width:1.5in; height:100%">
					<img runat="server" src="<%#: Item.Avatar.ImageURL %>" />
				</div>

				<br />

				<h2 style="margin-left:2in"><%#: Item.Avatar.Name %>: <%#: Item.FirstName + " " + Item.LastName %></h2>
				<h4 style="margin-left:2in">Username: <label id="userName"><%#: Item.Username %></label></h4>
				<h4 style="margin-left:2in">Member since: <label id="userRegDate"><%#: Item.DateJoined.Year %></label></h4>
				
				<h4 style="margin-left:2in">Profile Score: <label id="userProfileRank"><%#: Item.Score %></label></h4>
			</ItemTemplate>
		</asp:FormView>
			
		 
		<div class="form-group">
			<asp:Button runat="server" ID="EditProfileBtn" OnClientClick="window.location.href='PowerTheEngine/EditProfile'; return false;" Visible="false" Text="Edit Profile" />
		</div>
		<br />

		<!----------------------Votes Cast -------------------->
		<div class="panel panel-default panel-info">
			<div class="panel-heading">
				Last 5 Tags Voted On:
			</div>

 			<div class="panel-body">
				<asp:Label ID="lblNoVotesCast" Text="User has not Voted on any Tags" runat="server" Visible="False"></asp:Label>
				<table class="table table-striped table-hover ">
					<asp:Repeater runat="server"
						 ID="RecentVotesRepeater" 
						ItemType="Tuple<String, CrowdMovieTag.Models.Vote>">
						<HeaderTemplate>
							<!-----------------------Table Headings----------------------------->
							<thead>
								<tr>
									<th>#</th>
									<th>When:</th>
									<th>Vote:</th>
									<th>Tag:</th>
									<th>Movie Title:</th>
									<th>Current Tag Score:</th>
									<th>More Information:</th>
								</tr>
							</thead>
							<tbody>
						</HeaderTemplate>
						
						<ItemTemplate>
							<tr>
								<td><%#: Container.ItemIndex + 1 %></td>
								<td><%#: Item.Item1 %></td>
								<td>
									<button class="<%#: "btn btn-primary btn-xs " + (Item.Item2.IsUpvote ? "btn-success": "btn-danger") %>">
										<%#: (Item.Item2.IsUpvote ? "+1": "-1") %>	
									</button>

								</td>
								<td><%#: Item.Item2.TagApplication.Tag.Name %></td>
								<td><%#: Item.Item2.TagApplication.Movie.Title %></td>
								<td><%#: Item.Item2.TagApplication.Score %></td>
								<td>
									<a href="MovieDetails.aspx?movieID=<%#: Item.Item2.TagApplication.MovieID %>">
										<button type="button" class="btn btn-primary btn-xs btn-info">  
											Movie Page
										</button>
									</a>
								</td>
							</tr>
						</ItemTemplate>

						<FooterTemplate>
							</tbody>
						</FooterTemplate>
					</asp:Repeater>
				</table>
			</div>
		</div>
		
		<!----------------------TAGS APPLIED -------------------->
		<div class="panel panel-default panel-warning">
			<div class="panel-heading">
				Last 10 Movies Tagged:
			</div>

			<asp:Label ID="lblNoMoviesTagged" Text="User has not tagged any movies" runat="server" Visible="False"></asp:Label>
 			<div class="panel-body">
				<table class="table table-striped table-hover ">
					<asp:Repeater runat="server"
						 ID="RecentTagsRepeater" 
						ItemType="Tuple<String, CrowdMovieTag.Models.TagApplication>">
						<HeaderTemplate>
							<!-----------------------Table Headings----------------------------->
							<thead>
								<tr>
									<th>#</th>
									<th>When:</th>
									<th>Tag Applied:</th>
									<th>Movie Title:</th>
									<th>Current Tag Score:</th>
									<th>More Information:</th>
								</tr>
							</thead>
							<tbody>
						</HeaderTemplate>
						
						<ItemTemplate>
							<tr>
								<td><%#:  Container.ItemIndex + 1 %></td>
								<td><%#: Item.Item1 %></td>
								<td><%#: Item.Item2.Tag.Name %></td>
								<td><%#: Item.Item2.Movie.Title %></td>
								<td><%#: Item.Item2.Score %></td>
								<td>
									<a href="MovieDetails.aspx?movieID=<%#: Item.Item2.MovieID %>">
										<button type="button" class="btn btn-primary btn-xs btn-info">  
											Movie Page
										</button>
									</a>
								</td>
							</tr>
						</ItemTemplate>

						<FooterTemplate>
							</tbody>
						</FooterTemplate>
					</asp:Repeater>
				</table>
			</div>
		</div>

		<!-------------------- Movies Added --------------------->
		<div class="panel panel-default panel-danger">
			<div class="panel-heading">
				Last 5 Movies Added:
			</div>

			<div class="panel-body"> 
				<asp:Label ID="lblNoMoviesAdded" Text="User has not added any movies" runat="server" Visible="False"></asp:Label>
				
				<table class="table table-striped table-hover ">
					<asp:Repeater runat="server"
						 ID="RecentMoviesRepeater" 
						ItemType="Tuple<Pair, CrowdMovieTag.Models.Movie>">
						<HeaderTemplate>
							<!-----------------------Table Headings----------------------------->
							<thead>
								<tr>
									<th>#</th>
									<th>When:</th>
									<th>Movie Title:</th>
									<th>Year:</th>
									<th>Top 5 tags:</th>
									<th>More Information:</th>
								</tr>
							</thead>
							<tbody>
						</HeaderTemplate>
						
						<ItemTemplate>
							<tr>
								<td><%#: Container.ItemIndex + 1 %></td>
								<td><%#: (string)Item.Item1.First %></td>
								<td><%#: Item.Item2.Title %></td>
								<td><%#: Item.Item2.Year %></td>
								<td><%#: (string)Item.Item1.Second %></td>
								<td>
									<a href="MovieDetails.aspx?movieID=<%#: Item.Item2.MovieID %>">
										<button type="button" class="btn btn-primary btn-xs btn-info">  
											Movie Page
										</button>
									</a>
								</td>
							</tr>
						</ItemTemplate>

						<FooterTemplate>
							</tbody>
						</FooterTemplate>
					</asp:Repeater>
				</table>
			</div>
		</div>

		
	</div>     
	<br />
	<br />
	<br />
</asp:Content>
