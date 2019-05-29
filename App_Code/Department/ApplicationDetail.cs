using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ApplicationDetail
/// </summary>

    public class ApplicationDetail
    {
        public Int64 ApplicationKey { get; set; }
        public Int64 RegistrationKey { get; set; }
        public String ApplicantName { get; set; }
        public String ApplicationNo { get; set; }
        public String AadharNo { get; set; }
        public String NonIndividualName { get; set; }
        public String RegistrationNo { get; set; }
        public String RegistrationDate { get; set; }
        public String TANNo { get; set; }
        public String Designation { get; set; }
        public Int16 AgencyKey { get; set; }
        public String AgencyName { get; set; }
        public Int16 DistrictKey { get; set; }
        public String DistrictName { get; set; }
        public Int32 OfficeKey { get; set; }
        public String OfficeName { get; set; }
        public Int16 LegalType { get; set; }
        public Int16 Gender { get; set; }
        public DateTime DOB { get; set; }
        public Int16 SocialCategory { get; set; }
        public String SocialCategoryName { get; set; }
        public Int16 SpecialCategory { get; set; }
        public String SpecialCategoryName { get; set; }
        public Int16 Qualification { get; set; }
        public String QualificationName { get; set; }
        public Int16 WorkExpYear { get; set; }
        public Int16 WorkExpMonth { get; set; }
        //public String CommunicationAddress { get; set; }
        //public String CommunicationBlock { get; set; }
        public String CommunicationHouseNo { get; set; }
        public String CommunicationVillage { get; set; }
        public String CommunicationPO { get; set; }
        public String CommunicationVikasKhand { get; set; }
        public Int16 CommunicationDistrictKey { get; set; }
        public String CommunicationDistrictName { get; set; }
        public String CommunicationPinCode { get; set; }
        public Int16 UnitLocation { get; set; }
        //public String UnitAddress { get; set; }
        //public String UnitBlock { get; set; }
        public String UnitHouseNo { get; set; }
        public String UnitVillage { get; set; }
        public String UnitPO { get; set; }
        public String UnitVikasKhand { get; set; }
        public Int16 UnitDistrictKey { get; set; }
        public String UnitDistrictName { get; set; }
        public String UnitPinCode { get; set; }
        public String MobileNo1 { get; set; }
        public String MobileNo2 { get; set; }
        public String UnitEast { get; set; }
        public String UnitWest { get; set; }
        public String UnitNorth { get; set; }
        public String UnitSouth { get; set; }
        public String EMail { get; set; }
        public String PANNo { get; set; }
        public Int16 ActivityType { get; set; }
        public String ActivityTypeName { get; set; }
        public String ActivityName { get; set; }
        public String ProductDescription { get; set; }
        public Boolean EDPTraining { get; set; }
        public String EDPTrainingInstn { get; set; }
        public Decimal CapitalExpenditure { get; set; }
        public Decimal WorkingCapital { get; set; }
        public Decimal ApprovedCapitalExpenditure { get; set; }
        public Decimal ApprovedWorkingCapital { get; set; }
        public Int32 Employment { get; set; }
        public Int16 EmploymentType { get; set; }
        public String EmploymentTypeText { get; set; }
        public Int32 FirstFinancingBankKey { get; set; }
        public String FirstFinancingBankName { get; set; }
        public Int64 FirstFinancingBankDetailKey { get; set; }
        public String FirstFinancingIFSCCode { get; set; }
        public String FirstFinancingBranchName { get; set; }
        public String FirstFinancingAddress { get; set; }
        public String FirstFinancingDistrict { get; set; }
        public String AlternateFinancingBankName { get; set; }
        public String AlternateFinancingIFSCCode { get; set; }
        public Boolean IsFinalSubmit { get; set; }
        public Int16 ApplicationStatus { get; set; }
        public String ApplicationStatusText { get; set; }           //Other
        public String CurrentStatusText { get; set; }               //Other
        public String AvailableStatus { get; set; }                //Other
        public DateTime CurrentStatusDate { get; set; }            //Other
        public String LevelFrom { get; set; }                //Other
        public String LevelTo { get; set; }                //Other
        public Int64 CurrentStatusDetailKey { get; set; }
        public DateTime DocReceiveDate { get; set; }                //FOR BANK PANEL OR IN CASE OF RETURN
        public String Remark { get; set; }
        public DateTime CreatedOn { get; set; }
        public DateTime LastModifiedOn { get; set; }
        public String CSCUserName { get; set; }
        public String Signature { get; set; }
    }
