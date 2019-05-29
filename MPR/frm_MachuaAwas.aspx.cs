using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MPR_frmFishProduction : System.Web.UI.Page
{
    public static Int32 DistrictKey = 0;
    public static string FinYear = "";
    private static Int32 UserKey = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        DistrictKey = Convert.ToInt32(Session["DistrictKey"]);
        FinYear = Session["FinancialYear"].ToString();
        UserKey = Convert.ToInt32(Session["UserKey"]);

        lblLoginType.Text = Session["UserName"].ToString();

        lblFinYear.Text = FinYear;
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
    public static MachuaAwasYearlyTarget GetYearTarget()
    {
        try
        {
            MachuaAwasYearlyTarget objMachuaAwasYearlyTarget = new MachuaAwasYearlyTarget();
            objMachuaAwasYearlyTarget = new DBLayer().GetYearlyTarget(FinYear, DistrictKey);
            return objMachuaAwasYearlyTarget;
        }
        catch (Exception ex)
        {

            return null;
        }
    }



    [WebMethod]
    public static string Create(MachuaAwasMonthlyProgress objRecord)
    {
        try
        {
            objRecord.FinYear = FinYear;
            objRecord.DistrictKey = DistrictKey;
            objRecord.CreatedBy = UserKey;
            objRecord.IsActive = true;
            int rowAffected = new DBLayer().CreateMachuaAwasMonthlyProgress(objRecord);
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