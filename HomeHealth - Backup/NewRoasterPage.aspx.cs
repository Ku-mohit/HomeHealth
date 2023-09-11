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
    public partial class NewRoasterPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string year = Request.QueryString["Year"];
            string insurance = Request.QueryString["Insurance"];
            string month = Request.QueryString["Month"];
            //ClientScript.RegisterClientScriptBlock(this.GetType(), "CallMyFunction", "ShowMembershipRoaster('" + insurance + "','" + year+"','"+month+ "')", true);
            lblMonth.Text = month;
            lblInsurance.Text = insurance;
            lblYear.Text = year;
            BindGridview(insurance, year, month);
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("HomePage.aspx");
        }

        protected void btnSaveAsExcel_Click(object sender, EventArgs e)
        {
            ExportGridToExcel();
        }
        private void ExportGridToExcel()
        {
            Response.Clear();
            Response.Buffer = true;
            Response.ClearContent();
            Response.ClearHeaders();
            Response.Charset = "";
            string FileName = Request.QueryString["Insurance"] + "Roaster" + Request.QueryString["Month"] + Request.QueryString["Year"] + ".xls";
            StringWriter strwritter = new StringWriter();
            HtmlTextWriter htmltextwrtter = new HtmlTextWriter(strwritter);
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/vnd.ms-excel";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + FileName);
            grdvRoaster.GridLines = GridLines.Both;
            grdvRoaster.HeaderStyle.Font.Bold = true;
            grdvRoaster.RenderControl(htmltextwrtter);
            Response.Write(strwritter.ToString());
            Response.End();

        }
        [System.Web.Services.WebMethod]
        public static string GetMembershipByMonth(string insurance, string year, string month)
        {
            string ConnectionString = @"Data Source=VATSALPC6;Initial Catalog=PAVBCMDashboard;User ID=sa;Password=Vatsal123";
            SqlConnection con = new SqlConnection(ConnectionString);

            List<MembershipRoaster> membership_raoster = new List<MembershipRoaster>();
            SqlCommand cmd = new SqlCommand("GetMembershipByMonth", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Insurance", insurance);
            cmd.Parameters.AddWithValue("@Year", Convert.ToInt32(year));
            cmd.Parameters.AddWithValue("@Month", month);
            con.Open();
            SqlDataAdapter sda = new SqlDataAdapter();
            DataTable dt = new DataTable();
            sda.SelectCommand = cmd;
            sda.Fill(dt);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                MembershipRoaster data = new MembershipRoaster();
                data.FirstName = Convert.ToString(dt.Rows[i]["FirstName"]);
                data.LastName = Convert.ToString(dt.Rows[i]["LastName"]);
                data.MiddleName = Convert.ToString(dt.Rows[i]["MiddleName"]);
                data.DateOfBirth = Convert.ToDateTime(dt.Rows[i]["DateOfBirth"]);
                data.Gender = Convert.ToChar(dt.Rows[i]["Gender"]);
                data.Age = Convert.ToInt32(dt.Rows[i]["Age"]);
                data.PhoneNumber = Convert.ToDouble(dt.Rows[i]["PhoneNumber"]);
                data.MemberEmail = Convert.ToString(dt.Rows[i]["MemberEmail"]);
                data.PatientStartDate = Convert.ToDateTime(dt.Rows[i]["PatientStartDate"]);
                data.PCPStartDate = Convert.ToDateTime(dt.Rows[i]["PCPStartDate"]);
                data.PCPTermDate = Convert.ToDateTime(dt.Rows[i]["PCPTermDate"]);
                data.PCPTermDate = Convert.ToDateTime(dt.Rows[i]["PCPTermDate"]);
                data.LastVisit = Convert.ToDateTime(dt.Rows[i]["LastVisit"]);
                data.NextVisit = Convert.ToDateTime(dt.Rows[i]["NextVisit"]);
                data.Comments = Convert.ToString(dt.Rows[i]["Comments"]);
                data.CPI_ID = Convert.ToDouble(dt.Rows[i]["CPI_ID"]);
                data.ProviderID = Convert.ToInt32(dt.Rows[i]["ProviderID"]);
                data.PatientAdmissionInHospital = Convert.ToString(dt.Rows[i]["PatientAdmissionInHospital"]);
                data.Insurance = Convert.ToString(dt.Rows[i]["Insurance"]);
                data.InsurancePlan = Convert.ToString(dt.Rows[i]["InsurancePlan"]);
                data.NetworkCode = Convert.ToString(dt.Rows[i]["NetworkCode"]);
                data.NetworkName = Convert.ToString(dt.Rows[i]["NetworkName"]);
                data.Month = Convert.ToString(dt.Rows[i]["Month"]);
                data.Year = Convert.ToInt32(dt.Rows[i]["Year"]);
                data.opv0 = Convert.ToString(dt.Rows[i]["OptionalVariable1"]);
                data.opv1 = Convert.ToString(dt.Rows[i]["OptionalVariable2"]);
                data.opv2 = Convert.ToString(dt.Rows[i]["OptionalVariable3"]);

                membership_raoster.Add(data);
            }
            return JsonConvert.SerializeObject(membership_raoster);
        }

        // Added on 04202023 to display data in gridview by Utpal.
        private void BindGridview(string insurance, string year, string month)
        {
            string ConnectionString = @"Data Source=VATSALPC6;Initial Catalog=PAVBCMDashboard;User ID=sa;Password=Vatsal123";
            SqlConnection con = new SqlConnection(ConnectionString);

            List<MembershipRoaster> membership_raoster = new List<MembershipRoaster>();
            SqlCommand cmd = new SqlCommand("GetMembershipByMonth", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Insurance", insurance);
            cmd.Parameters.AddWithValue("@Year", Convert.ToInt32(year));
            cmd.Parameters.AddWithValue("@Month", month);
            con.Open();
            SqlDataAdapter sda = new SqlDataAdapter();
            DataTable dt = new DataTable();
            sda.SelectCommand = cmd;
            sda.Fill(dt);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                MembershipRoaster data = new MembershipRoaster();
                data.FirstName = Convert.ToString(dt.Rows[i]["FirstName"]);
                data.LastName = Convert.ToString(dt.Rows[i]["LastName"]);
                data.MiddleName = Convert.ToString(dt.Rows[i]["MiddleName"]);
                data.DateOfBirth = Convert.ToDateTime(dt.Rows[i]["DateOfBirth"]);
                data.Gender = Convert.ToChar(dt.Rows[i]["Gender"]);
                data.Age = Convert.ToInt32(dt.Rows[i]["Age"]);
                data.PhoneNumber = Convert.ToDouble(dt.Rows[i]["PhoneNumber"]);
                data.MemberEmail = Convert.ToString(dt.Rows[i]["MemberEmail"]);
                data.PatientStartDate = Convert.ToDateTime(dt.Rows[i]["PatientStartDate"]);
                data.PCPStartDate = Convert.ToDateTime(dt.Rows[i]["PCPStartDate"]);
                data.PCPTermDate = Convert.ToDateTime(dt.Rows[i]["PCPTermDate"]);
                data.PCPTermDate = Convert.ToDateTime(dt.Rows[i]["PCPTermDate"]);
                data.LastVisit = Convert.ToDateTime(dt.Rows[i]["LastVisit"]);
                data.NextVisit = Convert.ToDateTime(dt.Rows[i]["NextVisit"]);
                data.Comments = Convert.ToString(dt.Rows[i]["Comments"]);
                data.CPI_ID = Convert.ToDouble(dt.Rows[i]["CPI_ID"]);
                data.ProviderID = Convert.ToInt32(dt.Rows[i]["ProviderID"]);
                data.PatientAdmissionInHospital = Convert.ToString(dt.Rows[i]["PatientAdmissionInHospital"]);
                data.Insurance = Convert.ToString(dt.Rows[i]["Insurance"]);
                data.InsurancePlan = Convert.ToString(dt.Rows[i]["InsurancePlan"]);
                data.NetworkCode = Convert.ToString(dt.Rows[i]["NetworkCode"]);
                data.NetworkName = Convert.ToString(dt.Rows[i]["NetworkName"]);
                data.Month = Convert.ToString(dt.Rows[i]["Month"]);
                data.Year = Convert.ToInt32(dt.Rows[i]["Year"]);
                data.opv0 = Convert.ToString(dt.Rows[i]["OptionalVariable1"]);
                data.opv1 = Convert.ToString(dt.Rows[i]["OptionalVariable2"]);
                data.opv2 = Convert.ToString(dt.Rows[i]["OptionalVariable3"]);

                membership_raoster.Add(data);
            }
            grdvRoaster.DataSource = membership_raoster;
            grdvRoaster.DataBind();
        }

        public override void VerifyRenderingInServerForm(Control control)
        {

        }
    }
}