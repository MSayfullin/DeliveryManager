<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="DeliveryEntitiesList.aspx.cs" Inherits="DeliveryManager.DeliveryEntities.DeliveryEntitiesList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <a href="AddEditBookPage.aspx">Add Book</a><br />
    <asp:GridView ID="BooksGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
        CellPadding="4" DataKeyNames="Id" DataSourceID="BooksDataSource" ForeColor="#333333"
        GridLines="Vertical" Width="100%" EmptyDataText="No books. You can easily create some =)"
        Caption="Books" CaptionAlign="Left">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="ISBN" HeaderText="ISBN" SortExpression="ISBN">
                <HeaderStyle Width="15%" />
            </asp:BoundField>
            <asp:HyperLinkField DataNavigateUrlFields="Id" DataNavigateUrlFormatString="AddEditBookPage.aspx?delivery_entity_id={0}"
                HeaderText="Name" NavigateUrl="~/DeliveryEntities/AddEditBookPage.aspx" DataTextField="Name">
                <HeaderStyle Width="65%" />
            </asp:HyperLinkField>
            <asp:BoundField DataField="Cost" HeaderText="Cost, -30%" SortExpression="Cost" DataFormatString="{0:c}">
                <HeaderStyle Width="10%" />
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" DataFormatString="{0:c}">
                <HeaderStyle Width="10%" />
                <ItemStyle HorizontalAlign="Right" />
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
    <asp:EntityDataSource ID="BooksDataSource" runat="server" ConnectionString="name=DeliveryManagerModelContainer"
        DefaultContainerName="DeliveryManagerModelContainer" EntitySetName="DeliveryEntities"
        EntityTypeFilter="Book" EnableFlattening="False">
    </asp:EntityDataSource>
    <br />
    <br />
    <a href="AddEditCDPage.aspx">Add CD</a><br />
    <asp:GridView ID="CDsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
        CellPadding="4" DataKeyNames="Id" DataSourceID="CDsDataSource" ForeColor="#333333"
        GridLines="Vertical" Width="100%" EmptyDataText="No CDs. You can easily create some =)"
        Caption="CDs" CaptionAlign="Left">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="Format" HeaderText="Format" SortExpression="Format">
                <HeaderStyle Width="10%" />
            </asp:BoundField>
            <asp:HyperLinkField DataNavigateUrlFields="Id" DataNavigateUrlFormatString="AddEditCDPage.aspx?delivery_entity_id={0}"
                DataTextField="Name" HeaderText="Name" NavigateUrl="~/DeliveryEntities/AddEditCDPage.aspx">
                <HeaderStyle Width="70%" />
            </asp:HyperLinkField>
            <asp:BoundField DataField="Cost" HeaderText="Cost, -30%" SortExpression="Cost" DataFormatString="{0:c}">
                <HeaderStyle Width="10%" />
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" DataFormatString="{0:c}">
                <HeaderStyle Width="10%" />
                <ItemStyle HorizontalAlign="Right" />
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
    <asp:EntityDataSource ID="CDsDataSource" runat="server" ConnectionString="name=DeliveryManagerModelContainer"
        DefaultContainerName="DeliveryManagerModelContainer" EntitySetName="DeliveryEntities"
        EntityTypeFilter="CD" EnableFlattening="False">
    </asp:EntityDataSource>
</asp:Content>
