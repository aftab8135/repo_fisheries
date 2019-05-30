using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Report_District_wf_criteria : System.Web.UI.Page
{
    public Int32 DistrictKey = 0;
    public Int32 DivisionKey = 0;
    private string FinYear = "";
    private Int64 UserKey = 0;
    private string UserName = "";
    public int FR = 0;
    public int RPTKey = 0;
    public int ST = 0;

    public static DataTable dtPhyEventlist = new DataTable();

    protected void Page_PreInit(object sender, EventArgs e)
    {
        RPTKey = Convert.ToInt32(Request.QueryString.Get("RptKey"));
        FR = Convert.ToInt32(Request.QueryString.Get("FR"));

        Session["RPTKey"] = RPTKey;
        Session["FR"] = FR;

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
        else if (FR == 4)
        {
            this.MasterPageFile = "~/MasterPages/ShasanMaster.master";
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        UserKey = Convert.ToInt32(Session["UserKey"]);

        DistrictKey = Convert.ToInt32(Session["DistrictKey"]);
        DivisionKey = Convert.ToInt32(Session["DivisionKey"]);

        FinYear = Session["FinancialYear"].ToString();
        UserName = Session["UserName"].ToString();

        lblFinYear.Text = FinYear;
        lblLoginType.Text = UserName;


        switch (RPTKey)
        {
            case 1:
                lblFinYear.Text = FinYear;
                lblLoginType.Text = UserName;
                lblHeading.Text = "नीली क्रांति योजना - मण्डलवार";
                lblHomeHeading.Text = "नीली क्रांति योजना - मण्डलवार";
                lblTitle.Text = "नीली क्रांति योजना - मण्डलवार";
                break;
            case 2:
                lblFinYear.Text = FinYear;
                lblLoginType.Text = UserName;
                lblHeading.Text = "राष्ट्रीय कृषि विकास योजना";
                lblHomeHeading.Text = "राष्ट्रीय कृषि विकास योजना";
                lblTitle.Text = "राष्ट्रीय कृषि विकास योजना";
                break;
            case 3:
                lblFinYear.Text = FinYear;
                lblLoginType.Text = UserName;
                lblHeading.Text = "समस्त श्रोतों से अनुमानित मत्स्य उत्पादन रिपोर्ट";
                lblHomeHeading.Text = "समस्त श्रोतों से अनुमानित मत्स्य उत्पादन रिपोर्ट";
                lblTitle.Text = "समस्त श्रोतों से अनुमानित मत्स्य उत्पादन रिपोर्ट";
                break;
            case 4:
                lblFinYear.Text = FinYear;
                lblLoginType.Text = UserName;
                lblHeading.Text = "मछुआ आवास योजना की वर्षवार भौतिक एवं वित्तीय प्रगति";
                lblHomeHeading.Text = "मछुआ आवास योजना की वर्षवार भौतिक एवं वित्तीय प्रगति";
                lblTitle.Text = "मछुआ आवास योजना की वर्षवार भौतिक एवं वित्तीय प्रगति";
                break;
            case 5:
                lblFinYear.Text = FinYear;
                lblLoginType.Text = UserName;
                lblHeading.Text = "विभागीय श्रेणी 1,2,3,4 के जलाशय एवं श्रेणी-5 के तालाबों का विवरण";
                lblHomeHeading.Text = "विभागीय श्रेणी 1,2,3,4 के जलाशय एवं श्रेणी-5 के तालाबों का विवरण";
                lblTitle.Text = "विभागीय श्रेणी 1,2,3,4 के जलाशय एवं श्रेणी-5 के तालाबों का विवरण";
                break;
            case 6:
                lblFinYear.Text = FinYear;
                lblLoginType.Text = UserName;
                lblHeading.Text = "आनिस्तारित जलाशयों एवं तालाबों का विवरण";
                lblHomeHeading.Text = "आनिस्तारित जलाशयों एवं तालाबों का विवरण";
                lblTitle.Text = "आनिस्तारित जलाशयों एवं तालाबों का विवरण";
                break;
            case 7:
                lblFinYear.Text = FinYear;
                lblLoginType.Text = UserName;
                lblHeading.Text = "विभागीय जलाशयों में अंगुलिका संचय, उत्पादन एवं आय का विवरण";
                lblHomeHeading.Text = "विभागीय जलाशयों में अंगुलिका संचय, उत्पादन एवं आय का विवरण";
                lblTitle.Text = "विभागीय जलाशयों में अंगुलिका संचय, उत्पादन एवं आय का विवरण";
                break;
            case 8:
                lblFinYear.Text = FinYear;
                lblLoginType.Text = UserName;
                lblHeading.Text = "विभागीय मत्स्य प्रक्षेत्रों से स्पान से फाई मत्स्य बीज उत्पादन / व्यय / आय का विवरण";
                lblHomeHeading.Text = "विभागीय मत्स्य प्रक्षेत्रों से स्पान से फाई मत्स्य बीज उत्पादन / व्यय / आय का विवरण";
                lblTitle.Text = "विभागीय मत्स्य प्रक्षेत्रों से स्पान से फाई मत्स्य बीज उत्पादन / व्यय / आय का विवरण";
                break;
            case 9:
                lblFinYear.Text = FinYear;
                lblLoginType.Text = UserName;
                lblHeading.Text = "विभागीय मत्स्य प्रक्षेत्रों से फाई से फिंगरलिंग मत्स्य बीज उत्पादन / व्यय / आय का विवरण";
                lblHomeHeading.Text = "विभागीय मत्स्य प्रक्षेत्रों से फाई से फिंगरलिंग मत्स्य बीज उत्पादन / व्यय / आय का विवरण";
                lblTitle.Text = "विभागीय मत्स्य प्रक्षेत्रों से फाई से फिंगरलिंग मत्स्य बीज उत्पादन / व्यय / आय का विवरण";
                break;
            case 10:
                lblFinYear.Text = FinYear;
                lblLoginType.Text = UserName;
                lblHeading.Text = "ग्राम सभा के तालाबों के पट्टे की प्रगति - प्रारूप-1";
                lblHomeHeading.Text = "ग्राम सभा के तालाबों के पट्टे की प्रगति - प्रारूप-1";
                lblTitle.Text = "ग्राम सभा के तालाबों के पट्टे की प्रगति - प्रारूप-1";
                break;
            case 11:
                lblFinYear.Text = FinYear;
                lblLoginType.Text = UserName;
                lblHeading.Text = "ग्राम सभा के तालाबों के पट्टे की प्रगति - प्रारूप-2";
                lblHomeHeading.Text = "ग्राम सभा के तालाबों के पट्टे की प्रगति - प्रारूप-2";
                lblTitle.Text = "ग्राम सभा के तालाबों के पट्टे की प्रगति - प्रारूप-2";
                break;
            
            case 12:
                lblFinYear.Text = FinYear;
                lblLoginType.Text = UserName;
                lblHeading.Text = "समस्त श्रोतों से (अंगुलिका) मत्स्य बीज वितरण की प्रगति की सूचना";
                lblHomeHeading.Text = "समस्त श्रोतों से (अंगुलिका) मत्स्य बीज वितरण की प्रगति की सूचना";
                lblTitle.Text = "समस्त श्रोतों से (अंगुलिका) मत्स्य बीज वितरण की प्रगति की सूचना";
                break;
            case 13:
                lblFinYear.Text = FinYear;
                lblLoginType.Text = UserName;
                lblHeading.Text = "मत्स्य भौतिक कार्यक्रम सांख्यकीय रिपोर्ट";
                lblHomeHeading.Text = "मत्स्य भौतिक कार्यक्रम सांख्यकीय रिपोर्ट";
                lblTitle.Text = "मत्स्य भौतिक कार्यक्रम सांख्यकीय रिपोर्ट";
                break;
            case 14:
                lblFinYear.Text = FinYear;
                lblLoginType.Text = UserName;
                lblHeading.Text = "नीली क्रांति योजना - जिलावार";
                lblHomeHeading.Text = "नीली क्रांति योजना - जिलावार";
                lblTitle.Text = "नीली क्रांति योजना - जिलावार";
                break;
            case 15:
                lblFinYear.Text = FinYear;
                lblLoginType.Text = UserName;
                lblHeading.Text = "समस्त श्रोतों में मत्स्य बीज वितरण";
                lblHomeHeading.Text = "समस्त श्रोतों में मत्स्य बीज वितरण";
                lblTitle.Text = "समस्त श्रोतों में मत्स्य बीज वितरण";
                break;     
            case 16:
                lblFinYear.Text = FinYear;
                lblLoginType.Text = UserName;
                lblHeading.Text = "समस्त श्रोतों से मत्स्य बीज संचय";
                lblHomeHeading.Text = "समस्त श्रोतों से मत्स्य बीज संचय";
                lblTitle.Text = "समस्त श्रोतों से मत्स्य बीज संचय";
                break;
            case 17:
                lblFinYear.Text = FinYear;
                lblLoginType.Text = UserName;
                lblHeading.Text = "राष्ट्रीय कृषि विकास योजना- जिलावार";
                lblHomeHeading.Text = "राष्ट्रीय कृषि विकास योजना- जिलावार";
                lblTitle.Text = "राष्ट्रीय कृषि विकास योजना- जिलावार";
                break;
            case 18:
                lblFinYear.Text = FinYear;
                lblLoginType.Text = UserName;
                lblHeading.Text = "किसान क्रेडिट कार्ड योजना की प्रगति रिपोर्ट";
                lblHomeHeading.Text = "किसान क्रेडिट कार्ड योजना की प्रगति रिपोर्ट";
                lblTitle.Text = "किसान क्रेडिट कार्ड योजना की प्रगति रिपोर्ट";
                break;
            case 19:
                lblFinYear.Text = FinYear;
                lblLoginType.Text = UserName;
                lblHeading.Text = "विभागीय श्रेणी 1,2,3,4 के जलाशय एवं श्रेणी-5 के निस्तारित की प्रगति";
                lblHomeHeading.Text = "विभागीय श्रेणी 1,2,3,4 के जलाशय एवं श्रेणी-5 के निस्तारित की प्रगति";
                lblTitle.Text = "विभागीय श्रेणी 1,2,3,4 के जलाशय एवं श्रेणी-5 के निस्तारित की प्रगति";
                break;
            case 20:
                lblFinYear.Text = FinYear;
                lblLoginType.Text = UserName;
                lblHeading.Text = "सांसद आदर्श ग्राम योजना अन्तर्गत चयनित ग्रामों की कार्य की रिपोर्ट";
                lblHomeHeading.Text = "सांसद आदर्श ग्राम योजना अन्तर्गत चयनित ग्रामों की कार्य की रिपोर्ट";
                lblTitle.Text = "सांसद आदर्श ग्राम योजना अन्तर्गत चयनित ग्रामों की कार्य की रिपोर्ट";
                break;

            default:
                lblFinYear.Text = FinYear;
                lblLoginType.Text = UserName;
                lblHeading.Text = "";
                lblHomeHeading.Text = "";
                lblTitle.Text = "";
                break;
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
    public static string ShowReport(int MonthID)
    {
        int RPTKey = Convert.ToInt32(HttpContext.Current.Session["RptKey"]);
        string rt = "";
        try
        {
            if (RPTKey == 1)
            {
                rt = "1";
            }
            else if (RPTKey == 2)
            {
                rt = "2";
            }
            else if (RPTKey == 3)
            {
                rt = "3";
            }
            else if (RPTKey == 4)
            {
                rt = "4";
            }
            else if (RPTKey == 5)
            {
                rt = "5";
            }
            else if (RPTKey == 6)
            {
                rt = "6";
            }
            else if (RPTKey == 7)
            {
                rt = "7";
            }
            else if (RPTKey == 8)
            {
                rt = "8";
            }
            else if (RPTKey == 9)
            {
                rt = "9";
            }
            else if (RPTKey == 10)
            {
                rt = "10";
            }
            else if (RPTKey == 11)
            {
                rt = "11";
            }
            else if (RPTKey == 12)
            {
                rt = "12";
            }
            else if (RPTKey == 13)
            {
                rt = "13";
            }
            else if (RPTKey == 14)
            {
                rt = "14";
            }
            else if (RPTKey == 15)
            {
                rt = "15";
            }
            else if (RPTKey == 16)
            {
                rt = "16";
            }
            else if (RPTKey == 17)
            {
                rt = "17";
            }
            else if (RPTKey == 18)
            {
                rt = "18";
            }
            else if (RPTKey == 19)
            {
                rt = "19";
            }
            else if (RPTKey == 20)
            {
                rt = "20";
            }
            return rt;
        }
        catch (Exception)
        {

            return null;
        }
    }
}