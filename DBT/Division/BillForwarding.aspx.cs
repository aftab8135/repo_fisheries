using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Division_BillForwarding : System.Web.UI.Page
{
    public static Int64 UserKey;
    public static string UserName;
    public static int DivisionKey;
    public static string FinYear;
    protected void Page_Load(object sender, EventArgs e)
    {
        UserKey = Convert.ToInt64(Session["UserKey"]);
        UserName = Session["UserName"].ToString();
        DivisionKey = Convert.ToInt32(Session["DivisionKey"]);
        FinYear = Session["FinancialYear"].ToString();

        lblFinYear.Text = FinYear;
        lblLoginType.Text = UserName;
    }
}