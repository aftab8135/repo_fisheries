using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for PondProgressFirstMaster
/// </summary>
public class PondProgressFirstMaster
{
    public Int64 PondFMstKey { get; set; }

    public string FinYear { get; set; }

    public int? MonthKey { get; set; }

    public int? DistrictKey { get; set; }

    public int? DivisionKey { get; set; }

    public decimal? YearlyTarget { get; set; }

    public decimal? PondNos { get; set; }

    public decimal? PondArea { get; set; }

    public decimal? PastPastNos { get; set; }

    public decimal? PastPastArea { get; set; }

    public decimal? CurrPattaNos { get; set; }

    public decimal? CurrPattaArea { get; set; }

    public decimal? AbortPattaNos { get; set; }

    public decimal? AbortPattaArea { get; set; }

    public decimal? TotalPattaNos { get; set; }

    public decimal? TotalPattaArea { get; set; }

    public bool? IsActive { get; set; }

    public Int64? CreatedBy { get; set; }

    public int? LastModifiedBy { get; set; }

}