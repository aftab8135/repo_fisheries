using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ObjectMaster
/// </summary>
public class ObjectMaster
{
    public int ObjectKey { get; set; }

    public string ObjectCode { get; set; }

    public string ObjectEnglishName { get; set; }

    public string ObjectHindiName { get; set; }

    public bool IsActive { get; set; }

    public Int64? CreatedBy { get; set; }

    public string CreatedOn { get; set; }

    public Int64? LastModifiedBy { get; set; }

    public string LastModifiedOn { get; set; }

}
