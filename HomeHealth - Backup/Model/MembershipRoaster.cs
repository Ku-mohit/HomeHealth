using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HomeHealth.Model
{
    /*  It is a model class.
     * It is used to define the getter/setter for Membership.
     * Here the fields in membership used are defined.
     * As FirstName will be used to get and set the values from/to the variable.
     * Likewise the other variables used to get and set the values.
     */
    public class MembershipRoaster
    {
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public DateTime DateOfBirth { get; set; }
        public char Gender{ get; set; }
        public int Age{ get; set; }
        public double PhoneNumber{ get; set; }
        public string MemberEmail{ get; set; }
        public DateTime PatientStartDate{ get; set; }
        public DateTime PCPStartDate{ get; set; }
        public DateTime PCPTermDate{ get; set; }
        public DateTime LastVisit{ get; set; }
        public DateTime NextVisit{ get; set; }
        public string Comments{ get; set; }
        public double CPI_ID{ get; set; }
        public int ProviderID{ get; set; }
        public string PatientAdmissionInHospital{ get; set; }
        public string Insurance{ get; set; }
        public string InsurancePlan{ get; set; }
        public string NetworkCode{ get; set; }
        public string NetworkName{ get; set; }
        public string Month{ get; set; }
        public int Year{ get; set; }
        public string opv0{ get; set; }
        public string opv1{ get; set; }
        public string opv2{ get; set; }
        public string opv3{ get; set; }
    }
}