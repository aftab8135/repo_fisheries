using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for APT_SchemeRegistration
/// </summary>
public class APT_SchemeRegistration
{
    public int ApplicationNo { get; set; }

    public string ApplicationCode { get; set; }

    public Int64 RegistrationKey { get; set; }

    public Int64 UserNo { get; set; }

    public string FinYear { get; set; }

    public Int64 SchemeKey { get; set; }

    public short? SocialCategory { get; set; }

    public short? SpecialCategory { get; set; }

    public int LandOwnership { get; set; }

    public string PlotNo { get; set; }

    public Int64? LeaseDuration { get; set; }

    public DateTime? LeaseFromDate { get; set; }

    public DateTime? LeaseToDate { get; set; }

    public decimal LandArea { get; set; }

    public decimal WaterArea { get; set; }

    public decimal TotalArea { get; set; }

    public string ProposedWork { get; set; }

    public string AssistanceReceived { get; set; }

    public decimal ProjectCost { get; set; }

    public decimal BenShareCost { get; set; }

    public decimal CenShareCost { get; set; }

    public decimal StaShareCost { get; set; }

    public decimal? TotalSubAmount { get; set; }

    public string ReasonForFinDef { get; set; }

    public string APTExperience { get; set; }

    public string EcoOperation { get; set; }

    public string FinancialTieUp { get; set; }

    public decimal? EstRecCost { get; set; }

    public DateTime? ExcOprtDate { get; set; }

    public string MarketingTieUp { get; set; }

    public string LabourSource { get; set; }

    public int? LabourNos { get; set; }

    public bool? IsFinalSubmit { get; set; }

    public bool? IsReturned { get; set; }

    public int? ApplicationStatus { get; set; }

    public int? CurrentStatus { get; set; }

    public bool? District_Approval { get; set; }

    public int? District_Flag { get; set; }

    public bool? IsActive { get; set; }

    public Int64? LastModifiedBy { get; set; }

    public ICollection<APT_SchemeDocuments> SchemeDocuments;
}

