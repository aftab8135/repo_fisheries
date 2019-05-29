using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPages_DistrictMaster : System.Web.UI.MasterPage
{
    protected void Page_Init(object sender, EventArgs e)
    {
        if (Session["UserType"] == null || Session["UserTypeName"] == null || Session["UserKey"] == null || Session["DistrictKey"] == null || Session["FinancialYear"] == null || Session["UserName"] == null)
        {
            Response.Redirect("~/Default.aspx");
        }
        else
        {
            //if (Session["UserType"].ToString() != "5")
            //{
            //    Response.Redirect("~/Secure/Login/frm_Login.aspx");
            //}
        }
    }
}
