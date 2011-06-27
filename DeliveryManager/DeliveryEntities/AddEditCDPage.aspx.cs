using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DeliveryManager.DeliveryManagerModel;

namespace DeliveryManager.DeliveryEntities
{
    public partial class AddEditCDPage : Page
    {
        internal string Format
        {
            get { return FormatTextBox.Text; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                var master = (AddEditDeliveryEntity)Page.Master;
                if (master != null && master.DeliveryEntity != null)
                {
                    FormatTextBox.Text = (master.DeliveryEntity as CD).Format;
                }
            }
        }
    }
}