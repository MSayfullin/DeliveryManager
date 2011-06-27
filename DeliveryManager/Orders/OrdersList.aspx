<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="OrdersList.aspx.cs" Inherits="DeliveryManager.Orders.OrdersList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <a href="AddEditOrderPage.aspx">Add Order</a><br />
    <br />
    <asp:GridView ID="OrdersGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
        CellPadding="4" DataKeyNames="Id" DataSourceID="OrdersDataSource" ForeColor="#333333"
        GridLines="Vertical" PageSize="15" Width="100%" EmptyDataText="No orders. You can easily create some =)">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" DataFormatString="{0:D}">
                <HeaderStyle Width="120px" />
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:HyperLinkField DataNavigateUrlFields="Id" DataNavigateUrlFormatString="AddEditOrderPage.aspx?order_id={0}"
                DataTextField="Number" HeaderText="Number" NavigateUrl="~/Orders/AddEditOrderPage.aspx">
                <HeaderStyle Width="200px" />
            </asp:HyperLinkField>
            <asp:TemplateField HeaderText="Client" SortExpression="Client">
                <ItemTemplate>
                    <asp:Label ID="ClientLabel" runat="server" Text='<%# Eval("Client.CombinedName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="TotalPrice" HeaderText="Total Price" SortExpression="TotalPrice"
                DataFormatString="{0:c}">
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
    <asp:EntityDataSource ID="OrdersDataSource" runat="server" ConnectionString="name=DeliveryManagerModelContainer"
        DefaultContainerName="DeliveryManagerModelContainer" EntitySetName="Orders" OrderBy="it.[Date] desc"
        EnableFlattening="False" Include="Client, OrderEntries.DeliveryEntity" EntityTypeFilter="Order">
    </asp:EntityDataSource>
</asp:Content>
