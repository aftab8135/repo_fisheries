using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ComplainSubType
/// </summary>
public class ComplainSubType
{
    public Int64 SubTypeKey { get; set; }

    public Int64 ComplainTypeKey { get; set; }

    public string SubTypeName { get; set; }

    public int DesignationKey { get; set; }

    public int SectionKey { get; set; }

    public int TimeFrame { get; set; }

    public bool? IsActive { get; set; }

    public DateTime? CreatedOn { get; set; }

    public Int64? CreatedBy { get; set; }

    public Int64? LastModifiedBy { get; set; }

    public DateTime? LastModifiedOn { get; set; }

}
