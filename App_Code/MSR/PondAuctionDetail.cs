using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for PondAuctionDetail
/// </summary>
public class PondAuctionDetail
{
    public Int64 PondAuctDetKey { get; set; }

    public Int64 PondAuctMstKey { get; set; }

    public Int64? PondAuctionKey { get; set; }

    public Int64? PondId { get; set; }

    public decimal? PayableAmount { get; set; }

    public decimal? DepositAmount { get; set; }

    public decimal? TotalAmount { get; set; }

    public string Remark { get; set; }

    public decimal? LastYearPayableAmount { get; set; }

    public decimal? LastYearDepositAmount { get; set; }

    public bool? IsActive { get; set; }

}
