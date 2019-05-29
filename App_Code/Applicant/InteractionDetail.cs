using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for InteractionDetail
/// </summary>
public class InteractionDetail
{
    public Int64 InteractionKey { get; set; }
    public Int32 ApplicationNo { get; set; }
    public Int16 InteractionMode { get; set; }
    public String InteractionModeText { get; set; }
    public String OfficerName { get; set; }
    public String Designation { get; set; }
    public String InteractionDate { get; set; }
    public String InteractionTime { get; set; }
    public String InteractionRemark { get; set; }
    //public Int16 InteractionType { get; set; }
    //public String InteractionTypeText { get; set; }
    //public DateTime ExpectedResolvingDate { get; set; }
    //public String ExpectedResolvingDateText { get; set; }
    //public bool isResolved { get; set; }
    public Int32 CreatedBy { get; set; }
    public DateTime CreatedOn { get; set; }
}