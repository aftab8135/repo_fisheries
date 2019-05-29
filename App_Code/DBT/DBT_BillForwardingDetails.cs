using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for DBT_BillForwardingDetails
/// </summary>
public class DBT_BillForwardingDetails
{

        public Int64 BillForwardingDetailsKey { get; set; }
        public Int64 BillForwardingKey { get; set; }
        public string TransactionNo { get; set; }
        public string RegistrationNo { get; set; }
        public Int64 RegistrationKey { get; set; }
        public decimal BillAmount { get; set; }
        public string ApplicantName { get; set; }
}


public class DBT_GeneratedFileDetail
{

    public Int64 GeneratedFileDetailKey { get; set; }
    public string RegistrationNo { get; set; }
    public string TransactionNo { get; set; }
    public string DistrictName { get; set; }
    public string BankName { get; set; }
    public string BranchName { get; set; }
    public string IFSCCode { get; set; }
    public string AccountNo { get; set; }
    public string MobileNo { get; set; }
    public string ApplicantName { get; set; }
    public string BeneficiaryId { get; set; }
    public DateTime BeneficiaryMappedDate { get; set; }
    public Int64 CreatedBy { get; set; }
    public DateTime CreatedOn { get; set; }
    public Int64 LastModifiedBy { get; set; }
    public DateTime LastModifiedOn { get; set; }

}