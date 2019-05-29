using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DBT_DBTGenerateFile : System.Web.UI.Page
{
    public static Int64 UserKey;
    public static string UserName;
    public static int DivisionKey;
    public static string FinYear;
    public static Int64 BillForwardingKey;
    DBLayer db = new DBLayer();

    protected void Page_Load(object sender, EventArgs e)
    {
        UserKey = Convert.ToInt64(Session["UserKey"]);
        UserName = Session["UserName"].ToString();
        DivisionKey = Convert.ToInt32(Session["DivisionKey"]);
        FinYear = Session["FinancialYear"].ToString();

        lblFinYear.Text = FinYear;
        lblLoginType.Text = UserName;

        BillForwardingKey = Convert.ToInt64(Request.QueryString.Get("Key"));
        if (!IsPostBack)
        {
            GetDBT_BillList();
        }
    }

    private void GetDBT_BillList()
    {
        DBLayer db = new DBLayer();
        DataTable dt = new DataTable();
        dt = db.GetDBT_BillList_ById(BillForwardingKey);
        if (dt.Rows.Count > 0)
        {
            lblBillAmout.InnerText = dt.Rows[0]["TotalAmount"].ToString();
            lblSchemeCode.InnerText = dt.Rows[0]["SchemeCode"].ToString();
            lblSchemeName.InnerText = dt.Rows[0]["SchemeName"].ToString();
            lblTotalApplicant.InnerText = dt.Rows[0]["TotalApplicant"].ToString();
            lblTreasuryBillDate.InnerText = dt.Rows[0]["TreasuryBillDate"].ToString();
            lblTreasuryBillNo.InnerText = dt.Rows[0]["TreasuryBillNo"].ToString();

            GetDBT_BillList_Details();
        }
    }

    private void GetDBT_BillList_Details()
    {
        rptDBTGenerateFile.DataSource = null;
        rptDBTGenerateFile.DataBind();

        DataTable dt = new DataTable();
        dt = db.GetDBT_BillList_Details_ById(BillForwardingKey);
        if (dt.Rows.Count > 0)
        {
            rptDBTGenerateFile.DataSource = dt;
            rptDBTGenerateFile.DataBind();

            rptPrintBill.DataSource = dt;
            rptPrintBill.DataBind();
        }

    }
    protected void btnGenerateFile_Click(object sender, EventArgs e)
    {
        
        string strFile = "";
        string generatedFileName = lblTreasuryBillNo.InnerText + "_Beneficiary_"+DateTime.UtcNow.AddMinutes(330).ToString("yyyyMMddHHmmss")+".txt";
        string fPath = Server.MapPath("~/" + DBLayer.DBT_GeneratedFile + "/" + generatedFileName);

        db.UpdateGeneratedFile(generatedFileName, BillForwardingKey);

        foreach (RepeaterItem item in rptDBTGenerateFile.Items)
        {
            string applicantname = (item.FindControl("lblApplicantName") as Label).Text;
            string transactionno = (item.FindControl("lblTransactionNo") as Label).Text;
            string ifsccode = (item.FindControl("lblIFSCCode") as Label).Text;
            string bankname = (item.FindControl("lblBankName") as Label).Text;
            string branchname = (item.FindControl("lblBranchName") as Label).Text;
            string accountno = (item.FindControl("lblAccountNo") as Label).Text;
            string mobileno = (item.FindControl("lblMobileNo") as Label).Text;
            string registrationno = (item.FindControl("lblRegistrationNo") as Label).Text;

            strFile += string.Format("{0},{1},{2},{3},{4},{5},{6},{7}", applicantname, transactionno, ifsccode, bankname, branchname, accountno, mobileno, registrationno);
            strFile += Environment.NewLine;
        }
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment; filename=" + generatedFileName);
        Response.AddHeader("content-type", "text/plain");

        File.WriteAllText(fPath, strFile);

        using (StreamWriter writer = new StreamWriter(Response.OutputStream))
        {
            writer.WriteLine(strFile);
        }
        Response.End();
    }
}