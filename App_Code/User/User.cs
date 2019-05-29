using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class User
{
    

    public Int32 UserKey { get; set; }
    public Int16 UserType { get; set; }
    public String UserTypeName { get; set; }    //For JS
    public Int32 OfficeKey { get; set; }
    public String OfficeName { get; set; }
    public Int32 BankKey { get; set; }
    public string Gender { get; set; }
    public String Name { get; set; }
    public String UserName { get; set; }
    public String Password { get; set; }
    public Int32 DistrictKey { get; set; }
    public String DistrictName { get; set; }
    public String PinCode { get; set; }
    public String ContactPName { get; set; }
    public String ContactPDesignation { get; set; }
    public string OfficeAddress { get; set; }
    public string City { get; set; }
    public string MobileNo { get; set; }
    public String PhoneNo { get; set; }
    public String EmailID { get; set; }
    public String Fax { get; set; }
    public Boolean IsPasswordChanged { get; set; }
    public Boolean IsActive { get; set; }
    public Int32 CreatedBy { get; set; }
    public DateTime CreatedOn { get; set; }
    public Int32 LastModifiedBy { get; set; }
    public DateTime LastModifiedOn { get; set; }
    public Boolean IsPasswordChange { get; set; }

}



public class CandidateRegistration
{
    public Int64 RegistrationKey { get; set; }
    public string RegistrationNo { get; set; }
    public Int32 RegistrationType { get; set; }
    public String UserName { get; set; }
    public String Password { get; set; }

    public String FullName { get; set; }
    public String FatherName { get; set; }
    public String AadharNo { get; set; }
    public String MobileNo { get; set; }
    public String EmailId { get; set; }
    public DateTime DateOfBirth { get; set; }
    public String Dob { get; set; }
    public String PanNo { get; set; }

    public String CurrentAddress { get; set; }
    public Int32 StateKey { get; set; }
    public Int32 StateName { get; set; }
    public Int32 DistrictKey { get; set; }
    public Int32 DistrictName { get; set; }
    public String City { get; set; }
    public String PinCode { get; set; }
    public String Tehsil { get; set; }
    public String Village { get; set; }

    public Boolean IsSameAddress { get; set; }
    public String PostalAddress { get; set; }
    public Int32 PostalStateKey { get; set; }
    public Int32 PostalStateName { get; set; }
    public Int32 PostalDistrictKey { get; set; }
    public Int32 PostalDistrictName { get; set; }
    public String PostalCity { get; set; }
    public String PostalPinCode { get; set; }
    public String PostalTehsil { get; set; }
    public String PostalVillage { get; set; }
  
    public Int32 CreatedBy { get; set; }
    public Int32 LastModifiedBy { get; set; }
    public DateTime CreatedOn { get; set; }
    public DateTime LastModifiedOn { get; set; }
    public Boolean IsActive { get; set; }

    public Boolean RegistrationMode { get; set; }

    public Int32 PropertyKey { get; set; }
    public Int32 SchemeKey { get; set; }
    public Int32 SectorKey { get; set; }
    public String  AllotmentNo { get; set; }


   
}







