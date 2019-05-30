using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;

public partial class Report_District_wf_ReportViewer : System.Web.UI.Page
{
    ReportDocument ObjRpt = new ReportDocument();
    String FinancialYear = "";
    Int32 DistrictKey = 0;
    Int32 DivisionKey = 0;
    public static int FR = 0;
    public static int RPTKey = 0;
    public int ST = 0;


    protected void Page_PreInit(object sender, EventArgs e)
    {
        if (Session["FinancialYear"] == null)
        {
            Response.Redirect("~/Secure/Login/frm_Login.aspx");
        }
        RPTKey = Convert.ToInt32(Request.QueryString.Get("RptKey"));
        FR = Convert.ToInt32(Request.QueryString.Get("FR"));
        FinancialYear = Session["FinancialYear"].ToString();

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
        try
        {

            ShowReport();
        }
        catch (Exception ex)
        {

        }
    }

    private void ShowReport()
    {
        try
        {
            Int16 RptType = Convert.ToInt16(Request.QueryString["RptKey"]);
            Int16 MonthKey = Convert.ToInt16(Request.QueryString["MonthKey"]);

            Int32 CateKey = Convert.ToInt32(Request.QueryString["CateKey"]);
            Int32 FR = Convert.ToInt32(Request.QueryString["FR"]);

            DistrictKey = Convert.ToInt16(Request.QueryString["DSKEY"]);
            DivisionKey = Convert.ToInt16(Request.QueryString["DVKEY"]);

            string month_name = GlobalFunctions.Get_MonthName(MonthKey);
            string RptPath = "~/MIS/";

            if (RptType == 1)
            {
                string rptname = "";
                string querytype = "";
                //नीली क्रांति योजना - मण्डलवार
                DataTable dt = new DataTable();
                DBLayer objDb = new DBLayer();
                if (FR == 2)
                {
                    querytype = "HQ_DIS";
                    dt = objDb.GetRpt_BlueRevolution(querytype, FinancialYear, MonthKey, DivisionKey, DistrictKey);
                    rptname = "rptBlueRevolution_District.rpt";

                }
                else
                {
                    querytype = "HQ_DIV";
                    dt = objDb.GetRpt_BlueRevolution(querytype, FinancialYear, MonthKey, DivisionKey, DistrictKey);
                    rptname = "rptBlueRevolution_Division.rpt";
                }


                if (dt.Rows.Count > 0)
                {
                    string connString = ConfigurationManager.ConnectionStrings["ConnectionStr"].ConnectionString;
                    SqlConnectionStringBuilder connStringBuilder = new SqlConnectionStringBuilder(connString);

                    ObjRpt.Load(MapPath(RptPath + rptname));
                    ObjRpt.SetDatabaseLogon(connStringBuilder.UserID, connStringBuilder.Password, connStringBuilder.DataSource, connStringBuilder.InitialCatalog);
                    ObjRpt.SetDataSource(dt);
                    ObjRpt.SetParameterValue("QueryType", querytype);
                    ObjRpt.SetParameterValue("FinYear", FinancialYear);
                    ObjRpt.SetParameterValue("MonthId", MonthKey);
                    ObjRpt.SetParameterValue("DistrictKey", DistrictKey);
                    ObjRpt.SetParameterValue("DivisionKey", DivisionKey);

                    CRViewer.ReportSource = ObjRpt;
                    CRViewer.RefreshReport();

                    // ObjRpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "MSR_BlueRevolution_Division");
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "info alert", "alert('No Record Found.'); window.history.go(-1);", true);
                }
            }
            else if (RptType == 2)
            {
                string rptname = "";
                string querytype = "";
                //राष्ट्रीय कृषि विकास योजना  - मण्डलवार
                DataTable dt = new DataTable();
                DBLayer objDb = new DBLayer();

                if (FR == 2)
                {
                    querytype = "HQ_DIS";
                    dt = objDb.GetRpt_RKVY(querytype, FinancialYear, MonthKey, DivisionKey, DistrictKey);
                    rptname = "rptRKVY_District.rpt";

                }
                else
                {
                    querytype = "HQ_DIV";
                    dt = objDb.GetRpt_RKVY(querytype, FinancialYear, MonthKey, DivisionKey, DistrictKey);
                    rptname = "rptRKVY_Division.rpt";
                }
               

                if (dt.Rows.Count > 0)
                {
                    string connString = ConfigurationManager.ConnectionStrings["ConnectionStr"].ConnectionString;
                    SqlConnectionStringBuilder connStringBuilder = new SqlConnectionStringBuilder(connString);

                    ObjRpt.Load(MapPath(RptPath + rptname));
                    ObjRpt.SetDatabaseLogon(connStringBuilder.UserID, connStringBuilder.Password, connStringBuilder.DataSource, connStringBuilder.InitialCatalog);
                    ObjRpt.SetDataSource(dt);

                    ObjRpt.SetParameterValue("QueryType", querytype);
                    ObjRpt.SetParameterValue("FinYear", FinancialYear);
                    ObjRpt.SetParameterValue("MonthId", MonthKey);
                    ObjRpt.SetParameterValue("DistrictKey", DistrictKey);
                    ObjRpt.SetParameterValue("DivisionKey", DivisionKey);

                    CRViewer.ReportSource = ObjRpt;
                    CRViewer.RefreshReport();

                    //ObjRpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "MSR_MachuaAwasMonthlyProgress");

                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "info alert", "alert('No Record Found.'); window.history.go(-1);", true);
                }
            }
            else if (RptType == 3)
            {
                //समस्त श्रोतों से अनुमानित मत्स्य उत्पादन रिपोर्ट
                DataTable dt = new DataTable();
                DBLayer objDb = new DBLayer();
                dt = objDb.GetRptFishProductionAllSources(FinancialYear, MonthKey, DistrictKey, DivisionKey);

                if (dt.Rows.Count > 0)
                {
                    string connString = ConfigurationManager.ConnectionStrings["ConnectionStr"].ConnectionString;
                    SqlConnectionStringBuilder connStringBuilder = new SqlConnectionStringBuilder(connString);

                    ObjRpt.Load(MapPath(RptPath + "rpt_FishProductionAllSources.rpt"));
                    ObjRpt.SetDatabaseLogon(connStringBuilder.UserID, connStringBuilder.Password, connStringBuilder.DataSource, connStringBuilder.InitialCatalog);
                    ObjRpt.SetDataSource(dt);

                    ObjRpt.SetParameterValue("FinYear", FinancialYear);
                    ObjRpt.SetParameterValue("MonthId", MonthKey);
                    ObjRpt.SetParameterValue("DistrictKey", DistrictKey);
                    ObjRpt.SetParameterValue("DivisionKey", DivisionKey);

                    CRViewer.ReportSource = ObjRpt;
                    CRViewer.RefreshReport();

                    // ObjRpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "TentativeFishProduction");
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "info alert", "alert('Record Not Found'); window.history.back();", true);
                }
            }
            else if (RptType == 4)
            {
                //मछुआ आवास योजना की वर्षवार भौतिक एवं वित्तीय प्रगति

                DataTable dt = new DataTable();
                DBLayer objDb = new DBLayer();
                dt = objDb.GetRpt_MachuaAwasMonthlyProgress("HQ", FinancialYear, MonthKey, DivisionKey, DistrictKey);

                if (dt.Rows.Count > 0)
                {
                    string connString = ConfigurationManager.ConnectionStrings["ConnectionStr"].ConnectionString;
                    SqlConnectionStringBuilder connStringBuilder = new SqlConnectionStringBuilder(connString);

                    ObjRpt.Load(MapPath(RptPath + "rptMachuaAwasMonthlyProgress.rpt"));
                    ObjRpt.SetDatabaseLogon(connStringBuilder.UserID, connStringBuilder.Password, connStringBuilder.DataSource, connStringBuilder.InitialCatalog);
                    ObjRpt.SetDataSource(dt);

                    ObjRpt.SetParameterValue("QueryType", "HQ");
                    ObjRpt.SetParameterValue("FinYear", FinancialYear);
                    ObjRpt.SetParameterValue("MonthId", MonthKey);
                    ObjRpt.SetParameterValue("DistrictKey", DistrictKey);
                    ObjRpt.SetParameterValue("DivisionKey", DivisionKey);

                    //ObjRpt.SetParameterValue("MonthKey", MonthKey);
                    //ObjRpt.SetParameterValue("FYear", FinancialYear);

                    CRViewer.ReportSource = ObjRpt;
                    CRViewer.RefreshReport();

                    // ObjRpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "MSR_MachuaAwasMonthlyProgress");

                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "info alert", "alert('No Record Found.'); window.history.go(-1);", true);
                }
            }
            else if (RptType == 5)
            {
                //विभागीय श्रेणी 1,2,3,4 के जलाशय एवं श्रेणी-5 के तालाबों का विवरण
                //DataTable dt = new DataTable();
                //DBLayer objDb = new DBLayer();
                //dt = objDb.GetRpt_MachuaAwasMonthlyProgress("HQ", FinancialYear, MonthKey, DivisionKey, DistrictKey);

                //if (dt.Rows.Count > 0)
                //{
                //    string connString = ConfigurationManager.ConnectionStrings["ConnectionStr"].ConnectionString;
                //    SqlConnectionStringBuilder connStringBuilder = new SqlConnectionStringBuilder(connString);

                //    ObjRpt.Load(MapPath(RptPath + "rptMachuaAwasMonthlyProgress.rpt"));
                //    ObjRpt.SetDatabaseLogon(connStringBuilder.UserID, connStringBuilder.Password, connStringBuilder.DataSource, connStringBuilder.InitialCatalog);
                //    ObjRpt.SetDataSource(dt);

                //    ObjRpt.SetParameterValue("@QueryType", "HQ");
                //    ObjRpt.SetParameterValue("@FinYear", FinancialYear);
                //    ObjRpt.SetParameterValue("@MonthId", MonthKey);
                //    ObjRpt.SetParameterValue("@DistrictKey", DistrictKey);
                //    ObjRpt.SetParameterValue("@DivisionKey", DivisionKey);

                //    CRViewer.ReportSource = ObjRpt;
                //    CRViewer.RefreshReport();

                // ObjRpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "MSR_MachuaAwasMonthlyProgress");

                //}
                //else
                //{
                //    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "info alert", "alert('No Record Found.'); window.history.go(-1);", true);
                //}
            }
            else if (RptType == 6)
            {
                //आनिस्तारित जलाशयों एवं तालाबों का विवरण
                //DataTable dt = new DataTable();
                //DBLayer objDb = new DBLayer();
                //dt = objDb.GetRpt_MachuaAwasMonthlyProgress("HQ", FinancialYear, MonthKey, DivisionKey, DistrictKey);

                //if (dt.Rows.Count > 0)
                //{
                //    string connString = ConfigurationManager.ConnectionStrings["ConnectionStr"].ConnectionString;
                //    SqlConnectionStringBuilder connStringBuilder = new SqlConnectionStringBuilder(connString);

                //    ObjRpt.Load(MapPath(RptPath + "rptMachuaAwasMonthlyProgress.rpt"));
                //    ObjRpt.SetDatabaseLogon(connStringBuilder.UserID, connStringBuilder.Password, connStringBuilder.DataSource, connStringBuilder.InitialCatalog);
                //    ObjRpt.SetDataSource(dt);

                //    ObjRpt.SetParameterValue("@QueryType", "HQ");
                //    ObjRpt.SetParameterValue("@FinYear", FinancialYear);
                //    ObjRpt.SetParameterValue("@MonthId", MonthKey);
                //    ObjRpt.SetParameterValue("@DistrictKey", DistrictKey);
                //    ObjRpt.SetParameterValue("@DivisionKey", DivisionKey);

                //    CRViewer.ReportSource = ObjRpt;
                //    CRViewer.RefreshReport();

                //    // ObjRpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "MSR_MachuaAwasMonthlyProgress");

                //}
                //else
                //{
                //    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "info alert", "alert('No Record Found.'); window.history.go(-1);", true);
                //}
            }
            else if (RptType == 7)
            {
                //विभागीय जलाशयों में अंगुलिका संचय, उत्पादन एवं आय का विवरण
                //DataTable dt = new DataTable();
                //DBLayer objDb = new DBLayer();
                //dt = objDb.GetRpt_MachuaAwasMonthlyProgress("HQ", FinancialYear, MonthKey, DivisionKey, DistrictKey);

                //if (dt.Rows.Count > 0)
                //{
                //    string connString = ConfigurationManager.ConnectionStrings["ConnectionStr"].ConnectionString;
                //    SqlConnectionStringBuilder connStringBuilder = new SqlConnectionStringBuilder(connString);

                //    ObjRpt.Load(MapPath(RptPath + "rptMachuaAwasMonthlyProgress.rpt"));
                //    ObjRpt.SetDatabaseLogon(connStringBuilder.UserID, connStringBuilder.Password, connStringBuilder.DataSource, connStringBuilder.InitialCatalog);
                //    ObjRpt.SetDataSource(dt);

                //    ObjRpt.SetParameterValue("@QueryType", "HQ");
                //    ObjRpt.SetParameterValue("@FinYear", FinancialYear);
                //    ObjRpt.SetParameterValue("@MonthId", MonthKey);
                //    ObjRpt.SetParameterValue("@DistrictKey", DistrictKey);
                //    ObjRpt.SetParameterValue("@DivisionKey", DivisionKey);

                //    CRViewer.ReportSource = ObjRpt;
                //    CRViewer.RefreshReport();

                //    // ObjRpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "MSR_MachuaAwasMonthlyProgress");

                //}
                //else
                //{
                //    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "info alert", "alert('No Record Found.'); window.history.go(-1);", true);
                //}
            }
            else if (RptType == 8)
            {
                //विभागीय मत्स्य प्रक्षेत्रों से स्पान से फाई मत्स्य बीज उत्पादन / व्यय / आय का विवरण
                //DataTable dt = new DataTable();
                //DBLayer objDb = new DBLayer();
                //dt = objDb.GetRpt_MachuaAwasMonthlyProgress("HQ", FinancialYear, MonthKey, DivisionKey, DistrictKey);

                //if (dt.Rows.Count > 0)
                //{
                //    string connString = ConfigurationManager.ConnectionStrings["ConnectionStr"].ConnectionString;
                //    SqlConnectionStringBuilder connStringBuilder = new SqlConnectionStringBuilder(connString);

                //    ObjRpt.Load(MapPath(RptPath + "rptMachuaAwasMonthlyProgress.rpt"));
                //    ObjRpt.SetDatabaseLogon(connStringBuilder.UserID, connStringBuilder.Password, connStringBuilder.DataSource, connStringBuilder.InitialCatalog);
                //    ObjRpt.SetDataSource(dt);

                //    ObjRpt.SetParameterValue("@QueryType", "HQ");
                //    ObjRpt.SetParameterValue("@FinYear", FinancialYear);
                //    ObjRpt.SetParameterValue("@MonthId", MonthKey);
                //    ObjRpt.SetParameterValue("@DistrictKey", DistrictKey);
                //    ObjRpt.SetParameterValue("@DivisionKey", DivisionKey);

                //    CRViewer.ReportSource = ObjRpt;
                //    CRViewer.RefreshReport();

                //    // ObjRpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "MSR_MachuaAwasMonthlyProgress");

                //}
                //else
                //{
                //    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "info alert", "alert('No Record Found.'); window.history.go(-1);", true);
                //}
            }
            else if (RptType == 9)
            {
                //विभागीय मत्स्य प्रक्षेत्रों से फाई से फिंगरलिंग मत्स्य बीज उत्पादन / व्यय / आय का विवरण
                //DataTable dt = new DataTable();
                //DBLayer objDb = new DBLayer();
                //dt = objDb.GetRpt_MachuaAwasMonthlyProgress("HQ", FinancialYear, MonthKey, DivisionKey, DistrictKey);

                //if (dt.Rows.Count > 0)
                //{
                //    string connString = ConfigurationManager.ConnectionStrings["ConnectionStr"].ConnectionString;
                //    SqlConnectionStringBuilder connStringBuilder = new SqlConnectionStringBuilder(connString);

                //    ObjRpt.Load(MapPath(RptPath + "rptMachuaAwasMonthlyProgress.rpt"));
                //    ObjRpt.SetDatabaseLogon(connStringBuilder.UserID, connStringBuilder.Password, connStringBuilder.DataSource, connStringBuilder.InitialCatalog);
                //    ObjRpt.SetDataSource(dt);

                //    ObjRpt.SetParameterValue("@QueryType", "HQ");
                //    ObjRpt.SetParameterValue("@FinYear", FinancialYear);
                //    ObjRpt.SetParameterValue("@MonthId", MonthKey);
                //    ObjRpt.SetParameterValue("@DistrictKey", DistrictKey);
                //    ObjRpt.SetParameterValue("@DivisionKey", DivisionKey);

                //    CRViewer.ReportSource = ObjRpt;
                //    CRViewer.RefreshReport();

                //    // ObjRpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "MSR_MachuaAwasMonthlyProgress");

                //}
                //else
                //{
                //    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "info alert", "alert('No Record Found.'); window.history.go(-1);", true);
                //}
            }
            else if (RptType == 10)
            {
                //ग्राम सभा के तालाबों के पट्टे की प्रगति - प्रारूप-1
                DataTable dt = new DataTable("tblppff");
                DBLayer objDb = new DBLayer();
                dt = objDb.GetRptPondProgressPartFirst(FinancialYear, MonthKey, DivisionKey, DistrictKey);

                if (dt.Rows.Count > 0)
                {
                    string connString = ConfigurationManager.ConnectionStrings["ConnectionStr"].ConnectionString;
                    SqlConnectionStringBuilder connStringBuilder = new SqlConnectionStringBuilder(connString);

                    ObjRpt.Load(MapPath(RptPath + "rptPondPattaProgressPart1.rpt"));

                    ObjRpt.SetDatabaseLogon(connStringBuilder.UserID, connStringBuilder.Password, connStringBuilder.DataSource, connStringBuilder.InitialCatalog);
                    ObjRpt.SetDataSource(dt);

                    string FinYear = Session["FinancialYear"].ToString();
                    string MonthName = System.Globalization.DateTimeFormatInfo.CurrentInfo.GetMonthName(MonthKey);

                    ObjRpt.SetParameterValue("FYear", FinYear);
                    ObjRpt.SetParameterValue("MName", MonthName);

                    CRViewer.ReportSource = ObjRpt;
                    CRViewer.RefreshReport();

                    ObjRpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "PondPattaProgressPart1");
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "info alert", "alert('Record Not Found'); window.history.back();", true);
                }
            }
            else if (RptType == 11)
            {
                // ग्राम सभा के तालाबों के पट्टे की प्रगति - प्रारूप-2
                DataTable dt = new DataTable();
                DBLayer objDb = new DBLayer();
                dt = objDb.GetRptPondProgressPartSecond(FinancialYear, MonthKey, DivisionKey, DistrictKey);

                if (dt.Rows.Count > 0)
                {
                    string connString = ConfigurationManager.ConnectionStrings["ConnectionStr"].ConnectionString;
                    SqlConnectionStringBuilder connStringBuilder = new SqlConnectionStringBuilder(connString);

                    ObjRpt.Load(MapPath(RptPath + "RptPondPattaProgressPart2.rpt"));
                    ObjRpt.SetDatabaseLogon(connStringBuilder.UserID, connStringBuilder.Password, connStringBuilder.DataSource, connStringBuilder.InitialCatalog);
                    ObjRpt.SetDataSource(dt);

                    ObjRpt.SetParameterValue("FinYear", FinancialYear);
                    ObjRpt.SetParameterValue("MonthKey", MonthKey);
                    ObjRpt.SetParameterValue("DistrictKey", DistrictKey);
                    ObjRpt.SetParameterValue("DivisionKey", DivisionKey);

                    CRViewer.ReportSource = ObjRpt;
                    CRViewer.RefreshReport();

                    ObjRpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "PondPattaProgressPart2");

                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "info alert", "alert('No Record Found.'); window.history.go(-1);", true);
                }
            }
            else if (RptType == 12)
            {
                //समस्त श्रोतों से (अंगुलिका) मत्स्य बीज वितरण की प्रगति की सूचना 
                //DataTable dt = new DataTable();
                //DBLayer objDb = new DBLayer();
                //dt = objDb.GetRpt_MachuaAwasMonthlyProgress("HQ", FinancialYear, MonthKey, DivisionKey, DistrictKey);

                //if (dt.Rows.Count > 0)
                //{
                //    string connString = ConfigurationManager.ConnectionStrings["ConnectionStr"].ConnectionString;
                //    SqlConnectionStringBuilder connStringBuilder = new SqlConnectionStringBuilder(connString);

                //    ObjRpt.Load(MapPath(RptPath + "rptMachuaAwasMonthlyProgress.rpt"));
                //    ObjRpt.SetDatabaseLogon(connStringBuilder.UserID, connStringBuilder.Password, connStringBuilder.DataSource, connStringBuilder.InitialCatalog);
                //    ObjRpt.SetDataSource(dt);

                //    ObjRpt.SetParameterValue("@QueryType", "HQ");
                //    ObjRpt.SetParameterValue("@FinYear", FinancialYear);
                //    ObjRpt.SetParameterValue("@MonthId", MonthKey);
                //    ObjRpt.SetParameterValue("@DistrictKey", DistrictKey);
                //    ObjRpt.SetParameterValue("@DivisionKey", DivisionKey);

                //    CRViewer.ReportSource = ObjRpt;
                //    CRViewer.RefreshReport();

                //    // ObjRpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "MSR_MachuaAwasMonthlyProgress");

                //}
                //else
                //{
                //    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "info alert", "alert('No Record Found.'); window.history.go(-1);", true);
                //}
            }
            else if (RptType == 13)
            {
                //मत्स्य भौतिक कार्यक्रम सांख्यकीय रिपोर्ट

                DataTable dtSchemes = new DataTable();
                DBLayer objDb = new DBLayer();
                dtSchemes = objDb.GetRpt_MSR_PhyEvent(FinancialYear, MonthKey, DivisionKey, DistrictKey, 0);

                if (dtSchemes.Rows.Count > 0)
                {
                    string connString = ConfigurationManager.ConnectionStrings["ConnectionStr"].ConnectionString;
                    SqlConnectionStringBuilder connStringBuilder = new SqlConnectionStringBuilder(connString);

                    ObjRpt.Load(MapPath(RptPath + "RptMSR_PhyEventMontly.rpt"));
                    ObjRpt.SetDatabaseLogon(connStringBuilder.UserID, connStringBuilder.Password, connStringBuilder.DataSource, connStringBuilder.InitialCatalog);
                    ObjRpt.SetDataSource(dtSchemes);

                    ObjRpt.SetParameterValue("FinancialYear", FinancialYear);
                    ObjRpt.SetParameterValue("MonthId", MonthKey);
                    ObjRpt.SetParameterValue("DistrictId", DistrictKey);
                    ObjRpt.SetParameterValue("DivisionId", DivisionKey);
                    ObjRpt.SetParameterValue("CateKey", CateKey);

                    CRViewer.ReportSource = ObjRpt;
                    CRViewer.RefreshReport();

                    //  ObjRpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "MSR_PhyProgressSummry");
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "info alert", "alert('Record Not Found'); window.history.back();", true);
                }
            }
            else if (RPTKey == 14)
            {
                //नीली क्रांति योजना - जिलावार
                DataTable dt = new DataTable();
                DBLayer objDb = new DBLayer();
                dt = objDb.GetRpt_BlueRevolution("HQ_DIS", FinancialYear, MonthKey, DivisionKey, DistrictKey);

                if (dt.Rows.Count > 0)
                {
                    string connString = ConfigurationManager.ConnectionStrings["ConnectionStr"].ConnectionString;
                    SqlConnectionStringBuilder connStringBuilder = new SqlConnectionStringBuilder(connString);

                    ObjRpt.Load(MapPath(RptPath + "rptBlueRevolution_District.rpt"));
                    ObjRpt.SetDatabaseLogon(connStringBuilder.UserID, connStringBuilder.Password, connStringBuilder.DataSource, connStringBuilder.InitialCatalog);
                    ObjRpt.SetDataSource(dt);

                    ObjRpt.SetParameterValue("QueryType", "HQ_DIS");
                    ObjRpt.SetParameterValue("FinYear", FinancialYear);
                    ObjRpt.SetParameterValue("MonthId", MonthKey);
                    ObjRpt.SetParameterValue("DistrictKey", DistrictKey);
                    ObjRpt.SetParameterValue("DivisionKey", DivisionKey);

                    CRViewer.ReportSource = ObjRpt;
                    CRViewer.RefreshReport();

                    //  ObjRpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "MSR_BlueRevolution_District");
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "info alert", "alert('No Record Found.'); window.history.go(-1);", true);
                }
            }
            else if (RPTKey == 15)
            {
                //समस्त श्रोतों से मत्स्य बीज वितरण
                DataTable dtSchemes = new DataTable();
                DBLayer objDb = new DBLayer();
                dtSchemes = objDb.GetSP_SeedDistributionReport(FinancialYear, MonthKey, DivisionKey, DistrictKey);

                if (dtSchemes.Rows.Count > 0)
                {
                    string connString = ConfigurationManager.ConnectionStrings["ConnectionStr"].ConnectionString;
                    SqlConnectionStringBuilder connStringBuilder = new SqlConnectionStringBuilder(connString);

                    ObjRpt.Load(MapPath(RptPath + "rptSeedDistribution.rpt"));
                    ObjRpt.SetDatabaseLogon(connStringBuilder.UserID, connStringBuilder.Password, connStringBuilder.DataSource, connStringBuilder.InitialCatalog);
                    ObjRpt.SetDataSource(dtSchemes);

                    ObjRpt.SetParameterValue("FinYear", FinancialYear);
                    ObjRpt.SetParameterValue("MonthKey", MonthKey);
                    ObjRpt.SetParameterValue("DistrictKey", DistrictKey);
                    ObjRpt.SetParameterValue("DivisionKey", DivisionKey);

                    CRViewer.ReportSource = ObjRpt;
                    CRViewer.RefreshReport();

                    //  ObjRpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "MSR_PhyProgressSummry");
                }
            }
            else if (RPTKey == 16)
            {
                //समस्त श्रोतों से मत्स्य बीज संचय
                DataTable dtSchemes = new DataTable();
                DBLayer objDb = new DBLayer();
                dtSchemes = objDb.GetSP_SeedStockReport(FinancialYear, MonthKey, DivisionKey, DistrictKey);

                if (dtSchemes.Rows.Count > 0)
                {
                    string connString = ConfigurationManager.ConnectionStrings["ConnectionStr"].ConnectionString;
                    SqlConnectionStringBuilder connStringBuilder = new SqlConnectionStringBuilder(connString);

                    ObjRpt.Load(MapPath(RptPath + "rptSeedStockReport.rpt"));
                    ObjRpt.SetDatabaseLogon(connStringBuilder.UserID, connStringBuilder.Password, connStringBuilder.DataSource, connStringBuilder.InitialCatalog);
                    ObjRpt.SetDataSource(dtSchemes);

                    ObjRpt.SetParameterValue("FinYear", FinancialYear);
                    ObjRpt.SetParameterValue("MonthKey", MonthKey);
                    ObjRpt.SetParameterValue("DistrictKey", DistrictKey);
                    ObjRpt.SetParameterValue("DivisionKey", DivisionKey);

                    CRViewer.ReportSource = ObjRpt;
                    CRViewer.RefreshReport();

                    ObjRpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "SeedStockReport");
                }
            }
            else if (RPTKey == 17)
            {
                //राष्ट्रीय कृषि विकास योजना  - जिलावार
                DataTable dt = new DataTable();
                DBLayer objDb = new DBLayer();
                dt = objDb.GetRpt_RKVY("HQ_DIS", FinancialYear, MonthKey, DivisionKey, DistrictKey);

                if (dt.Rows.Count > 0)
                {
                    string connString = ConfigurationManager.ConnectionStrings["ConnectionStr"].ConnectionString;
                    SqlConnectionStringBuilder connStringBuilder = new SqlConnectionStringBuilder(connString);

                    ObjRpt.Load(MapPath(RptPath + "rptRKVY_District.rpt"));
                    ObjRpt.SetDatabaseLogon(connStringBuilder.UserID, connStringBuilder.Password, connStringBuilder.DataSource, connStringBuilder.InitialCatalog);
                    ObjRpt.SetDataSource(dt);

                    ObjRpt.SetParameterValue("QueryType", "HQ_DIS");
                    ObjRpt.SetParameterValue("FinYear", FinancialYear);
                    ObjRpt.SetParameterValue("MonthId", MonthKey);
                    ObjRpt.SetParameterValue("DistrictKey", DistrictKey);
                    ObjRpt.SetParameterValue("DivisionKey", DivisionKey);

                    CRViewer.ReportSource = ObjRpt;
                    CRViewer.RefreshReport();

                    // ObjRpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "MSR_BlueRevolution_District");
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "info alert", "alert('No Record Found.'); window.history.go(-1);", true);
                }
            }
            else if (RPTKey == 18)
            {
                //किसान क्रेडिट कार्ड योजना की प्रगति रिपोर्ट
                DataTable dt = new DataTable();
                DBLayer objDb = new DBLayer();
                dt = objDb.GetRpt_KCC("HQ", FinancialYear, MonthKey, DivisionKey, DistrictKey);

                if (dt.Rows.Count > 0)
                {
                    string connString = ConfigurationManager.ConnectionStrings["ConnectionStr"].ConnectionString;
                    SqlConnectionStringBuilder connStringBuilder = new SqlConnectionStringBuilder(connString);

                    ObjRpt.Load(MapPath(RptPath + "rpt_KisanCreditCard.rpt"));
                    ObjRpt.SetDatabaseLogon(connStringBuilder.UserID, connStringBuilder.Password, connStringBuilder.DataSource, connStringBuilder.InitialCatalog);
                    ObjRpt.SetDataSource(dt);

                    // ObjRpt.SetParameterValue("QueryType", "HQ_DIS");
                    ObjRpt.SetParameterValue("FinYear", FinancialYear);
                    ObjRpt.SetParameterValue("MonthId", MonthKey);
                    ObjRpt.SetParameterValue("DistrictKey", DistrictKey);
                    ObjRpt.SetParameterValue("DivisionKey", DivisionKey);

                    CRViewer.ReportSource = ObjRpt;
                    CRViewer.RefreshReport();

                    // ObjRpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "MSR_BlueRevolution_District");
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "info alert", "alert('No Record Found.'); window.history.go(-1);", true);
                }
            }
            else if (RPTKey == 19)
            {
                //विभागीय श्रेणी 1,2,3,4 के जलाशय एवं श्रेणी-5 के निस्तारित की प्रगति
                DataTable dt = new DataTable();
                DBLayer objDb = new DBLayer();
                dt = objDb.GetRptPondGrdNistarnProg(FinancialYear, MonthKey, DivisionKey, DistrictKey);

                if (dt.Rows.Count > 0)
                {
                    string connString = ConfigurationManager.ConnectionStrings["ConnectionStr"].ConnectionString;
                    SqlConnectionStringBuilder connStringBuilder = new SqlConnectionStringBuilder(connString);

                    ObjRpt.Load(MapPath(RptPath + "RptDeptGradePondNistarn.rpt"));
                    ObjRpt.SetDatabaseLogon(connStringBuilder.UserID, connStringBuilder.Password, connStringBuilder.DataSource, connStringBuilder.InitialCatalog);
                    ObjRpt.SetDataSource(dt);

                    // ObjRpt.SetParameterValue("QueryType", "HQ_DIS");
                    ObjRpt.SetParameterValue("FinYear", FinancialYear);
                    ObjRpt.SetParameterValue("MonthKey", MonthKey);
                    ObjRpt.SetParameterValue("DistrictKey", DistrictKey);
                    ObjRpt.SetParameterValue("DivisionKey", DivisionKey);

                    CRViewer.ReportSource = ObjRpt;
                    CRViewer.RefreshReport();

                    ObjRpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "DeptGradePondNistarn");
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "info alert", "alert('No Record Found.'); window.history.go(-1);", true);
                }
            }
            else if (RPTKey == 20)
            {
                //सांसद आदर्श ग्राम योजना अन्तर्गत चयनित ग्रामों की कार्य की रिपोर्ट
                DataTable dt = new DataTable();
                DBLayer objDb = new DBLayer();
                dt = objDb.GetRpt_SansadAdarshGramYojnaDetails("HQ", FinancialYear, MonthKey, DivisionKey, DistrictKey);

                if (dt.Rows.Count > 0)
                {
                    string connString = ConfigurationManager.ConnectionStrings["ConnectionStr"].ConnectionString;
                    SqlConnectionStringBuilder connStringBuilder = new SqlConnectionStringBuilder(connString);

                    ObjRpt.Load(MapPath(RptPath + "rpt_SansadAdarshGramYojnaDetails.rpt"));
                    ObjRpt.SetDatabaseLogon(connStringBuilder.UserID, connStringBuilder.Password, connStringBuilder.DataSource, connStringBuilder.InitialCatalog);
                    ObjRpt.SetDataSource(dt);

                    // ObjRpt.SetParameterValue("QueryType", "HQ_DIS");
                    ObjRpt.SetParameterValue("FinYear", FinancialYear);
                    ObjRpt.SetParameterValue("MonthId", MonthKey);
                    ObjRpt.SetParameterValue("DistrictKey", DistrictKey);
                    ObjRpt.SetParameterValue("DivisionKey", DivisionKey);

                    CRViewer.ReportSource = ObjRpt;
                    CRViewer.RefreshReport();

                    // ObjRpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "MSR_BlueRevolution_District");
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "info alert", "alert('No Record Found.'); window.history.go(-1);", true);
                }
            }
            else
            {

            }

            //if (RptType == 1)
            //{
            //    DataTable dtMSTPhyEventList = new DataTable();
            //    DBLayer objDb = new DBLayer();
            //    dtMSTPhyEventList = objDb.GetRpt_MSR_PhyEvent(FinancialYear, MonthKey, DivisionKey, DistrictKey, CateKey);
            //    if (dtMSTPhyEventList.Rows.Count > 0)
            //    {
            //        string connString = ConfigurationManager.ConnectionStrings["ConnectionStr"].ConnectionString;
            //        SqlConnectionStringBuilder connStringBuilder = new SqlConnectionStringBuilder(connString);
            //        ObjRpt.Load(MapPath(RptPath + "RptMSR_PhyEventMontly.rpt"));
            //        ObjRpt.SetDatabaseLogon(connStringBuilder.UserID, connStringBuilder.Password, connStringBuilder.DataSource, connStringBuilder.InitialCatalog);
            //        ObjRpt.SetDataSource(dtMSTPhyEventList);
            //        ObjRpt.SetParameterValue("FinancialYear", FinancialYear);
            //        ObjRpt.SetParameterValue("MonthId", MonthKey);
            //        ObjRpt.SetParameterValue("DistrictId", DistrictKey);
            //        ObjRpt.SetParameterValue("DivisionId", DivisionKey);
            //        ObjRpt.SetParameterValue("CateKey", CateKey);
            //        CRViewer.ReportSource = ObjRpt;
            //        CRViewer.RefreshReport();
            //        //ObjRpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "MSR_PhyEventMontly");
            //    }
            //    else
            //    {
            //        ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "info alert", "alert('No Record Found.'); window.history.go(-1);", true);
            //    }
            //}       
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

}