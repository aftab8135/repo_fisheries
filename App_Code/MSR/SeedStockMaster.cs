using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for SeedStockMaster
/// </summary>
public class SeedStockMaster
{
    public Int64 SSMasterKey { get; set; }

    public int SSObjectKey { get; set; }

    public decimal YearlyTarget { get; set; }

    public int? DistrictKey { get; set; }

    public int? DivisionKey { get; set; }

    public string FinYear { get; set; }

    public int? MonthKey { get; set; }

    public Int64? CreatedBy { get; set; }

    public Int64? LastModifiedBy { get; set; }

    public ICollection<SeedStockDetail> SeedStocks;
}
