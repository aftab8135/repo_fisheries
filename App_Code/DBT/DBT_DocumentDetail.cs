using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for DBT_DocumentDetail
/// </summary>
public class DBT_DocumentDetail
{
    public Int64 DocumentDetailKey { get; set; }

    public Int64? DistributionDetailKey { get; set; }

    public int? DocumentKey { get; set; }

    public string DocumentFileName { get; set; }

    public string DocumentPath { get; set; }

}