using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HomeHealth.Model
{
    /* Also it is a model class.
     * This class is defined for clinical quality(HEDIS).
     * As MissingPatient will be used to get/set value.
     * Likewise other variable are used to get and set the value.
     */
    public class ClinicalQuality
    {
        public int MissingPatient { get; set; }
        public int Total { get; set; }
        public string Month { get; set; }
        public int Year{ get; set; }
        public string Description{ get; set; }
        public string Category{ get;set; }
        public string Measure{ get; set; }
    }
}