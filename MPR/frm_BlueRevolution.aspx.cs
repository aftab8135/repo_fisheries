using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MPR_frm_BlueRevolution : System.Web.UI.Page
{
    public static Int32 DistrictKey = 0;
    public static string FinYear = "";
    private static Int32 UserKey = 0;
    private static Int32 SchemeKey = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            hidSchemeKey.Value = Request.QueryString.Get("Key");
            SchemeKey = Convert.ToInt32(Request.QueryString.Get("Key"));
            DistrictKey = Convert.ToInt32(Session["DistrictKey"]);
            FinYear = Session["FinancialYear"].ToString();
            UserKey = Convert.ToInt32(Session["UserKey"]);

            lblFinYear.Text = FinYear;
            lblLoginType.Text = Session["DistrictName"].ToString();
        }
    }

    [WebMethod]
    public static List<ListItem> GetSchemeType(int key)
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
    public static string Create(BlueRevolution objBlueRevolution)
    {
        try
        {
            objBlueRevolution.SchemeKey = SchemeKey;
            objBlueRevolution.FinYear = FinYear;
            objBlueRevolution.DistrictKey = DistrictKey;
            objBlueRevolution.CreatedBy = UserKey;
            objBlueRevolution.IsActive = true;


            int rowAffected = new DBLayer().CreateBlueRevolution(objBlueRevolution);
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
    public static BlueRevolution Load_BlueRevolution(int monthkey, int schemesubtypekey)
    {
        BlueRevolution objBlueRevolution = new BlueRevolution();

        objBlueRevolution = new DBLayer().Get_BlueRevolution(FinYear, monthkey, DistrictKey, SchemeKey, schemesubtypekey);

        return objBlueRevolution;
    }

}