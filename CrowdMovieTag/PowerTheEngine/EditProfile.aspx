<%@ Page Title="Edit Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditProfile.aspx.cs" Inherits="CrowdMovieTag.PowerTheEngine.EditProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	
	<asp:FormView runat="server" ID="EditProfileForm" ItemType="CrowdMovieTag.Models.Profile" SelectMethod="GetProfile" >
		<EmptyDataTemplate>
			<h1>User not found</h1>
			<p>Please log out, and log back in again to retry.</p>
		</EmptyDataTemplate>
		<ItemTemplate>
			<asp:HiddenField ID="HiddenProfileID" Value="<%#: Item.ProfileID %>" runat="server" />
			
				<h1><%#: Item.Username %></h1>
			
			<br />
			<table>
				<tr>
					<td>
						<asp:Label ID="LabelFirstName" runat="server">First Name:&nbsp;</asp:Label>
					</td>
					<td>
						<asp:TextBox ID="FirstName" runat="server" Text="<%#:Item.FirstName %>"></asp:TextBox>
						<asp:RegularExpressionValidator ID="RegularExpressionValidator1"  runat="server" ControlToValidate="FirstName" ErrorMessage="First name must contain only letters" ValidationExpression="[A-Za-z]*"></asp:RegularExpressionValidator>
					</td>
				</tr>
				<tr>
					<td>
						<asp:Label ID="Label1" runat="server">Last Name:&nbsp;</asp:Label>
					</td>
					<td>
						<asp:TextBox ID="LastName" runat="server" Text="<%#:Item.LastName %>"></asp:TextBox>
						<asp:RegularExpressionValidator ID="RegularExpressionValidator2"  runat="server" ControlToValidate="LastName" ErrorMessage="Last name must contain only letters" ValidationExpression="[A-Za-z]*"></asp:RegularExpressionValidator>
					</td>
				</tr>
				<tr>
					<td>
						<asp:Label ID="Label2" runat="server">E-mail:&nbsp;</asp:Label>
					</td>
					<td>
						<asp:TextBox ID="Email" runat="server" Text="<%#:Item.Email %>"></asp:TextBox>
						<asp:RegularExpressionValidator ID="RegularExpressionValidator3"  runat="server" ControlToValidate="Email" ErrorMessage="Invalid E-mail address" ValidationExpression="[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}"></asp:RegularExpressionValidator>
					</td>
				</tr>
			</table>
			<asp:Button ID="UpdateProfileBtn" runat="server" OnClick="UpdateProfile_Click" CausesValidation="true" Text="Update" />
		</ItemTemplate>
	</asp:FormView>
	
	<asp:Label ID="LabelUpdateProfileStatus" runat="server" Text=""></asp:Label>

</asp:Content>
