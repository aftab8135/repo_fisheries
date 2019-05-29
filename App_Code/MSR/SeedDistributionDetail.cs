using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for SeedDistributionDetail
/// </summary>
public class SeedDistributionDetail
{
    public Int64 SDDetailKey { get; set; }

    public Int64 SDMasterKey { get; set; }

    public Int64 SDSubObjectKey { get; set; }

    public decimal? Target { get; set; }

    public decimal? Availed { get; set; }

    public decimal? Perc { get; set; }

}