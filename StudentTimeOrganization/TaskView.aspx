<%@ Page Title="Task View" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TaskView.aspx.cs" Inherits="StudentTimeOrganization.TaskView" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %></h2>

    <label class="form-label">Filter</label>
    <asp:DropDownList ID="DropDownListAuthorSearch" AutoPostBack="true" runat="server">
        <asp:ListItem Text="All" Value="" />
        <asp:ListItem Text="Boyana" />
        <asp:ListItem Text="Schedule" />
        <asp:ListItem Text="Moodle" />
    </asp:DropDownList>


    <section id="taskView">
        <asp:GridView ID="GridViewTask" runat="server"
            ItemType="StudentTimeOrganization.Task"
            DataKeyNames="Task_Id"
            DeleteMethod="GridViewTask_DeleteItem"
            SelectMethod="GridViewTask_GetData"
            AllowPaging="true"
            AllowSorting="true"
            AutoGenerateColumns="false"
            AutoGenerateSelectButton="true"
            OnSelectedIndexChanged="GridViewTask_SelectedIndexChanged"
            OnRowDataBound="GridViewTask_RowDataBound"
            OnPageIndexChanged="GridViewTask_PageIndexChanged"
            CssClass="table table-striped table-hover">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButtonDelete" runat="server" Text="Delete" CommandName="Delete"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Task_Title" HeaderText="Title" SortExpression="Task_Title" />
                <asp:BoundField DataField="Task_Content" HeaderText="Content" SortExpression="Task_Content" />
                <asp:BoundField DataField="Priority.Priority_Name" HeaderText="Priority" />
                <asp:BoundField DataField="State.State_Name" HeaderText="State" />
                <asp:BoundField DataField="Author.Author_Name" HeaderText="Author" />
                <asp:BoundField DataField="Date_Time" HeaderText="Time" SortExpression="Date_Time" />
            </Columns>
        </asp:GridView>
    </section>

    <section class="clearfix">
        <asp:EntityDataSource
            ID="EntityDataSourceTaskDetails"
            runat="server"
            ConnectionString="name=ProjectStudentTimeOrganizationEntities"
            DefaultContainerName="ProjectStudentTimeOrganizationEntities"
            EnableFlattening="False"
            EnableUpdate="True"
            EntitySetName="Tasks"
            Include="Priority,State,Type,Author"
            Where="it.Task_id=@TaskID">
            <WhereParameters>
                <asp:ControlParameter Name="TaskID" Type="Int32"
                    ControlID="GridViewTask" />
            </WhereParameters>
        </asp:EntityDataSource>

        <asp:EntityDataSource
            ID="EntityDataSourcePriorities"
            runat="server"
            ConnectionString="name=ProjectStudentTimeOrganizationEntities"
            DefaultContainerName="ProjectStudentTimeOrganizationEntities"
            EntitySetName="Priorities"
            EnableFlattening="False">
        </asp:EntityDataSource>

        <asp:EntityDataSource
            ID="EntityDataSourceStates"
            runat="server"
            ConnectionString="name=ProjectStudentTimeOrganizationEntities"
            DefaultContainerName="ProjectStudentTimeOrganizationEntities"
            EntitySetName="States"
            EnableFlattening="False">
        </asp:EntityDataSource>

        <asp:EntityDataSource
            ID="EntityDataSourceTypes"
            runat="server"
            ConnectionString="name=ProjectStudentTimeOrganizationEntities"
            DefaultContainerName="ProjectStudentTimeOrganizationEntities"
            EntitySetName="Types"
            EnableFlattening="False">
        </asp:EntityDataSource>

        <div class="left-insert">
            <h2>Task Details</h2>
            <asp:ListView ID="ListViewTaskDetails"
                runat="server"
                DataKeyNames="Task_Id"
                ItemType="StudentTimeOrganization.Task"
                DataSourceID="EntityDataSourceTaskDetails"
                OnItemDataBound="ListViewTaskDetails_ItemDataBound"
                OnItemUpdated="ListViewTaskDetails_ItemUpdated">
                <EditItemTemplate>
                    Title:
            <asp:TextBox ID="Task_TitleTextBox" runat="server" Text='<%# BindItem.Task_Title %>' CssClass="form-control" />
                    <br />
                    Content:
            <asp:TextBox ID="Task_ContentTextBox" runat="server" TextMode="MultiLine"
                Text='<%# BindItem.Task_Content %>' CssClass="form-control" />
                    <br />
                    Time:
            <asp:TextBox ID="Date_TimeTextBox" runat="server" Text='<%# BindItem.Date_Time %>' CssClass="form-control" />
                    <br />
                    Location:
            <asp:TextBox ID="Location_NameTextBox" runat="server" Text='<%# BindItem.Location_Name %>' CssClass="form-control" />
                    <br />
                    Priority:
            <asp:DropDownList ID="DropDownListPriorities" runat="server"
                DataSourceID="EntityDataSourcePriorities"
                DataValueField="Priority_Id"
                DataTextField="Priority_Name"
                SelectedValue="<%# BindItem.Priority_ID %>">
            </asp:DropDownList>
                    <br />
                    State:
            <asp:DropDownList ID="DropDownStates" runat="server"
                DataSourceID="EntityDataSourceStates"
                DataValueField="State_ID"
                DataTextField="State_Name"
                SelectedValue="<%# BindItem.State_ID %>">
            </asp:DropDownList>
                    <br />
                    Type:
            <asp:DropDownList ID="DropDownListTypes" runat="server"
                DataSourceID="EntityDataSourceTypes"
                DataValueField="Type_ID"
                DataTextField="Type_Name"
                SelectedValue="<%# BindItem.Type_ID %>">
            </asp:DropDownList>
                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" CssClass="btn btn-primary" />
                    &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-primary" />
                </EditItemTemplate>
                <ItemTemplate>
                    Task ID:
                <asp:Label ID="TaskID_Label" runat="server" Text='<%# Item.Task_Id %>' />
                    <br />
                    Title:
            <asp:Label ID="Task_TitleLabel" runat="server" Text='<%#: Item.Task_Title%>' />
                    <br />
                    Content:
            <asp:Label ID="Task_ContentLabel" runat="server" Text='<%#: Item.Task_Content %>' />
                    <br />
                    Time:
            <asp:Label ID="Date_TimeLabel" runat="server" Text='<%#: Item.Date_Time %>' />
                    <br />
                    Location:
            <asp:Label ID="Location_NameLabel" runat="server" Text='<%#: (Item.Location_Name != null) ? Item.Location_Name : "none" %>' />
                    <br />
                    Author:
            <asp:Label ID="AuthorLabel" runat="server" Text='<%#: Item.Author.Author_Name %>' />
                    <br />
                    Priority:
            <asp:Label ID="PriorityLabel" runat="server" Text='<%#: Item.Priority.Priority_Name %>' />
                    <br />
                    State:
            <asp:Label ID="StateLabel" runat="server" Text='<%#: Item.State.State_Name %>' />
                    <br />
                    Type:
            <asp:Label ID="TypeLabel" runat="server" Text='<%#: Item.Type.Type_Name %>' />
                    <br />
                    <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" CssClass="btn btn-primary" />
                </ItemTemplate>
            </asp:ListView>
        </div>

        <asp:EntityDataSource
            ID="EntityDataSourceNotes"
            runat="server"
            ConnectionString="name=ProjectStudentTimeOrganizationEntities"
            DefaultContainerName="ProjectStudentTimeOrganizationEntities"
            EnableFlattening="False"
            EnableUpdate="True"
            EnableInsert="true"
            EnableDelete="true"
            EntitySetName="Notes"
            Where="it.Task_id=@TaskID">
            <WhereParameters>
                <asp:ControlParameter Name="TaskID" Type="Int32"
                    ControlID="GridViewTask" />
            </WhereParameters>
        </asp:EntityDataSource>

        <div class="right-insert">
            <h2>Task Notes</h2>
            <asp:ListView ID="ListViewNotes"
                runat="server"
                DataKeyNames="Note_ID"
                ItemType="StudentTimeOrganization.Note"
                DataSourceID="EntityDataSourceNotes"
                InsertItemPosition="LastItem"
                OnItemInserted="ListViewNotes_ItemInserted">
                <LayoutTemplate>
                    <span runat="server" id="itemPlaceholder" />
                    <div class="pagerLine">
                        <asp:LinkButton ID="ButtonInsertNote" Text="Insert" runat="server"
                            OnClick="LinkButtonInsertNote_Click" CssClass="btn btn-primary" />
                        <asp:DataPager ID="DataPagerNotes" runat="server" PageSize="2">
                            <Fields>
                                <asp:NextPreviousPagerField ShowFirstPageButton="True"
                                    ShowNextPageButton="False" ShowPreviousPageButton="False"  ButtonCssClass="btn btn-info"/>
                                <asp:NumericPagerField />
                                <asp:NextPreviousPagerField ShowLastPageButton="True"
                                    ShowNextPageButton="False" ShowPreviousPageButton="False"  ButtonCssClass="btn btn-info"/>
                            </Fields>
                        </asp:DataPager>
                    </div>
                </LayoutTemplate>
                <EditItemTemplate>
                    Content:
            <asp:TextBox ID="Note_ContentTextBox" runat="server" TextMode="MultiLine" Rows="6" Columns="30" Text='<%# BindItem.Note_Content %>' CssClass="form-control" />
                    <br />
                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" CssClass="btn btn-primary" />
                    &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-primary" />
                </EditItemTemplate>
                <ItemTemplate>
                    <div class="block-label" >
                        Content:
            <asp:Label ID="LabelNoteContent" runat="server" Text='<%#:  Item.Note_Content %>' />
                    </div>
                    <asp:LinkButton ID="EditButtonNotes" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" CssClass="btn btn-primary" />
                    <asp:LinkButton ID="DeleteButtonNotes" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" CssClass="btn btn-primary" />
                </ItemTemplate>
                <InsertItemTemplate>
                    <div class="insertItem">
                        Content:
               <asp:TextBox ID="TextBoxNoteContent" runat="server" TextMode="MultiLine" Rows="6" Columns="30" Text='<%# BindItem.Note_Content %>' CssClass="form-control" />
                        <br />
                        Task ID:
               <asp:TextBox ID="TextBoxTaskID" runat="server" Text='<%# BindItem.Task_ID %>' CssClass="form-control" />
                        <br />
                        <asp:Button ID="ButtonInsert" runat="server" CommandName="Insert" Text="Insert" CssClass="btn btn-primary" />
                        <asp:Button ID="ButtonCancel" runat="server" CommandName="Cancel" Text="Clear" OnClick="ButtonCancel_Click" CssClass="btn btn-primary" />
                    </div>
                </InsertItemTemplate>
            </asp:ListView>
        </div>
    </section>

    <section id="TaskInsertion" class="clearfix">
        <h2>Add Task</h2>
        <div class="left-insert">
            <asp:Label ID="LabelTitle" runat="server" Text="Title" AssociatedControlID="TextBoxTitle" CssClass="control-label"></asp:Label>
            <asp:TextBox ID="TextBoxTitle" runat="server" AutoPostBack="True"
                placeholder="Task Title" CssClass="form-control">
            </asp:TextBox>
            <asp:RequiredFieldValidator ID="RquiredFieldTitle"
                runat="server"
                ErrorMessage="*Required"
                ControlToValidate="TextBoxTitle"
                ForeColor="Red" ValidationGroup="InsertTask">
            </asp:RequiredFieldValidator>
            <br />
            <asp:Label ID="LabelContent" runat="server" Text="Content" AssociatedControlID="TextBoxContent"></asp:Label>
            <asp:TextBox ID="TextBoxContent" runat="server" TextMode="MultiLine" Rows="6" Columns="30" AutoPostBack="True"
                placeholder="Task Content" CssClass="form-control">
            </asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldContent"
                runat="server"
                ErrorMessage="*Required"
                ControlToValidate="TextBoxContent"
                ForeColor="Red"
                ValidationGroup="InsertTask">
            </asp:RequiredFieldValidator>
            <br />
            <asp:Label ID="LabelPriority" runat="server" Text="Priority" AssociatedControlID="DropdownListPriority" CssClass="control-label"></asp:Label>
            <asp:DropDownList ID="DropdownListPriority" runat="server" AutoPostBack="True"
                DataTextField="Priority_Name" DataValueField="Priority_Id" AppendDataBoundItems="True">
                <asp:ListItem></asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="RequiredFieldPriority"
                runat="server"
                ErrorMessage="*Required"
                ControlToValidate="DropdownListPriority"
                ForeColor="Red"
                ValidationGroup="InsertTask">
            </asp:RequiredFieldValidator>
            <br />
            <asp:Label ID="LabelState" runat="server" Text="State" AssociatedControlID="DropdownListState" CssClass="control-label"></asp:Label>
            <asp:DropDownList ID="DropdownListState" runat="server" AutoPostBack="True"
                DataTextField="State_Name" DataValueField="State_ID" AppendDataBoundItems="true">
                <asp:ListItem></asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="RequiredFieldState"
                runat="server"
                ErrorMessage="*Required"
                ControlToValidate="DropdownListState"
                ForeColor="Red"
                ValidationGroup="InsertTask">
            </asp:RequiredFieldValidator>
            <br />
            <asp:Label ID="LabelType" runat="server" Text="Type" AssociatedControlID="DropdownListType" CssClass="control-label"></asp:Label>
            <asp:DropDownList ID="DropdownListType" runat="server" AutoPostBack="True"
                DataTextField="Type_Name" DataValueField="Type_ID" AppendDataBoundItems="true">
                <asp:ListItem></asp:ListItem>
            </asp:DropDownList>
            <br />
        </div>
        <div class="right-insert">
            <asp:Label ID="LabelCalendar" runat="server" Text="Task Date" AssociatedControlID="TextBoxCalendar"></asp:Label>
            <asp:TextBox ID="TextBoxCalendar" runat="server" placeholder="Click for task date"
                CssClass="form-control"></asp:TextBox>
            <juice:Datepicker runat="server" TargetControlID="TextBoxCalendar" />
            <asp:RequiredFieldValidator ID="RequiredFieldCalendar"
                runat="server"
                ErrorMessage="*Required"
                ControlToValidate="TextBoxCalendar"
                ForeColor="red"
                ValidationGroup="InsertTask">
            </asp:RequiredFieldValidator>
            <br />
            <asp:Label ID="LabelTime" runat="server" Text="Task Time" AssociatedControlID="TextBoxTime"></asp:Label>
            <asp:TextBox ID="TextBoxTime" runat="server" placeholder="Click for task time" CssClass="time_element form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldViewTime"
                runat="server"
                ErrorMessage="*Required"
                ControlToValidate="TextBoxTime"
                ForeColor="Red"
                ValidationGroup="InsertTask">
            </asp:RequiredFieldValidator>
            <br />
            <asp:Label ID="LabelLocation" runat="server" Text="Location" AssociatedControlID="TextBoxLocation"></asp:Label>
            <asp:TextBox ID="TextBoxLocation" runat="server" AutoPostBack="True" placeholder="Task Location" CssClass="form-control"></asp:TextBox>
            <br />
            <asp:Label ID="LabelNote" runat="server" Text="Note" AssociatedControlID="TextBoxNote"></asp:Label>
            <asp:TextBox ID="TextBoxNote" runat="server" TextMode="MultiLine"
                Rows="6" Columns="30" AutoPostBack="True" placeholder="Task Note" CssClass="form-control"></asp:TextBox>
            <br />
        </div>
    </section>

    <div class="insert-button">
        <asp:Button ID="ButtonInsert" runat="server" ValidationGroup="InsertTask" Text="Add Task" OnClick="ButtonInsert_Click" CssClass="btn btn-primary" />
        <asp:Label ID="LabelValidity" runat="server" Text="" class="block"></asp:Label>
    </div>

    <div>
        <asp:Button ID="SynchronizeData" runat="server" Text="Synchronize Data" OnClick="SynchronizeData_Click" CssClass="btn btn-primary" />
        <asp:Label ID="InsertLabel" runat="server" Text=""></asp:Label>
    </div>

    <link href="TimePicki-master/css/timepicki.css" rel="stylesheet" />
    <link href="Content/customStyles.css" rel="stylesheet" />
    <script src="TimePicki-master/js/jquery.min.js"></script>
    <script src="TimePicki-master/js/timepicki.js"></script>
    <script src="TimePicki-master/js/timeFunction.js"></script>
</asp:Content>
