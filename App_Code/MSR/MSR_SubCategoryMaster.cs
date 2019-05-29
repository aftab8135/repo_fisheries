using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for MSR_SubCategoryMaster
/// </summary>
public class MSR_SubCategoryMaster
{
    public int SubCategoryKey { get; set; }

    public string SubEnglishName { get; set; }

    public string SubHindiName { get; set; }

    public bool IsActive { get; set; }

    public Int64? CreatedBy { get; set; }

    public Int64? LastModifiedBy { get; set; }

}
