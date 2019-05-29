using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Secure_Login_frm_Login : System.Web.UI.Page
{

    protected void Page_Init(object sender, EventArgs e)
    {
        Session.Clear();
        Session.Abandon();

        Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static List<ListItem> GetDistrict()
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.PopulateDistrict();
        }
        catch (Exception ex)
        {

            return null;
        }

    }

    [WebMethod]
    public static List<ListItem> GetMandal()
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.PopulateMandal();
        }
        catch (Exception ex)
        {

            return null;
        }

    }

    [WebMethod]
    public static List<ListItem> GetFinancialYear()
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.PopulateFinancialYear();
        }
        catch (Exception ex)
        {

            return null;
        }

    }

    [WebMethod]
    public static int UserLogin(string UserName, string Password, string FinancialYear, string UserType)
    {
        try
        {
            DBLayer db = new DBLayer();
            DataTable dt = new DataTable();

            dt = db.GetUserMaster(UserName.Trim(), Password, UserType);

            if (dt.Rows.Count > 0)
            {
                return (new Secure_Login_frm_Login()).SetUserDetail(dt, FinancialYear);

            }
            else
            {
                return -1;
            }

        }
        catch (Exception ex)
        {
            return -2;
        }
    }
    
    public int SetUserDetail(DataTable dt, string FinancialYear)
    {
        try
        {
            Session["UserType"] = dt.Rows[0]["UserType"].ToString();
            Session["UserTypeName"] = dt.Rows[0]["UserTypeName"].ToString();
            Session["UserKey"] = dt.Rows[0]["UserKey"].ToString();
            Session["UserName"] = dt.Rows[0]["UserName"].ToString();
            Session["DivisionKey"] = dt.Rows[0]["DivisionKey"].ToString();
            Session["DistrictKey"] = dt.Rows[0]["DistrictKey"].ToString();
            Session["OfficeKey"] = dt.Rows[0]["OfficeKey"].ToString();
            Session["FinancialYear"] = FinancialYear;
            Session["DivisionName"] = dt.Rows[0]["DivisionName"].ToString();
            Session["DistrictName"] = dt.Rows[0]["DistrictName"].ToString();

            return 1;
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }

}