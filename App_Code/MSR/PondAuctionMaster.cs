using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for PondAuctionMaster
/// </summary>
public class PondAuctionMaster
{
    public Int64 PondAuctMstKey { get; set; }

    public string FinYear { get; set; }

    public int? MonthKey { get; set; }

    public Int64 CreatedBy { get; set; }

    public int? LastModifiedBy { get; set; }

    public ICollection<PondAuctionDetail> Auctions;
}

