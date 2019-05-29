using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Bud_DeptBooking
/// </summary>
public class Bud_DeptBooking
{
    public Int64 BookingKey { get; set; }

    public string FinancialYear { get; set; }

    public int BudgetType { get; set; }

    public int SourceKey { get; set; }

    public int? GrandCode { get; set; }

    public int? AccountType { get; set; }

    public int HeadNameKey { get; set; }

    public Int64 SchemeKey { get; set; }

    public int ObjectKey { get; set; }

    public string GONo { get; set; }

    public string GODate { get; set; }

    public decimal BAmount { get; set; }

    public Int64 BankKey { get; set; }

    public int? PaymentType { get; set; }

    public string RefNo { get; set; }

    public string RefDate { get; set; }

    public string Remark { get; set; }

    public Int64? CreatedBy { get; set; }

    public Int64? LastModifiedBy { get; set; }

}