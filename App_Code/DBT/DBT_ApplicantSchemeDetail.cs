using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for DBT_ApplicantSchemeDetail
/// </summary>
public class DBT_ApplicantSchemeDetail
{
    public Int64 DetailKey { get; set; }

    public Int64 RegistrationKey { get; set; }

    public Int64 AppSchemeKey { get; set; }

    public bool IsKhatauni { get; set; }

    public string KhatauniNo { get; set; }

    public decimal Area { get; set; }

    public int UnitID { get; set; }

    public bool IsActive { get; set; }

}
