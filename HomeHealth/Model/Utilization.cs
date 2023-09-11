using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HomeHealth.Model
{
    /*  It is a model class.
     * It is used to define the getter/setter for Utilization(cost analysis).
     * Here the fields in Utilization used are defined.
     * As Month will be used to get and set the values from/to the Month variable.
     * Likewise the other variables used to get and set the values.
     */
    public class Utilization
    {
        public string Month { get; set; }
        public int Year { get; set; }
        public int MembershipCount { get; set; }
        public int TotalRevenue { get; set; }
        public int TotalCost { get; set; }
        public int TotalCost_with_IBNR { get; set; }
        public int PartA_Cost { get; set; }
        public int PartB_Cost { get; set; }
        public int PartD_Cost { get; set; }
        public int Ancilliary { get; set; }
        public int Dental { get; set; }
        public int OTC { get; set; }
        public int Other { get; set; }
        public float MLR { get; set; }
    }
}