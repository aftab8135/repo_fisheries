using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class MPR_frmPondMaster : System.Web.UI.Page
{
    //private static Int32 DistrictKey = 0;
    //private static Int32 DivisionKey = 0;
    //private static string FinYear = "";
    //private static Int64 UserKey = 0;
    //private static string UserName = "";

    public static DataTable dtPhyEventlist = new DataTable();

    protected void Page_Load(object sender, EventArgs e)
    {
        //UserKey = Convert.ToInt32(Session["UserKey"]);
        //DistrictKey = Convert.ToInt32(Session["DistrictKey"]);
        //FinYear = Session["FinancialYear"].ToString();
        //UserName = Session["UserName"].ToString();

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
    public static string GetPondAuctionList(int MonthId)
    {
        try
        {
            string jsondata = "";
            DBLayer db = new DBLayer();
            jsondata = JsonConvert.SerializeObject(db.GetPondAuctionListByDistict(HttpContext.Current.Session["FinancialYear"].ToString(), Convert.ToInt32(HttpContext.Current.Session["DistrictKey"])));
            return jsondata;
        }

        catch (Exception ex)
        {
            return null;
        }
    }

    [WebMethod]
    public static string Create(PondAuctionMaster objPondAuctionMaster)
    {
        try
        {
            objPondAuctionMaster.FinYear = HttpContext.Current.Session["FinancialYear"].ToString();
            objPondAuctionMaster.CreatedBy = Convert.ToInt32(HttpContext.Current.Session["UserKey"]);

            //int rowAffected = new DBLayer().Create_MSR_PHY_EVENT(objMSR_PhyEventMst);
            //if (rowAffected > 0)
            //{
            //    return "{\"StatusCode\":\"200\", \"Msg\":\"Record Saved Successfully.\"}";
            //}
            //else
            //{
            //    return "{\"StatusCode\":\"500\", \"Msg\":\"Record Not Saved.\"}";
            //}
            return "";
        }
        catch (Exception ex)
        {
            return "{\"StatusCode\":\"404\", \"Msg\":\"Something Went Wrong.\"}";
            throw;
        }
    }


}