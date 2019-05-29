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

public partial class Report_WebReportViewer : System.Web.UI.Page
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
        RPTKey = Convert.ToInt32(Request.QueryString.Get("RptKey"));
        FR = Convert.ToInt32(Request.QueryString.Get("FR"));

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
            FinancialYear = Session["FinancialYear"].ToString();
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
            Int32 SchemeKey = 0;
            Int16 FR = Convert.ToInt16(Request.QueryString["FR"]);
            DistrictKey = Convert.ToInt16(Request.QueryString["DSKEY"]);
            DivisionKey = Convert.ToInt16(Request.QueryString["DVKEY"]);

            if (RptType == 10)
            {
               
            }

            string RptPath = "~/MIS/";

            if (RptType == 1)  
            {
                SchemeKey = Convert.ToInt32(Request.QueryString["SchemeKey"]);
                DataTable dtSchemes = new DataTable();
                DBLayer objDb = new DBLayer();
                dtSchemes = objDb.GetRpt_SchemesForApplicant(FinancialYear, MonthKey, DivisionKey, DistrictKey, SchemeKey);

                if (dtSchemes.Rows.Count > 0)
                {
                    string connString = ConfigurationManager.ConnectionStrings["ConnectionStr"].ConnectionString;
                    SqlConnectionStringBuilder connStringBuilder = new SqlConnectionStringBuilder(connString);

                    ObjRpt.Load(MapPath(RptPath + "rptNFDScheme.rpt"));
                    ObjRpt.SetDatabaseLogon(connStringBuilder.UserID, connStringBuilder.Password, connStringBuilder.DataSource, connStringBuilder.InitialCatalog);
                    ObjRpt.SetDataSource(dtSchemes);

                    ObjRpt.SetParameterValue("DistrictKey", DistrictKey);
                    ObjRpt.SetParameterValue("DivisionKey", DivisionKey);
                    ObjRpt.SetParameterValue("FinYear", FinancialYear);
                    ObjRpt.SetParameterValue("MonthId", MonthKey);
                    ObjRpt.SetParameterValue("QueryType", "ReportForDis");
                    ObjRpt.SetParameterValue("SchemeID", SchemeKey);
                    ObjRpt.SetParameterValue("ForDistrict", FR);

                    CRViewer.ReportSource = ObjRpt;
                    CRViewer.RefreshReport();

                   // ObjRpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "MSR_PhyEventMontly");
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "info alert", "alert('Record Not Found'); window.history.back();", true);
                }
            }

            else if (RptType == 10)
            {
                
            }
            else if (RptType == 11)
            {
                DataTable dt = new DataTable();
                DBLayer objDb = new DBLayer();
                dt = objDb.GetRptPondAuctionInfo(FinancialYear, MonthKey, DivisionKey, DistrictKey);

                if (dt.Rows.Count > 0)
                {
                    string connString = ConfigurationManager.ConnectionStrings["ConnectionStr"].ConnectionString;
                    SqlConnectionStringBuilder connStringBuilder = new SqlConnectionStringBuilder(connString);

                    ObjRpt.Load(MapPath(RptPath + "rptPondInformation.rpt"));
                    ObjRpt.SetDatabaseLogon(connStringBuilder.UserID, connStringBuilder.Password, connStringBuilder.DataSource, connStringBuilder.InitialCatalog);
                    ObjRpt.SetDataSource(dt);
                    string FinYear = Session["FinancialYear"].ToString();
                    string MonthName = System.Globalization.DateTimeFormatInfo.CurrentInfo.GetMonthName(MonthKey);
                    ObjRpt.SetParameterValue("FinancialYear", FinYear);
                    ObjRpt.SetParameterValue("MonthName", MonthName);

                    CRViewer.ReportSource = ObjRpt;
                    CRViewer.RefreshReport();

                   ObjRpt.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "PondAuctionInfo");
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "info alert", "alert('Record Not Found'); window.history.back();", true);
                }
            }
            else if (RptType == 12)
            {
                
            }
            else if (RptType == 13)
            {
               
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}