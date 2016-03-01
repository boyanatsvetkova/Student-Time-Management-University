<%@ Page Title="Schedule" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Schedule.aspx.cs" Inherits="StudentTimeOrganization._Schedule" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>Schedule</h1>
        <asp:EntityDataSource runat="server" ID="EntityDataSourceTaskScheduler" ConnectionString="name=ProjectStudentTimeOrganizationEntities"
            DefaultContainerName="ProjectStudentTimeOrganizationEntities" EntitySetName="Tasks">
        </asp:EntityDataSource>
        <telerik:RadScheduler ID="RadSchedulerTaskScheduler"
            runat="server"
            DataSourceID="EntityDataSourceTaskScheduler"
            DayStartTime="06:00:00"
            DataKeyField="Task_Id"
            DataStartField="Date_Time"
            DataEndField="Date_Time"
            DataSubjectField="Task_Title" 
            AllowDelete="False" 
            AllowEdit="False" 
            AllowInsert="False" 
            ReadOnly="True" 
            OverflowBehavior="Expand">
        </telerik:RadScheduler>
    </div>

</asp:Content>
