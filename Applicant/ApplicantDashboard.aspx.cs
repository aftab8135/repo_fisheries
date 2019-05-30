using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Applicant_ApplicantDashboard : System.Web.UI.Page
{
    DBLayer db = new DBLayer();

    protected void Page_Init(object sender, EventArgs e)
    {
        if (Session["ApplicantKey"] == null)
        {
            Response.Redirect("~/Secure/Login/frm_ApplicantLogin.aspx");
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        string var = Session["ApplicantKey"].ToString();
        FillApplicantScheme();
    }

    public void FillApplicantScheme()
    {
        DataTable dtScheme = db.GetApplicantSchemes(Convert.ToInt16(Session["ApplicantKey"].ToString()));

        if (dtScheme.Rows.Count > 0)
            rptlog.DataSource = dtScheme;
        else
            rptlog.DataSource = "";
        rptlog.DataBind();
    }

    public void fillGrievance()
    {
        DataSet ds = new DataSet();
        //rptGrievance.DataSource = ds;
        //rptGrievance.DataBind();
    }
    protected void rptlog_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {

        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataRowView row = e.Item.DataItem as DataRowView;
            string appKey = row.Row[1].ToString();
            if (appKey.Trim().Length > 0)
            {
                Session["ApplicationCode"] = appKey;
            }
           
        }
    }


    protected void rptlog_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (Session["ApplicationCode"] != null)
        {
            Response.Redirect("ApplicantSchemeRegt.aspx");
        }
        
    }
}