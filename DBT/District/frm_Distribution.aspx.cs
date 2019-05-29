using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class District_frm_Distribution : System.Web.UI.Page
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
    //public static string GetRegApplicantByCode(string RegCode)
    //{
    //    string jsondata = "";
    //    DBLayer db = new DBLayer();
    //    DataTable dt = db.GetDBT_ApplicantByRegCode(RegCode, DistrictKey);
    //    if (dt.Rows.Count > 0)
    //    {
    //        jsondata = JsonConvert.SerializeObject(dt);
    //        return jsondata;
    //    }
    //    else
    //    {
    //        return "";
    //    }

    //}

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
    public static List<ListItem> GetSchemes(string RegCode)
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.GetSchemesByRegCode(RegCode);
        }
        catch (Exception ex)
        {
            return null;
        }

    }

    [WebMethod]
    public static List<ListItem> GetWorkType(int schemeID, string RegCode)
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.GetProgressTypeByRegCode(schemeID, RegCode);
        }
        catch (Exception ex)
        {

            return null;
        }

    }

    [WebMethod]
    public static List<ListItem> GetWorkIntallment(int schemeID, int workTypeID, string RegCode)
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.GetWorkIntallmentByRegCode(schemeID, workTypeID, RegCode);
        }
        catch (Exception ex)
        {

            return null;
        }

    }

    [WebMethod]
    public static string GetDocumentByWorkInstallment(int WorkTypeID, Int64 InsDetailKey)
    {
        try
        {
            DBLayer db = new DBLayer();
            string jsondata = "";
            DataTable dt = db.GetDocumentByWorkInstallment(WorkTypeID,InsDetailKey);

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
        catch (Exception ex)
        {

            return null;
        }

    }

    [WebMethod]
    public static string GetWorkIntallmentAmount(int schemeID, int workTypeID, string RegCode, int insId)
    {
        try
        {
            DBLayer db = new DBLayer();
            string jsondata = "";
            DataTable dt = db.GetWorkIntallmentAmount(schemeID, workTypeID, RegCode,insId);

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
        catch (Exception ex)
        {

            return null;
        }

    }

    [WebMethod]
    public static string Create(DBT_InsDistributionMaster objDBT_InsDistributionMaster)
    {
        string resultMsg = "";
        try
        {
            DBLayer objDBLayer = new DBLayer();
            if (objDBT_InsDistributionMaster.RegistrationKey > 0)
            {
                objDBT_InsDistributionMaster.CreatedBy = UserKey;
                string RegCode = objDBLayer.CreateDBTApplicantDistribution(objDBT_InsDistributionMaster);
                if (RegCode != "")
                    resultMsg = "Recored Saved Successfully.";
            }

        }
        catch (Exception ex)
        {
            resultMsg = "Something Went Wrong.";
            throw ex;

        }
        return resultMsg;
    }
}