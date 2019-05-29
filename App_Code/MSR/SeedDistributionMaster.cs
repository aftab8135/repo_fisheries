using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for SeedDistributionMaster
/// </summary>
public class SeedDistributionMaster
{
    public Int64 SDMasterKey { get; set; }

    public int SDObjectKey { get; set; }

    public int DistrictKey { get; set; }

    public int DivisionKey { get; set; }

    public string FinYear { get; set; }

    public int MonthKey { get; set; }

    public Int64? CreatedBy { get; set; }

    public Int64? LastModifiedBy { get; set; }

    public ICollection<SeedDistributionDetail> DistDetails;
}