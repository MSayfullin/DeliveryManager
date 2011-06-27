using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DeliveryManager.ReportService;
using System.Net;
using DeliveryManager.DeliveryManagerModel;

namespace DeliveryManager.Deliveries
{
    public partial class PrintDeliveryPage : Page
    {
        private string deliveryIDParam;

        private Delivery internalDeliveryValue = null;
        internal Delivery Delivery
        {
            get
            {
                if (internalDeliveryValue == null)
                {
                    this.deliveryIDParam = Request.QueryString[DeliveryConstants.IDParamName];
                    if (this.deliveryIDParam != null)
                    {
                        int deliveryID;
                        if (Int32.TryParse(this.deliveryIDParam, out deliveryID))
                        {
                            var container = new DeliveryManagerModelContainer();
                            internalDeliveryValue = container.Deliveries.SingleOrDefault(d => d.Id == deliveryID);
                            if (internalDeliveryValue == null)
                                TurnOnErrorPanel(this.deliveryIDParam);
                        }
                        else
                            TurnOnErrorPanel(this.deliveryIDParam);
                    }
                    else
                        TurnOnErrorPanel(this.deliveryIDParam);
                }
                return internalDeliveryValue;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Delivery != null)
                this.RenderPDFtoResponse(DeliveryConstants.DeliveryFormReportName, String.Format("Order_{0}.pdf", this.Delivery.SafeOrderNumbers));
        }

        private byte[] RenderReport(string reportName, string format)
        {
            string extension;
            string mimeType;
            string encoding;
            string[] streamIDs;
            Warning[] warnings;

            var service = new ReportExecutionService();
            service.Credentials = CredentialCache.DefaultCredentials;
            service.LoadReport(reportName, null);

            var parameter = new ParameterValue();
            parameter.Name = "DeliveryId";
            parameter.Value = this.deliveryIDParam;
            var parameters = new ParameterValue[1] { parameter };
            service.SetExecutionParameters(parameters, "ru-RU");

            return service.Render(format, null, out extension, out mimeType, out encoding, out warnings, out streamIDs);
        }

        private void RenderPDFtoResponse(string reportName, string fileName)
        {
            var reportData = this.RenderReport(reportName, "PDF");
            this.Response.Clear();
            this.Response.ContentType = "application/pdf";
            this.Response.AddHeader("Content-Disposition", String.Format("attachment; filename = {0}", fileName));
            this.Response.Flush();
            this.Response.BufferOutput = false;
            this.Response.OutputStream.Write(reportData, 0, reportData.Length);
            this.Response.End();
        }

        private void TurnOnErrorPanel(string deliveryIDParam)
        {
            Panel.Visible = false;
            ErrorPanel.Visible = true;
            ErrorLabel.Text = string.Format("Error loading delivery with '{0}' ID", deliveryIDParam ?? "empty");
        }
    }
}