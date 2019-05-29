using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ApplicationDetail
/// </summary>
public class ApplicantDetail
{
    public Int64 UserNo { get; set; }
    public Int64 RegistrationKey { get; set; }
    public String CareOf { get; set; }
    public String FatherName { get; set; }

    public String DOB { get; set; }
    public Int16 Gender { get; set; }
    public Int16 Caste { get; set; }
    public String RevenueVillage { get; set; }
    public String PostOffice { get; set; }
    public String PinNo { get; set; }
    public Int32 DistrictNo { get; set; }
    public Int32 BlockNo { get; set; }
    public Int32 TehsilNo { get; set; }
    public String PostallAddress { get; set; }
    public String EmailID { get; set; }
    public int UserBankName { get; set; }
    public int UserBankShakha { get; set; }
    public String UserBankIFSC { get; set; }
    public String UserAcNo { get; set; }
    public String NomineeName { get; set; }

    public int NomineeGender { get; set; }
    public DateTime NomineeDOB { get; set; }
    public String NomineeRelation { get; set; }
    public String NomineeBankName { get; set; }
    public String NomineeBankShakha { get; set; }
    public String NomineeBankIFSC { get; set; }
    public String NomineeBankAcNo { get; set; }
    public DateTime CreatedOn { get; set; }
    public DateTime LastUpdateOn { get; set; }
    public String Phone_no { get; set; }

    public String TehsilName { get; set; }
    public String MobileNo { get; set; }
}
