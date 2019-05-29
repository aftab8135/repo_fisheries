using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HeadQuarter_DocumentVerificationReport : System.Web.UI.Page
{
    public static string UserName;
    public static string FinancialYear;
    protected void Page_Load(object sender, EventArgs e)
    {
        UserName = Session["UserName"].ToString();// + " [ " + Session["District"].ToString() + " ]";
        FinancialYear = Session["FinancialYear"].ToString();
    }
}