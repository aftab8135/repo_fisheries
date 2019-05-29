using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class MPR_FisheryProductionAllSources : System.Web.UI.Page
{
    private static Int32 DistrictKey = 0;
    private static Int32 DivisionKey = 0;
    private static string FinYear = "";
    private static Int64 UserKey = 0;
    private static string UserName = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        UserKey = Convert.ToInt32(Session["UserKey"]);
        DistrictKey = Convert.ToInt32(Session["DistrictKey"]);
        FinYear = Session["FinancialYear"].ToString();
        UserName = Session["UserName"].ToString();

        lblFinYear.Text = FinYear;
        lblLoginType.Text = UserName;
    }

    [WebMethod]
    public static List<ListItem> GetMonthName()
    {
        try
        {
            return new DBLayer().PopulateMonthName();
        }
        catch (Exception)
        {

            return null;
        }
    }

    [WebMethod]
    public static List<ListItem> GetMPR_ProductionHead()
    {
        try
        {
            return new DBLayer().GetMPR_GetProdHeadMaster();
        }
        catch (Exception)
        {

            return null;
        }
    }

    [WebMethod]
    public static string GetFisheryProduction(int CateKey)
    {
        try
        {
            string jsondata = "";
            DBLayer db = new DBLayer();
            jsondata = JsonConvert.SerializeObject(db.GetMPR_FishproductionMonthList(FinYear, DistrictKey, CateKey));
            return jsondata;
        }

        catch (Exception ex)
        {
            return null;
        }
    }

    [WebMethod]
    public static string Create(MSR_FisheryProductionAllSources objFP)
    {
        try
        {
            objFP.DistrictKey = DistrictKey;
            objFP.DivisionKey = DivisionKey;
            objFP.FinancialYear = FinYear;
            objFP.CreatedBy = UserKey;
            objFP.IsActive = true;

            int rowAffected = new DBLayer().Create_MSR_FisheryProduction(objFP);
            if (rowAffected > 0)
            {
                return "{\"StatusCode\":\"200\", \"Msg\":\"Record Saved Successfully.\"}";
            }
            else
            {
                return "{\"StatusCode\":\"500\", \"Msg\":\"Record Not Saved.\"}";
            }
        }
        catch (Exception ex)
        {
            return "{\"StatusCode\":\"404\", \"Msg\":\"Something Went Wrong.\"}";
            throw;
        }
    }

    [WebMethod]
    public static string IsExist(int MonthId, int CategoryID)
    {
        try
        {
            if (new DBLayer().IS_MPR_FishProductionExist(MonthId,CategoryID,DistrictKey,FinYear))
            {
                return "{\"StatusCode\":\"200\", \"Msg\":\"Record Already Exist.\"}";
            }
            else
            {
                return "{\"StatusCode\":\"202\", \"Msg\":\"Record Not Exist.\"}";
            }
        }
        catch (Exception ex)
        {
            return "{\"StatusCode\":\"404\", \"Msg\":\"Something Went Wrong.\"}";
            throw;
        }
    }
}