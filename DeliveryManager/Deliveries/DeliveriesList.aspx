<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="DeliveriesList.aspx.cs" Inherits="DeliveryManager.Deliveries.DeliveriesList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <a href="AddEditDeliveryPage.aspx">Add Delivery</a><br />
    <br />
    <asp:GridView ID="DeliveriesGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
        CellPadding="4" DataKeyNames="Id" DataSourceID="DeliveriesDataSource" ForeColor="#333333"
        GridLines="Vertical" PageSize="15" Width="100%" EmptyDataText="No deliveries. You can easily create some =)">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:HyperLink ID="PrintHyperLink" runat="server" NavigateUrl='<%# Eval("Id", "PrintDeliveryPage.aspx?delivery_id={0}") %>'
                        Text="Print"></asp:HyperLink>
                </ItemTemplate>
                <HeaderStyle Width="40px" />
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:HyperLinkField DataNavigateUrlFields="Id" DataNavigateUrlFormatString="AddEditDeliveryPage.aspx?delivery_id={0}"
                DataTextField="Date" HeaderText="Date" NavigateUrl="~/Deliveries/AddEditDeliveryPage.aspx"
                DataTextFormatString="{0:D}">
                <HeaderStyle Width="120px" />
                <ItemStyle HorizontalAlign="Center" />
            </asp:HyperLinkField>
            <asp:TemplateField HeaderText="Orders">
                <ItemTemplate>
                    <asp:Label ID="OrdersLabel" runat="server" Text='<%# Eval("OrderNumbers") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Courier" SortExpression="Courier">
                <ItemTemplate>
                    <asp:Label ID="CourierLabel" runat="server" Text='<%# Eval("Courier.CombinedName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Address" SortExpression="Address">
                <ItemTemplate>
                    <asp:Label ID="AddressLabel" runat="server" Text='<%# Eval("Address.Details") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="TotalPrice" HeaderText="Total Price" SortExpression="TotalPrice"
                DataFormatString="{0:c}">
                <HeaderStyle Width="70px" />
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status">
                <HeaderStyle Width="80px" />
                <ItemStyle HorizontalAlign="Center" />
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
    <asp:EntityDataSource ID="DeliveriesDataSource" runat="server" ConnectionString="name=DeliveryManagerModelContainer"
        DefaultContainerName="DeliveryManagerModelContainer" EntitySetName="Deliveries"
        OrderBy="it.[Status], it.[Date] desc" Include="DeliveryType, Courier, Orders.OrderEntries.DeliveryEntity"
        EntityTypeFilter="Delivery" EnableFlattening="False" Select="">
    </asp:EntityDataSource>
</asp:Content>
