using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace HomeHealth.Connection
{
    public class Connection
    {
        string ConnectionString = @"Data Source=VATSALPC6;Initial Catalog=PAVBCMDashboard;User ID=sa;Password=Vatsal123";
        SqlConnection con;

        public void OpenConnection()
        {
            con = new SqlConnection(ConnectionString);
            con.Open();
            Console.WriteLine("Connection is istablished!");
        }
        public void CloseConnection()
        {
            con.Close();
            Console.WriteLine("Connection is Closed!");
        }
        public void ExecuteQueries(string Query_)
        {
            SqlCommand cmd = new SqlCommand(Query_, con);
            cmd.ExecuteNonQuery();
            Console.WriteLine("Your Querry is executed!");
        }

        public SqlDataReader DataReader(string Query_)
        {
            SqlCommand cmd = new SqlCommand();
            SqlDataReader dr = cmd.ExecuteReader();
            return dr;
        }
        public DataTable GetDataTable(string Query_)
        {
            SqlDataAdapter dr = new SqlDataAdapter(Query_ ,ConnectionString);
            SqlCommand cmd = new SqlCommand(Query_, con);

            DataTable dt = new DataTable();
            dr.SelectCommand = cmd; 
            dr.Fill(dt);
            return dt;
        }
    }
}