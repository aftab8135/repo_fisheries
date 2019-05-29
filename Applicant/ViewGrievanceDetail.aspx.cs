using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Applicant_ViewGrievanceDetail : System.Web.UI.Page
{
    public static DataSet TableData = new DataSet();
    public static DataSet TableData2 = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        DBLayer db = new DBLayer();

        if (!IsPostBack)
        {
            int ckey = Convert.ToInt32(Request.QueryString.Get("cKey"));
            if (ckey == 0)
                Response.Redirect("GrievanceStatus.aspx");
            else
            {
                TableData = db.ReadComplainDetail(ckey);
                TableData2 = db.ReadForwardedComplain(ckey, 1);
            }

        }
    }
}