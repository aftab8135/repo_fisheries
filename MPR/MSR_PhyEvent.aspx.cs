using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class District_MSR_PhyEvent : System.Web.UI.Page
{
    public static DataTable dtPhyEventlist = new DataTable();

    protected void Page_Load(object sender, EventArgs e)
    {
        //UserKey = Convert.ToInt32(Session["UserKey"]);
        //DistrictKey = Convert.ToInt32(Session["DistrictKey"]);
        //FinYear = Session["FinancialYear"].ToString();
        //UserName = Session["UserName"].ToString();

        lblFinYear.Text = Session["FinancialYear"].ToString(); ;
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
    public static List<ListItem> GetMSR_Category()
    {
        try
        {
            return new DBLayer().GetMSR_Category();
        }
        catch (Exception)
        {

            return null;
        }
    }

    [WebMethod]
    public static string GetPhyEventDetail(int CateKey)
    {
        try
        {
            string jsondata = "";
            DBLayer db = new DBLayer();
            jsondata = JsonConvert.SerializeObject(db.GetMSR_PhyEventMonthList(HttpContext.Current.Session["FinancialYear"].ToString(), Convert.ToInt32(HttpContext.Current.Session["DistrictKey"]), CateKey));
            return jsondata;
        }

        catch (Exception ex)
        {
            return null;
        }
    }

    [WebMethod]
    public static string Create(MSR_PhyEventMaster objMSR_PhyEventMst)
    {
        try
        {
            objMSR_PhyEventMst.DistrictKey = Convert.ToInt32(HttpContext.Current.Session["DistrictKey"]);
            objMSR_PhyEventMst.DivisionKey = Convert.ToInt32(HttpContext.Current.Session["DivisionKey"]);
            objMSR_PhyEventMst.FinancialYear = HttpContext.Current.Session["FinancialYear"].ToString();
            objMSR_PhyEventMst.CreatedBy = Convert.ToInt64(HttpContext.Current.Session["UserKey"]);
            objMSR_PhyEventMst.IsActive = true;

            int rowAffected = new DBLayer().Create_MSR_PHY_EVENT(objMSR_PhyEventMst);
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
            if (new DBLayer().IS_MSR_PhyEventExist(MonthId, CategoryID, Convert.ToInt32(HttpContext.Current.Session["DistrictKey"]), HttpContext.Current.Session["FinancialYear"].ToString()))
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