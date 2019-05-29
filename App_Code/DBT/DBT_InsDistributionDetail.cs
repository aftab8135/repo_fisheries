using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for DBT_InsDistributionDetail
/// </summary>
public class DBT_InsDistributionDetail
{
    public Int64 DetailKey { get; set; }
    public Int64 DistributionKey { get; set; }
    public string TransactionKey { get; set; }
    public Int64 WorkTypeKey { get; set; }
    public Int64 InstallmentKey { get; set; }
    public decimal InstallmentAmount { get; set; }
    public int InsStatus { get; set; }
    public bool IsForwarded { get; set; }
    public DateTime? ForwardedDate { get; set; }
    public Int64 ForwardedBy { get; set; }
    public bool IsApproved { get; set; }
    public DateTime? ApprovedDate { get; set; }
    public Int64 ApprovedBy { get; set; }
    public DateTime? VerificationDate { get; set; }
    public Int64 VerifiedBy { get; set; }
    public bool IsDocVerify { get; set; }
    public bool DelFlag { get; set; }

    public Int64 RegistrationKey { get; set; }
    public string RegistrationNo { get; set; }
    public String ApplicantName { get; set; }
    public decimal BillAmount { get; set; }



}
