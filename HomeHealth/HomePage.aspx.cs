using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.ComponentModel;
using System.Drawing;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using Newtonsoft.Json;
using HomeHealth.Model;
using System.Net;
using System.Globalization;

namespace HomeHealth
{
    public partial class HomePage : System.Web.UI.Page
    {

        List<string> utilizationSubCategory = new List<string> { "Cost", "MLR" };

        List<string> clinicalQualitySubCategory = new List<string> { "Labs/Vitals", "Medication Related", "Process Measures", "Tracking Measures" };

        List<string> medicalRiskSubCategory = new List<string> { "MRA1", "MRA2", "MRA3" };
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                ddlYear.SelectedValue = "2023";
                ddlInsurance.SelectedIndex = 0;
                var cat = Request.QueryString["Category"];
                if (cat == "Report")
                {
                    CategoryTitle.Text = "Report";

                }
                else if (cat == "Help")
                {
                    CategoryTitle.Text = "Help";
                }
                else
                {
                    DisplayCharts();
                }
            }
        }

        protected void Membership(object sender, EventArgs e)
        {
            Response.Redirect("~/HomePage.aspx?Category=Membership");
            DisplayCharts();
        }

        protected void ClinicalQuality(object sender, EventArgs e)
        {
            Response.Redirect("~/HomePage.aspx?Category=Clinical_Quality");
        }

        protected void MedicalRisk(object sender, EventArgs e)
        {
            Response.Redirect("~/HomePage.aspx?Category=MedicalRisk");
        }

        protected void Utilization(object sender, EventArgs e)
        {
            Response.Redirect("~/HomePage.aspx?Category=Utilization");
        }

        protected void Report(object sender, EventArgs e)
        {
            Response.Redirect("~/Reports.aspx");
        }

        protected void Help(object sender, EventArgs e)
        {
            Response.Redirect("~/Help.aspx");
        }

        protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            /*On year change in drop down first subcategory will be cleared from the radio button list.
             * Then charts will be display as per the category and year.
             */
            DisplayCharts();
        }

        protected void ddlInsurance_SelectedIndexChanged(object sender, EventArgs e)
        {    /*On Insurance change in drop down first subcategory will be cleared from the radio button list.
              * Then charts will be display as per the category and year.
              */
            //utilizationSubCategory.Clear();
            //clinicalQualitySubCategory.Clear();
            //medicalRiskSubCategory.Clear();
            DisplayCharts();
        }

        protected void ddlMonth_SelectedIndexChanged(object sender, EventArgs e)
        {


            //calling javascript function for Clinical graph.
            string subcategory = RBL_Subcategory.SelectedValue;
            string month = ddlMonth.SelectedValue;
            ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowClinicalQualityLabs_Vital_Graph('" + ddlInsurance.SelectedValue + "','" + ddlYear.SelectedValue + "','" +subcategory + "','" + month + "')", true);
            //DisplayCharts();
        }

        /*Purpose : This function is used to call the respective category function to load graph into dashboard.
         * Params: insurance, year
         * Return: JSON object for membership category
         */
        private void DisplayCharts()
        {
            var cat = Request.QueryString["Category"];
            if (cat == "Membership" || cat == null)
            {
                CategoryTitle.Text = "Membership " + ddlInsurance.SelectedValue + " (" + ddlYear.SelectedValue + ")";
                //calling javascript function for membership graph.
                ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowMembershipGraph('" + ddlYear.SelectedValue + "','" + ddlInsurance.SelectedValue + "')", true);
                //clearing the radio button list item.
                RBL_Subcategory.Items.Clear();
                //Adding CSS Class to membership category and removing from other category because membership is selected here.
                if (lnkMembership.CssClass == null || lnkMembership.CssClass != "active")
                {
                    lnkMembership.CssClass = "active";
                    lnkBtnUtilization.CssClass = "";
                    lnkMembership.CssClass = "";
                    lnkBtnClinicalQuality.CssClass = "";
                }

            }
            else if (cat == "Clinical_Quality")
            {
                RBL_Subcategory.Items.Clear();
                RBL_Subcategory.Attributes.Add("style", "width:500px;");
                RBL_Subcategory.DataSource = clinicalQualitySubCategory;
                RBL_Subcategory.DataBind();
                RBL_Subcategory.Items[0].Text = "Labs/Vitals";
                RBL_Subcategory.Items[1].Text = "Medication";
                //RBL_Subcategory.Items[2].Text = "Process Measures";
                //RBL_Subcategory.Items[3].Text = "Tracking Measures";
                //for (int i = 0; i < clinicalQualitySubCategory.Count; i++)
                //{
                //    RBL_Subcategory.Items.Add(new ListItem(clinicalQualitySubCategory[i].ToString()));
                //}
                RBL_Subcategory.SelectedIndex = 0;
                CategoryTitle.Text = "Clinical Quality " + ddlInsurance.SelectedValue + " (" + ddlYear.SelectedValue + ")";
                // Updated on 04202023 by Utpal - added category parameter
                //Adding CSS Class to Clinical Quality category and removing from other category because clinical quality is selected here.
                lnkBtnUtilization.CssClass = "";
                lnkMembership.CssClass = "";
                lnkBtnClinicalQuality.CssClass = "active";
                //Added on 06/07/2023 to add drop down of month in HEDIS(Clinical Quality). 

                lblMonth.Visible = true;
                ddlMonth.Visible = true;
                //Connection string of database.
                string ConnectionString = @"Data Source=VATSALPC6;Initial Catalog=PAVBCMDashboard;User ID=sa;Password=Vatsal123";
                SqlConnection con = new SqlConnection(ConnectionString);
                string query = "Select Month from HEDIS_Master where year=" + ddlYear.SelectedValue.ToString() + "Group By Month order by Month asc";
                SqlDataAdapter adpt = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                adpt.Fill(dt);
                List<string> months = new List<string>();
                //for (int i = 0; i < dt.Rows.Count; i++)
                //{
                //    months[i] = dt.Rows[i]["Month"].ToString();
                //}
                if (dt.Rows.Count > 0)
                {
                    AnalysisReport.Visible = true;
                    btnSaveGraph.Enabled = true;
                    lblNoRecord.Visible = false;
                    ddlMonth.Items.Clear();
                    ddlMonth.DataSource = SortMOnths(dt);
                    //ddlMonth.DataValueField = "Month";
                    ddlMonth.DataBind();
                    //calling javascript function for Clinical graph.
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowClinicalQualityLabs_Vital_Graph('" + ddlInsurance.SelectedValue + "','" + ddlYear.SelectedValue + "','" + RBL_Subcategory.SelectedValue + "','" + ddlMonth.SelectedValue + "')", true);
                }
                else
                {
                    ddlMonth.Items.Clear();
                    ddlMonth.Items.Add("Month(s) not Found!");
                    lblNoRecord.Visible = true;
                    lblNoRecord.Text = "No Record Found!";
                    AnalysisReport.Visible = false;
                    btnSaveGraph.Enabled = false;
                }

            }
            else if (cat == "MedicalRisk")
            {
                // This category will be updated later when we will add MRA in our project.
                RBL_Subcategory.DataSource = medicalRiskSubCategory;
                RBL_Subcategory.DataBind();
                RBL_Subcategory.SelectedIndex = 0;
                CategoryTitle.Text = "Medical Risk " + ddlInsurance.SelectedValue + " (" + ddlYear.SelectedValue + ")";
                lnkBtnUtilization.CssClass = "";
                lnkMembership.CssClass = "";
                lnkBtnClinicalQuality.CssClass = "";
            }
            else if (cat == "Utilization")
            {
                RBL_Subcategory.Items.Clear();
                RBL_Subcategory.DataSource = utilizationSubCategory;
                RBL_Subcategory.DataBind();
                RBL_Subcategory.SelectedIndex = 0;
                CategoryTitle.Text = "Utilization - " + ddlInsurance.SelectedValue + " (" + ddlYear.SelectedValue + ")";
                //calling javascript function for Clinical graph.
                ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowUtilizationCostGraph('" + ddlInsurance.SelectedValue + "','" + ddlYear.SelectedValue + "')", true);
                //Adding CSS Class to Utilization category and removing from other category because Utilization is selected here.
                lnkBtnUtilization.CssClass = "active";
                lnkMembership.CssClass = "";
                lnkBtnClinicalQuality.CssClass = "";

            }
        }
        /*Purpose : This is the web method which is used to get the data from the database and convert it into JSON.
         * Params: insurance, year
         * Return: JSON object for membership category
         */
        [System.Web.Services.WebMethod]
        public static string GetMembershipData(string insurance, string year)
        {
            //Connection string of database.
            string ConnectionString = @"Data Source=VATSALPC6;Initial Catalog=PAVBCMDashboard;User ID=sa;Password=Vatsal123";
            SqlConnection con = new SqlConnection(ConnectionString);
            SqlCommand cmd = new SqlCommand("GetMembership", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Year", year);
            cmd.Parameters.AddWithValue("@Insurance", insurance);
            con.Open();
            SqlDataAdapter sda = new SqlDataAdapter();
            DataTable dt = new DataTable();
            sda.SelectCommand = cmd;
            sda.Fill(dt);
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
            return JsonConvert.SerializeObject(patient_data);
        }
        /*Purpose : This is the web method which is used to get the data from the database and convert it into JSON.
         * Params: insurance, year
         * Return: JSON object for category Utilization and subcategory Cost
         */
        [System.Web.Services.WebMethod]
        public static string GetUtilizationCostData(string insurance, string year)
        {
            string ConnectionString = @"Data Source=VATSALPC6;Initial Catalog=PAVBCMDashboard;User ID=sa;Password=Vatsal123";
            SqlConnection con = new SqlConnection(ConnectionString);
            List<Utilization> utilization_cost_data = new List<Utilization>();
            SqlCommand cmd = new SqlCommand("GetUtilizationByCost", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Year", year);
            cmd.Parameters.AddWithValue("@Insurance", insurance);
            con.Open();
            SqlDataAdapter sda = new SqlDataAdapter();
            DataTable dt = new DataTable();
            sda.SelectCommand = cmd;
            sda.Fill(dt);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                Utilization data = new Utilization();
                data.Month = Convert.ToString(dt.Rows[i]["Month"]);
                data.Year = Convert.ToInt32(dt.Rows[i]["Year"]);
                data.MembershipCount = Convert.ToInt32(dt.Rows[i]["MembershipCount"]);
                data.TotalRevenue = Convert.ToInt32(dt.Rows[i]["TotalRevenue"]);
                data.TotalCost = Convert.ToInt32(dt.Rows[i]["TotalCost"]);
                data.TotalCost_with_IBNR = Convert.ToInt32(dt.Rows[i]["TotalCost_with_IBNR"]);
                data.PartA_Cost = Convert.ToInt32(dt.Rows[i]["PartA_Cost"]);
                data.PartB_Cost = Convert.ToInt32(dt.Rows[i]["PartB_Cost"]);
                data.PartD_Cost = Convert.ToInt32(dt.Rows[i]["PartD_Cost"]);
                data.Ancilliary = Convert.ToInt32(dt.Rows[i]["Ancilliary"]);
                data.Dental = Convert.ToInt32(dt.Rows[i]["Dental"]);
                data.OTC = Convert.ToInt32(dt.Rows[i]["OTC"]);
                data.Other = Convert.ToInt32(dt.Rows[i]["Other"]);
                utilization_cost_data.Add(data);
            }
            return JsonConvert.SerializeObject(utilization_cost_data);
        }
        /*Purpose : This is the web method which is used to get the data from the database and convert it into JSON.
      * Params: insurance, year
      * Return: JSON object for category Utilization and subcategory MLR
      */
        [System.Web.Services.WebMethod]
        public static string GetUtilizationMLRData(string insurance, string year)
        {
            string ConnectionString = @"Data Source=VATSALPC6;Initial Catalog=PAVBCMDashboard;User ID=sa;Password=Vatsal123";
            SqlConnection con = new SqlConnection(ConnectionString);
            List<Utilization> utilization_mlr_data = new List<Utilization>();
            SqlCommand cmd = new SqlCommand("GetUtilizationByMLR", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Year", year);
            cmd.Parameters.AddWithValue("@Insurance", insurance);
            con.Open();
            SqlDataAdapter sda = new SqlDataAdapter();
            DataTable dt = new DataTable();
            sda.SelectCommand = cmd;
            sda.Fill(dt);

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                Utilization data = new Utilization();
                data.Month = Convert.ToString(dt.Rows[i]["Month"]);
                data.Year = Convert.ToInt32(dt.Rows[i]["Year"]);
                data.MLR = Convert.ToSingle(dt.Rows[i]["MLR"].ToString());
                utilization_mlr_data.Add(data);
            }
            return JsonConvert.SerializeObject(utilization_mlr_data);
        }
        /*Purpose : This is the web method which is used to get the data from the database and convert it into JSON.
       * Params: insurance, year
       * Return: JSON object for category Clinical Quality.
       */

        [System.Web.Services.WebMethod]
        public static string GetClinicalQualityData_Category_Graph(string insurance, string year, string category, string month)
        {
            string ConnectionString = @"Data Source=VATSALPC6;Initial Catalog=PAVBCMDashboard;User ID=sa;Password=Vatsal123";
            SqlConnection con = new SqlConnection(ConnectionString);

            List<ClinicalQuality> clinical_quality_Labs_vital = new List<ClinicalQuality>();
            SqlCommand cmd = new SqlCommand("GetClinicalQualityByMeasure", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Insurance", insurance);
            cmd.Parameters.AddWithValue("@Year", year);
            cmd.Parameters.AddWithValue("@Month", month);
            con.Open();
            SqlDataAdapter sda = new SqlDataAdapter();
            DataTable dt = new DataTable();
            sda.SelectCommand = cmd;
            sda.Fill(dt);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (dt.Rows[i]["Category"].ToString() == category)
                {
                    ClinicalQuality data = new ClinicalQuality();
                    data.Month = Convert.ToString(dt.Rows[i]["Month"]);
                    data.Year = Convert.ToInt32(dt.Rows[i]["Year"]);
                    data.Description = Convert.ToString(dt.Rows[i]["Description"]);
                    data.MissingPatient = Convert.ToInt32(dt.Rows[i]["MissingPatient"]);
                    data.Total = Convert.ToInt32(dt.Rows[i]["Total"]);
                    data.Category = Convert.ToString(dt.Rows[i]["Category"]);
                    data.Measure = Convert.ToString(dt.Rows[i]["Measure"]);
                    clinical_quality_Labs_vital.Add(data);
                }

            }
            return JsonConvert.SerializeObject(clinical_quality_Labs_vital);
        }

        protected void RBL_Subcategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (RBL_Subcategory.SelectedValue == "Cost")
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowUtilizationCostGraph('" + ddlInsurance.SelectedValue + "','" + ddlYear.SelectedValue + "')", true);
            }
            else if (RBL_Subcategory.SelectedValue == "MLR")
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowUtilizationMLRGraph('" + ddlInsurance.SelectedValue + "','" + ddlYear.SelectedValue + "')", true);
            }
            else if (RBL_Subcategory.SelectedValue == "Labs/Vitals")
            {
                // Updated on 04202023 by Utpal - added category parameter
                ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowClinicalQualityLabs_Vital_Graph('" + ddlInsurance.SelectedValue + "','" + ddlYear.SelectedValue + "','Labs/Vitals','" + ddlMonth.SelectedValue + "')", true);

            }
            else if (RBL_Subcategory.SelectedValue == "Medication Related")
            {
                // Updated on 04202023 by Utpal - added category parameter
                ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowClinicalQualityLabs_Vital_Graph('" + ddlInsurance.SelectedValue + "','" + ddlYear.SelectedValue + "','Medication Related','" + ddlMonth.SelectedValue + "')", true);

            }
            else if (RBL_Subcategory.SelectedValue == "Process Measures")
            {
                // Updated on 04202023 by Utpal - added category parameter
                ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowClinicalQualityLabs_Vital_Graph('" + ddlInsurance.SelectedValue + "','" + ddlYear.SelectedValue + "','Process Measures','" + ddlMonth.SelectedValue + "')", true);
            }
            else if (RBL_Subcategory.SelectedValue == "Tracking Measures")
            {
                // Updated on 04202023 by Utpal - added category parameter
                ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowClinicalQualityLabs_Vital_Graph('" + ddlInsurance.SelectedValue + "','" + ddlYear.SelectedValue + "','Tracking Measures','" + ddlMonth.SelectedValue + "')", true);

            }

        }
        /*On clicking on the link button of collapsible side bar the pdf file for help will be shown.*/
        protected void lnkBtnHelp_Click(object sender, EventArgs e)
        {
            /*The below code is used to show the pdf file in asp.net */
            //string FilePath = Server.MapPath("~/Assests/OtherDocuments/PAVBCMDHelp.pdf");
            //WebClient User = new WebClient();
            //Byte[] FileBuffer = User.DownloadData(FilePath);
            //if (FileBuffer != null)
            //{
            //    Response.ContentType = "application/pdf";
            //    Response.AddHeader("content-length", FileBuffer.Length.ToString());
            //    Response.BinaryWrite(FileBuffer);
            //}
            Response.Redirect("Help.aspx");
        }
        /*On clicking on the link button of yellow top bar the help page will be shown.*/
        protected void imgbtnHelp_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("Help.aspx");
        }

        protected void btnSaveGraph_Click(object sender, EventArgs e)
        {
            //Response.Redirect("HomePage.aspx", false);
            var cat = Request.QueryString["Category"];
            if (cat == "Clinical_Quality")
            {
                //int categorySelectedIndex = RBL_Subcategory.SelectedIndex;
                //RBL_Subcategory.SelectedIndex = categorySelectedIndex;
                ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowClinicalQualityLabs_Vital_Graph('" + ddlInsurance.SelectedValue + "','" + ddlYear.SelectedValue + "','" + RBL_Subcategory.SelectedValue + "','" + ddlMonth.SelectedValue + "')", true);
            }
            else if (cat == "Utilization")
            {
                int categorySelectedIndex = RBL_Subcategory.SelectedIndex;
                RBL_Subcategory.SelectedIndex = categorySelectedIndex;
                if (categorySelectedIndex == 0)
                {

                    ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowUtilizationCostGraph('" + ddlInsurance.SelectedValue + "','" + ddlYear.SelectedValue + "')", true);
                }
                else if (categorySelectedIndex == 1)
                {
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowUtilizationMLRGraph('" + ddlInsurance.SelectedValue + "','" + ddlYear.SelectedValue + "')", true);
                }
            }
            else if (cat == "Membership" || cat == null)
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowMembershipGraph('" + ddlYear.SelectedValue + "','" + ddlInsurance.SelectedValue + "')", true);
            }

        }

        protected List<string> SortMOnths(DataTable dt)
        {
            List<string> _months = new List<string>();
            List<int> __months = new List<int>();
            List<string> _months_ = new List<string>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                _months.Add(dt.Rows[i]["Month"].ToString());
            }
            for (int i = 0; i < _months.Count; i++)
            {
                if (_months[i] != string.Empty)
                {
                    __months.Add(DateTime.ParseExact(_months[i], "MMMM", CultureInfo.CurrentCulture).Month);
                }
            }
            __months.Sort();
            for (int i = 0; i < __months.Count; i++)
            {
                _months_.Add(CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(__months[i]));
            }
            return _months_;
        }
      



    }


}