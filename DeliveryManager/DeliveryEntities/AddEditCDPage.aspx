<%@ Page Title="" Language="C#" MasterPageFile="~/DeliveryEntities/AddEditDeliveryEntity.master"
    AutoEventWireup="true" CodeBehind="AddEditCDPage.aspx.cs" Inherits="DeliveryManager.DeliveryEntities.AddEditCDPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="NestedContent" runat="server">
    <table width="100%">
        <tr>
            <td valign="top" width="10%">
                Format:
            </td>
            <td>
                <asp:TextBox ID="FormatTextBox" runat="server" Width="100px"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
