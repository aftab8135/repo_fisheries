using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.Script.Serialization;
using System.Data;
using Newtonsoft.Json;


public partial class Applicant_ApplicantProfile : System.Web.UI.Page
{
    DBLayer db = new DBLayer();
    private static Int64 registrationKey;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["ApplicantKey"] == null)
        {
            Response.Redirect("~/Secure/Login/frm_ApplicantLogin.aspx");
        }
        else
        {
            if (!IsPostBack)
            {
                string var = Session["ApplicantKey"].ToString();
                registrationKey = Convert.ToInt64(Session["ApplicantKey"]);
                HiddenRegistrationKey.Value = var;

                fillcombo();
                FillApplicantProfile();
            }
          
        }
    }

    [WebMethod]
    public static List<ListItem> GetDistrict(int DivisionKey)
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.PopulateDistrictMondalwise(DivisionKey);
        }
        catch (Exception ex)
        {
            return null;
        }

    }

    [WebMethod]
    public static List<ListItem> GetDistictBlock(int DistrictID)
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.PopulateBlockDistrictwise(DistrictID);
        }
        catch (Exception ex)
        {

            return null;
        }

    }

    public void FillApplicantProfile()
    {
        try
        {

            DataSet ds = db.GetApplicantDetailBykey(registrationKey);
            if (ds.Tables[0].Rows.Count > 0)
            {
                txtName.Text = ds.Tables[0].Rows[0]["Name"].ToString();
                txtmobile.Text = ds.Tables[0].Rows[0]["MobileNo"].ToString();
                txtAadhar.Text = ds.Tables[0].Rows[0]["aadharNo"].ToString();
            }
         
            fillcombo();
            int k = 0;
            k = db.ApplicantDetailsExist(registrationKey);

            if (k > 0)
            {
                DataTable dt = (new DBLayer()).GetApplicantProfile(registrationKey);

                foreach (DataRow drow in dt.Rows)
                {
                    txtDOB.Text = drow["DOB"].ToString();
                    txtAcno.Text = drow["UserAcNo"].ToString();
                    txtaddress.Text = drow["PostallAddress"].ToString();
                    txtEmail.Text = drow["EmailID"].ToString();
                    txtFathername.Text = drow["FatherName"].ToString();
                    txtPinno.Text = drow["PinNo"].ToString();
                    txtPostOffice.Text = drow["PostOffice"].ToString();
                    txtTehsilName.Text = drow["TehsilName"].ToString();
                    txtVillagename.Text = drow["RevenueVillage"].ToString();
                    txtBranchIFSC.Text = drow["UserBankIFSC"].ToString();
                    txtPhone.Text = drow["Phone_no"].ToString();

                    ddlDivision.SelectedValue = drow["DivisionId"].ToString();
                    ddlBank.SelectedValue = drow["UserBankName"].ToString();
                    ddlGender.SelectedValue = drow["Gender"].ToString();
                    ddlCaste.SelectedValue = drow["Caste"].ToString();

                    int ddlDivisionKey = Convert.ToInt32(ddlDivision.SelectedValue);
                    if (ddlDivisionKey > 0)
                    {

                        ddlDistrict.Items.Clear();
                        ddlDistrict.DataSource = db.PopulateDistrictMondalwise(ddlDivisionKey);

                        ddlDistrict.DataTextField = "Text";
                        ddlDistrict.DataValueField = "Value";
                        ddlDistrict.DataBind();
                        ddlDistrict.Items.Insert(0, new ListItem { Text = "Select District Name", Value = "" });

                        ddlDistrict.SelectedValue = drow["DistrictNo"].ToString();

                        int DistrictKey = Convert.ToInt32(drow["DistrictNo"].ToString());

                        if (DistrictKey > 0)
                        {
                            ddlBlock.Items.Clear();
                            ddlBlock.DataSource = db.PopulateBlockDistrictwise(DistrictKey);

                            ddlBlock.DataTextField = "Text";
                            ddlBlock.DataValueField = "Value";
                            ddlBlock.DataBind();
                            ddlBlock.Items.Insert(0, new ListItem { Text = "Select Block Name", Value = "" });

                            ddlBlock.SelectedValue = drow["BlockNo"].ToString();
                        }

                    }
                    int BankKey = Convert.ToInt32(drow["UserBankName"].ToString());

                    if (BankKey > 0 && Convert.ToInt32(drow["DistrictNo"].ToString()) > 0)
                    {
                        ddlBranch.Items.Clear();
                        ddlBranch.DataSource = db.PopulateBranch(BankKey, Convert.ToInt32(drow["DistrictNo"].ToString()));

                        ddlBranch.DataTextField = "Text";
                        ddlBranch.DataValueField = "Value";
                        ddlBranch.DataBind();
                        ddlBranch.Items.Insert(0, new ListItem { Text = "Select Branch Name", Value = "" });

                        ddlBranch.SelectedValue = drow["UserBankShakha"].ToString();

                        if (Convert.ToInt64(drow["UserBankShakha"].ToString()) > 0)
                        {
                             DataTable dtBranch = new DataTable();
                             dtBranch = db.GetBranchDetail(Convert.ToInt32(drow["UserBankShakha"].ToString()));
                             foreach  (DataRow dr in dtBranch.Rows)
                             {
                                 txtBranchAddress.Text = dr["Address"].ToString();
                             }
                        }
                    }
                }

            }

            txtName.Enabled = false;
            txtmobile.Enabled = false;
            txtAadhar.Enabled = false;
        }
        catch (Exception ex)
        {
            throw;
        }

    }

    public void fillcombo()
    {
        ddlBank.DataSource = db.PopulateBank();
        ddlBank.DataTextField = "Text";
        ddlBank.DataValueField = "Value";
        ddlBank.DataBind();
        ddlBank.Items.Insert(0, new ListItem { Text = "Select Bank Name", Value = "" });

        ddlDivision.DataSource = db.PopulateMandal(1);
        ddlDivision.DataTextField = "Text";
        ddlDivision.DataValueField = "Value";
        ddlDivision.DataBind();
        ddlDivision.Items.Insert(0, new ListItem { Text = "Select Division Name", Value = "" });
        
       
        List<ListItem> lstGender = (db.PopulateCommonMaster("Gender"));
        List<ListItem> lstCategory = (db.PopulateCommonMaster("Category"));

        GeneralClass.LoadCombo(ref ddlGender, ref lstGender, "Select Gender");
        GeneralClass.LoadCombo(ref ddlCaste, ref lstCategory,  "Select Category");

    }

    [WebMethod]
    public static List<ListItem> PopulateDistrictName(string distkey)
    {
        List<ListItem> lstTehsil = new List<ListItem>();
        DBLayer db = new DBLayer();
        lstTehsil = db.PopulateDistrict(Convert.ToInt32(distkey)).Where(p => p.Text != "Select").ToList();
        return lstTehsil;
    }

    [WebMethod]
    public static List<ListItem> GetBranchByBankID(int BankID, int DistrinctKey)
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.PopulateBranch(BankID, DistrinctKey);
        }
        catch (Exception ex)
        {

            return null;
        }
    }


    [WebMethod]
    public static string GetBranchDetail(int BankDetailId)
    {
        try
        {
            DBLayer db = new DBLayer();
            DataTable dt = new DataTable();
            dt = db.GetBranchDetail(BankDetailId);
            return JsonConvert.SerializeObject(dt);
        }
        catch (Exception ex)
        {
            return "{}";
        }

    }

    private Int32 GetInt32(object objVal)
    {
        Int32 intValue = 0;
        if (objVal == null) return 0;
        if (objVal is DBNull) return 0;
        if (objVal is Int32) return (Int32)objVal;
        int.TryParse(objVal.ToString(), out intValue);
        return intValue;
    }
    private Int16 GetInt16(object objVal)
    {
        Int16 intValue = 0;
        if (objVal == null) return 0;
        if (objVal is DBNull) return 0;
        if (objVal is Int16) return (Int16)objVal;
        Int16.TryParse(objVal.ToString(), out intValue);
        return intValue;
    }

    [WebMethod]
    public static string UpdateProfile(ApplicantDetail objApplicant)
    {
        objApplicant.RegistrationKey = registrationKey;
        try
        {
            int k = 0;
            k = (new DBLayer()).checkApplicant(objApplicant);
            Int64 j = 0;
            if (k == 0)
            {
                objApplicant.CareOf = "Shri";
                j = (new DBLayer()).CreateApplicantDetails(objApplicant);

            }
            else
            {
                objApplicant.CareOf = "Shri";
                j = (new DBLayer()).UpdateApplicantDetails(objApplicant);
            }
            if (j > 0)
            {
                return "{\"Status\" :\"OK\", \"Msg\" : \"Record Updated Succesfully.\"}";
            }
            else
            {
                return "{\"Status\" :\"Error\", \"Msg\" : \"Record Not Updated.\"}";
            }
        }
        catch (Exception ex)
        {
            return "{\"Status\" :\"Error\", \"Msg\" : \"Something Went Wrong.\"}";
        }
    }
}