using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HomeHealth
{
    public partial class Contact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var dateAsString = DateTime.Now.ToString("MMM-yyyy");
            lblDate.Text = dateAsString;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {

        }
    }
}