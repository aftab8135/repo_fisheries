using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for DBT_ApplicantRegistration
/// </summary>
public class DBT_ApplicantRegistration
{
    public Int64 RegistrationKey { get; set; }

    public string RegistrationCode { get; set; }

    public string RegistrationDate { get; set; }

    public string FinancialYear { get; set; }

    public string AFirstName { get; set; }

    public string ASecondName { get; set; }

    public string ALastName { get; set; }

    public string FFirstName { get; set; }

    public string FSecondName { get; set; }

    public string FLastName { get; set; }

    public int DistrictKey { get; set; }

    public int BlockKey { get; set; }

    public int VillageKey { get; set; }

    public string MobileNo { get; set; }

    public string AadharNo { get; set; }

    public string EmailId { get; set; }

    public int Category { get; set; }

    public int Gender { get; set; }

    public bool Minority { get; set; }

    public int? BankKey { get; set; }

    public int? BranchKey { get; set; }

    public string AccountNo { get; set; }

    public string IFSCCode { get; set; }

    public bool IsActive { get; set; }

    public Int64 CreatedBy { get; set; }

    public Int64? LastModifiedBy { get; set; }

    public string DateofBirth { get; set; }

    public string kisanCreditCard { get; set; }

    public string VoterIdCard { get; set; }

    public ICollection<DBT_ApplicantSchemeMaster> Schemes;


}

