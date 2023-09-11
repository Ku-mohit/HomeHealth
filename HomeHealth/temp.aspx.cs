using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using HomeHealth;
using Newtonsoft.Json;

namespace HomeHealth.Modals
{
    public partial class temp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                List<string> category = new List<string> { "Simply", "Wellmed", "Ambetter" };
                List<string> year = new List<string> { "2023", "2022", "2021" };
                for (int i = 0; i < category.Count; i++)
                {
                    ddlInsurance.Items.Insert(i, new ListItem(category[i]));
                    ddlYear.Items.Insert(i, new ListItem(year[i]));
                }

                var cat = Request.QueryString["Category"];
                //lblCategory.Text ="Membership " +"Simply " + "2023";
                var user_selected_insurance = ddlInsurance.SelectedValue;


                //if (cat == "Membership")
                //{
                //    lblCategory.Text = cat + " Simply " + "2023";
                //    ddlInsurance.Items.Clear();
                //    ddlYear.Items.Clear();
                //    for (int i = 0; i < category.Count; i++)
                //    {
                //        ddlInsurance.Items.Insert(i, new ListItem(category[i]));
                //        ddlYear.Items.Insert(i, new ListItem(year[i]));
                //    }
                //}
                //else if (cat == "Hedis")
                //{
                //    lblCategory.Text = cat + " Simply " + "2023";
                //    ddlInsurance.Items.Clear();
                //    ddlYear.Items.Clear();
                //    for (int i = 0; i < category.Count - 1; i++)
                //    {
                //        ddlInsurance.Items.Insert(i, new ListItem(category[i]));
                //        ddlYear.Items.Insert(i, new ListItem(year[i]));
                //    }
                //}
                //else if (cat == "MRA")
                //{
                //    lblCategory.Text = cat + " Simply " + "2023";
                //    ddlInsurance.Items.Clear();
                //    ddlYear.Items.Clear();
                //    for (int i = 0; i < category.Count - 2; i++)
                //    {
                //        ddlInsurance.Items.Insert(i, new ListItem(category[i]));
                //        ddlYear.Items.Insert(i, new ListItem(year[i]));
                //    }
                //}
                //else if (cat == "Utilization")
                //{
                //    lblCategory.Text = cat + " Simply " + "2023";
                //    ddlInsurance.Items.Clear();
                //    ddlYear.Items.Clear();
                //    for (int i = 0; i < category.Count - 2; i++)
                //    {
                //        ddlInsurance.Items.Insert(i, new ListItem(category[i]));
                //        ddlYear.Items.Insert(i, new ListItem(year[i]));
                //    }
                //}

                //else if (cat == "Report")
                //{
                //    lblCategory.Text = cat + " Simply " + "2023";

                //}
                //else if (cat == "Help")
                //{
                //    lblCategory.Text = cat + " Simply " + "2023";

                //}

            }
        }

        protected void ddlInsurance_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblCategory.Text = Request.QueryString["Category"].ToString() + " " + ddlInsurance.SelectedValue.ToString() + " " + ddlYear.SelectedValue.ToString();
            GetData(ddlInsurance.SelectedValue, Convert.ToInt32(ddlYear.SelectedValue));
            // Category.Text = insurance;
            //return insurance;
        }

        protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblCategory.Text = Request.QueryString["Category"].ToString() + " " + ddlInsurance.SelectedValue.ToString() + " " + ddlYear.SelectedValue.ToString();
            GetData(ddlInsurance.SelectedValue, Convert.ToInt32(ddlYear.SelectedValue));
            // return year;
        }

        protected void lnkBtnMembership_Click(object sender, EventArgs e)
        {
            //Response.Redirect("~/temp.aspx?Category=Membership");
            lblCategory.Text = lnkBtnMembership.Text;
            //lnkBtnMembership.Attributes.Add("CssClass", "active");
            //lnkBtnMembership.Attributes.Clear();
        }

        protected void lnkBtnHedis_Click(object sender, EventArgs e)
        {
            //Response.Redirect("~/temp.aspx?Category=Hedis");
            lblCategory.Text = lnkBtnHedis.Text;
            //lnkBtnMembership.Attributes.Clear();
            //lnkBtnHedis.Attributes.Add("CssClass", "active"); ;
        }



        [WebMethod()]
        public static string GetData(string insurance="Simply", int year=2023)
        {
            Connection.Connection con = new Connection.Connection();
            con.OpenConnection();
            var query = "select Insurance,Month,Year,DisenrolledPatientCount,NewPatientCount,ActivePatientCount,DisenrolledAnalysis from DASHBOARD where Year=" + year + " AND Insurance='" + insurance + "'";
            Console.WriteLine(query);

            con.ExecuteQueries(query);
            DataTable dt = new DataTable();
            dt = con.GetDataTable(query);
            //con.CloseConnection();
            List<PatientData> patient_data = new List<PatientData>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                PatientData data = new PatientData();
                data.ActivePatient = Convert.ToInt32(dt.Rows[i]["ActivePatientCount"]);
                data.NewPatient = Convert.ToInt32(dt.Rows[i]["NewPatientCount"]);
                data.DisenrolledPatient = Convert.ToInt32(dt.Rows[i]["DisenrolledPatientCount"]);
                data.DisenrolledAnalysis = Convert.ToString(dt.Rows[i]["DisenrolledAnalysis"]);
                data.Month = Convert.ToString(dt.Rows[i]["Month"]);
                data.Year = Convert.ToInt32(dt.Rows[i]["Year"]);
                patient_data.Add(data);

            }
            Console.WriteLine(patient_data);
            return JsonConvert.SerializeObject(patient_data);
        }

       
    }
    public class PatientData
        {
            public string Month { get; set; }
            public int Year { get; set; }
            public int ActivePatient { get; set; }
            public int NewPatient { get; set; }
            public int DisenrolledPatient { get; set; }
            public string DisenrolledAnalysis { get; set; }
        }
}