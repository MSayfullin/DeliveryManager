using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DeliveryManager.DeliveryManagerModel;
using System.Drawing;

namespace DeliveryManager.Corrections
{
    public partial class AddEditCorrectionPage : Page
    {
        private Correction internalCorrectionValue = null;
        internal Correction Correction
        {
            get
            {
                if (internalCorrectionValue == null)
                {
                    var correctionIDParam = Request.QueryString[CorrectionConstants.IDParamName];
                    if (correctionIDParam != null)
                    {
                        int correctionID;
                        if (Int32.TryParse(correctionIDParam, out correctionID))
                        {
                            var container = new DeliveryManagerModelContainer();
                            internalCorrectionValue = container.Corrections.SingleOrDefault(d => d.Id == correctionID);
                            if (internalCorrectionValue == null)
                                TurnOnErrorPanel(correctionIDParam);
                        }
                        else
                            TurnOnErrorPanel(correctionIDParam);
                    }
                }
                return internalCorrectionValue;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                if (this.Correction != null)
                {
                    Label.Text = String.Format("Edit correction for '{0:D}'", this.Correction.Date);

                    Calendar.VisibleDate = Calendar.SelectedDate = this.Correction.Date;
                    CorrectionTypeList.SelectedValue = this.Correction.CorrectionTypeId.ToString();
                    CorrectionTypeList.Enabled = false;
                    TotalCostLabel.Text = this.Correction.TotalCost.ToString("C");

                    foreach (var entry in this.Correction.CorrectionEntries)
                    {
                        foreach (GridViewRow row in EntriesGridView.Rows)
                        {
                            var hdnField = row.Cells[0].Controls.OfType<HiddenField>().Single();
                            var depotEntryId = Int32.Parse(hdnField.Value);
                            if (entry.DepotEntry.Id == depotEntryId)
                            {
                                var chkBox = row.Cells[0].Controls.OfType<CheckBox>().Single();
                                chkBox.Checked = true;
                                var txtBox = row.Cells[0].Controls.OfType<TextBox>().Single();
                                txtBox.Text = entry.Count.ToString();
                                break;
                            }
                        }
                    }
                }
                else
                {
                    Label.Text = "Add new correction";

                    Calendar.SelectedDate = DateTime.Now;
                    TotalCostLabel.Text = String.Format("{0:C}", 0);
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

            Correction correction;
            var correctionIDParam = Request.QueryString[CorrectionConstants.IDParamName];
             if (correctionIDParam != null)
             {
                 int correctionID = Int32.Parse(correctionIDParam);
                 correction = container.Corrections.Single(d => d.Id == correctionID);
             }
             else
             {
                 correction = new Correction();
                 container.Corrections.AddObject(correction);
             }
             correction.Date = Calendar.SelectedDate;
             correction.CorrectionTypeId = Int32.Parse(CorrectionTypeList.SelectedValue);

             foreach (GridViewRow row in EntriesGridView.Rows)
             {
                 var hdnField = row.Cells[0].Controls.OfType<HiddenField>().Single();
                 var depotEntryId = Int32.Parse(hdnField.Value);
                 var depotEntry = container.Entries.Single(de => de.Id == depotEntryId) as DepotEntry;
                 var correctionEntry = correction.CorrectionEntries.SingleOrDefault(oe => oe.DepotEntry.Id == depotEntryId);

                 var chkBox = row.Cells[0].Controls.OfType<CheckBox>().Single();
                 if (chkBox.Checked)
                 {
                     var txtBox = row.Cells[0].Controls.OfType<TextBox>().Single();
                     int count;
                     if (!Int32.TryParse(txtBox.Text, out count) || count < 1)
                         count = 1;

                     if (correctionEntry == null)
                     {
                         correctionEntry = new CorrectionEntry
                         {
                             DepotEntry = depotEntry,
                             DeliveryEntityId = depotEntry.DeliveryEntityId,
                             Cost = depotEntry.DeliveryEntity.Cost
                         };
                         correction.CorrectionEntries.Add(correctionEntry);
                     }
                     correctionEntry.Count = count;
                 }
                 else
                 {
                     if (correctionEntry != null)
                     {
                         // return entities back
                         depotEntry.Count += correctionEntry.Count;
                         container.Entries.DeleteObject(correctionEntry);
                     }
                 }
             }

             container.SaveChanges();

             Response.Redirect("~/Corrections/CorrectionsList.aspx", true);
        }

        private void TurnOnErrorPanel(string correctionIDParam)
        {
            AddEditPanel.Visible = false;
            ErrorPanel.Visible = true;
            ErrorLabel.Text = string.Format("Error loading correction with '{0}' ID", correctionIDParam);
        }
    }
}