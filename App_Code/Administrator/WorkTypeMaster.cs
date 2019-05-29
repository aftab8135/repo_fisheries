using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for WorkTypeMaster
/// </summary>
public class WorkTypeMaster
{
    public int WorkTypeKey { get; set; }

    public string WorkTypeName { get; set; }

    public Int64? CreatedBy { get; set; }

    public DateTime? CreatedOn { get; set; }

    public Int64? LastModifiedBy { get; set; }

    public DateTime? LastModifiedOn { get; set; }

    public bool? IsActive { get; set; }

}
