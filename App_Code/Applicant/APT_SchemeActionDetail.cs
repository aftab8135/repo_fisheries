using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for APT_SchemeActionDetail
/// </summary>
public class APT_SchemeActionDetail
{
    public Int64 RegistrationKey { get; set; }

    public Int64 ApplicationNo { get; set; }

    public Int64 SchemeKey { get; set; }

    public bool? ObjForm { get; set; }

    public bool? ObjAttach { get; set; }

    public bool? IsForword { get; set; }

    public string SurveryFileName { get; set; }

    public string SurveryFilePath { get; set; }

    public string OtherFileName { get; set; }

    public string OtherFilePath { get; set; }

    public string Remarks { get; set; }

    public Int64 CurStatus { get; set; }

    public string ActionBy { get; set; }

    public Int64? CreatedBy { get; set; }

    public Int64? LastModifiedBy { get; set; }
}
