using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Applicant_ApplicantSchemeRegt : System.Web.UI.Page
{
    public static Int64 ApplicantKey;
    public static string AppicationCode = "";
    public static Int64 SchemeKey;
    public static Int64 UserNo;

    public static decimal LandRateInHect;
    public static decimal BenSharePer;
    public static decimal CenSharePer;
    public static decimal StaSharePer;
    public static bool objForm = false;
    public static bool objAttach = false;
    public static DataTable DTDocuments = new DataTable();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                if ((Session["ApplicantKey"] == null || Session["SchemeKey"] == null) && Session["ApplicationCode"] == null)
                {
                    Response.Redirect("ApplicantDashboard.aspx");
                }
                if (Session["ApplicationCode"] != null && Session["ApplicationCode"] != "")
                {
                    AppicationCode = Session["ApplicationCode"].ToString();

                    DataTable dt = (new DBLayer()).GetSchemeApplicationCode(AppicationCode);
                    
                    foreach (DataRow drow in dt.Rows)
                    {
                        ApplicantKey = Convert.ToInt64(drow["RegistrationKey"]);
                        SchemeKey = Convert.ToInt64(drow["SchemeKey"]);
                        UserNo = Convert.ToInt64(drow["UserNo"]);
                        FillControls();

                        txtAadhar.Text = drow["AadharNo"].ToString();
                        txtAddress.Text = drow["PostallAddress"].ToString();
                        txtApplicantName.Text = drow["Name"].ToString();
                        txtBankAcNo.Text = drow["UserAcNo"].ToString();
                        txtBankName.Text = drow["BankName"].ToString();
                        txtBranch.Text = drow["BranchName"].ToString();
                        txtDistrict.Text = drow["DistrictName"].ToString();
                        txtFatherName.Text = drow["FatherName"].ToString();
                        txtIFSC.Text = drow["UserBankIFSC"].ToString();
                        txtMobile.Text = drow["MobileNo"].ToString();
                        txtPostOffice.Text = drow["PostOffice"].ToString();
                        txtPin.Text = drow["PinNo"].ToString();
                        txtTehsil.Text = drow["TehsilName"].ToString();
                        txtTelephone.Text = drow["Phone_no"].ToString();
                        txtVillagename.Text = drow["RevenueVillage"].ToString();

                        ddlCaste.SelectedValue = drow["Caste"].ToString();
                        ddlGender.SelectedValue = drow["Gender"].ToString();

                        FillSchemeDetail();

                        txtAssistanceReceived.Text = drow["AssistanceReceived"].ToString();
                        txtBenShare.Text = drow["BenShareCost"].ToString();
                        txtCentralShare.Text = drow["CenShareCost"].ToString();
                        txtEcoOperation.Text = drow["EcoOperation"].ToString();
                        txtEstRecCost.Text = drow["EstRecCost"].ToString();
                        txtExpectedDate.Text = drow["ExcOprtDate"].ToString();
                        txtExperience.Text = drow["APTExperience"].ToString();
                        txtFinaciaTieUp.Text = drow["FinancialTieUp"].ToString();
                        txtLabourSource.Text = drow["LabourSource"].ToString();
                        txtLeadDuration.Text = drow["LeaseDuration"].ToString();
                        txtMarketingTieUp.Text = drow["MarketingTieUp"].ToString();
                        txtNoofLabour.Text = drow["LabourNos"].ToString();
                        txtPlotno.Text = drow["PlotNo"].ToString();
                        txtPondArea.Text = drow["LandArea"].ToString();
                        txtProjectCost.Text = drow["ProjectCost"].ToString();
                        txtPropsed.Text = drow["ProposedWork"].ToString();
                        txtReasonForFinDef.Text = drow["ReasonForFinDef"].ToString();
                        txtStateshare.Text = drow["StaShareCost"].ToString();
                        txtTehsil.Text = drow["TehsilName"].ToString();
                        txtTotalSubsidy.Text = drow["TotalSubAmount"].ToString();
                        txtWaterArea.Text = drow["WaterArea"].ToString();
                      
                        objForm = Convert.ToBoolean(drow["ObjForm"]);

                        //Disable All Control.
                        if (!objForm)
                        {
                            ddlOwnership.Attributes.Add("disabled", "disabled");
                        }

                        txtPlotno.ReadOnly = !objForm;
                        txtLeadDuration.ReadOnly = !objForm;
                        txtPondArea.ReadOnly = !objForm;
                        txtWaterArea.ReadOnly = !objForm;
                        txtPropsed.ReadOnly = !objForm;
                        txtAssistanceReceived.ReadOnly = !objForm;
                        txtReasonForFinDef.ReadOnly = !objForm;
                        txtExperience.ReadOnly = !objForm;
                        txtEcoOperation.ReadOnly = !objForm;
                        txtExpectedDate.ReadOnly = !objForm;
                        txtFinaciaTieUp.ReadOnly = !objForm;
                        txtMarketingTieUp.ReadOnly = !objForm;
                        txtNoofLabour.ReadOnly = !objForm;
                        txtLabourSource.ReadOnly = !objForm;
                        txtEstRecCost.ReadOnly = !objForm;

                        FillSchemeDocs();
                        
                    }
                }
                else
                {
                    if (!IsPostBack)
                    {
                        string var = Session["ApplicantKey"].ToString();
                        ApplicantKey = Convert.ToInt64(Session["ApplicantKey"]);
                        SchemeKey = Convert.ToInt64(Session["SchemeKey"]);
                        UserNo = Convert.ToInt64(Session["SchemeKey"]);
                        FillControls();
                        FillBasicDetail();
                        FillSchemeDetail();
                        FillSchemeDocs();
                    }

                }


            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Error", "alert('Something Went Wrong!')", true);
            }

        }
    }

    private void FillControls()
    {
        try
        {
            DBLayer db = new DBLayer();

            List<ListItem> lstGender = db.PopulateCommonMaster("Gender");
            GeneralClass.LoadCombo(ref ddlGender, ref lstGender, "Select Gender");

            List<ListItem> lstCategory = db.PopulateCommonMaster("Category");
            GeneralClass.LoadCombo(ref ddlCaste, ref lstCategory, "Select Category");

            List<ListItem> lstLandType = db.PopulateCommonMaster("LandType");
            GeneralClass.LoadCombo(ref ddlOwnership, ref lstLandType, "Select Ownership");
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private void FillBasicDetail()
    {
        try
        {
            DataTable dt = (new DBLayer()).GetApplicantProfile(ApplicantKey);
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow drow in dt.Rows)
                {
                    txtAadhar.Text = drow["AadharNo"].ToString();
                    txtAddress.Text = drow["PostallAddress"].ToString();
                    txtApplicantName.Text = drow["Name"].ToString();
                    txtBankAcNo.Text = drow["UserAcNo"].ToString();
                    txtBankName.Text = drow["BankName"].ToString();
                    txtBranch.Text = drow["BankShakha"].ToString();
                    txtDistrict.Text = drow["DistrictName"].ToString();
                    txtFatherName.Text = drow["FatherName"].ToString();
                    txtIFSC.Text = drow["UserBankIFSC"].ToString();
                    txtMobile.Text = drow["MobileNo"].ToString();
                    txtPostOffice.Text = drow["PostOffice"].ToString();
                    txtPin.Text = drow["PinNo"].ToString();
                    txtTehsil.Text = drow["TehsilName"].ToString();
                    txtTelephone.Text = drow["Phone_no"].ToString();
                    txtVillagename.Text = drow["RevenueVillage"].ToString();

                    ddlCaste.SelectedValue = drow["Caste"].ToString();
                    ddlGender.SelectedValue = drow["Gender"].ToString();
                }
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Error", "alert('Please Fill User Profile First.'); window.location.href ='ApplicantProfile.aspx'", true);

            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private void FillSchemeDetail()
    {
        try
        {

            if (SchemeKey > 0 && Convert.ToInt32(ddlCaste.SelectedValue) > 0 && Convert.ToInt32(ddlGender.SelectedValue) > 0)
            {
                DataTable dt = (new DBLayer()).GetSchemeShareForApplicant(SchemeKey, Convert.ToInt32(ddlCaste.SelectedValue), (Convert.ToInt32(ddlGender.SelectedValue) == 1 ? false : true));
                foreach (DataRow drow in dt.Rows)
                {
                    BenSharePer = Convert.ToDecimal(drow["BShare"].ToString());
                    CenSharePer = Convert.ToDecimal(drow["CShare"].ToString());
                    StaSharePer = Convert.ToDecimal(drow["SShare"].ToString());
                    LandRateInHect = Convert.ToDecimal(drow["RatePerHect"].ToString());

                    lblBenSharePer.Text = "Beneficiaries " + BenSharePer.ToString() + "% Share (Rs.)";
                    lblCenSharePer.Text = "Central Share " + CenSharePer.ToString() + "% of Total Subsidy (Rs.)";
                    lblStaSharePer.Text = "State Share " + StaSharePer.ToString() + "% of  Total Subsidy (Rs.)";
                    lblSchemeName.Text = drow["SchemeName"].ToString();
                }
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void FillSchemeDocs()
    {
        try
        {
            if (SchemeKey > 0 && AppicationCode == "")
            {
                DTDocuments = (new DBLayer()).GetDocumentBySchemeKey(SchemeKey);

            }
            else if (AppicationCode != "")
            {
                DTDocuments = (new DBLayer()).GetSchemeDocsApplicationCode(AppicationCode);
                if (DTDocuments.Rows.Count > 0)
                {
                    objAttach = Convert.ToBoolean(DTDocuments.Rows[0]["ObjDoc"]);
                }
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    [WebMethod]
    public static string Create(APT_SchemeRegistration objAPT_SchemeRegistration)
    {
        try
        {
            objAPT_SchemeRegistration.RegistrationKey = ApplicantKey;
            objAPT_SchemeRegistration.UserNo = UserNo;
            objAPT_SchemeRegistration.SchemeKey = SchemeKey;

            string strResult = (new DBLayer()).CreateAPT_SchemeRegistration(objAPT_SchemeRegistration);
            if (strResult == "")
            {
                return "{\"StatusCode\":\"ND\",\"Msg\":\"Something Went Wrong.\"}";
            }
            else if (strResult == "InValid")
            {
                return "{\"StatusCode\":\"IV\",\"Msg\":\"Please Correct All The Entries.\"}";
            }
            else
            {
                return "{\"StatusCode\":\"OK\",\"Msg\":\"Record Saved Successfully. Application Code = " + strResult + "\",\"APCode\":\"" + strResult + "\"}";
            }

        }
        catch (Exception ex)
        {
            return "{\"StatusCode\":\"401\",\"Msg\":\"" + ex.Message + "\"}";
        }
    }

    [WebMethod]
    public static string Update(APT_SchemeRegistration objAPT_SchemeRegistration)
    {
        try
        {
            objAPT_SchemeRegistration.RegistrationKey = ApplicantKey;
            objAPT_SchemeRegistration.UserNo = UserNo;
            objAPT_SchemeRegistration.SchemeKey = SchemeKey;
            objAPT_SchemeRegistration.ApplicationCode = AppicationCode;

            string strResult = (new DBLayer()).UpdateAPT_SchemeRegistration(objAPT_SchemeRegistration,objAttach);
            if (strResult == "")
            {
                return "{\"StatusCode\":\"ND\",\"Msg\":\"Something Went Wrong.\"}";
            }
            else if (strResult == "InValid")
            {
                return "{\"StatusCode\":\"IV\",\"Msg\":\"Please Correct All The Entries.\"}";
            }
            else
            {
                return "{\"StatusCode\":\"OK\",\"Msg\":\"Record Updated Successfully. Application Code = " + strResult + " \"}";
            }

        }
        catch (Exception ex)
        {
            return "{\"StatusCode\":\"401\",\"Msg\":\"" + ex.Message + "\"}";
        }
    }
}