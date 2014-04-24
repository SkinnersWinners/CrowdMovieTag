<%@ Page Title="All Movies" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ShowAllMovies.aspx.cs" Inherits="CrowdMovieTag.All_Movies" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

	<br />
	<h2>Where We Go One, We Go All:</h2>
	<br />

	<!-----------------------Panel Begins----------------------------->
    <div class="panel panel-default panel-warning" "margin-top:30px">
        <div class="panel-heading">
			Movies Belonging to the Crowd:
        </div>
        
		<asp:Panel runat="server" ID="SearchLabelsPanel" Visible="false">
			<br />
			<asp:Label ID="SearchedForLabel" runat="server" Text="" ></asp:Label>
			<br />
			<br />
			<asp:Label ID="SearchResultsLabel" runat="server" Text=""></asp:Label>
		</asp:Panel>

		<div class="panel-body"> 
			<asp:Label ID="lblNoMoviesAdded" Text="The crowd has no movies!" runat="server" Visible="False"></asp:Label>
				
			<table class="table table-striped table-hover ">
				<asp:Repeater runat="server"
						ID="MoviesListRepeater" 
					ItemType="Tuple<Pair, CrowdMovieTag.Models.Movie>">
					<HeaderTemplate>
						<!-----------------------Table Headings----------------------------->
						<thead>
							<tr>
								<th>#</th>
								<th>Movie Title:</th>
								<th>Year:</th>
								<th>Top 5 tags:</th>
								<th>Added:</th>
								<th>More Information:</th>
							</tr>
						</thead>
						<tbody>
					</HeaderTemplate>
						
					<ItemTemplate>
						<tr>
							<td><%#: Container.ItemIndex + 1 %></td>
							<td><%#: Item.Item2.Title %></td>
							<td><%#: Item.Item2.Year %></td>
							<td><%#: (string)Item.Item1.Second %></td>
							<td><%#: (string)Item.Item1.First %></td>
							<td>
								<a href="MovieDetails?movieID=<%#: Item.Item2.MovieID %>">
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


	<br />
	<br />
</asp:Content>
