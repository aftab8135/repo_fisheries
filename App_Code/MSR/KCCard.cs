using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for KCCard
/// </summary>
public class KCC_Target
{
    public Int64 KCCTargetKey { get; set; }
    public String FinYear { get; set; }
    public Int32 DistrictKey { get; set; }
    public Int32 KCCTarget { get; set; }
    public Boolean IsActive { get; set; }
    public Int32 CreatedBy { get; set; }
    public DateTime CreatedOn { get; set; }
    public Int32 LastModifiedBy { get; set; }
    public DateTime LastModifiedOn { get; set; }
}

public class KCCMonthlyProgress
{ 
    public Int64 KisanCreditCardKey { get; set; }
    public String FinYear { get; set; }
    public Int32 DivisionKey { get; set; }
    public Int32 DistrictKey { get; set; }
    public Int32 MonthKey { get; set; }
    public Int32 TotalTarget { get; set; }
    public Int32 PastMonthTotalCard { get; set; }
    public Decimal PastMonthTotalAmount { get; set; }
    public Int64 CurrentMonthTotalCard { get; set; }
    public Decimal CurrentMonthTotalAmount { get; set; }
    public Boolean IsActive { get; set; }
    public DateTime CreatedOn { get; set; }
    public Int32 CreatedBy { get; set; }
    public DateTime LastModifiedOn { get; set; }
    public Int32 LastModifiedBy { get; set; }
}

public class KCC_PastMonth
{
    public Int32 PastMonthTotalCard { get; set; }
    public Decimal PastMonthTotalAmount { get; set; }
  
}