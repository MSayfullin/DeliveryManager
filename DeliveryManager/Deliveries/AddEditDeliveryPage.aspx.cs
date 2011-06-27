using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DeliveryManager.DeliveryManagerModel;

namespace DeliveryManager.Deliveries
{
    public partial class AddEditDeliveryPage : Page
    {
        private Delivery internalDeliveryValue = null;
        internal Delivery Delivery
        {
            get
            {
                if (internalDeliveryValue == null)
                {
                    var deliveryIDParam = Request.QueryString[DeliveryConstants.IDParamName];
                    if (deliveryIDParam != null)
                    {
                        int deliveryID;
                        if (Int32.TryParse(deliveryIDParam, out deliveryID))
                        {
                            var container = new DeliveryManagerModelContainer();
                            internalDeliveryValue = container.Deliveries.SingleOrDefault(d => d.Id == deliveryID);
                            if (internalDeliveryValue == null)
                                TurnOnErrorPanel(deliveryIDParam);
                        }
                        else
                            TurnOnErrorPanel(deliveryIDParam);
                    }
                }
                return internalDeliveryValue;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                if (this.Delivery != null)
                {
                    Label.Text = String.Format("Edit delivery for '{0:D}'", this.Delivery.Date);

                    Calendar.VisibleDate = Calendar.SelectedDate = this.Delivery.Date;
                    // Delivery Type value is loaded when DeliveryTypeList control is loading
                    // Courier value is loaded when CouriersList control is loading
                    StatusesList.Text = this.Delivery.Status;
                    AddressTextBox.Text = this.Delivery.Address.Details;
                    NotesTextBox.Text = this.Delivery.Notes;
                    TotalPriceLabel.Text = this.Delivery.TotalPrice.ToString("C");

                    foreach (var order in this.Delivery.Orders)
                    {
                        foreach (GridViewRow row in OrdersGridView.Rows)
                        {
                            var hdnField = row.Cells[0].Controls.OfType<HiddenField>().Single();
                            var orderId = Int32.Parse(hdnField.Value);
                            if (order.Id == orderId)
                            {
                                var chkBox = row.Cells[0].Controls.OfType<CheckBox>().Single();
                                chkBox.Checked = true;
                                break;
                            }
                        }
                    }
                }
                else
                {
                    Label.Text = "Add new delivery";

                    Calendar.SelectedDate = DateTime.Now;
                    TotalPriceLabel.Text = String.Format("{0:C}", 0);
                }
            }
        }

        protected void DeliveryTypeList_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                var container = new DeliveryManagerModelContainer();
                foreach (var deliveryType in container.DeliveryTypes)
                {
                    var deliveryTypeName = String.Format("{0} : {1:C}", deliveryType.Name, deliveryType.Cost);
                    var listItem = new ListItem(deliveryTypeName, deliveryType.Id.ToString());
                    listItem.Selected = (this.Delivery == null) ? deliveryType.IsDefault : deliveryType.Id == this.Delivery.DeliveryTypeId;
                    this.DeliveryTypesList.Items.Add(listItem);
                }
            }
        }

        protected void CouriersList_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                var container = new DeliveryManagerModelContainer();
                var couriers = container.Users.OfType<Courier>();
                this.CouriersList.Items.Add(new ListItem(String.Empty, null));
                foreach (var courier in couriers)
                {
                    var listItem = new ListItem(courier.FullName.Combined, courier.Id.ToString());
                    if (this.Delivery != null)
                        listItem.Selected = (courier.Id == this.Delivery.CourierId);
                    this.CouriersList.Items.Add(listItem);
                }
            }
        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            var container = new DeliveryManagerModelContainer();

            Delivery delivery;
            var deliveryIDParam = Request.QueryString[DeliveryConstants.IDParamName];
            if (deliveryIDParam != null)
            {
                int deliveryID = Int32.Parse(deliveryIDParam);
                delivery = container.Deliveries.Single(d => d.Id == deliveryID);
            }
            else
            {
                delivery = new Delivery();
                container.Deliveries.AddObject(delivery);
            }
            delivery.Date = Calendar.SelectedDate;
            delivery.DeliveryTypeId = Int32.Parse(DeliveryTypesList.SelectedValue);

            int deliveryCourierId;
            if (Int32.TryParse(CouriersList.SelectedValue, out deliveryCourierId))
                delivery.CourierId = deliveryCourierId;

            delivery.Status = StatusesList.Text;
            delivery.Address.Details = AddressTextBox.Text.Trim();
            delivery.Notes = NotesTextBox.Text.Trim();

            foreach (GridViewRow row in OrdersGridView.Rows)
            {
                var hdnField = row.Cells[0].Controls.OfType<HiddenField>().Single();
                var orderId = Int32.Parse(hdnField.Value);
                var deliveryOrder = delivery.Orders.SingleOrDefault(o => o.Id == orderId);
                var chkBox = row.Cells[0].Controls.OfType<CheckBox>().Single();
                if (chkBox.Checked)
                {
                    if (deliveryOrder == null)
                    {
                        var order = container.Orders.Single(o => o.Id == orderId);
                        delivery.Orders.Add(order);
                    }
                }
                else
                {
                    if (deliveryOrder != null)
                        delivery.Orders.Remove(deliveryOrder);
                }
            }

            container.SaveChanges();

            Response.Redirect("~/Deliveries/DeliveriesList.aspx", true);
        }

        private void TurnOnErrorPanel(string deliveryIDParam)
        {
            AddEditPanel.Visible = false;
            ErrorPanel.Visible = true;
            ErrorLabel.Text = string.Format("Error loading delivery with '{0}' ID", deliveryIDParam);
        }
    }
}