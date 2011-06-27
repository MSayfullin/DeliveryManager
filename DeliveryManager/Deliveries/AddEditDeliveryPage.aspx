<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="AddEditDeliveryPage.aspx.cs" Inherits="DeliveryManager.Deliveries.AddEditDeliveryPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="AddEditPanel" runat="server" Visible="true">
        <table width="100%">
            <tr>
                <td colspan="3">
                    <asp:Label ID="Label" runat="server" Text="[PlaceHolder]"></asp:Label>
                </td>
            </tr>
            <tr>
                <td valign="top" width="205px" rowspan="9">
                    <asp:Calendar ID="Calendar" runat="server" BackColor="White" BorderColor="#999999"
                        CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt"
                        ForeColor="Black" Height="180px" Width="200px">
                        <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                        <NextPrevStyle VerticalAlign="Bottom" />
                        <OtherMonthDayStyle ForeColor="#808080" />
                        <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                        <SelectorStyle BackColor="#CCCCCC" />
                        <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                        <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                        <WeekendDayStyle BackColor="#FFFFCC" />
                    </asp:Calendar>
                </td>
            </tr>
            <tr>
                <td valign="top" width="7%">
                    Delivery Type:
                </td>
                <td valign="top">
                    <asp:DropDownList ID="DeliveryTypesList" runat="server" Width="300px" OnLoad="DeliveryTypeList_Load">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="DeliveryTypesRequiredFieldValidator" runat="server"
                        ControlToValidate="DeliveryTypesList" ErrorMessage="Delivery Type is required field"
                        SetFocusOnError="True" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    Status:
                </td>
                <td>
                    <asp:DropDownList ID="StatusesList" runat="server" Width="300px">
                        <asp:ListItem Selected="True">В процессе</asp:ListItem>
                        <asp:ListItem>Доставлено</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td valign="top" width="10%">
                    Courier:
                </td>
                <td valign="top">
                    <asp:DropDownList ID="CouriersList" runat="server" Width="300px" OnLoad="CouriersList_Load">
                    </asp:DropDownList>
                    <a href="../Users/AddEditCourierPage.aspx" target="_blank">Add Courier</a>
                </td>
            </tr>
            <tr>
                <td>
                    Address:
                </td>
                <td>
                    <asp:TextBox ID="AddressTextBox" runat="server" Width="500px" TextMode="MultiLine"></asp:TextBox><br />
                    <asp:RequiredFieldValidator ID="AddressRequiredFieldValidator" runat="server" ControlToValidate="AddressTextBox"
                        ErrorMessage="Address is required field" SetFocusOnError="True" ForeColor="Red"
                        Display="Dynamic"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    Total Price:
                </td>
                <td>
                    <asp:Label ID="TotalPriceLabel" runat="server" Text="[PlaceHolder]"></asp:Label>
                </td>
            </tr>
            <tr>
                <td valign="top" width="7%">
                    Orders:
                </td>
                <td valign="top">
                    <asp:GridView ID="OrdersGridView" runat="server" CellPadding="4" ForeColor="#333333"
                        GridLines="None" Width="100%" AllowPaging="True" AutoGenerateColumns="False"
                        DataSourceID="OrdersDataSource" EmptyDataText="No order is available" DataKeyNames="Id">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:TemplateField>
                                <HeaderStyle Width="15px" />
                                <ItemTemplate>
                                    <asp:CheckBox ID="IncludeCheckBox" runat="server" ToolTip="Include in delivery?" />
                                    <asp:HiddenField ID="HiddenField" runat="server" Value='<%# Eval("Id") %>' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="Number" HeaderText="Number" SortExpression="Number">
                                <HeaderStyle Width="200px" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Client" SortExpression="Client">
                                <ItemTemplate>
                                    <asp:Label ID="ClientLabel" runat="server" Text='<%# Eval("Client.CombinedName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="TotalPrice" HeaderText="TotalPrice" SortExpression="TotalPrice"
                                DataFormatString="{0:c}">
                                <HeaderStyle Width="60px" />
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
                <td>
                    Notes:
                </td>
                <td>
                    <asp:TextBox ID="NotesTextBox" runat="server" TextMode="MultiLine" Width="100%"></asp:TextBox>
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
        <asp:EntityDataSource ID="OrdersDataSource" runat="server" ConnectionString="name=DeliveryManagerModelContainer"
            DefaultContainerName="DeliveryManagerModelContainer" EntitySetName="Orders" EntityTypeFilter="Order"
            OrderBy="it.[Date] desc" EnableFlattening="False" Include="Client, OrderEntries.DeliveryEntity, Delivery"
            Where="it.[WithoutDelivery] = False AND (it.[Delivery] IS NULL OR it.[DeliveryId] = @delivery_id)">
            <WhereParameters>
                <asp:QueryStringParameter Name="delivery_id" QueryStringField="delivery_id" Type="Int32" />
            </WhereParameters>
        </asp:EntityDataSource>
    </asp:Panel>
    <asp:Panel ID="ErrorPanel" runat="server" Visible="false" HorizontalAlign="Center">
        <asp:Label ID="ErrorLabel" runat="server" Text="[PlaceHolder]" ForeColor="Red"></asp:Label>
    </asp:Panel>
</asp:Content>
