using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using Newtonsoft.Json;
using HomeHealth.Modals;

namespace HomeHealth
{
    public partial class HomePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

               
                ClientScript.RegisterClientScriptBlock(this.GetType(),"CallMyFunction","ShowGraph('2023','Simply')",true);

                var cat = Request.QueryString["Category"];
                if (cat == "Membership")
                {
                    CategoryTitle.Text = "Membership";
                }
                else if (cat == "Clinal_Quality")
                {
                    CategoryTitle.Text = "Clinical Quality";
                }
                else if (cat == "Medical_Risk")
                {
                    CategoryTitle.Text = "Medical Risk";
                }
                else if (cat == "Utilization")
                {
                    CategoryTitle.Text = "Utilization";
                }

                else if (cat == "Report")
                {
                    CategoryTitle.Text = "Report";

                }
                else if (cat == "Help")
                {
                    CategoryTitle.Text = "Help";

                }

            }
        }
        protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowGraph('"+ddlYear.SelectedValue+"','"+ddlInsurance.SelectedValue+"')", true);
        }

        protected void ddlInsurance_SelectedIndexChanged(object sender, EventArgs e)
        {
            ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowGraph('" + ddlYear.SelectedValue + "','" + ddlInsurance.SelectedValue + "')", true);
        }
        [System.Web.Services.WebMethod]
        public static string GetData(string insurance, string year)
        {
            string ConnectionString = @"Data Source=VATSALPC6;Initial Catalog=PAVBCMDashboard;User ID=sa;Password=Vatsal123";
            SqlConnection con = new SqlConnection(ConnectionString);
            //var query = "select Insurance,Month,Year,DisenrolledPatientCount,NewPatientCount,ActivePatientCount,DisenrolledAnalysis from DASHBOARD where Year=" + year + " AND Insurance='" + insurance + "'";
            ////Console.WriteLine(query);
            //SqlCommand cmd = new SqlCommand(query, con);
            //cmd.CommandType = CommandType.Text;

            SqlCommand cmd = new SqlCommand("GetMembership", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Year", year);
            cmd.Parameters.AddWithValue("@Insurance", insurance);
            con.Open();
            SqlDataAdapter sda = new SqlDataAdapter();
            DataTable dt = new DataTable();
            sda.SelectCommand = cmd;
            sda.Fill(dt);

            //con.CloseConnection();
            List<Dashboard> patient_data = new List<Dashboard>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                Dashboard data = new Dashboard();
                data.ActivePatient = Convert.ToInt32(dt.Rows[i]["ActivePatientCount"]);
                data.NewPatient = Convert.ToInt32(dt.Rows[i]["NewPatientCount"]);
                data.DisenrolledPatient = Convert.ToInt32(dt.Rows[i]["DisenrolledPatientCount"]);
                data.DisenrolledAnalysis = Convert.ToString(dt.Rows[i]["DisenrolledAnalysis"]);
                data.Month = Convert.ToString(dt.Rows[i]["Month"]);
                data.Year = Convert.ToInt32(dt.Rows[i]["Year"]);
                data.Insurance = Convert.ToString(dt.Rows[i]["Insurance"]);
                patient_data.Add(data);
            }
            //Console.WriteLine(patient_data);
            return JsonConvert.SerializeObject(patient_data);
        }

    }
   

}