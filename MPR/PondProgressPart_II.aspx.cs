using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class District_PondProgressPart_II : System.Web.UI.Page
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
    public static string GetFirstPondTotal(int MonthId)
    {
        try
        {
            string jsondata = "";
            DBLayer db = new DBLayer();
            jsondata = JsonConvert.SerializeObject(db.GetFirstTotalPatta(HttpContext.Current.Session["FinancialYear"].ToString(), MonthId, Convert.ToInt32(HttpContext.Current.Session["DistrictKey"])));
            return jsondata;
        }

        catch (Exception ex)
        {
            return null;
        }
    }

    [WebMethod]
    public static string Create(PondProgressMaster objPondProgressMaster)
    {
        try
        {
            objPondProgressMaster.DistrictKey = DistrictKey;
            objPondProgressMaster.DivisionKey = DivisionKey;
            objPondProgressMaster.FinYear = FinYear;
            objPondProgressMaster.CreatedBy = UserKey;

            int rowAffected = new DBLayer().CreatePondProgress(objPondProgressMaster);
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