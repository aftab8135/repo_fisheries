using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for MSR_PhyEventMaster
/// </summary>
public class MSR_PhyEventMaster
{
    public Int64 PEMMasterKey { get; set; }

    public int CategoryKey { get; set; }

    public int MonthId { get; set; }

    public string FinancialYear { get; set; }

    public int DistrictKey { get; set; }

    public int DivisionKey { get; set; }

    public bool IsActive { get; set; }

    public Int64? CreatedBy { get; set; }

    public Int64? LastModifiedBy { get; set; }

    public ICollection<MSR_PhyEventDetail> EventDts;
}
