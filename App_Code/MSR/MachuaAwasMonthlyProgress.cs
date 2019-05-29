using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for MachuaAwasMonthlyProgress
/// </summary>
public class MachuaAwasMonthlyProgress
{
    public Int64 MAProgressKey { get; set; }
    public int? MonthKey { get; set; }
    public string FinYear { get; set; }
    public int? DistrictKey { get; set; }
    public int? DivisionKey { get; set; }
    public int? YearlyTargetKey { get; set; }
    public int? YearlyTarget { get; set; }
    public int? AwasCompleted { get; set; }
    public int? AwasUnConstruction { get; set; }
    public int? AwasUntimely { get; set; }
    public decimal? AllocatedAmount { get; set; }
    public decimal? FirstInstallment { get; set; }
    public decimal? SecondInstallment { get; set; }
    public decimal? ExpenditureAmount { get; set; }
    public decimal? BalanceAmount { get; set; }
    public string Remarks { get; set; }
    public bool? IsActive { get; set; }
    public DateTime? CreatedOn { get; set; }
    public int? CreatedBy { get; set; }
    public DateTime? LastModifiedOn { get; set; }
    public int? LastModifiedBy { get; set; }
}

public class MachuaAwasYearlyTarget
{
    public Int64 YearlyTargetKey { get; set; }
    public string FinYear { get; set; }
    public int? DivisionKey { get; set; }
    public int? DistrictKey { get; set; }
    public int? MA_YearlyTarget { get; set; }

}