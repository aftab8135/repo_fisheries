using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class frm_SeedDistribution : System.Web.UI.Page
{
    private Int32 DistrictKey = 0;
    private Int32 DivisionKey = 0;
    private string FinYear = "";
    private Int64 UserKey = 0;
    private string UserName = "";

    protected void Page_Load(object sender, EventArgs e)
    {
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
    public static List<ListItem> GetSeedObject()
    {
        try
        {
            return new DBLayer().GetSeedObject();
        }
        catch (Exception)
        {

            return null;
        }
    }

    [WebMethod]
    public static string SeedTarget_DistrictWise(int SDObjectKey)
    {
        try
        {
            string jsondata = "";
            DBLayer db = new DBLayer();
            jsondata = JsonConvert.SerializeObject(db.GetSeedTarget_DistrictWise(HttpContext.Current.Session["FinancialYear"].ToString(), Convert.ToInt32(HttpContext.Current.Session["DistrictKey"].ToString()), SDObjectKey));
            return jsondata;
        }

        catch (Exception ex)
        {
            return null;
        }
    }

    [WebMethod]
    public static string Create(SeedDistributionMaster objSeedDistributionMaster)
    {
        try
        {
            objSeedDistributionMaster.FinYear = HttpContext.Current.Session["FinancialYear"].ToString();
            objSeedDistributionMaster.CreatedBy = Convert.ToInt32(HttpContext.Current.Session["UserKey"]);
            objSeedDistributionMaster.DistrictKey = Convert.ToInt32(HttpContext.Current.Session["DistrictKey"]); ;

            int rowAffected = new DBLayer().CreateSeedDistribution(objSeedDistributionMaster);
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