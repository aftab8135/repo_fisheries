using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for SchemeWorkTypeDetail
/// </summary>
public class SchemeWorkTypeDetail
{
    public Int64 DetailKey { get; set; }

    public Int64 SchemeWorkKey { get; set; }

    public int InstallmentNo { get; set; }

    public decimal? InstallmentPercent { get; set; }

    public bool IsActive { get; set; }

}
