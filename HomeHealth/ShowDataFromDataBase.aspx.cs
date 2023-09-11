using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.Web.Services;
using System.Threading;
using System.Data.SqlClient;
using System.Data;
using HomeHealth.Model;

namespace HomeHealth
{
    public partial class ShowDataFromDataBase : System.Web.UI.Page
    {
        static string connectionString = @"Data Source=VATSALPC6;Initial Catalog=PAVBCMDashboard;User ID=sa;Password=Vatsal123";
        SqlConnection con = new SqlConnection(connectionString);
       
        protected void Page_Load(object sender, EventArgs e)
        {
            //var year = ddlYear.SelectedValue;
            // var data = GetData();
            //lblCount.Text = (data.Rows.Count).ToString();
            //SqlCommand cmd = new SqlCommand("select * from MEMBERSHIP where Year=2022 and Month=5", con);
            //cmd.CommandType = CommandType.Text;
            //con.Open();
            //SqlDataAdapter sda = new SqlDataAdapter();
            //DataSet ds = new DataSet();
            //sda.SelectCommand = cmd;
            //sda.Fill(ds);
            //con.Close();
            //DataGrid.DataSource = ds;
            //DataGrid.DataBind();

            //var data = GetData();
            //lblCount.Text = data.ToString();


            if (!IsPostBack)
            {
                //CallFunction
                List<string> category = new List<string> { "","Simply", "Wellmed", "Ambetter" };
                List<string> year = new List<string> { "","2023", "2022", "2021" };
                ddlInsurance.Items.Insert(0, "Select");
                ddlYear.Items.Insert(0, "Select");
                for (int i = 1; i < category.Count; i++)
                {
                    ddlInsurance.Items.Insert(i, new ListItem(category[i]));
                    ddlYear.Items.Insert(i, new ListItem(year[i]));
                }

                var cat = Request.QueryString["Category"];
                //lblCategory.Text ="Membership " +"Simply " + "2023";
                var user_selected_insurance = ddlInsurance.SelectedValue;


                if (cat == "Membership")
                {
                    lblCategory.Text = cat + " Simply " + "2023";
                    ddlInsurance.Items.Clear();
                    ddlYear.Items.Clear();
                    for (int i = 0; i < category.Count; i++)
                    {
                        ddlInsurance.Items.Insert(i, new ListItem(category[i]));
                        ddlYear.Items.Insert(i, new ListItem(year[i]));
                    }
                }
                else if (cat == "Hedis")
                {
                    lblCategory.Text = cat + " Simply " + "2023";
                    ddlInsurance.Items.Clear();
                    ddlYear.Items.Clear();
                    for (int i = 0; i < category.Count - 1; i++)
                    {
                        ddlInsurance.Items.Insert(i, new ListItem(category[i]));
                        ddlYear.Items.Insert(i, new ListItem(year[i]));
                    }
                }
                else if (cat == "MRA")
                {
                    lblCategory.Text = cat + " Simply " + "2023";
                    ddlInsurance.Items.Clear();
                    ddlYear.Items.Clear();
                    for (int i = 0; i < category.Count - 2; i++)
                    {
                        ddlInsurance.Items.Insert(i, new ListItem(category[i]));
                        ddlYear.Items.Insert(i, new ListItem(year[i]));
                    }
                }
                else if (cat == "Utilization")
                {
                    lblCategory.Text = cat + " Simply " + "2023";
                    ddlInsurance.Items.Clear();
                    ddlYear.Items.Clear();
                    for (int i = 0; i < category.Count - 2; i++)
                    {
                        ddlInsurance.Items.Insert(i, new ListItem(category[i]));
                        ddlYear.Items.Insert(i, new ListItem(year[i]));
                    }
                }

                else if (cat == "Report")
                {
                    lblCategory.Text = cat + " Simply " + "2023";

                }
                else if (cat == "Help")
                {
                    lblCategory.Text = cat + " Simply " + "2023";

                }
                //ddlInsurance.SelectedValue = "Simply";
                ddlYear.SelectedValue = DateTime.Now.Year.ToString();
                //CallFunction
            }
            //ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "CallFunction('" + ddlYear.SelectedValue + "')", true);
        }

