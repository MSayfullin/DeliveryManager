<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="CorrectionsList.aspx.cs" Inherits="DeliveryManager.Corrections.CorrectionsList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <a href="AddEditCorrectionPage.aspx">Add Correction</a><br />
    <br />
    <asp:GridView ID="CorrectionsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
        CellPadding="4" DataKeyNames="Id" DataSourceID="CorrectionsDataSource" ForeColor="#333333"
        GridLines="Vertical" PageSize="15" Width="100%" EmptyDataText="No corrections. You can easily create some =)">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="Id" DataNavigateUrlFormatString="AddEditCorrectionPage.aspx?correction_id={0}"
                DataTextField="Date" HeaderText="Date" NavigateUrl="~/Corrections/AddEditCorrectionPage.aspx"
                DataTextFormatString="{0:D}">
                <HeaderStyle Width="120px" />
                <ItemStyle HorizontalAlign="Center" />
            </asp:HyperLinkField>
            <asp:TemplateField HeaderText="Correction Type">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("CorrectionType.Name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="TotalCost" HeaderText="Total Cost" SortExpression="TotalCost"
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
        <SortedAscendingCellStyle BackColor="#E9E7E2"></SortedAscendingCellStyle>
        <SortedAscendingHeaderStyle BackColor="#506C8C"></SortedAscendingHeaderStyle>
        <SortedDescendingCellStyle BackColor="#FFFDF8"></SortedDescendingCellStyle>
        <SortedDescendingHeaderStyle BackColor="#6F8DAE"></SortedDescendingHeaderStyle>
    </asp:GridView>
    <asp:EntityDataSource ID="CorrectionsDataSource" runat="server" ConnectionString="name=DeliveryManagerModelContainer"
        DefaultContainerName="DeliveryManagerModelContainer" EntitySetName="Corrections"
        EntityTypeFilter="Correction" OrderBy="it.[Date] DESC" Include="CorrectionType, CorrectionEntries.DepotEntry.DeliveryEntity"
        EnableFlattening="False">
    </asp:EntityDataSource>
</asp:Content>
