using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;



public class DBT_BillForwardingMaster
{
    public Int64 BillForwardingKey { get; set; }
    public string TreasuryBillNo { get; set; }
    public DateTime TreasuryBillDate { get; set; }
    public Int64 SchemeKey { get; set; }
    public decimal TotalAmount { get; set; }
    public int TotalApplicant { get; set; }
    public Int64 DistrictKey { get; set; }
    public List<DBT_BillForwardingDetails> lstBillForwardingDetails { get; set; }

}

