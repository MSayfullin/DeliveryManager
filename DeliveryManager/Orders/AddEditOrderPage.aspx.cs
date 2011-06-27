using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DeliveryManager.DeliveryManagerModel;
using System.Drawing;

namespace DeliveryManager.Orders
{
    public partial class AddEditOrderPage : Page
    {
        private Order internalOrderValue = null;
        internal Order Order
        {
            get
            {
                if (internalOrderValue == null)
                {
                    var orderIDParam = Request.QueryString[OrderConstants.IDParamName];
                    if (orderIDParam != null)
                    {
                        int orderID;
                        if (Int32.TryParse(orderIDParam, out orderID))
                        {
                            var container = new DeliveryManagerModelContainer();
                            internalOrderValue = container.Orders.SingleOrDefault(d => d.Id == orderID);
                            if (internalOrderValue == null)
                                TurnOnErrorPanel(orderIDParam);
                        }
                        else
                            TurnOnErrorPanel(orderIDParam);
                    }
                }
                return internalOrderValue;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                if (this.Order != null)
                {
                    Label.Text = String.Format("Edit '{0}' order", this.Order.Number);

                    Calendar.VisibleDate = Calendar.SelectedDate = this.Order.Date;
                    NumberTextBox.Text = this.Order.Number;
                    WithoutDeliveryCheckBox.Checked = this.Order.WithoutDelivery;
                    WithoutDeliveryCheckBox.Enabled = !this.Order.DeliveryId.HasValue;
                    // Client value loaded when ClientsList control is loading
                    TotalPriceLabel.Text = this.Order.TotalPrice.ToString("C");

                    foreach (var entry in this.Order.OrderEntries)
                    {
                        foreach (GridViewRow row in EntriesGridView.Rows)
                        {
                            var hdnField = row.Cells[0].Controls.OfType<HiddenField>().Single();
                            var depotEntryId = Int32.Parse(hdnField.Value);
                            if (entry.DepotEntry.Id == depotEntryId)
                            {
                                var chkBox = row.Cells[0].Controls.OfType<CheckBox>().Single();
                                chkBox.Enabled = true;
                                chkBox.Checked = true;
                                var txtBox = row.Cells[0].Controls.OfType<TextBox>().Single();
                                txtBox.Enabled = true;
                                txtBox.Text = entry.Count.ToString();
                                break;
                            }
                        }
                    }
                }
                else
                {
                    Label.Text = "Add new order";

                    Calendar.SelectedDate = DateTime.Now;
                    NumberTextBox.Text = String.Format("{0}{1}", OrderConstants.SPbNumberAbbr, GetFreeSPbNumber());
                    TotalPriceLabel.Text = String.Format("{0:C}", 0);
                }
                NumberTextBox.Focus();
            }
        }

        protected void ClientsList_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                var container = new DeliveryManagerModelContainer();
                var clients = container.Users.OfType<Client>();

                bool additionProcess = false;
                // Adding empty entry to create client explicitly and not to assign first from list
                if (this.Order == null)
                {
                    additionProcess = true;
                    this.ClientsList.Items.Add(new ListItem(String.Empty, null));
                }
                foreach (var client in clients)
                {
                    var listItem = new ListItem(client.FullName.Combined, client.Id.ToString());
                    // Do not select any client if addition mode
                    if (!additionProcess && client.Id == this.Order.ClientId)
                        listItem.Selected = true;

                    this.ClientsList.Items.Add(listItem);
                }
            }
        }

        protected void EntriesGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var depotEntry = e.Row.DataItem as DepotEntry;
                if (depotEntry.Count == 0)
                    e.Row.BackColor = Color.Pink;
            }
        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            var container = new DeliveryManagerModelContainer();

            Order order;
            var orderIDParam = Request.QueryString[OrderConstants.IDParamName];
            if (orderIDParam != null)
            {
                int orderID = Int32.Parse(orderIDParam);
                order = container.Orders.Single(d => d.Id == orderID);
            }
            else
            {
                order = new Order();
                container.Orders.AddObject(order);
            }
            order.Number = NumberTextBox.Text.Trim();
            order.WithoutDelivery = WithoutDeliveryCheckBox.Checked;
            order.Date = Calendar.SelectedDate;
            order.ClientId = Int32.Parse(ClientsList.SelectedValue);

            foreach (GridViewRow row in EntriesGridView.Rows)
            {
                var hdnField = row.Cells[0].Controls.OfType<HiddenField>().Single();
                var depotEntryId = Int32.Parse(hdnField.Value);
                var depotEntry = container.Entries.Single(de => de.Id == depotEntryId) as DepotEntry;
                var orderEntry = order.OrderEntries.SingleOrDefault(oe => oe.DepotEntry.Id == depotEntryId);

                var chkBox = row.Cells[0].Controls.OfType<CheckBox>().Single();
                if (chkBox.Checked)
                {
                    var txtBox = row.Cells[0].Controls.OfType<TextBox>().Single();
                    int count;
                    if (!Int32.TryParse(txtBox.Text, out count) || count < 1)
                        count = 1;

                    if (orderEntry == null)
                    {
                        orderEntry = new OrderEntry
                        {
                            DepotEntry = depotEntry,
                            DeliveryEntityId = depotEntry.DeliveryEntityId,
                            Cost = depotEntry.DeliveryEntity.Cost,
                            Price = depotEntry.DeliveryEntity.Price
                        };
                        order.OrderEntries.Add(orderEntry);
                    }
                    orderEntry.Count = count;
                }
                else
                {
                    if (orderEntry != null)
                    {
                        // return entities back
                        depotEntry.Count += orderEntry.Count;
                        container.Entries.DeleteObject(orderEntry);
                    }
                }
            }

            container.SaveChanges();

            Response.Redirect("~/Orders/OrdersList.aspx", true);
        }

        private static int GetFreeSPbNumber()
        {
            var container = new DeliveryManagerModelContainer();
            var spbNumbers = container.Orders.Where(o => o.Number.StartsWith(OrderConstants.SPbNumberAbbr)).Select(o => o.Number);
            var numbers = new List<int>() { 1000 };
            foreach (var spbNumber in spbNumbers)
            {
                var splited = spbNumber.Split('/');
                int number;
                if (splited.Length == 2 && Int32.TryParse(splited[1], out number))
                    numbers.Add(number);
            }
            return numbers.Max() + 1;
        }

        private void TurnOnErrorPanel(string orderIDParam)
        {
            AddEditPanel.Visible = false;
            ErrorPanel.Visible = true;
            ErrorLabel.Text = string.Format("Error loading order with '{0}' ID", orderIDParam);
        }
    }
}