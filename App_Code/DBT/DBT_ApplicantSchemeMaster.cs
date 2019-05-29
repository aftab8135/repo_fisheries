using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for DBT_ApplicantSchemeMaster
/// </summary>
public class DBT_ApplicantSchemeMaster
{
    public Int64 AppSchemeKey { get; set; }

    public Int64 RegistrationKey { get; set; }

    public Int64 SchemeKey { get; set; }

    public int LandType { get; set; }

    public bool IsActive { get; set; }

    public ICollection<DBT_ApplicantSchemeDetail> Lands;
}