        [WebMethod()]
        public static string GetData(string year)
        {
            
            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand("select Insurance,Month,Year,DisenrolledPatientCount,NewPatientCount,ActivePatientCount,DisenrolledAnalysis from DASHBOARD where Year = " + Convert.ToInt32(year)  , con);
            //Console.WriteLine("select Insurance,Month,Year,DisenrolledPatientCount,NewPatientCount,ActivePatientCount,DisenrolledAnalysis from DASHBOARD where Year=" + year);
            cmd.CommandType = CommandType.Text;
            con.Open();
            SqlDataAdapter sda = new SqlDataAdapter();
            //DataSet ds = new DataSet();
            //sda.SelectCommand = cmd;
            //sda.Fill(ds);
            //con.Close();
            //DataGrid.DataSource = ds;
            //DataGrid.DataBind();

            // Converting Datatable into JSON
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
                patient_data.Add(data);

            }
            return JsonConvert.SerializeObject(patient_data);
        }

        protected void ddlInsurance_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblCategory.Text = ddlInsurance.SelectedValue.ToString() + " " + ddlYear.SelectedValue.ToString();
            //lblCategory.Text = Request.QueryString["Category"].ToString() + " " + ddlInsurance.SelectedValue.ToString() + " " + ddlYear.SelectedValue.ToString();
            //GetData(ddlInsurance.SelectedValue, Convert.ToInt32(ddlYear.SelectedValue));
        }

        protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblCategory.Text = ddlInsurance.SelectedValue.ToString() + " " + ddlYear.SelectedValue.ToString();
            //CallFunction
            //GetData(Convert.ToInt32(ddlYear.SelectedValue));
            //lblCategory.Text = Request.QueryString["Category"].ToString() + " " + ddlInsurance.SelectedValue.ToString() + " " + ddlYear.SelectedValue.ToString();
            //GetData(ddlInsurance.SelectedValue, Convert.ToInt32(ddlYear.SelectedValue));
        }
    }
    //[WebMethod()]
    //public static string GetData(string insurance , int year)
    //{
    //    Connection.Connection con = new Connection.Connection();
    //    con.OpenConnection();
    //    var query = "select Insurance,Month,Year,DisenrolledPatientCount,NewPatientCount,ActivePatientCount,DisenrolledAnalysis from DASHBOARD where Year=" + year + " AND Insurance='" + insurance + "'";
    //    Console.WriteLine(query);

    //    con.ExecuteQueries(query);
    //    DataTable dt = new DataTable();
    //    dt = con.GetDataTable(query);
    //    //con.CloseConnection();
    //    List<PatientData> patient_data = new List<PatientData>();
    //    for (int i = 0; i < dt.Rows.Count; i++)
    //    {
    //        PatientData data = new PatientData();
    //        data.ActivePatient = Convert.ToInt32(dt.Rows[i]["ActivePatientCount"]);
    //        data.NewPatient = Convert.ToInt32(dt.Rows[i]["NewPatientCount"]);
    //        data.DisenrolledPatient = Convert.ToInt32(dt.Rows[i]["DisenrolledPatientCount"]);
    //        data.DisenrolledAnalysis = Convert.ToString(dt.Rows[i]["DisenrolledAnalysis"]);
    //        data.Month = Convert.ToString(dt.Rows[i]["Month"]);
    //        data.Year = Convert.ToInt32(dt.Rows[i]["Year"]);
    //        patient_data.Add(data);

    //    }
    //    Console.WriteLine(patient_data);
    //    return JsonConvert.SerializeObject(patient_data);
    //}

    //public class PatientData
    //{
    //    public string Month { get; set; }
    //    public int Year { get; set; }
    //    public int ActivePatient { get; set; }
    //    public int NewPatient { get; set; }
    //    public int DisenrolledPatient { get; set; }
    //    public string DisenrolledAnalysis { get; set; }
    //}

}