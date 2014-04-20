<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MovieDetails.aspx.cs" Inherits="CrowdMovieTag.individual_Movie" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	<br />
	<asp:FormView ID="FormView1" ItemType="CrowdMovieTag.Models.Movie" SelectMethod="GetMovie" runat="server" BackColor="Transparent">
		<EmptyDataTemplate>
			<h1>Movie Not Found</h1>
			<p>Did you type the name correctly?</p>		
		</EmptyDataTemplate>
		<ItemTemplate>
			<h1><%#:Item.Title %> (<%#:Item.Year %>)</h1>

			<hr style="margin-top:10px">

			<!-----------------------Movie Description Panel----------------------------->
			<div class="panel panel-default">
				<div class="panel-heading">Movie Description:</div>
				<div class="panel-body">
					<label class="control-label" style="width:100%" id="displayDescription"><%#:Item.Description %></label>
				</div>
			</div>

		</ItemTemplate>
	</asp:FormView>  

	
    <hr style="margin-top:10px" />

	<!-----------------------Tag Panel----------------------------->
	<div class="panel panel-default">
		<div class="panel-heading">
			Tags:
		</div>
		<div class="panel-body">
			<asp:GridView ID="TagsList" ItemType="CrowdMovieTag.Models.TagFromQuery" AutoGenerateColumns="false" 
				SelectMethod="GetTagsForMovie" 
				CssClass="table table-striped table-hover" 
				ShowHeader="true"
				GridLines="None" 
				AllowSorting="true"
				OnRowCommand="VoteWasClicked"
				runat="server">
				<Columns>
					<asp:BoundField HeaderText="Score" DataField="Score" />
					<asp:TemplateField HeaderText="Type">
						<ItemTemplate>
							<%#: EvaluateTagTypeEnum(Item.TagTypeEnumID) %>
						</ItemTemplate>
					</asp:TemplateField>
					<asp:BoundField HeaderText="Tag" DataField="Label" />
					<asp:TemplateField HeaderText="Vote">
						<ItemTemplate>
							<asp:Button ID="UpVote" runat="server"
								CommandName="UpVote"
								CommandArgument="<%#: Item.TagID %>" 
								Text="+1"
								CssClass="btn btn-primary btn-xs btn-success" />
							<asp:Button ID="DownVote" runat="server"
								CommandName="DownVote"
								CommandArgument="<%#: Item.TagID %>" 
								Text="-1"
								CssClass="btn btn-primary btn-xs btn-danger" />
	<!--
							<button type="submit" class="btn btn-primary btn-xs btn-success">&nbsp;&nbsp;+1&nbsp;&nbsp;</button>
							<button type="submit" class="btn btn-primary btn-xs btn-danger">&nbsp;&nbsp;-1&nbsp;&nbsp;</button> -->
						</ItemTemplate>
					</asp:TemplateField>
				</Columns>
			</asp:GridView>
			<table class="table table-striped table-hover ">
				<!-----------------------Table Headings----------------------------->
				<thead>
					<tr>
					  <th>Score:</th>
					  <th>Type:</th>
					  <th>Tag:</th>
					  <th>Vote:</th>
					</tr>
				</thead>

				<!-----------------------Table Body-----------------------------> 
				<tbody>
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
		</div> <!--End Table Body-->
	</div>

	<!-----------------------Add a New Tag to Movie ----------------------------->
	<!--<asp:Panel DefaultButton="AddNewTagBtn" runat="server">-->
	<div class="panel panel-default">
		<div class="panel-heading">
			Add a New Tag:
		</div>
		<div class="panel-body" style="height:150px">
			<div class="form-group" style="margin-left:0px; margin-top:0px">
				<asp:DropDownList runat="server" ID="NewTagTypeDropDown" CssClass="form-control">
					<asp:ListItem Text="Select One..." Value="-1" />
				</asp:DropDownList>
			<!--	<asp:RequiredFieldValidator id="Rfv1" runat="server" ControlToValidate="NewTagTypeDropDown" InitialValue="-1"  ErrorMessage="Tag Category is required" Display="Dynamic" /> --> 
			 </div>
			<div class="form-group" style="margin-top:-54px; margin-left:200px">
				<asp:TextBox 
					CssClass="form-control" 
					ID="NewTagNameTextBox" 
					placeholder="Enter new tag..." 
					runat="server"></asp:TextBox> 
				<asp:RequiredFieldValidator ID="RequiredFieldValidator2" 
					runat="server" 
					Text="* Tag name is required" 
					ControlToValidate="NewTagNameTextBox" 
					SetFocusOnError="true" 
					Display="Dynamic"
					 ValidationGroup="NewTag" ></asp:RequiredFieldValidator>
				<asp:RegularExpressionValidator 
					ID="RegexValidator1" runat="server" 
					Text="* Name must not contain spaces or special characters" ControlToValidate="NewTagNameTextBox" 
					ValidationExpression="^[A-Z\-a-z0-9_]+$"
					ValidationGroup="NewTag"></asp:RegularExpressionValidator>
			</div>

			<!-----------------------Buttons----------------------------->
			
			<div class="form-group">
				<asp:Button CssClass="btn btn-primary" ID="AddNewTagBtn" 
					CausesValidation="true" runat="server" 
					Text="Submit" 
					 ValidationGroup="NewTag"
					OnClick="AddNewTag_Click"/>
			</div>

		</div>
	</div>
	<!--</asp:Panel>-->
  
	<br />
	<br />      

</asp:Content>
