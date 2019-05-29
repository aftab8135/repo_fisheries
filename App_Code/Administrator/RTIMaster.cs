using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for RTIMaster
/// </summary>
public class RTIMaster
{
    public int MasterKey { get; set; }

    public string EffectiveDate { get; set; }

    public decimal? Amount { get; set; }

    public Int64 CreatedBy { get; set; }

    public Int64? LastModifiedBy { get; set; }
}