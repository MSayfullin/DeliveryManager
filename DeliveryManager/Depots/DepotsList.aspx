<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="DepotsList.aspx.cs" Inherits="DeliveryManager.Depots.DepotsList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <a href="AddEditDepotPage.aspx">Add Depot</a><br />
    <br />
    <asp:GridView ID="DepotsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
        CellPadding="4" DataKeyNames="Id" DataSourceID="DepotsDataSource" ForeColor="#333333"
        GridLines="Vertical" PageSize="15" Width="100%" EmptyDataText="No depots. You can easily create some =)">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="Id" DataNavigateUrlFormatString="AddEditDepotPage.aspx?depot_id={0}"
                DataTextField="Name" HeaderText="Name" NavigateUrl="~/Depots/AddEditDepotPage.aspx">
                <HeaderStyle Width="20%" />
            </asp:HyperLinkField>
            <asp:TemplateField HeaderText="Address Details" SortExpression="Address.Details">
                <ItemTemplate>
                    <asp:Label ID="AddressLabel" runat="server" Text='<%# Eval("Address.Details") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="TotalCost" HeaderText="Total Cost" SortExpression="TotalCost"
                DataFormatString="{0:c}">
                <HeaderStyle Width="70px" />
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="TotalPrice" DataFormatString="{0:c}" HeaderText="Total Price"
                SortExpression="TotalPrice">
                <HeaderStyle Width="70px" />
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
    <asp:EntityDataSource ID="DepotsDataSource" runat="server" ConnectionString="name=DeliveryManagerModelContainer"
        DefaultContainerName="DeliveryManagerModelContainer" EntitySetName="Depots" EntityTypeFilter="Depot"
        OrderBy="it.[Name]" EnableFlattening="False" Include="DepotEntries.DeliveryEntity">
    </asp:EntityDataSource>
</asp:Content>
