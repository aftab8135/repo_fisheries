using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for DBT_InsDistributionMaster
/// </summary>
public class DBT_InsDistributionMaster
{
    public Int64 DistributionKey { get; set; }
    public Int64 RegistrationKey { get; set; }
    public string FinYear { get; set; }
    public Int64 SchemeKey { get; set; }
    public Int64 DistrictKey { get; set; }
    public decimal ProjectCost { get; set; }
    public decimal BenCost { get; set; }
    public decimal SubCost { get; set; }
    public Int64? CreatedBy { get; set; }
    public Int64? LastModifiedBy { get; set; }
    public decimal TotalBilledAmount { get; set; }
    public Int64 TotalApplicant { get; set; }
    public ICollection<DBT_InsDistributionDetail> Installments;
    public ICollection<DBT_DocumentDetail> InsDocuments;

}
