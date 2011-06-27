<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="UsersList.aspx.cs" Inherits="DeliveryManager.Users.UsersList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <a href="AddEditClientPage.aspx">Add Client</a><br />
    <asp:GridView ID="ClientsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
        CellPadding="4" DataKeyNames="Id" DataSourceID="ClientsDataSource" ForeColor="#333333"
        GridLines="Vertical" Width="100%" EmptyDataText="No clients. You can easily create some =)"
        Caption="Clients" CaptionAlign="Left">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="Id" DataNavigateUrlFormatString="AddEditClientPage.aspx?user_id={0}"
                HeaderText="Name" NavigateUrl="~/Users/AddEditClientPage.aspx" DataTextField="CombinedName">
                <HeaderStyle Width="60%" />
            </asp:HyperLinkField>
            <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone">
                <HeaderStyle Width="15%" />
            </asp:BoundField>
            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email">
                <HeaderStyle Width="25%" />
            </asp:BoundField>
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Right" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
    <asp:EntityDataSource ID="ClientsDataSource" runat="server" ConnectionString="name=DeliveryManagerModelContainer"
        DefaultContainerName="DeliveryManagerModelContainer" EntitySetName="Users" EntityTypeFilter="Client"
        EnableFlattening="False">
    </asp:EntityDataSource>
    <br />
    <br />
    <a href="AddEditCourierPage.aspx">Add Courier</a><br />
    <asp:GridView ID="CouriersGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
        CellPadding="4" DataKeyNames="Id" DataSourceID="CouriersDataSource" ForeColor="#333333"
        GridLines="Vertical" Width="100%" EmptyDataText="No couriers. You can easily create some =)"
        Caption="Couriers" CaptionAlign="Left">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="Id" DataNavigateUrlFormatString="AddEditCourierPage.aspx?user_id={0}"
                HeaderText="Name" NavigateUrl="~/Users/AddEditCourierPage.aspx" DataTextField="CombinedName">
                <HeaderStyle Width="60%" />
            </asp:HyperLinkField>
            <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone">
                <HeaderStyle Width="15%" />
            </asp:BoundField>
            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email">
                <HeaderStyle Width="25%" />
            </asp:BoundField>
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Right" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
    <asp:EntityDataSource ID="CouriersDataSource" runat="server" ConnectionString="name=DeliveryManagerModelContainer"
        DefaultContainerName="DeliveryManagerModelContainer" EntitySetName="Users" EntityTypeFilter="Courier"
        EnableFlattening="False">
    </asp:EntityDataSource>
</asp:Content>
