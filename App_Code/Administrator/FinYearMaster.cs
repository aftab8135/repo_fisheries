using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for FinYearMaster
/// </summary>
public class FinYearMaster
{
    public int FinYearKey { get; set; }

    public string FinYear { get; set; }

    public bool? IsActive { get; set; }

    public DateTime? CreatedOn { get; set; }

    public Int64 CreatedBy { get; set; }

    public Int64 LastModifiedBy { get; set; }

    public DateTime? LastModifiedOn { get; set; }

}
