using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for StatusDetail
/// </summary>
public class StatusDetail
{
	
		public Int64 StatusDetailKey { get; set; }
    public Int64 ApplicationKey { get; set; }
    public Int32 ApplicationNo { get; set; }
    public Int32 StatusKey { get; set; }
    public String StatusText { get; set; }
    public String LevelFrom { get; set; }
    public String LevelTo { get; set; }
    public String AvailableStatus { get; set; }
    public String CurrentStatusText { get; set; }

    public Int32 StepNo { get; set; }
    public String FileName { get; set; }
    public String Remark { get; set; }
    public DateTime DocReceiveDate { get; set; }
    public DateTime ActionDate { get; set; }
    public Int32 ActionBy { get; set; }
	
}