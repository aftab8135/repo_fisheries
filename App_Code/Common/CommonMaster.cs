using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for CommonMaster
/// </summary>
public class CommonMaster
{
    public int MasterKey { get; set; }

    public string RecordType { get; set; }

    public string ParticularEnglish { get; set; }

    public string ParticularHindi { get; set; }

    public bool? IsActive { get; set; }

    public Int64? CreatedBy { get; set; }

    public DateTime? CreatedOn { get; set; }

    public Int64? LastModifiedBy { get; set; }

    public DateTime? LastModifiedOn { get; set; }

}