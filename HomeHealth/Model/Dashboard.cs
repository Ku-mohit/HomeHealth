using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HomeHealth.Model
{
    /*  It is a model class.
     * It is used to define the getter/setter for dashboard.
     * Here the fields in dashboard used are defined.
     * As Month will be used to get and set the values from/to the Month variable.
     * Likewise the other variables used to get and set the values.
     */
    public class Dashboard
    {
        public string Month { get; set; }
        public string Insurance { get; set; }
        public int Year { get; set; }
        public int ActivePatient { get; set; }
        public int NewPatient { get; set; }
        public int DisenrolledPatient { get; set; }
        public string DisenrolledAnalysis { get; set; }
    }
    

}