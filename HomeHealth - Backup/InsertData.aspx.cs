using HomeHealth.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;


namespace HomeHealth
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        static string connectionString = @"Data Source=VATSALPC6;Initial Catalog=PAVBCMDashboard;User ID=sa;Password=Vatsal123";
        SqlConnection con = new SqlConnection(connectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            //GridView1.DataSource = LoadCSV();
            //GridView1.DataBind();
            FillDatabase();



        }
        private void FillDatabase()
        {
            int maxId = 1;
            con.Open();
            var data = LoadCSV("Sep2022 - Dummy");
            string querry = "select Max(Id) as Id from HEDIS_MASTER";
            SqlCommand cmds = new SqlCommand(querry, con);
            cmds.CommandType = CommandType.Text;
            SqlDataAdapter da = new SqlDataAdapter(cmds);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["Id"] != null && dt.Rows[0]["Id"].ToString() != string.Empty)
                {

                    maxId = Convert.ToInt32(dt.Rows[0]["Id"].ToString());
                }
                else
                {
                    Response.Write("Null");
                }

            }
            else
            {
                Response.Write("NULL DT empty");
            }
            if (maxId != 1)
            {
                maxId += 1;
            }



            //int MaxID = 1;
            //if (MaxID==)
            //{

            //}
            for (int i = 0; i < data.Rows.Count; i++)
            {
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                // Get measure id
                string measure = data.Rows[i]["Measure"].ToString();
                SqlCommand cmdMeasure = new SqlCommand("select Id from HEDIS_MEASURES where Measure='" + measure + "'", con);
                cmds.CommandType = CommandType.Text;
                SqlDataAdapter daMeasure = new SqlDataAdapter(cmdMeasure);
                DataTable dtMeasure = new DataTable();
                daMeasure.Fill(dtMeasure);
                if (dtMeasure.Rows.Count > 0)
                {
                    measure = dtMeasure.Rows[0]["Id"].ToString();
                }

                //Get Insurance Id
                //
                /*string _insurance = data.Rows[i]["Insurance"].ToString();
                SqlCommand cmd_insurance = new SqlCommand("select Id from Insurance_Master where Insurance_Company='" + _insurance + "' and Insurance_Plan='Extra' and Insurance_Type='Primary'", con);
                cmd_insurance.CommandType = CommandType.Text;
                SqlDataAdapter da_insurance = new SqlDataAdapter(cmd_insurance);
                DataTable dt_insurance = new DataTable();
                da_insurance.Fill(dt_insurance);
                //lblConfirm.Text = dt.Rows[0]["Id"].ToString();
                //GridView2.DataSource = dt_insurance;
                //GridView2.DataBind();
                if (dt_insurance.Rows.Count > 0)
                {
                    _insurance = dt_insurance.Rows[0]["Id"].ToString();
                }
                if (_insurance != null)
                {
                    _insurance = dt_insurance.Rows[0]["Id"].ToString();

                }*/

                // Insert data
                SqlCommand cmd = new SqlCommand("InsertClinicalQualityData", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Clear();
                
                cmd.Parameters.AddWithValue("@Id", maxId);
                cmd.Parameters.AddWithValue("@Year", 2022);
                cmd.Parameters.AddWithValue("@Month", "September");
                if (measure == null || measure != string.Empty)
                {
                    measure = "1";
                }
                cmd.Parameters.AddWithValue("@Measure", Convert.ToInt32(measure));
                cmd.Parameters.AddWithValue("@Criteria", "");

                int MissingPatient = 0;
                string MissingPatient_ = data.Rows[i]["MissingPatient"].ToString().Replace("\r", string.Empty);
                if (MissingPatient_ == string.Empty && MissingPatient_ == null)
                {
                    MissingPatient_ = "0";
                }
                else if (MissingPatient_ == string.Empty)
                {
                    MissingPatient_ = "0";
                }
                cmd.Parameters.AddWithValue("@MissingPatient", Convert.ToInt32(MissingPatient_));

                //var Insurance = "";
                //string Insurance_ = data.Rows[i]["Insurance"].ToString();
                //    if (Insurance_ != string.Empty)
                //{
                //    Insurance_ = data.Rows[i]["Insurance"].ToString();
                //}
                cmd.Parameters.AddWithValue("@Insurance", 1);

                int Total = 0;
                string Total_ = data.Rows[i]["Total"].ToString().Replace("\r", string.Empty);
                if (Total_ == string.Empty && Total_ == null)
                {
                    Total_ = "0";
                }
                else if (Total_ == string.Empty)
                {
                    Total_ = "0";
                }
                cmd.Parameters.AddWithValue("@Total", Convert.ToInt32(Total_));

                cmd.Parameters.AddWithValue("@OptionalVariable1", data.Rows[i]["OptionalVariable1"].ToString());
                cmd.Parameters.AddWithValue("@OptionalVariable2", data.Rows[i]["OptionalVariable2"].ToString());
                cmd.Parameters.AddWithValue("@OptionalVariable3", data.Rows[i]["OptionalVariable3"].ToString());
                cmd.Parameters.AddWithValue("@Description", data.Rows[i]["Description"].ToString());

                string category = string.Empty;
                if (data.Rows[i]["Category"] != null)
                {
                    category = data.Rows[i]["Category"].ToString();
                }
                cmd.Parameters.AddWithValue("@Category", category);
                cmd.ExecuteNonQuery();
                cmd.Dispose();
                con.Close();
                lblConfirm.Text = "Added!";
                maxId++;
            }
            //int age = 0;
            //if (data.Rows[i]["Age"].ToString() != string.Empty)
            //{
            //    age = Convert.ToInt32(data.Rows[i]["Age"].ToString());
            //}
            //DateTime patientStartDate = DateTime.Parse("01-01-1900");
            //if (data.Rows[i]["PatientStartDate"].ToString() != string.Empty)
            //{
            //    patientStartDate = DateTime.Parse(data.Rows[i]["PatientStartDate"].ToString());
            //}
            //DateTime patientNextVisit = DateTime.Parse("01-01-1900");
            //if (data.Rows[i]["NextVisit"].ToString() != string.Empty)
            //{
            //    patientNextVisit = DateTime.Parse(data.Rows[i]["NextVisit"].ToString());
            //}
            //DateTime patientLastVisit = DateTime.Parse("01-01-1900");
            //if (data.Rows[i]["LastVisit"].ToString() != string.Empty)
            //{
            //    patientLastVisit = DateTime.Parse(data.Rows[i]["LastVisit"].ToString());
            //}
            //int providerID = 0;
            //if (data.Rows[i]["ProviderID"].ToString() != string.Empty)
            //{
            //    providerID = Convert.ToInt32(data.Rows[i]["ProviderID"].ToString());
            //}
            //cmd.Parameters.AddWithValue("@Id", Convert.ToInt32(data.Rows[i]["Id"]));


            //cmd.Parameters.AddWithValue("@Id", Convert.ToInt32(data.Rows[i]["Id"]));
            //cmd.Parameters.AddWithValue("@Insurance", data.Rows[i]["Insurance"].ToString());

            //cmd.Parameters.AddWithValue("@Month", data.Rows[i]["Month"].ToString());
            //cmd.Parameters.AddWithValue("@Year", Convert.ToInt32(data.Rows[i]["Year"]));
            //cmd.Parameters.AddWithValue("@DisenrolledPatientCount", Convert.ToInt32(data.Rows[i]["DisenrolledPatientCount"]));

            //int NewPatientCount = 0;
            //var newPatient_ = data.Rows[i]["NewPatientCount"].ToString().Replace("\r", string.Empty);
            //if (newPatient_ != string.Empty)
            //{
            //    newPatient_ = Convert.ToInt32(data.Rows[i]["NewPatientCount"]).ToString();
            //}

            //cmd.Parameters.AddWithValue("@NewPatientCount", newPatient_);
            //int ActivePatientCount = 0;
            //var ActivePatientCount__ = data.Rows[i]["ActivePatientCount"].ToString().Replace("\r", string.Empty);
            //if (ActivePatientCount__ != string.Empty)
            //{
            //    ActivePatientCount__ = Convert.ToInt32(data.Rows[i]["NewPatientCount"]).ToString();
            //}

            //cmd.Parameters.AddWithValue("@ActivePatientCount", ActivePatientCount__);
            //cmd.Parameters.AddWithValue("@DisenrolledAnalysis", data.Rows[i]["DisenrolledAnalysis"].ToString());
            //cmd.Parameters.AddWithValue("@Year", Convert.ToInt32(data.Rows[i]["Year"]));
            //cmd.Parameters.AddWithValue("@Month", data.Rows[i]["Month"].ToString());
            //cmd.Parameters.AddWithValue("@MembershipCount", Convert.ToInt32(data.Rows[i]["MembershipCount"]));
            //cmd.Parameters.AddWithValue("@MLR", float.Parse((data.Rows[i]["MLR"].ToString())));
            //cmd.Parameters.AddWithValue("@TotalRevenue", Convert.ToInt64(data.Rows[i]["Totalrevenue"]));
            //cmd.Parameters.AddWithValue("@TotalCost", Convert.ToInt64(data.Rows[i]["TotalCost"]));
            //cmd.Parameters.AddWithValue("@TotalCost_with_IBNR", Convert.ToInt64(data.Rows[i]["TotalCost_with_IBNR"]));
            //cmd.Parameters.AddWithValue("@PartA_Cost", Convert.ToInt64(data.Rows[i]["PartA_Cost"]));
            //cmd.Parameters.AddWithValue("@PartB_Cost", Convert.ToInt64(data.Rows[i]["PartB_Cost"]));
            //cmd.Parameters.AddWithValue("@PartD_Cost", Convert.ToInt64(data.Rows[i]["PartD_Cost"]));
            //cmd.Parameters.AddWithValue("@Anicilliary", Convert.ToInt64(data.Rows[i]["PartA_Cost"]));
            //cmd.Parameters.AddWithValue("@Dental", Convert.ToInt64(data.Rows[i]["Dental"]));
            //int OTC = 0;
            //var OTC_= data.Rows[i]["OTC"].ToString().Replace("\r", string.Empty);
            //if (OTC_!= string.Empty)
            //{
            //    OTC = Convert.ToInt32(data.Rows[i]["OTC"].ToString());
            //}

            //cmd.Parameters.AddWithValue("@OTC", OTC);

            //int other = 0;
            //var other_ = data.Rows[i]["Other"].ToString().Replace("\r", string.Empty);
            //if (other_ != string.Empty)
            //{
            //    other = Convert.ToInt32(data.Rows[i]["Other"].ToString());
            //}

            //cmd.Parameters.AddWithValue("@Other", other);
            //cmd.Parameters.AddWithValue("@CPI_ID", Convert.ToInt64(data.Rows[i]["CPI_ID"].ToString()));
            //cmd.Parameters.AddWithValue("@ProviderID", providerID);
            //cmd.Parameters.AddWithValue("@PatientAdmissionInHospital", data.Rows[i]["PatientAdmissionInHospital"].ToString());
            //cmd.Parameters.AddWithValue("@Insurance", data.Rows[i]["Insurance"].ToString());
            //cmd.Parameters.AddWithValue("@InsurancePlan", data.Rows[i]["InsurancePlan"].ToString());
            //cmd.Parameters.AddWithValue("@NetworkCode", data.Rows[i]["NetworkCode"].ToString());
            //cmd.Parameters.AddWithValue("@NetworkName", data.Rows[i]["NetworkName"].ToString());
            //int Measure = 0;
            //var Measure_ = Convert.ToInt32(data.Rows[i]["Measure"].ToString().Replace("\r", string.Empty));
            //if (dt.Rows[i]["Measure"]!=null && dt.)
            //{
            //    Measure_ = Convert.ToInt32(data.Rows[i]["Measure"].ToString());
            //}
        }

        private DataTable LoadCSV(string fileName)
        {
            //string Year = ddlYear.SelectedItem.Text;
            //ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + message + "');", true);

            //string Insurance = ddlInsurance.SelectedItem.Text;
            //ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + message + "');", true);


            List<Dashboard> dataDashboard = new List<Dashboard>();


            //Upload and save the file
            string csvPath = Server.MapPath("~/Assests/SampleData/HEDIS/"+fileName+".csv");
            //Read the contents of CSV file.
            var csvData = File.ReadAllText(csvPath);
            string data = csvData.ToString().Replace("\n\r", "").Replace("\r", "").Replace("\n", "");
            //string csvData = string.Empty;
            //Create a DataTable.
            DataTable dt = new DataTable();
            dt.Columns.AddRange(new DataColumn[9]
            {
                //new DataColumn("Id", typeof(string)),
                new DataColumn("Measure", typeof(string)),
                //new DataColumn("Criteria", typeof(string)),
                new DataColumn("Category", typeof(string)),
                new DataColumn("Insurance", typeof(string)),
                new DataColumn("MissingPatient", typeof(string)),
                new DataColumn("Total", typeof(string)),
                new DataColumn("OptionalVariable1", typeof(string)),
                new DataColumn("OptionalVariable2", typeof(string)),
                new DataColumn("OptionalVariable3", typeof(string)),
                new DataColumn("Description", typeof(string)),
                //new DataColumn("Month", typeof(string)),
                //new DataColumn("Year", typeof(string)),

               // new DataColumn("MembershipCount", typeof(string)),
               //// new DataColumn("MembershipId", typeof(string)),
               // new DataColumn("MLR", typeof(string)),
               // new DataColumn("TotalRevenue", typeof(string)),
               // new DataColumn("TotalCost", typeof(string)),
               // new DataColumn("TotalCost_with_IBNR", typeof(string)),
               // new DataColumn("PartA_Cost", typeof(string)),
               // new DataColumn("PartB_Cost", typeof(string)),
               // new DataColumn("PartD_Cost", typeof(string)),
               // new DataColumn("Ancilliary", typeof(string)),
               // new DataColumn("Dental", typeof(string)),
               // new DataColumn("OTC", typeof(string)),
               // new DataColumn("Other", typeof(string))
                //new DataColumn("CPI_ID", typeof(string)),
                //new DataColumn("ProviderID", typeof(string)),
                //new DataColumn("PatientAdmissionInHospital", typeof(string)),
                //new DataColumn("NetworkName", typeof(string)),
                //new DataColumn("Insurance", typeof(string)),
                //new DataColumn("InsurancePlan", typeof(string)),
                //new DataColumn("NetworkCode", typeof(string)),
                //new DataColumn("DisenrolledAnalysis", typeof(string)),

            });

            //Execute a loop over the rows.
            foreach (string row in csvData.Split('\n'))
            {
                if (!string.IsNullOrEmpty(row))
                {
                    string row1 = row.Replace("\r", string.Empty).Replace("\n", string.Empty).Replace("\r\n", string.Empty).Replace("\"", string.Empty);
                    if (!string.IsNullOrEmpty(row1))
                    {
                        dt.Rows.Add();
                        int i = 0;
                        // Execute a loop over the columns.
                        foreach (string cell in row1.Split(','))
                        {
                            dt.Rows[dt.Rows.Count - 1][i] = cell;
                            i++;
                        }
                        //dt.Rows[dt.Rows.Count-1][i] = Convert.ToString(row);
                        //i++;
                    }
                }
            }

            return dt;

        }

    }
}
