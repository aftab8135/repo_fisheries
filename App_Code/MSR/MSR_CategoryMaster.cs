using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for public_class_MSR_CategoryMaster
/// </summary>
public class MSR_CategoryMaster
{
    public int CategoryKey { get; set; }

    public string CatEnglishName { get; set; }

    public string CatHindiName { get; set; }

    public bool IsActive { get; set; }

    public Int64? CreatedBy { get; set; }

    public Int64? LastModifiedBy { get; set; }

}
