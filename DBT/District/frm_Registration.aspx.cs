using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class District_frm_Registration : System.Web.UI.Page
{
    public static Int64 UserKey;
    public static string UserName;
    public static int DistrictKey;
    public static string FinYear;
    protected void Page_Load(object sender, EventArgs e)
    {
        UserKey = Convert.ToInt64(Session["UserKey"]);
        UserName = Session["UserName"].ToString();
        DistrictKey = Convert.ToInt32(Session["DistrictKey"]);
        FinYear = Session["FinancialYear"].ToString();

        lblFinYear.Text = FinYear;
        lblLoginType.Text = UserName;
    }

    [WebMethod]
    public static List<ListItem> GetRegCode()
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.Get_RegistrationCodeList(DistrictKey, FinYear);
        }
        catch (Exception ex)
        {
            return null;
        }
    }

    [WebMethod]
    public static List<ListItem> GetSchemesType()
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.GetAllSchemeType();
        }
        catch (Exception ex)
        {
            return null;
        }
    }

    [WebMethod]
    public static List<ListItem> GetSchemes(int key)
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.GetSchemesForSelect(key).ToList();
        }
        catch (Exception ex)
        {

            return null;
        }

    }

    [WebMethod]
    public static List<ListItem> GetDistrict()
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.PopulateDistrict();
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

    [WebMethod]
    public static List<ListItem> GetBlockVillage(int BlockID)
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.PopulateVillageBlockwise(BlockID);
        }
        catch (Exception ex)
        {

            return null;
        }

    }

    [WebMethod]
    public static List<ListItem> GetBank()
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.PopulateBank(DistrictKey);
        }
        catch (Exception ex)
        {

            return null;
        }

    }

    [WebMethod]
    public static List<ListItem> GetBranchByBankID(Int32 BankID)
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.PopulateBranch(BankID, DistrictKey);
        }
        catch (Exception ex)
        {

            return null;
        }
    }

    [WebMethod]
    public static string GetBranchIFSCCode(int detID)
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.GetIFSCode(detID);
        }
        catch (Exception ex)
        {

            return null;
        }
    }

    [WebMethod]
    public static List<ListItem> GetCategory()
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.PopulateCommonMaster("Category", true);
        }
        catch (Exception ex)
        {

            return null;
        }

    }

    [WebMethod]
    public static List<ListItem> GetGender()
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.PopulateCommonMaster("Gender", true);
        }
        catch (Exception ex)
        {

            return null;
        }

    }

    [WebMethod]
    public static List<ListItem> GetLandType()
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.PopulateCommonMaster("LandType",true);
        }
        catch (Exception ex)
        {

            return null;
        }

    }

    [WebMethod]
    public static List<ListItem> GetUnitType()
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.PopulateCommonMaster("Unit", true);
        }
        catch (Exception ex)
        {
            return null;
        }

    }

    [WebMethod]
    public static string AddVillageName(int bkey, string vname)
    {
        Page page = HttpContext.Current.CurrentHandler as Page;
        string resultMsg = "";
        try
        {
            DBLayer objDBLayer = new DBLayer();
            Village objVillage = new Village();
            objVillage.EnglishName = vname;
            objVillage.BlockKey = bkey;
            objVillage.CreatedBy = UserKey;
            objVillage.IsActive = true;

            objDBLayer.CreateVillage(objVillage);
            resultMsg = "सुरक्षित किया गया";
        }
        catch (Exception ex)
        {
            
            resultMsg = "अज्ञात त्रुटि प्रात्त। कृपया पुनः प्रयास करें।";
            throw ex;
        }
        return resultMsg;
    }

    [WebMethod]
    public static string Create(DBT_ApplicantRegistration objApplicantRegistration)
    {
        Page page = HttpContext.Current.CurrentHandler as Page; 
        string resultMsg = "";
        try
        {
            DBLayer objDBLayer = new DBLayer();
            if (objApplicantRegistration.RegistrationCode != "")
            {
                if (objApplicantRegistration.RegistrationCode.Length == 16) //Update
                {
                    objApplicantRegistration.CreatedBy = UserKey;
                    string RegCode = objDBLayer.UpdateDBTApplicant(objApplicantRegistration);
                    if (RegCode != ""){
                        resultMsg = "परिवर्तित किया गया।\nपंजीकरण संख्या : " + objApplicantRegistration.RegistrationCode + "";
                    }                       
                }
                else
                {
                    resultMsg = "अमान्य पंजीकरण संख्या।";
                }
            }
            
            else if (objApplicantRegistration.RegistrationCode == "") //Insert
            {
                objApplicantRegistration.CreatedBy = UserKey;
                string RegCode = objDBLayer.CreateDBTApplicantRegistration(objApplicantRegistration);
                if (RegCode != "")
                    resultMsg = "सुरक्षित किया गया।\nपंजीकरण संख्या : " + RegCode;
            }

        }
        catch (Exception ex)
        {
            resultMsg = "अज्ञात त्रुटि प्रात्त। कृपया पुनः प्रयास करें।";
            throw ex;

        }
        return resultMsg;
    }

    [WebMethod]
    public static string GetRegApplicantByCode(int regkey)
    {
        string jsondata = "";
        DBLayer db = new DBLayer();
        DataTable dt = db.GetDBT_ApplicantByRegCode(regkey);
        if (dt.Rows.Count > 0)
        {
            jsondata = JsonConvert.SerializeObject(dt);
            return jsondata;
        }
        else
        {
            return "";
        }
        
    }
}