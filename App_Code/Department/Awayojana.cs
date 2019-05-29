using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Awayojana
/// </summary>
public class Awayojana
{
    public Int16 AlottmentKey {get; set;}
     public Int16 	MandalKey {get; set;}
     public Int16  DistrictKey {get; set;}
     public Int16 BlockKey {get; set;}
     public string VillageName {get; set;}
     public Int16  ApplicantKey {get; set;}
     public string ApplicantName {get; set;}
    public string Gender {get; set;}
     public DateTime DOB {get; set;}
     public string ApplicantAddress {get; set;}
    public Int16 ApplicantDistrictKey {get; set;}
     public Int16 ApplicantBlockKey {get; set;}
    public string ApplicantMobileno {get; set;}
    public string ApplicantAadhar {get; set;}
    public Int16 SchemeID {get; set;}
    public Int32 fundallotbydept {get; set;}
    public string for_month {get; set;}
    public string For_year {get; set;}
    public Int16 LastModifiedBy { get; set; }
    public Int16 CreateBy { get; set; }	
    public bool	IsActive {get; set;}

   public string first_for_month{ get; set;}
   public string First_for_year {get; set;}
   public string first_remarks {get;set;}
   public string second_for_month {get;set;}
   public string second_for_year  {get;set;}
   public string second_remarks { get; set;}
   public Int32 FirstInstallment { get; set; }
   public Int32 SecondInstallment { get; set; }
}