using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DeliveryManager.DeliveryManagerModel;

namespace DeliveryManager.Users
{
    public partial class AddEditUser : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                var userIDParam = Request.QueryString[UserConstants.IDParamName];
                if (userIDParam != null)
                {
                    int usertID;
                    if (Int32.TryParse(userIDParam, out usertID))
                    {
                        var container = new DeliveryManagerModelContainer();
                        var user = container.Users.SingleOrDefault(d => d.Id == usertID);
                        if (user != null)
                        {
                            var combinedName = user.FullName.Combined;
                            Label.Text = String.Format("Edit '{0}'", combinedName);

                            NameTextBox.Text = combinedName;
                            PhoneTextBox.Text = user.Phone;
                            EmailTextBox.Text = user.Email;
                        }
                        else
                            TurnOnErrorPanel(userIDParam);
                    }
                    else
                        TurnOnErrorPanel(userIDParam);
                }
                else
                    Label.Text = string.Format("Add new {0}", GetUserType());

                NameTextBox.Focus();
            }
        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            var container = new DeliveryManagerModelContainer();

            User user;
            var userIDParam = Request.QueryString[UserConstants.IDParamName];
            if (userIDParam != null)
            {
                int userID = Int32.Parse(userIDParam);
                user = container.Users.Single(u => u.Id == userID);
            }
            else
            {
                if (Page is AddEditClientPage)
                    user = new Client();
                else
                    user = new Courier();
                container.Users.AddObject(user);
            }
            user.FullName = ParseName(NameTextBox.Text.Trim());
            user.Phone = PhoneTextBox.Text.Trim();
            user.Email = EmailTextBox.Text.Trim();

            container.SaveChanges();

            Response.Redirect("~/Users/UsersList.aspx", true);
        }

        private FullName ParseName(string combinedName)
        {
            var splited = combinedName.Split(new char[]{ ' ' }, StringSplitOptions.RemoveEmptyEntries);
            var fullName = new FullName { Name = splited[0] };
            if (splited.Length == 2)
                fullName.Surname = splited[1];
            else if (splited.Length > 2)
            {
                fullName.MiddleName = splited[1];
                fullName.Surname = splited[2];
            }
            return fullName;
        }

        private string GetUserType()
        {
            return this.Page is AddEditClientPage ? "client" : "courier";
        }

        private void TurnOnErrorPanel(string userIDParam)
        {
            AddEditPanel.Visible = false;
            ErrorPanel.Visible = true;
            ErrorLabel.Text = string.Format("Error loading {0} with '{1}' ID", GetUserType(), userIDParam);
        }
    }
}