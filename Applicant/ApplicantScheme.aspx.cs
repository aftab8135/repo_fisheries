using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.Script.Serialization;
using System.Data.SqlClient;
using System.Data;

public partial class Applicant_ApplicantScheme : System.Web.UI.Page
{
    DBLayer db = new DBLayer();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["ApplicantKey"] == null)
        {
            Response.Redirect("~/Secure/Login/frm_ApplicantLogin.aspx");
        }
        else
        {
            DataTable dt = (new DBLayer()).GetApplicantProfile(Convert.ToInt64(Session["ApplicantKey"]));
            if (dt.Rows.Count > 0)
            {
                Session["UserNo"] = dt.Rows[0]["UserNo"].ToString();
                if (!IsPostBack)
                {
                    getdetailsgrid();
                }
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Error", "alert('Please Fill User Profile First.'); window.location.href ='ApplicantProfile.aspx'", true);
            }
           
        }
    }

    public void getdetailsgrid()
    {
        rptScheme.DataSource = null;
        rptScheme.DataBind();

        DataTable dt = null;
        try
        {
            if (!Page.IsPostBack)
            {
                dt = db.GetSchemedetails();
                if (dt != null)
                {
                    if (dt.Rows.Count > 0)
                    {
                        rptScheme.DataSource = dt;
                        rptScheme.DataBind();
                    }

                }
            }
        }
        catch (Exception ex)
        {

        }
    }

    protected void rptScheme_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "Update")
        {
            if (e.Item.ItemIndex == 0)
            {
                string str = e.Item.ItemIndex.ToString();
            }

            Int16 xxx = Convert.ToInt16(e.CommandArgument.ToString());
            Session["SchemeKey"] = xxx;
            Session["ApplicationCode"] = "";
            Response.Redirect("../Applicant/ApplicantSchemeRegt.aspx");

        }
    }

}