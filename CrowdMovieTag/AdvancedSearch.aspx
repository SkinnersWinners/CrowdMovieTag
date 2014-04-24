<%@ Page Title="Advanced Search" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdvancedSearch.aspx.cs" Inherits="CrowdMovieTag.AdvancedSearch" EnableEventValidation="false" %>
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
              <th></th>
            </tr>
          </thead>
          <tbody>
           

<!-----------------------SEARCH TAG 1----------------------------->
              <tr>
              <td style="vertical-align:middle">1</td>
              <td>
					<asp:DropDownList runat="server" 
						ID="DropDownList1" 
						CssClass="form-control"></asp:DropDownList>
              </td>
              <td>
                  <asp:TextBox runat="server" CssClass="form-control" ID="TextBox1" placeholder="Enter First tag..."></asp:TextBox>
              </td>
              <td style="vertical-align:middle">
                  <asp:RegularExpressionValidator 
					ID="RegexValidator1" runat="server" 
					CssClass="validator"
					Text="* Name must not contain spaces or special characters" 
					ControlToValidate="TextBox1" 
					ValidationExpression="^[A-Z\-a-z0-9_]+$"
					></asp:RegularExpressionValidator>
              </td>
            </tr>

<!-----------------------SEARCH TAG 2----------------------------->
            <tr>
              <td style="vertical-align:middle">2</td>
              <td>
                  <asp:DropDownList runat="server" 
						ID="DropDownList2" 
						CssClass="form-control"></asp:DropDownList>
              </td>
              <td>
                   <asp:TextBox runat="server" CssClass="form-control" ID="TextBox2" placeholder="Enter Second tag..."></asp:TextBox>
              </td>
              <td style="vertical-align:middle">
                  <asp:RegularExpressionValidator 
					ID="RegularExpressionValidator1" runat="server" 
					CssClass="validator"
					Text="* Name must not contain spaces or special characters" 
					ControlToValidate="TextBox2" 
					ValidationExpression="^[A-Z\-a-z0-9_]+$"
					></asp:RegularExpressionValidator>
              </td>
            </tr>

<!-----------------------SEARCH TAG 3----------------------------->
            <tr>
              <td style="vertical-align:middle">3</td>
              <td>
                  <asp:DropDownList runat="server" 
						ID="DropDownList3" 
						CssClass="form-control"></asp:DropDownList>
              </td>
              <td>
                   <asp:TextBox runat="server" CssClass="form-control" ID="TextBox3" placeholder="Enter Third tag..."></asp:TextBox>
              </td>
              <td style="vertical-align:middle">
                  <asp:RegularExpressionValidator 
					ID="RegularExpressionValidator4" runat="server" 
					CssClass="validator"
					Text="* Name must not contain spaces or special characters" 
					ControlToValidate="TextBox3" 
					ValidationExpression="^[A-Z\-a-z0-9_]+$"
					></asp:RegularExpressionValidator>
              </td>
            </tr>

<!-----------------------SEARCH TAG 4----------------------------->
            <tr>
              <td style="vertical-align:middle">4</td>
              <td>
                  <asp:DropDownList runat="server" 
						ID="DropDownList4" 
						CssClass="form-control"></asp:DropDownList>
              </td>
              <td>
                   <asp:TextBox runat="server" CssClass="form-control" ID="TextBox4" placeholder="Enter Fourth tag..."></asp:TextBox>
              </td>
              <td style="vertical-align:middle">
                 <asp:RegularExpressionValidator 
					ID="RegularExpressionValidator2" runat="server" 
					CssClass="validator"
					Text="* Name must not contain spaces or special characters" 
					ControlToValidate="TextBox4" 
					ValidationExpression="^[A-Z\-a-z0-9_]+$"
					></asp:RegularExpressionValidator>
              </td>
            </tr>

<!-----------------------SEARCH TAG 5----------------------------->
            <tr>
              <td style="vertical-align:middle">5</td>
              <td>
                  <asp:DropDownList runat="server" 
						ID="DropDownList5" 
						CssClass="form-control"></asp:DropDownList>
              </td>
              <td>
                   <asp:TextBox runat="server" CssClass="form-control" ID="TextBox5" placeholder="Enter Fifth tag..."></asp:TextBox>
              </td>
              <td style="vertical-align:middle">
                  <asp:RegularExpressionValidator 
					ID="RegularExpressionValidator3" runat="server" 
					CssClass="validator"
					Text="* Name must not contain spaces or special characters" 
					ControlToValidate="TextBox5" 
					ValidationExpression="^[A-Z\-a-z0-9_]+$"
					></asp:RegularExpressionValidator>
              </td>
            </tr>
          </tbody>
    </table>
	<ajaxToolkit:CascadingDropDown ID="CascadingDropDown1" runat="server"
				TargetControlID="DropDownList1" 
				Category="Category"
				LoadingText="LoadingCategories..." 
				PromptText="Select a Tag Category"
				ServicePath="TagService.asmx"
				ServiceMethod="GetTagCategories"/>
		<ajaxToolkit:CascadingDropDown ID="CascadingDropDown2" runat="server" 
				TargetControlID="DropDownList2" 
				Category="Category"
				LoadingText="LoadingCategories..." 
				PromptText="Select a Tag Category"
				ServicePath="TagService.asmx"
				ServiceMethod="GetTagCategories"/>
		<ajaxToolkit:CascadingDropDown ID="CascadingDropDown3" runat="server" 
				TargetControlID="DropDownList3" 
				Category="Category"
				LoadingText="LoadingCategories..." 
				PromptText="Select a Tag Category"
				ServicePath="TagService.asmx"
				ServiceMethod="GetTagCategories"/>
		<ajaxToolkit:CascadingDropDown ID="CascadingDropDown4" runat="server" 
				TargetControlID="DropDownList4" 
				Category="Category"
				LoadingText="LoadingCategories..." 
				PromptText="Select a Tag Category"
				ServicePath="TagService.asmx"
				ServiceMethod="GetTagCategories"/>
		<ajaxToolkit:CascadingDropDown ID="CascadingDropDown5" runat="server" 
				TargetControlID="DropDownList5" 
				Category="Category"
				LoadingText="LoadingCategories..." 
				PromptText="Select a Tag Category"
				ServicePath="TagService.asmx"
				ServiceMethod="GetTagCategories"/>
    </div>
</div>
 
<div class="form-group" style="margin-top:20px">
	<asp:Label ID="ErrorLabel" runat="server" Text="" Visible="false"
		CssClass="validator"></asp:Label>
	<br />
	<asp:Button runat="server" CssClass="btn btn-primary" Text="Search" 
		   CausesValidation="true" OnClick="Search_Click"/>
	
	
</div>

<br />
<br />
</asp:Content>
