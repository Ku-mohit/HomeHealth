using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HomeHealth
{
    public partial class ajax_method : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_Click(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static string GetData(string fname, string lname)
        {
            return "Your first name is: " + fname + " and last name is: " + lname;
        }
    }
}