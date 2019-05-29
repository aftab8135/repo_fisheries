using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for RoleMaster
/// </summary>
public class RoleMaster
{
    public Int64 ID { get; set; }

    public string RoleName { get; set; }

    public bool? IsActive { get; set; }

    public DateTime? CreatedOn { get; set; }

    public Int64 CreatedBy { get; set; }

}