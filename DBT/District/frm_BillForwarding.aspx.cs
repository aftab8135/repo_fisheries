using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class District_frm_BillForwarding : System.Web.UI.Page
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
        hidDistrictKey.Value = Session["DistrictKey"].ToString();

        lblFinYear.Text = FinYear;
        lblLoginType.Text = UserName;
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
    public static string GetIsForwardInstallment(Int64 SchemeKey)
    {
        try
        {
            string jsondata = "";
            DBLayer db = new DBLayer();
            jsondata = JsonConvert.SerializeObject(db.GetDBT_IsForwardedByDistrict(FinYear, DistrictKey, SchemeKey));
            return jsondata;
        }

        catch (Exception ex)
        {
            return null;
        }
    }

    [WebMethod]
    public static string BillForward(DBT_InsDistributionMaster objDBT_InsDistributionMaster)
    {
        string resultMsg = "";
        try
        {
            DBLayer objDBLayer = new DBLayer();
            if (objDBT_InsDistributionMaster.Installments.Count > 0)
            {
                objDBT_InsDistributionMaster.CreatedBy = UserKey;
                foreach (DBT_InsDistributionDetail objInst in objDBT_InsDistributionMaster.Installments)
                {
                    objInst.ForwardedBy = UserKey;
                }
                string RegCode = objDBLayer.UpdateForwardBillByDBT(objDBT_InsDistributionMaster);

                if (RegCode != "")
                    resultMsg = "Record Saved Successfully.";
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