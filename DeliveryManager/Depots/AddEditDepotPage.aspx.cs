using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DeliveryManager.DeliveryManagerModel;
using System.Drawing;

namespace DeliveryManager.Depots
{
    public partial class AddDepotPage : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                var depotIDParam = Request.QueryString[DepotConstants.IDParamName];
                if (depotIDParam != null)
                {
                    int depotID;
                    if (Int32.TryParse(depotIDParam, out depotID))
                    {
                        var container = new DeliveryManagerModelContainer();
                        var depot = container.Depots.SingleOrDefault(d => d.Id == depotID);
                        if (depot != null)
                        {
                            Label.Text = String.Format("Edit '{0}' depot", depot.Name);

                            NameTextBox.Text = depot.Name;
                            AddressTextBox.Text = depot.Address.Details;

                            foreach (var entry in depot.DepotEntries)
                            {
                                foreach (GridViewRow row in EntriesGridView.Rows)
                                {
                                    var hdnField = row.Cells[0].Controls.OfType<HiddenField>().Single();
                                    var deliveryEntityId = Int32.Parse(hdnField.Value);
                                    if (entry.DeliveryEntityId == deliveryEntityId)
                                    {
                                        var txtBox = row.Cells[0].Controls.OfType<TextBox>().Single();
                                        txtBox.Text = entry.Count.ToString();
                                        if (entry.Count == 0)
                                            row.BackColor = Color.Pink;
                                        break;
                                    }
                                }
                            }
                        }
                        else
                            TurnOnErrorPanel(depotIDParam);
                    }
                    else
                        TurnOnErrorPanel(depotIDParam);
                }
                else
                    Label.Text = "Add new depot";

                NameTextBox.Focus();
            }
        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            var container = new DeliveryManagerModelContainer();

            Depot depot;
            var depotIDParam = Request.QueryString[DepotConstants.IDParamName];
            if (depotIDParam != null)
            {
                int depotID = Int32.Parse(depotIDParam);
                depot = container.Depots.Single(d => d.Id == depotID);
            }
            else
            {
                depot = new Depot();
                container.Depots.AddObject(depot);
            }
            depot.Name = NameTextBox.Text.Trim();
            depot.Address = new Address { Details = AddressTextBox.Text.Trim() };

            foreach (GridViewRow row in EntriesGridView.Rows)
            {
                var txtBox = row.Cells[0].Controls.OfType<TextBox>().Single();
                int count;
                if (Int32.TryParse(txtBox.Text, out count))
                {
                    var hdnField = row.Cells[0].Controls.OfType<HiddenField>().Single();
                    var deliveryEntityId = Int32.Parse(hdnField.Value);

                    var depotEntry = depot.DepotEntries.SingleOrDefault(de => de.DeliveryEntity.Id == deliveryEntityId);
                    if (depotEntry == null)
                    {
                        depotEntry = new DepotEntry { DeliveryEntityId = deliveryEntityId };
                        depot.DepotEntries.Add(depotEntry);
                    }
                    depotEntry.Count = count;
                }
            }

            container.SaveChanges();

            Response.Redirect("~/Depots/DepotsList.aspx", true);
        }

        private void TurnOnErrorPanel(string depotIDParam)
        {
            AddEditPanel.Visible = false;
            ErrorPanel.Visible = true;
            ErrorLabel.Text = String.Format("Error loading depot with '{0}' ID", depotIDParam);
        }
    }
}