using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for PondAuction
/// </summary>
public class PondAuction
{
    public Int64 PondAuctionKey { get; set; }

    public string FinYear { get; set; }

    public Int64? PondKey { get; set; }

    public string PondGrade { get; set; }

    public decimal? PondArea { get; set; }

    public decimal? PondMinValue { get; set; }

    public DateTime? AuctionFromDate { get; set; }

    public DateTime? AuctionToDate { get; set; }

    public decimal? FirstYearAmount { get; set; }

    public decimal? TotalDurationAmount { get; set; }

    public decimal? SecurityMoney { get; set; }

    public decimal? LastYearPayableAmount { get; set; }

    public decimal? LastYearDepositAmount { get; set; }

    public int? CreatedBy { get; set; }

    public int? LastModifiedBy { get; set; }

}
