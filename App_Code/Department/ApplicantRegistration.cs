using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ApplicantRegistration
/// </summary>
public class ApplicantRegistration
{
    public Int64 RegistrationKey { get; set; }
    public String AadharNo { get; set; }
    public String MobileNo { get; set; }
    public String Salutation { get; set; }
    public String Name { get; set; }
    public String UserName { get; set; }
    public String Password { get; set; }

    public Boolean IsActive { get; set; }
    public DateTime CreatedOn { get; set; }
    public String PrevPasswords { get; set; }
    public Int64 userkey { get; set; }

}
