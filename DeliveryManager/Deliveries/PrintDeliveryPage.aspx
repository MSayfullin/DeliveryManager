<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="PrintDeliveryPage.aspx.cs" Inherits="DeliveryManager.Deliveries.PrintDeliveryPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="Panel" runat="server" HorizontalAlign="Center">
        Your download should shortly begin.
    </asp:Panel>
    <asp:Panel ID="ErrorPanel" runat="server" Visible="false" HorizontalAlign="Center">
        <asp:Label ID="ErrorLabel" runat="server" Text="[PlaceHolder]" ForeColor="Red"></asp:Label>
    </asp:Panel>
</asp:Content>
