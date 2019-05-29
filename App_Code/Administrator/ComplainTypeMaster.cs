using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ComplainTypeMaster
/// </summary>
public class ComplainTypeMaster
{
    public Int64 ComplainTypeKey { get; set; }

    public string ComplainName { get; set; }

    public bool? IsActive { get; set; }

    public DateTime? CreatedOn { get; set; }

    public Int64? CreatedBy { get; set; }

    public Int64? LastModifiedBy { get; set; }

    public DateTime? LastModifiedOn { get; set; }

}
