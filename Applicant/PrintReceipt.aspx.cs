using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Applicant_PrintReceipt : System.Web.UI.Page
{
    public static DataSet ds = new DataSet();
    public static string frmtype;
    public static int complainkey;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            complainkey = Convert.ToInt32(Request.QueryString.Get("ckey"));
            if (complainkey == 0)
                Response.Redirect("GrievanceStatus.aspx");
            else
            {
                DBLayer db = new DBLayer();
                frmtype = Request.QueryString.Get("type").ToString();
                ds = db.ComplainReceipt(complainkey);
            }

        }
    }
}