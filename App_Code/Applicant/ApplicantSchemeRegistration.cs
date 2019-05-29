using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ApplicantSchemeRegistration
/// </summary>
public class ApplicantSchemeRegistration
{
public int	ApplicationNo {get;set;}
public string Fy_year {get;set;}
public int Registrationkey{get;set;}
public int SchemeKey { get; set; }
public Int16 user_no {get;set;}
public string Revenue_Village {get;set;}
public string PostOffice  {get;set;}
public string PinNo  {get;set;}
public int DistrictNo  {get;set;}
public int BlockNo  {get;set;}
public int TehsilNo  {get;set;}
public  string PlotNo  {get;set;}
public int Category  {get;set;}
public int social_category  {get;set;}
public int special_category  {get;set;}
public string Ownership	 {get;set;}
public DateTime Lease_From_date	 {get;set;}
public DateTime Lease_to_date	 {get;set;}
public Double totalland	 {get;set;}
public Double totalwaterarea	 {get;set;}
public string detailsproposedwork	 {get;set;}
public string Details_regard_assistance_received	 {get;set;}
public Double Project_cost	 {get;set;}
public Double Beneficiaries_share { get; set; }
public Double Total_Subsidy_Amount { get; set; }
public Double Central_share { get; set; }
public Double State_share { get; set; }
public Double applicant_payment_Financial_institution { get; set; }
public Double Estimate_Project_cost_regarding_recurring_cost { get; set; }
public string Applicant_Experience { get; set; }
public string Details_economics { get; set; }
public string finacial_tieupanybank  {get;set;}
public Double finacial_tieupanybankamount { get; set; }
public DateTime expect_operation_date	{get;set;}
public Boolean Marketing_tieup	 {get;set;}
public string Source_of_labour	 {get;set;}
public int  No_Of_Labour  {get;set;}
public Boolean Isfinalsubmit  {get;set;}
public Boolean isReturned  {get;set;}
public int ApplicationStatus  {get;set;}
public int CurrentStatusdetailskey  {get;set;}
public DateTime createdon	 {get;set;}
public DateTime latmodifiedon	 {get;set;}
public Boolean District_Approval { get; set; }
public string PostallAddress { get; set; }
public string AadharNo { get; set; }
public string EnglishName { get; set; }
public string BlockName { get; set; }
public string DivisionName { get; set; }
public string Name { get; set; }
public string MobileNo { get; set; }
public string StatusText { get; set; }
public string UserBankIFSC { get; set; }
public string SocialCategoryName { get; set; }
public DateTime DOB { get; set; }
public string Address { get; set; }
    public string EmailID { get; set; }
public int UserBankName { get; set; }
public string LevelTo { get; set; }
public string LevelFrom { get; set; }
public string CurrentStatusText { get; set; }
public string SchemeName { get; set; }
public string BankName { get; set; }

public string UserAcNo { get; set; }
public string BranchName { get; set; }
public string AvailableStatus { get; set; }
public DateTime DocReceiveDate { get; set; }
public string Remark { get; set; }
public int Gender { get; set; }
public int District_Flag { get; set; }
}