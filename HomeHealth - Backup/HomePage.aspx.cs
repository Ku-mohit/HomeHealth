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

namespace HomeHealth
{
    public partial class HomePage : System.Web.UI.Page
    {
        //string[] utilizationSubCategory = { "Cost", "MLR" };
        List<string> utilizationSubCategory = new List<string> { "Cost", "MLR" };

        //string[] clinicalQualitySubCategory = { "Vital/Labs", "Medication", "Processs Measures", "Tracking Measures" };
        List<string> clinicalQualitySubCategory = new List<string> { "Vital/Labs", "Medication", "Process Measures", "Tracking Measures" };

        //string[] medicalRiskSubCategory = { "MRA1", "MRA2", "MRA3" };
        List<string> medicalRiskSubCategory =new List<string> { "MRA1", "MRA2", "MRA3" };
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
               
                ddlYear.SelectedValue = "2023";
                //ddlInsurance.SelectedValue = "Simply";
                ddlInsurance.SelectedIndex = 0;

                var cat = Request.QueryString["Category"];

                //if (cat == null)
                //{
                //ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowMembershipGraph('2023','Simply')", true);
                //    lnkMembership.Attributes["class"] = "active";
                //}

                //if (cat == "Membership" || cat == null)
                //{
                //    CategoryTitle.Text = "Membership";
                //    ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowMembershipGraph('" + ddlYear.SelectedValue + "','" + ddlInsurance.SelectedValue + "')", true);
                //    if (lnkMembership.Attributes["CssClass"] == null || lnkMembership.Attributes["CssClass"] != "active")
                //    {
                //    //lnkMembership.Attributes["class"] = "active";
                //        lnkMembership.CssClass = "active";
                //    }
                //}
                //else if (cat == "Clinal_Quality")
                //{
                //    CategoryTitle.Text = "Clinical Quality";
                //}
                //else if (cat == "Medical_Risk")
                //{
                //    CategoryTitle.Text = "Medical Risk";
                //}
                //else if (cat == "Utilization")
                //{
                //    CategoryTitle.Text = "Utilization - " + ddlInsurance.SelectedValue + " (" +ddlYear.SelectedValue+")";
                //    ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowUtilizationGraph('" + ddlYear.SelectedValue + "')", true);
                //    //lnkBtnUtilization.Attributes["class"] = "active";
                //    lnkBtnUtilization.Attributes["CssClass"] = "active";
                //    //lnkMembership.Attributes["class"] = "";
                //    lnkMembership.CssClass = lnkMembership.CssClass.Replace("active", "");
                //    //lnkBtnClinicalQuality.Attributes["class"] = "";
                //    //lnkBtnMedicalRisk.Attributes["class"] = "";
                //}

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
            //lbltempcategories.Text = "Membership";
            Response.Redirect("~/HomePage.aspx?Category=Membership");
            DisplayCharts();
        }
        
        protected void ClinicalQuality(object sender, EventArgs e)
        {
            //lbltempcategories.Text = "Membership";
            Response.Redirect("~/HomePage.aspx?Category=Clinical_Quality");
        }
        
        protected void MedicalRisk(object sender, EventArgs e)
        {
            //lbltempcategories.Text = "Membership";
            Response.Redirect("~/HomePage.aspx?Category=MedicalRisk");
        }
        
        protected void Utilization(object sender, EventArgs e)
        {
            //lbltempcategories.Text = "Membership";
            Response.Redirect("~/HomePage.aspx?Category=Utilization");
        }
        
        protected void Report(object sender, EventArgs e)
        {
            //lbltempcategories.Text = "Membership";
            Response.Redirect("~/Reports.aspx");
        }
        
        protected void Help(object sender, EventArgs e)
        {
            Response.Redirect("~/Help.aspx");
        }

        protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            //ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowMembershipGraph('" + ddlYear.SelectedValue + "','" + ddlInsurance.SelectedValue + "')", true);
            //  ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowUtilizationGraph('" + ddlYear.SelectedValue +"')", true);
            //var cat = Request.QueryString["Category"];

