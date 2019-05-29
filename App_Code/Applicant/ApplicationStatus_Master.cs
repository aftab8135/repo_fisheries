using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ApplicationStatus_Master
/// </summary>
public class ApplicationStatus_Master
{
    public Int32 StatusKey { get; set; }
    public String StatusText { get; set; }
    public String LevelFrom { get; set; }
    public String LevelTo { get; set; }
    public String AvailableStatus { get; set; }
    public String CurrentStatusText { get; set; }
    public Boolean IntimateApplicant { get; set; }
    public Boolean IsActive { get; set; }
    public Int16 CreatedBy { get; set; }
    public DateTime CreatedOn { get; set; }
    public Int16 LastModifiedBy { get; set; }
    public DateTime LastModifiedOn { get; set; }
}