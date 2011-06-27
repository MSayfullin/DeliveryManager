using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DeliveryManager.DeliveryManagerModel;
using System.Drawing;

namespace DeliveryManager.DeliveryEntities
{
    public partial class AddEditDeliveryEntity : MasterPage
    {
        private DeliveryEntity internalDeliveryEntityValue = null;
        internal DeliveryEntity DeliveryEntity
        {
            get
            {
                if (internalDeliveryEntityValue == null)
                {
                    var deliveryEntityIDParam = Request.QueryString[DeliveryEntityConstants.IDParamName];
                    if (deliveryEntityIDParam != null)
                    {
                        int deliveryEntityID;
                        if (Int32.TryParse(deliveryEntityIDParam, out deliveryEntityID))
                        {
                            var container = new DeliveryManagerModelContainer();
                            internalDeliveryEntityValue = container.DeliveryEntities.SingleOrDefault(de => de.Id == deliveryEntityID);
                            if (internalDeliveryEntityValue == null)
                                TurnOnErrorPanel(deliveryEntityIDParam);
                        }
                        else
                            TurnOnErrorPanel(deliveryEntityIDParam);
                    }
                }
                return internalDeliveryEntityValue;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                if (DeliveryEntity != null)
                {
                    Label.Text = String.Format("Edit '{0}'", DeliveryEntity.Name);

                    NameTextBox.Text = DeliveryEntity.Name;
                    PriceTextBox.Text = DeliveryEntity.Price.ToString("0.##");
                    CostLabel.Text = DeliveryEntity.Cost.ToString("C");
                }
                else
                {
                    Label.Text = String.Format("Add new {0}", GetDeliveryEntityType());

                    CostLabel.Text = String.Empty;
                }
                NameTextBox.Focus();
            }
        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            Decimal price;
            if (Decimal.TryParse(PriceTextBox.Text, out price))
            {
                var container = new DeliveryManagerModelContainer();

                DeliveryEntity deliveryEntity;
                var deliveryEntityIDParam = Request.QueryString[DeliveryEntityConstants.IDParamName];
                if (deliveryEntityIDParam != null)
                {
                    int deliveryEntityID = Int32.Parse(deliveryEntityIDParam);
                    deliveryEntity = container.DeliveryEntities.Single(de => de.Id == deliveryEntityID);
                    if (Page is AddEditBookPage)
                        (deliveryEntity as Book).ISBN = (Page as AddEditBookPage).ISBN;
                    else// if (Page is AddEditCDPage)
                        (deliveryEntity as CD).Format = (Page as AddEditCDPage).Format;
                }
                else
                {
                    if (Page is AddEditBookPage)
                        deliveryEntity = new Book { ISBN = (Page as AddEditBookPage).ISBN };
                    else// if (Page is AddEditCDPage)
                        deliveryEntity = new CD { Format = (Page as AddEditCDPage).Format };

                    container.DeliveryEntities.AddObject(deliveryEntity);
                }
                deliveryEntity.Name = NameTextBox.Text.Trim();

                deliveryEntity.Price = price;
                deliveryEntity.Cost = Decimal.Multiply(deliveryEntity.Price, 0.7m);

                container.SaveChanges();

                Response.Redirect("~/DeliveryEntities/DeliveryEntitiesList.aspx", true);
            }
            else
            {
                Label.ForeColor = Color.Red;
                Label.Text = "Check Price value";
            }
        }

        private string GetDeliveryEntityType()
        {
            return this.Page is AddEditBookPage ? "book" : "CD";
        }

        private void TurnOnErrorPanel(string deliveryEntityIDParam)
        {
            AddEditPanel.Visible = false;
            ErrorPanel.Visible = true;
            ErrorLabel.Text = string.Format("Error loading {0} with '{1}' ID", GetDeliveryEntityType(), deliveryEntityIDParam);
        }
    }
}