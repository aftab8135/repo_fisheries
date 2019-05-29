using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class MPR_frmSeedStock : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    
        lblFinYear.Text = Session["FinancialYear"].ToString();
        lblLoginType.Text = Session["UserName"].ToString();
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
    public static string SeedStockObject()
    {
        try
        {
            string jsondata = "";
            DBLayer db = new DBLayer();
            jsondata = JsonConvert.SerializeObject(db.GetSeedStockObject());
            return jsondata;
        }

        catch (Exception ex)
        {
            return null;
        }
    }

    [WebMethod]
    public static string Create(SeedStockMaster objSeedStockMaster)
    {
        try
        {
            objSeedStockMaster.FinYear = HttpContext.Current.Session["FinancialYear"].ToString();
            objSeedStockMaster.CreatedBy = Convert.ToInt32(HttpContext.Current.Session["UserKey"]);
            objSeedStockMaster.DistrictKey = Convert.ToInt32(HttpContext.Current.Session["DistrictKey"]); ;

            int rowAffected = new DBLayer().CreateSeedStock(objSeedStockMaster);
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