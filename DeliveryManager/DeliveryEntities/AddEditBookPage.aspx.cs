using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DeliveryManager.DeliveryManagerModel;

namespace DeliveryManager.DeliveryEntities
{
    public partial class AddEditBookPage : Page
    {
        internal string ISBN
        {
            get { return ISBNTextBox.Text; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                var master = (AddEditDeliveryEntity)Page.Master;
                if (master != null && master.DeliveryEntity != null)
                {
                    ISBNTextBox.Text = (master.DeliveryEntity as Book).ISBN;
                }
            }
        }
    }
}