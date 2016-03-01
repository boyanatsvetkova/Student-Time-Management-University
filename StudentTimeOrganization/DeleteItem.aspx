<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DeleteItem.aspx.cs" Inherits="StudentTimeOrganization.DeleteItem" %>
<asp:Content ID="DeleteTask" ContentPlaceHolderID="MainContent" runat="server">
    <section id="Alert">
        <asp:Label ID="LabelAlertMessage" runat="server" Text="Are you sure you want to delete the task?">
        </asp:Label>
        <asp:Button ID="ButtonYes" runat="server" Text="Yes" OnClick="ButtonYes_Click" />
        <asp:Button ID="ButtonNo" runat="server" Text="No" OnClick="ButtonNo_Click" />
    </section>
</asp:Content>
