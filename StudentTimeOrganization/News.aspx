<%@ Page Title="News" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="News.aspx.cs" Inherits="StudentTimeOrganization.News" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %></h2>

    <asp:EntityDataSource
        ID="EntityDataSourceNews"
        runat="server"
        ConnectionString="name=ProjectStudentTimeOrganizationEntities"
        DefaultContainerName="ProjectStudentTimeOrganizationEntities"
        EnableFlattening="False"
        EnableUpdate="True"
        EnableInsert="true"
        EnableDelete="true"
        EntitySetName="News">
    </asp:EntityDataSource>

    <div>
        <asp:ListView ID="ListViewNews"
            runat="server"
            DataKeyNames="News_ID"
            ItemType="StudentTimeOrganization.News"
            DataSourceID="EntityDataSourceNews">
            <LayoutTemplate>
                <span runat="server" id="itemPlaceholder" />
                <div class="pagerLine">
                    <asp:DataPager ID="DataPagerNotes" runat="server" PageSize="7">
                        <Fields>
                            <asp:NextPreviousPagerField ShowFirstPageButton="True"
                                ShowNextPageButton="False" ShowPreviousPageButton="False" ButtonCssClass="btn btn-info" />
                            <asp:NumericPagerField />
                            <asp:NextPreviousPagerField ShowLastPageButton="True"
                                ShowNextPageButton="False" ShowPreviousPageButton="False" ButtonCssClass="btn btn-info" />
                        </Fields>
                    </asp:DataPager>
                </div>
            </LayoutTemplate>
            <ItemTemplate>
                <div class="block-label">
                    <span><asp:Label ID="LabelNoteTitle" runat="server" Text='<%#: Item.News_Title  %>' CssClass="label label-default"/></span>            
                </div>
                <div class="block-label">
                   <asp:Label ID="LabelNoteContent" runat="server" Text='<%#: Item.News_Content  %>'/>
                </div>
                <div class="block-label">
                    Date:
            <asp:Label ID="LabelNoteDate" runat="server" Text='<%#: Item.News_Creation_Date  %>' CssClass="label label-default"/>
                </div>
            </ItemTemplate>
        </asp:ListView>
    </div>
</asp:Content>
