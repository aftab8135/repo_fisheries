using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for MSR_PhyEventDetail
/// </summary>
public class MSR_PhyEventDetail
{
    public Int64 PEMDetailKey { get; set; }

    public Int64 PEMMasterKey { get; set; }

    public int SubCategoryKey { get; set; }

    public int UnitKey { get; set; }

    public string Grade { get; set; }

    public decimal? YearlyTarget { get; set; }

    public decimal? PrevAmount { get; set; }

    public decimal? RecAmount { get; set; }

    public decimal? TotalAmount { get; set; }

    public bool IsActive { get; set; }

}
