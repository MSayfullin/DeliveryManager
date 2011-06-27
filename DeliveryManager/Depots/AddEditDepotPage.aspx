<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="AddEditDepotPage.aspx.cs" Inherits="DeliveryManager.Depots.AddDepotPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="AddEditPanel" runat="server" Visible="true">
        <table width="100%">
            <tr>
                <td colspan="2">
                    <asp:Label ID="Label" runat="server" Text="[PlaceHolder]"></asp:Label>
                </td>
            </tr>
            <tr>
                <td valign="top" width="7%">
                    Name:
                </td>
                <td>
                    <asp:TextBox ID="NameTextBox" runat="server" Width="200px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="NameRequiredValidator" runat="server" ControlToValidate="NameTextBox"
                        ErrorMessage="Name is required field" SetFocusOnError="True" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    Address:
                </td>
                <td>
                    <asp:TextBox ID="AddressTextBox" runat="server" Width="500px" TextMode="MultiLine"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    Entries:
                </td>
                <td>
                    <asp:GridView ID="EntriesGridView" runat="server" CellPadding="4" ForeColor="#333333"
                        GridLines="None" Width="100%" AutoGenerateColumns="False" DataSourceID="DeliveryEntitiesDataSource"
                        EmptyDataText="No entry is available">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:TemplateField>
                                <HeaderStyle Width="30px" />
                                <ItemTemplate>
                                    <asp:TextBox ID="CountTextBox" runat="server" Width="25px" ToolTip="How many?"></asp:TextBox>
                                    <asp:HiddenField ID="HiddenField" runat="server" Value='<%# Eval("Id") %>' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="Name" HeaderText="Name" />
                            <asp:TemplateField HeaderText="Type">
                                <ItemTemplate>
                                    <asp:Label ID="DeliveryEntityTypeLabel" runat="server" Text='<%# Eval("EntityType") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Width="30px" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="Price" DataFormatString="{0:c}" HeaderText="Price" SortExpression="Price">
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
                </td>
            </tr>
            <tr>
                <td colspan="2" align="right">
                    <asp:Button ID="SaveButton" runat="server" Text="Save" Width="60px" OnClick="SaveButton_Click" />
                    &nbsp;
                    <input id="CancelButton" type="button" value="Cancel" onclick="javascript:history.back(); return false;"
                        style="width: 60px" />
                </td>
            </tr>
        </table>
        <asp:EntityDataSource ID="DeliveryEntitiesDataSource" runat="server" ConnectionString="name=DeliveryManagerModelContainer"
            DefaultContainerName="DeliveryManagerModelContainer" EnableFlattening="False"
            EntitySetName="DeliveryEntities">
        </asp:EntityDataSource>
    </asp:Panel>
    <asp:Panel ID="ErrorPanel" runat="server" Visible="false" HorizontalAlign="Center">
        <asp:Label ID="ErrorLabel" runat="server" Text="[PlaceHolder]" ForeColor="Red"></asp:Label>
    </asp:Panel>
</asp:Content>
