using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for FishProductionTant
/// </summary>
public class FishProductionTant
{
    public Int64 FishProdKey { get; set; }

    public int DistrictKey { get; set; }

    public string FinYear { get; set; }

    public int? MonthKey { get; set; }

    public decimal? YearlyTarget { get; set; }

    public decimal? Pond { get; set; }

    public decimal? WaterArea { get; set; }

    public decimal? Lake { get; set; }

    public decimal? River { get; set; }

    public decimal? Total { get; set; }

    public string Remark { get; set; }

    public bool? IsActive { get; set; }

    public Int64? CreatedBy { get; set; }

    public Int64? LastModifiedBy { get; set; }

}
