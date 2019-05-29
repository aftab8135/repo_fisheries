using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for MSR_FisheryProductionAllSources
/// </summary>
public class MSR_FisheryProductionAllSources
{
    public Int64 FisheryProductionKey { get; set; }
    public int DistrictKey { get; set; }
    public int DivisionKey { get; set; }
    public int FishProdHeadKey { get; set; }
    public int MonthId { get; set; }
    public string FinancialYear { get; set; }
    public decimal YearlyTaget { get; set; }
    public bool IsActive { get; set; }
    public Int64? CreatedBy { get; set; }
    public Int64? LastModifiedBy { get; set; }
    public DateTime? CreatedOn { get; set; }
    public DateTime? LastModifiedOn { get; set; }

    public ICollection<MSR_FisheryProductionAllSourcesDetail> FishProdDetails;
}


public class MSR_FisheryProductionAllSourcesDetail
{ 
      public Int64  FishProductionDetailKey { get; set; }
      public Int64 FisheryProductionKey { get; set; }
      public Int64 FishProdSubHeadKey { get; set; }
      public decimal TotalArea { get; set; }
      public decimal TotalProduction { get; set; }
      public bool IsActive  { get; set; }
}