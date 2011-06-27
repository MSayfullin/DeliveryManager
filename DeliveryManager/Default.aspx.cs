using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DeliveryManager
{
    public partial class _Default : Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            Response.Redirect("~/Deliveries/DeliveriesList.aspx");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
        }
    }
}
