using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for SchemeWorkTypeMaster
/// </summary>
public class SchemeWorkTypeMaster
{
    public Int64 SchemeWorkKey { get; set; }

    public string EffectiveDate { get; set; }

    public Int64 SchemeKey { get; set; }

    public int WorkTypeKey { get; set; }

    public decimal? InstPercent { get; set; }

    public int? InstNos { get; set; }

    public Int64 CreatedBy { get; set; }

    public DateTime CreatedOn { get; set; }

    public Int64? LastModifiedBy { get; set; }

    public DateTime? LastModifiedDate { get; set; }

    public bool? IsActive { get; set; }

    public ICollection<SchemeWorkTypeDetail> SchemeWorkTypeDetails;

}