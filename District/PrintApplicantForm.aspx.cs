using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DVIO_PrintApplicantForm : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["appno"] != null)
            {
                DBLayer db = new DBLayer();
                ApplicantSchemeRegistration objApplicant = new ApplicantSchemeRegistration();
                objApplicant.ApplicationNo = Convert.ToInt16(Request.QueryString["appno"]);
                db.ReadApplication(objApplicant);
                lblschname2.Text = objApplicant.SchemeName;
                txtaadharno.Text = objApplicant.ApplicationNo.ToString();
                txtName.Text = objApplicant.Name;
                txtDOB.Text = objApplicant.DOB.ToString("dd-MMM-yyyy");
                ddlDistrict.Text = objApplicant.EnglishName;

                 if (objApplicant.Gender == 1)
                           {
                               ddlGender.Text="Male";
                           }
                           else if (objApplicant.Gender == 2)
                           {
                               ddlGender.Text="Female";
                              
                           }
                           else
                           {
                                ddlGender.Text="TransGender";
                           
                           }
                        
                           if (objApplicant.Category == 1) {
                               ddlSpecialCat.Text = "General";
                               
                            }
                           else if (objApplicant.Category == 2) {
                               ddlSpecialCat.Text = "SC";
                           }
                           else if (objApplicant.Category == 3) {
                               ddlSpecialCat.Text = "ST";
                              
                               }
                           else {
                               ddlSpecialCat.Text = "OBC";
                              
                           }
                           txtCommunicationHouseNo.Text = objApplicant.PostallAddress;
                           txtUnitVillage.Text = objApplicant.Revenue_Village;
                           txtCommunicationPO.Text = objApplicant.PostOffice;
                           txtUnitVikasKhand.Text = objApplicant.BlockName;
                           txtUnitDistrict.Text = objApplicant.EnglishName;
                           txtUnitPinCode.Text = objApplicant.PinNo;
                           txtMobileNo1.Text = objApplicant.MobileNo;
                           txtEMail.Text = objApplicant.EmailID;
                           txtActivityName.Text = objApplicant.SchemeName;
                           txtProductDescription.Text = objApplicant.detailsproposedwork;
                           txtplotno.Text = objApplicant.PlotNo;
                           txttotalLand.Text = objApplicant.totalland.ToString();
                           txtTotalwaterarea.Text = objApplicant.totalwaterarea.ToString();
                           txtProjectcost.Text = objApplicant.Project_cost.ToString();
                           txtBeneficary.Text = objApplicant.Beneficiaries_share.ToString();
                           txtSubsidary.Text = objApplicant.Total_Subsidy_Amount.ToString();
                           txtcentralshare.Text = objApplicant.Central_share.ToString();
                           txtstateshare.Text = objApplicant.State_share.ToString();
                           txtApplicantExperience.Text = objApplicant.Applicant_Experience;
                           txtdetailEconomics.Text = objApplicant.Details_economics;
                           ddlFirstFinancingBank.Text = objApplicant.BankName;
                           txtFirstFinancingIFSCCode.Text = objApplicant.UserBankIFSC;
                           txtFirstFinancingBranchName.Text = objApplicant.BranchName;
                           txtFirstFinancingAddress.Text = objApplicant.Address;
                           txtFirstFinancingDistrict.Text = objApplicant.EnglishName;



                     

            }
        }

    }

}