﻿<%@ Page Title="" Language="C#" MasterPageFile="~/DeliveryEntities/AddEditDeliveryEntity.master"
    AutoEventWireup="true" CodeBehind="AddEditBookPage.aspx.cs" Inherits="DeliveryManager.DeliveryEntities.AddEditBookPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="NestedContent" runat="server">
    <table width="100%">
        <tr>
            <td valign="top" width="10%">
                ISBN:
            </td>
            <td>
                <asp:TextBox ID="ISBNTextBox" runat="server" Width="100px"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
