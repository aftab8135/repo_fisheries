using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Report_CriteriaFormScheme : System.Web.UI.Page
{
    public static Int32 DistrictKey = 0;
    public static Int32 DivisionKey = 0;
    private static string FinYear = "";
    private static Int64 UserKey = 0;
    private static string UserName = "";
    public static int SchemeTypeKey = 0;
    public int FR = 0;
    public int RptKey = 0;


    protected void Page_PreInit(object sender, EventArgs e)
    {
        RptKey = Convert.ToInt32(Request.QueryString.Get("RptKey"));
        FR = Convert.ToInt32(Request.QueryString.Get("FR"));

        if (RptKey == 10)
        {
            SchemeTypeKey = Convert.ToInt32(Request.QueryString.Get("ST"));
        }
        else
        {
            SchemeTypeKey = RptKey;
        }

        if (FR == 1)
        {
            this.MasterPageFile = "~/MasterPages/DistrictMaster.master";
        }
        else if (FR == 2)
        {
            this.MasterPageFile = "~/MasterPages/DivisionMaster.master";
        }
        else if (FR == 3)
        {
            this.MasterPageFile = "~/MasterPages/HOMaster.master";
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {

        UserKey = Convert.ToInt32(Session["UserKey"]);
        DistrictKey = Convert.ToInt32(Session["DistrictKey"]);
        DivisionKey = Convert.ToInt32(Session["DivisionKey"]);

        FinYear = Session["FinancialYear"].ToString();
        UserName = Session["UserName"].ToString();

        switch (RptKey)
        {
            case 1:
                lblFinYear.Text = FinYear;
                lblLoginType.Text = UserName;
                lblHeading.Text = "नीली क्रांति योजना - स्कीम स्तर";
                lblHomeHeading.Text = "नीली क्रांति योजना - स्कीम स्तर";
                lblTitle.Text = "नीली क्रांति योजना - स्कीम स्तर";
                break;
            case 2:
                lblFinYear.Text = FinYear;
                lblLoginType.Text = UserName;
                lblHeading.Text = "राष्ट्रीय कृषि विकास योजना - स्कीम स्तर";
                lblHomeHeading.Text = "राष्ट्रीय कृषि विकास योजना - स्कीम स्तर";
                lblTitle.Text = "राष्ट्रीय कृषि विकास योजना - स्कीम स्तर";
                break;
            case 10:
                lblFinYear.Text = FinYear;
                lblLoginType.Text = UserName;
                lblHeading.Text = "राष्ट्रीय कृषि विकास योजना";
                lblHomeHeading.Text = "राष्ट्रीय कृषि विकास योजना";
                lblTitle.Text = "राष्ट्रीय कृषि विकास योजना";
                break;
            case 11:
                lblFinYear.Text = FinYear;
                lblLoginType.Text = UserName;
                lblHeading.Text = "नीलाम जलाशयों का विवरण";
                lblHomeHeading.Text = "नीलाम जलाशयों का विवरण";
                lblTitle.Text = "नीलाम जलाशयों का विवरण";
                break;
            case 12:
                lblFinYear.Text = FinYear;
                lblLoginType.Text = UserName;
                lblHeading.Text = "समस्त श्रोतों से मतस्य उत्पादन";
                lblHomeHeading.Text = "समस्त श्रोतों से मतस्य उत्पादन";
                lblTitle.Text = "समस्त श्रोतों से मतस्य उत्पादन";
                break;
            case 13:
                lblFinYear.Text = FinYear;
                lblLoginType.Text = UserName;
                lblHeading.Text = "ग्राम समाज तालाबों की प्रगति प्रपत्र-1";
                lblHomeHeading.Text = "ग्राम समाज तालाबों की प्रगति प्रपत्र-1";
                lblTitle.Text = "ग्राम समाज तालाबों की प्रगति प्रपत्र-1";
                break;
            default:
                lblFinYear.Text = FinYear;
                lblLoginType.Text = UserName;
                lblHeading.Text = "सेन्ट्रल सेक्टर स्कीम । मासिक प्रगति सूचना";
                lblHomeHeading.Text = "सेन्ट्रल सेक्टर स्कीम । मासिक प्रगति सूचना";
                lblTitle.Text = "सेन्ट्रल सेक्टर स्कीम । मासिक प्रगति सूचना";
                break;
        }


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
    public static List<ListItem> GetDistrict(int DivKey)
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.PopulateDistrictMondalwise(DivKey);
        }
        catch (Exception ex)
        {

            return null;
        }

    }

    [WebMethod]
    public static List<ListItem> GetSchemesType()
    {
        try
        {
            DBLayer db = new DBLayer();
            return db.GetAllSchemeType();
        }
        catch (Exception ex)
        {

            return null;
        }
    }

    [WebMethod]
    public static List<ListItem> GetSchemes(int key)
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
    public static string ShowReport(int MonthID)
    {
        try
        {

            return "1";
        }
        catch (Exception)
        {

            return null;
        }
    }
}