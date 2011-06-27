﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="AddEditCorrectionPage.aspx.cs" Inherits="DeliveryManager.Corrections.AddEditCorrectionPage" %>

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
                <td valign="top" width="205px" rowspan="6">
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
                <td valign="top" width="11%">
                    Correction Type:
                </td>
                <td>
                    <asp:DropDownList ID="CorrectionTypeList" runat="server" Width="300px" DataSourceID="CorrectionTypesDataSource"
                        DataTextField="Name" DataValueField="Id">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    Total Cost:
                </td>
                <td>
                    <asp:Label ID="TotalCostLabel" runat="server" Text="[PlaceHolder]"></asp:Label>
                </td>
            </tr>
            <tr>
                <td valign="top" width="7%">
                    Entries:
                </td>
                <td valign="top">
                    <asp:GridView ID="EntriesGridView" runat="server" CellPadding="4" ForeColor="#333333"
                        Width="100%" AutoGenerateColumns="False" DataSourceID="DepotEntriesDataSource"
                        EmptyDataText="No entry is available" DataKeyNames="Id" GridLines="None" OnRowDataBound="EntriesGridView_RowDataBound">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:TemplateField>
                                <HeaderStyle Width="55px" />
                                <ItemTemplate>
                                    <asp:HiddenField ID="HiddenField" runat="server" Value='<%# Eval("Id") %>' />
                                    <asp:CheckBox ID="IncludeCheckBox" runat="server" ToolTip="Include in order?" />
                                    <asp:TextBox ID="CountTextBox" runat="server" Width="25px" ToolTip="How many?" />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField SortExpression="Count">
                                <ItemTemplate>
                                    <asp:Label ID="DepotEntryCountLabel" runat="server" ToolTip="How many items left"
                                        Text='<%# Eval("Count") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Name" SortExpression="DeliveryEntity.Name">
                                <ItemTemplate>
                                    <asp:Label ID="DeliveryEntityLabel" runat="server" Text='<%# Eval("DeliveryEntity.Name") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Type">
                                <ItemTemplate>
                                    <asp:Label ID="DeliveryEntityTypeLabel" runat="server" Text='<%# Eval("DeliveryEntity.EntityType") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Width="30px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Cost" SortExpression="DeliveryEntity.Cost">
                                <ItemTemplate>
                                    <asp:Label ID="DeliveryEntityCostLabel" runat="server" Text='<%# Eval("DeliveryEntity.Cost", "{0:c}") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Width="60px" />
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Depot" SortExpression="Depot.Name">
                                <ItemTemplate>
                                    <asp:Label ID="DepotNameLabel" runat="server" Text='<%# Eval("Depot.Name") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Width="20%" />
                            </asp:TemplateField>
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
        <asp:EntityDataSource ID="DepotEntriesDataSource" runat="server" ConnectionString="name=DeliveryManagerModelContainer"
            DefaultContainerName="DeliveryManagerModelContainer" EntitySetName="Entries"
            EntityTypeFilter="DepotEntry" OrderBy="it.Depot.Name, it.DeliveryEntity.Name"
            EnableFlattening="False" Include="Depot, DeliveryEntity">
        </asp:EntityDataSource>
        <asp:EntityDataSource ID="CorrectionTypesDataSource" runat="server" ConnectionString="name=DeliveryManagerModelContainer"
            DefaultContainerName="DeliveryManagerModelContainer" EntitySetName="CorrectionTypes"
            EntityTypeFilter="CorrectionType" EnableFlattening="False" Select="it.[Id], it.[Name]">
        </asp:EntityDataSource>
    </asp:Panel>
    <asp:Panel ID="ErrorPanel" runat="server" Visible="false" HorizontalAlign="Center">
        <asp:Label ID="ErrorLabel" runat="server" Text="[PlaceHolder]" ForeColor="Red"></asp:Label>
    </asp:Panel>
</asp:Content>
