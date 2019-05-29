using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MPR_frmFishProduction : System.Web.UI.Page
{
    public static Int32 DistrictKey = 0;
    public static string FinYear = "";
    private static Int64 UserKey = 0;
    private static string UserName = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        DistrictKey = Convert.ToInt32(Session["DistrictKey"]);
        FinYear = Session["FinancialYear"].ToString();
        UserKey = Convert.ToInt32(Session["UserKey"]);
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
    public static string Create(FishProductionTant objFishProductionTant)
    {
        try
        {
            objFishProductionTant.FinYear = FinYear;
            objFishProductionTant.DistrictKey = DistrictKey;
            objFishProductionTant.CreatedBy = UserKey;
            objFishProductionTant.IsActive = true;
            int rowAffected = new DBLayer().CreateFishProdTant(objFishProductionTant);
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
}