            //if (cat == "Membership" || cat==null)
            //{
            //    CategoryTitle.Text = "Membership " + ddlInsurance.SelectedValue + " (" + ddlYear.SelectedValue + ")"; ;
            //    ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowMembershipGraph('"+ddlYear.SelectedValue+"','"+ddlInsurance.SelectedValue+"')", true);
            //}
            //else if (cat == "Clinal_Quality")
            //{
            //    CategoryTitle.Text = "Clinical Quality " + ddlInsurance.SelectedValue + " (" + ddlYear.SelectedValue + ")"; ;
            //}
            //else if (cat == "Medical_Risk")
            //{
            //    CategoryTitle.Text = "Medical Risk " + ddlInsurance.SelectedValue + " (" + ddlYear.SelectedValue + ")"; ;
            //}
            //else if (cat == "Utilization")
            //{
            //    CategoryTitle.Text = "Utilization - " + ddlInsurance.SelectedValue + " (" + ddlYear.SelectedValue + ")";
            //    ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowUtilizationGraph('" + ddlYear.SelectedValue + "')", true);
            //}
            utilizationSubCategory.Clear();
            clinicalQualitySubCategory.Clear();
            medicalRiskSubCategory.Clear();
            DisplayCharts();
        }

        protected void ddlInsurance_SelectedIndexChanged(object sender, EventArgs e)
        {
            //var cat = Request.QueryString["Category"];
            //if (cat == "Membership" || cat == null)
            //{
            //    CategoryTitle.Text = "Membership " + ddlInsurance.SelectedValue + " (" + ddlYear.SelectedValue + ")"; ;
            //    ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowMembershipGraph('" + ddlYear.SelectedValue + "','" + ddlInsurance.SelectedValue + "')", true);
            //    if (lnkMembership.Attributes["CssClass"] == null || lnkMembership.Attributes["CssClass"] != "active")
            //    {
            //        //lnkMembership.Attributes["class"] = "active";
            //        lnkMembership.CssClass = "active";
            //    }
            //}
            //else if (cat == "Clinal_Quality")
            //{
            //    CategoryTitle.Text = "Clinical Quality " + ddlInsurance.SelectedValue + " (" + ddlYear.SelectedValue + ")"; ;
            //}
            //else if (cat == "Medical_Risk")
            //{
            //    CategoryTitle.Text = "Medical Risk " + ddlInsurance.SelectedValue + " (" + ddlYear.SelectedValue + ")"; ;
            //}
            //else if (cat == "Utilization")
            //{
            //    CategoryTitle.Text = "Utilization - " + ddlInsurance.SelectedValue + " (" + ddlYear.SelectedValue + ")";
            //    ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowUtilizationGraph('" + ddlYear.SelectedValue + "')", true);
            //}
            utilizationSubCategory.Clear();
            clinicalQualitySubCategory.Clear();
            medicalRiskSubCategory.Clear();
            DisplayCharts();
        }

        private void DisplayCharts()
        {
            var cat = Request.QueryString["Category"];
            if (cat == "Membership" || cat == null)
            {
                CategoryTitle.Text = "Membership " + ddlInsurance.SelectedValue + " (" + ddlYear.SelectedValue + ")"; ;
                ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowMembershipGraph('" + ddlYear.SelectedValue + "','" + ddlInsurance.SelectedValue + "')", true);
                RBL_Subcategory.Items.Clear();
                if (lnkMembership.CssClass == null || lnkMembership.CssClass != "active")
                {
                    lnkMembership.CssClass = "active";
                    lnkBtnUtilization.CssClass = "";
                    lnkMembership.CssClass = "";
                    //lnkBtnMedicalRisk.CssClass = "";
                    lnkBtnClinicalQuality.CssClass = "";
                }
            }
            else if (cat == "Clinical_Quality")
            {
                RBL_Subcategory.Attributes.Add("style", "width:500px;");
                RBL_Subcategory.DataSource = clinicalQualitySubCategory;
                RBL_Subcategory.DataBind();
                RBL_Subcategory.SelectedIndex = 0;
                CategoryTitle.Text = "Clinical Quality " + ddlInsurance.SelectedValue + " (" + ddlYear.SelectedValue + ")";
                // Updated on 04202023 by Utpal - added category parameter
               ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowClinicalQualityLabs_Vital_Graph('" + ddlInsurance.SelectedValue + "','" + ddlYear.SelectedValue + "','Labs/Vitals')", true);
                lnkBtnUtilization.CssClass = "";
                lnkMembership.CssClass = "";
                //lnkBtnMedicalRisk.CssClass = "";
                lnkBtnClinicalQuality.CssClass = "active";
            }
            else if (cat == "MedicalRisk")
            {
                RBL_Subcategory.DataSource = medicalRiskSubCategory;
                RBL_Subcategory.DataBind();
                RBL_Subcategory.SelectedIndex = 0;
                CategoryTitle.Text = "Medical Risk " + ddlInsurance.SelectedValue + " (" + ddlYear.SelectedValue + ")";
                lnkBtnUtilization.CssClass = "";
                lnkMembership.CssClass = "";
                //lnkBtnMedicalRisk.CssClass = "active";
                lnkBtnClinicalQuality.CssClass = "";
            }
            else if (cat == "Utilization")
            {
                
                RBL_Subcategory.DataSource = utilizationSubCategory;
                RBL_Subcategory.DataBind();
              
               http://sunrisedomsvr/Intranet
                RBL_Subcategory.SelectedIndex = 0;
                CategoryTitle.Text = "Utilization - " + ddlInsurance.SelectedValue + " (" + ddlYear.SelectedValue + ")";
                lnkBtnUtilization.CssClass = "active";
                lnkMembership.CssClass = "";
                //lnkBtnMedicalRisk.CssClass = "";
                lnkBtnClinicalQuality.CssClass = "";
                //ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowUtilizationGraph('" + ddlInsurance.SelectedValue + "','" + ddlYear.SelectedValue + "')", true);
                ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowUtilizationCostGraph('" + ddlInsurance.SelectedValue + "','" + ddlYear.SelectedValue + "')", true);

                

            }
        }


        // web method for Membership 

        [System.Web.Services.WebMethod]
        public static string GetMembershipData(string insurance, string year)
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


        // Web Method for Utilization

        //[System.Web.Services.WebMethod]
        //public static string GetUtilizationData(string insurance, string year, string filterType = "COST")
        //{
        //    string ConnectionString = @"Data Source=VATSALPC6;Initial Catalog=PAVBCMDashboard;User ID=sa;Password=Vatsal123";
        //    SqlConnection con = new SqlConnection(ConnectionString);
        //    //var query = "select Insurance,Month,Year,DisenrolledPatientCount,NewPatientCount,ActivePatientCount,DisenrolledAnalysis from DASHBOARD where Year=" + year + " AND Insurance='" + insurance + "'";
        //    ////Console.WriteLine(query);
        //    //SqlCommand cmd = new SqlCommand(query, con);
        //    //cmd.CommandType = CommandType.Text;

        //    //SqlCommand cmd = new SqlCommand("GetUtilization", con);
        //    //cmd.CommandType = CommandType.StoredProcedure;
        //    //cmd.Parameters.AddWithValue("@Year", year);
        //    //cmd.Parameters.AddWithValue("@Insurance", insurance);
        //    //con.Open();
        //    //SqlDataAdapter sda = new SqlDataAdapter();
        //    //DataTable dt = new DataTable();
        //    //sda.SelectCommand = cmd;
        //    //sda.Fill(dt);

        //    ////con.CloseConnection();
        //    //List<Utilization> utilization_data = new List<Utilization>();
        //    //for (int i = 0; i < dt.Rows.Count; i++)
        //    //{
        //    //    Utilization data = new Utilization();
        //    //    data.Month = Convert.ToString(dt.Rows[i]["Month"]);
        //    //    data.Year = Convert.ToInt32(dt.Rows[i]["Year"]);
        //    //    data.MembershipCount = Convert.ToInt32(dt.Rows[i]["MembershipCount"]);
        //    //    data.TotalRevenue = Convert.ToInt32(dt.Rows[i]["TotalRevenue"]);
        //    //    data.TotalCost = Convert.ToInt32(dt.Rows[i]["TotalCost"]);
        //    //    data.TotalCost_with_IBNR = Convert.ToInt32(dt.Rows[i]["TotalCost_with_IBNR"]);
        //    //    data.PartA_Cost = Convert.ToInt32(dt.Rows[i]["PartA_Cost"]);
        //    //    data.PartB_Cost = Convert.ToInt32(dt.Rows[i]["PartB_Cost"]);
        //    //    data.PartD_Cost = Convert.ToInt32(dt.Rows[i]["PartD_Cost"]);
        //    //    data.Ancilliary = Convert.ToInt32(dt.Rows[i]["Ancilliary"]);
        //    //    data.Dental = Convert.ToInt32(dt.Rows[i]["Dental"]);
        //    //    data.OTC = Convert.ToInt32(dt.Rows[i]["OTC"]);
        //    //    data.Other = Convert.ToInt32(dt.Rows[i]["Other"]);
        //    //    utilization_data.Add(data);
        //    //}
        //    List<Utilization> utilization_data = new List<Utilization>();
        //    if (filterType == "COST")
        //    {
        //        //
        //        SqlCommand cmd = new SqlCommand("GetUtilizationByCost", con);
        //        cmd.CommandType = CommandType.StoredProcedure;
        //        cmd.Parameters.AddWithValue("@Year", year);
        //        cmd.Parameters.AddWithValue("@Insurance", insurance);
        //        con.Open();
        //        SqlDataAdapter sda = new SqlDataAdapter();
        //        DataTable dt = new DataTable();
        //        sda.SelectCommand = cmd;
        //        sda.Fill(dt);

        //        //con.CloseConnection();
        //       // List<Utilization> utilization_data = new List<Utilization>();
        //        for (int i = 0; i < dt.Rows.Count; i++)
        //        {
        //            Utilization data = new Utilization();
        //            data.Month = Convert.ToString(dt.Rows[i]["Month"]);
        //            data.Year = Convert.ToInt32(dt.Rows[i]["Year"]);
        //            data.MembershipCount = Convert.ToInt32(dt.Rows[i]["MembershipCount"]);
        //            data.TotalRevenue = Convert.ToInt32(dt.Rows[i]["TotalRevenue"]);
        //            data.TotalCost = Convert.ToInt32(dt.Rows[i]["TotalCost"]);
        //            data.TotalCost_with_IBNR = Convert.ToInt32(dt.Rows[i]["TotalCost_with_IBNR"]);
        //            data.PartA_Cost = Convert.ToInt32(dt.Rows[i]["PartA_Cost"]);
        //            data.PartB_Cost = Convert.ToInt32(dt.Rows[i]["PartB_Cost"]);
        //            data.PartD_Cost = Convert.ToInt32(dt.Rows[i]["PartD_Cost"]);
        //            data.Ancilliary = Convert.ToInt32(dt.Rows[i]["Ancilliary"]);
        //            data.Dental = Convert.ToInt32(dt.Rows[i]["Dental"]);
        //            data.OTC = Convert.ToInt32(dt.Rows[i]["OTC"]);
        //            data.Other = Convert.ToInt32(dt.Rows[i]["Other"]);
        //            utilization_data.Add(data);
        //        }
        //    }
        //    else if (filterType == "MLR")
        //    {
        //        //
        //        SqlCommand cmd = new SqlCommand("GetUtilizationByMLR", con);
        //        cmd.CommandType = CommandType.StoredProcedure;
        //        cmd.Parameters.AddWithValue("@Year", year);
        //        cmd.Parameters.AddWithValue("@Insurance", insurance);
        //        con.Open();
        //        SqlDataAdapter sda = new SqlDataAdapter();
        //        DataTable dt = new DataTable();
        //        sda.SelectCommand = cmd;
        //        sda.Fill(dt);

        //        //con.CloseConnection();
        //       // List<Utilization> utilization_data = new List<Utilization>();
        //        for (int i = 0; i < dt.Rows.Count; i++)
        //        {
        //            Utilization data = new Utilization();
        //            data.Month = Convert.ToString(dt.Rows[i]["Month"]);
        //            data.Year = Convert.ToInt32(dt.Rows[i]["Year"]);
        //            data.MLR = Convert.ToSingle(dt.Rows[i]["MLR"].ToString());
        //            //data.MembershipCount = Convert.ToInt32(dt.Rows[i]["MembershipCount"]);
        //            //data.TotalRevenue = Convert.ToInt32(dt.Rows[i]["TotalRevenue"]);
        //            //data.TotalCost = Convert.ToInt32(dt.Rows[i]["TotalCost"]);
        //            //data.TotalCost_with_IBNR = Convert.ToInt32(dt.Rows[i]["TotalCost_with_IBNR"]);
        //            //data.PartA_Cost = Convert.ToInt32(dt.Rows[i]["PartA_Cost"]);
        //            //data.PartB_Cost = Convert.ToInt32(dt.Rows[i]["PartB_Cost"]);
        //            //data.PartD_Cost = Convert.ToInt32(dt.Rows[i]["PartD_Cost"]);
        //            //data.Ancilliary = Convert.ToInt32(dt.Rows[i]["Ancilliary"]);
        //            //data.Dental = Convert.ToInt32(dt.Rows[i]["Dental"]);
        //            //data.OTC = Convert.ToInt32(dt.Rows[i]["OTC"]);
        //            //data.Other = Convert.ToInt32(dt.Rows[i]["Other"]);
        //            utilization_data.Add(data);
        //        }
        //    }
        //    //Console.WriteLine(patient_data);
        //    return JsonConvert.SerializeObject(utilization_data);
        //}

        [System.Web.Services.WebMethod]
        public static string GetUtilizationCostData(string insurance, string year)
        {
            string ConnectionString = @"Data Source=VATSALPC6;Initial Catalog=PAVBCMDashboard;User ID=sa;Password=Vatsal123";
            SqlConnection con = new SqlConnection(ConnectionString);
            //var query = "select Insurance,Month,Year,DisenrolledPatientCount,NewPatientCount,ActivePatientCount,DisenrolledAnalysis from DASHBOARD where Year=" + year + " AND Insurance='" + insurance + "'";
            ////Console.WriteLine(query);
            //SqlCommand cmd = new SqlCommand(query, con);
            //cmd.CommandType = CommandType.Text;

            //SqlCommand cmd = new SqlCommand("GetUtilization", con);
            //cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Parameters.AddWithValue("@Year", year);
            //cmd.Parameters.AddWithValue("@Insurance", insurance);
            //con.Open();
            //SqlDataAdapter sda = new SqlDataAdapter();
            //DataTable dt = new DataTable();
            //sda.SelectCommand = cmd;
            //sda.Fill(dt);

            ////con.CloseConnection();
            //List<Utilization> utilization_data = new List<Utilization>();
            //for (int i = 0; i < dt.Rows.Count; i++)
            //{
            //    Utilization data = new Utilization();
            //    data.Month = Convert.ToString(dt.Rows[i]["Month"]);
            //    data.Year = Convert.ToInt32(dt.Rows[i]["Year"]);
            //    data.MembershipCount = Convert.ToInt32(dt.Rows[i]["MembershipCount"]);
            //    data.TotalRevenue = Convert.ToInt32(dt.Rows[i]["TotalRevenue"]);
            //    data.TotalCost = Convert.ToInt32(dt.Rows[i]["TotalCost"]);
            //    data.TotalCost_with_IBNR = Convert.ToInt32(dt.Rows[i]["TotalCost_with_IBNR"]);
            //    data.PartA_Cost = Convert.ToInt32(dt.Rows[i]["PartA_Cost"]);
            //    data.PartB_Cost = Convert.ToInt32(dt.Rows[i]["PartB_Cost"]);
            //    data.PartD_Cost = Convert.ToInt32(dt.Rows[i]["PartD_Cost"]);
            //    data.Ancilliary = Convert.ToInt32(dt.Rows[i]["Ancilliary"]);
            //    data.Dental = Convert.ToInt32(dt.Rows[i]["Dental"]);
            //    data.OTC = Convert.ToInt32(dt.Rows[i]["OTC"]);
            //    data.Other = Convert.ToInt32(dt.Rows[i]["Other"]);
            //    utilization_data.Add(data);
            //}
            List<Utilization> utilization_cost_data = new List<Utilization>();
        
            
                //
                SqlCommand cmd = new SqlCommand("GetUtilizationByCost", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Year", year);
                cmd.Parameters.AddWithValue("@Insurance", insurance);
                con.Open();
                SqlDataAdapter sda = new SqlDataAdapter();
                DataTable dt = new DataTable();
                sda.SelectCommand = cmd;
                sda.Fill(dt);

                //con.CloseConnection();
                // List<Utilization> utilization_data = new List<Utilization>();
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
            
        
            //Console.WriteLine(patient_data);
            return JsonConvert.SerializeObject(utilization_cost_data);
        }

        [System.Web.Services.WebMethod]
        public static string GetUtilizationMLRData(string insurance, string year)
        {
            string ConnectionString = @"Data Source=VATSALPC6;Initial Catalog=PAVBCMDashboard;User ID=sa;Password=Vatsal123";
            SqlConnection con = new SqlConnection(ConnectionString);
            //var query = "select Insurance,Month,Year,DisenrolledPatientCount,NewPatientCount,ActivePatientCount,DisenrolledAnalysis from DASHBOARD where Year=" + year + " AND Insurance='" + insurance + "'";
            ////Console.WriteLine(query);
            //SqlCommand cmd = new SqlCommand(query, con);
            //cmd.CommandType = CommandType.Text;

            //SqlCommand cmd = new SqlCommand("GetUtilization", con);
            //cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Parameters.AddWithValue("@Year", year);
            //cmd.Parameters.AddWithValue("@Insurance", insurance);
            //con.Open();
            //SqlDataAdapter sda = new SqlDataAdapter();
            //DataTable dt = new DataTable();
            //sda.SelectCommand = cmd;
            //sda.Fill(dt);

            ////con.CloseConnection();
            //List<Utilization> utilization_data = new List<Utilization>();
            //for (int i = 0; i < dt.Rows.Count; i++)
            //{
            //    Utilization data = new Utilization();
            //    data.Month = Convert.ToString(dt.Rows[i]["Month"]);
            //    data.Year = Convert.ToInt32(dt.Rows[i]["Year"]);
            //    data.MembershipCount = Convert.ToInt32(dt.Rows[i]["MembershipCount"]);
            //    data.TotalRevenue = Convert.ToInt32(dt.Rows[i]["TotalRevenue"]);
            //    data.TotalCost = Convert.ToInt32(dt.Rows[i]["TotalCost"]);
            //    data.TotalCost_with_IBNR = Convert.ToInt32(dt.Rows[i]["TotalCost_with_IBNR"]);
            //    data.PartA_Cost = Convert.ToInt32(dt.Rows[i]["PartA_Cost"]);
            //    data.PartB_Cost = Convert.ToInt32(dt.Rows[i]["PartB_Cost"]);
            //    data.PartD_Cost = Convert.ToInt32(dt.Rows[i]["PartD_Cost"]);
            //    data.Ancilliary = Convert.ToInt32(dt.Rows[i]["Ancilliary"]);
            //    data.Dental = Convert.ToInt32(dt.Rows[i]["Dental"]);
            //    data.OTC = Convert.ToInt32(dt.Rows[i]["OTC"]);
            //    data.Other = Convert.ToInt32(dt.Rows[i]["Other"]);
            //    utilization_data.Add(data);
            //}
            List<Utilization> utilization_mlr_data = new List<Utilization>();


            //
            SqlCommand cmd = new SqlCommand("GetUtilizationByMLR", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Year", year);
            cmd.Parameters.AddWithValue("@Insurance", insurance);
            con.Open();
            SqlDataAdapter sda = new SqlDataAdapter();
            DataTable dt = new DataTable();
            sda.SelectCommand = cmd;
            sda.Fill(dt);

            //con.CloseConnection();
            // List<Utilization> utilization_data = new List<Utilization>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                Utilization data = new Utilization();
                data.Month = Convert.ToString(dt.Rows[i]["Month"]);
                data.Year = Convert.ToInt32(dt.Rows[i]["Year"]);
                data.MLR = Convert.ToSingle(dt.Rows[i]["MLR"].ToString());
                //data.TotalRevenue = Convert.ToInt32(dt.Rows[i]["TotalRevenue"]);
                //data.TotalCost = Convert.ToInt32(dt.Rows[i]["TotalCost"]);
                //data.TotalCost_with_IBNR = Convert.ToInt32(dt.Rows[i]["TotalCost_with_IBNR"]);
                //data.PartA_Cost = Convert.ToInt32(dt.Rows[i]["PartA_Cost"]);
                //data.PartB_Cost = Convert.ToInt32(dt.Rows[i]["PartB_Cost"]);
                //data.PartD_Cost = Convert.ToInt32(dt.Rows[i]["PartD_Cost"]);
                //data.Ancilliary = Convert.ToInt32(dt.Rows[i]["Ancilliary"]);
                //data.Dental = Convert.ToInt32(dt.Rows[i]["Dental"]);
                //data.OTC = Convert.ToInt32(dt.Rows[i]["OTC"]);
                //data.Other = Convert.ToInt32(dt.Rows[i]["Other"]);
                utilization_mlr_data.Add(data);
            }


            //Console.WriteLine(patient_data);
            return JsonConvert.SerializeObject(utilization_mlr_data);
        }


        [System.Web.Services.WebMethod]
        public static string GetClinicalQualityData_Category_Graph(string insurance, string year, string category)
        {
            string ConnectionString = @"Data Source=VATSALPC6;Initial Catalog=PAVBCMDashboard;User ID=sa;Password=Vatsal123";
            SqlConnection con = new SqlConnection(ConnectionString);
          
            List<ClinicalQuality> clinical_quality_Labs_vital= new List<ClinicalQuality>();
            SqlCommand cmd = new SqlCommand("GetClinicalQualityByMeasure", con);
            cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Parameters.AddWithValue("@Category", category);
            cmd.Parameters.AddWithValue("@Insurance", insurance);
            cmd.Parameters.AddWithValue("@Year", year);
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

        //[System.Web.Services.WebMethod]
        //public static string GetClinicalQualityData_Medication_Graph(string insurance, string year)
        //{
        //    string ConnectionString = @"Data Source=VATSALPC6;Initial Catalog=PAVBCMDashboard;User ID=sa;Password=Vatsal123";
        //    SqlConnection con = new SqlConnection(ConnectionString);
          
        //    List<ClinicalQuality> clinical_quality_medication_graph= new List<ClinicalQuality>();
        //    SqlCommand cmd = new SqlCommand("GetClinicalQualityByMeasure", con);
        //    cmd.CommandType = CommandType.StoredProcedure;
        //    cmd.Parameters.AddWithValue("@Insurance", 1);
        //    cmd.Parameters.AddWithValue("@Year", year);
        //    con.Open();
        //    SqlDataAdapter sda = new SqlDataAdapter();
        //    DataTable dt = new DataTable();
        //    sda.SelectCommand = cmd;
        //    sda.Fill(dt);
        //    for (int i = 0; i < dt.Rows.Count; i++)
        //    {
        //        ClinicalQuality data = new ClinicalQuality();
        //        data.Month = Convert.ToString(dt.Rows[i]["Month"]);
        //        data.Year = Convert.ToInt32(dt.Rows[i]["Year"]);
        //        data.Description = Convert.ToString(dt.Rows[i]["Description"]);
        //        data.MissingPatient = Convert.ToInt32(dt.Rows[i]["MissingPatient"]);
        //        data.Total = Convert.ToInt32(dt.Rows[i]["Total"]);
        //        data.Category = Convert.ToString(dt.Rows[i]["Category"]);
        //        clinical_quality_medication_graph.Add(data);
        //    }
        //    return JsonConvert.SerializeObject(clinical_quality_medication_graph);
        //}   
        
        //[System.Web.Services.WebMethod]
        //public static string GetClinicalQualityData_ProcessMeasures_Graph(string insurance, string year)
        //{
        //    string ConnectionString = @"Data Source=VATSALPC6;Initial Catalog=PAVBCMDashboard;User ID=sa;Password=Vatsal123";
        //    SqlConnection con = new SqlConnection(ConnectionString);
          
        //    List<ClinicalQuality> clinical_quality_process_measure= new List<ClinicalQuality>();
        //    SqlCommand cmd = new SqlCommand("GetClinicalQualityByMeasure", con);
        //    cmd.CommandType = CommandType.StoredProcedure;
        //    cmd.Parameters.AddWithValue("@Insurance", 1);
        //    cmd.Parameters.AddWithValue("@Year", year);
        //    con.Open();
        //    SqlDataAdapter sda = new SqlDataAdapter();
        //    DataTable dt = new DataTable();
        //    sda.SelectCommand = cmd;
        //    sda.Fill(dt);
        //    for (int i = 0; i < dt.Rows.Count; i++)
        //    {
        //        ClinicalQuality data = new ClinicalQuality();
        //        data.Month = Convert.ToString(dt.Rows[i]["Month"]);
        //        data.Year = Convert.ToInt32(dt.Rows[i]["Year"]);
        //        data.Description = Convert.ToString(dt.Rows[i]["Description"]);
        //        data.MissingPatient = Convert.ToInt32(dt.Rows[i]["MissingPatient"]);
        //        data.Total = Convert.ToInt32(dt.Rows[i]["Total"]);
        //        data.Category = Convert.ToString(dt.Rows[i]["Category"]);
        //        clinical_quality_process_measure.Add(data);
        //    }
        //    return JsonConvert.SerializeObject(clinical_quality_process_measure);
        //} 
        //[System.Web.Services.WebMethod]
        //public static string GetClinicalQualityData_TrackingMeasures_Graph(string insurance, string year)
        //{
        //    string ConnectionString = @"Data Source=VATSALPC6;Initial Catalog=PAVBCMDashboard;User ID=sa;Password=Vatsal123";
        //    SqlConnection con = new SqlConnection(ConnectionString);
          
        //    List<ClinicalQuality> clinical_quality_tracking_measure= new List<ClinicalQuality>();
        //    SqlCommand cmd = new SqlCommand("GetClinicalQualityByMeasure", con);
        //    cmd.CommandType = CommandType.StoredProcedure;
        //    cmd.Parameters.AddWithValue("@Insurance", 1);
        //    cmd.Parameters.AddWithValue("@Year", year);
        //    con.Open();
        //    SqlDataAdapter sda = new SqlDataAdapter();
        //    DataTable dt = new DataTable();
        //    sda.SelectCommand = cmd;
        //    sda.Fill(dt);
        //    for (int i = 0; i < dt.Rows.Count; i++)
        //    {
        //        ClinicalQuality data = new ClinicalQuality();
        //        data.Month = Convert.ToString(dt.Rows[i]["Month"]);
        //        data.Year = Convert.ToInt32(dt.Rows[i]["Year"]);
        //        data.Description = Convert.ToString(dt.Rows[i]["Description"]);
        //        data.MissingPatient = Convert.ToInt32(dt.Rows[i]["MissingPatient"]);
        //        data.Total = Convert.ToInt32(dt.Rows[i]["Total"]);
        //        data.Category = Convert.ToString(dt.Rows[i]["Category"]);
        //        clinical_quality_tracking_measure.Add(data);
        //    }
        //    return JsonConvert.SerializeObject(clinical_quality_tracking_measure);
        //}

        protected void RBL_Subcategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (RBL_Subcategory.SelectedValue == "Cost") 
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowUtilizationCostGraph('" + ddlInsurance.SelectedValue + "','" + ddlYear.SelectedValue +"')", true);
            }
            else if (RBL_Subcategory.SelectedValue== "MLR") 
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowUtilizationMLRGraph('" + ddlInsurance.SelectedValue + "','" + ddlYear.SelectedValue + "')", true);
            }
            else if (RBL_Subcategory.SelectedValue == "Vital/Labs")
            {
                // Updated on 04202023 by Utpal - added category parameter
                ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowClinicalQualityLabs_Vital_Graph('" + ddlInsurance.SelectedValue + "','" + ddlYear.SelectedValue + "','Labs/Vitals')", true);

            }
            else if (RBL_Subcategory.SelectedValue == "Medication")
            {
                // Updated on 04202023 by Utpal - added category parameter
                ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowClinicalQualityLabs_Vital_Graph('" + ddlInsurance.SelectedValue + "','" + ddlYear.SelectedValue + "','Medication Related')", true);

            }
            else if (RBL_Subcategory.SelectedValue == "Process Measures")
            {
                // Updated on 04202023 by Utpal - added category parameter
                ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowClinicalQualityLabs_Vital_Graph('" + ddlInsurance.SelectedValue + "','" + ddlYear.SelectedValue + "','Process Measures')", true);
            }
            else if (RBL_Subcategory.SelectedValue == "Tracking Measures")
            {
                // Updated on 04202023 by Utpal - added category parameter
                ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowClinicalQualityLabs_Vital_Graph('" + ddlInsurance.SelectedValue + "','" + ddlYear.SelectedValue + "','Tracking Measures')", true);

            }

        }
        /*On clicking on the link button of collapsible side bar the pdf file for help will be shown.*/
        protected void lnkBtnHelp_Click(object sender, EventArgs e)
        {
            /*The below code is used to show the pdf file in asp.net */
            string FilePath = Server.MapPath("~/Assests/OtherDocuments/PAVBCMDHelp.pdf");
            WebClient User = new WebClient();
            Byte[] FileBuffer = User.DownloadData(FilePath);
            if (FileBuffer != null)
            {
                Response.ContentType = "application/pdf";
                Response.AddHeader("content-length", FileBuffer.Length.ToString());
                Response.BinaryWrite(FileBuffer);
            }
        }

        protected void imgbtnHelp_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("Help.aspx");
        }

        protected void btnSaveGraph_Click(object sender, EventArgs e)
        {
            Response.Redirect("HomePage.aspx", false);
        }
    }


}