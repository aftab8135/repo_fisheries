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

public partial class Applicant_AcknowledgementReciept : System.Web.UI.Page
{
    public static DataSet ds = new DataSet();
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string strApplicationCode = "";
            strApplicationCode = Request.QueryString.Get("APCode");
            if (strApplicationCode != "" && strApplicationCode != null)
            {
                DataTable dt = new DataTable();
                dt = (new DBLayer()).GetSchemeAcknowledgement(strApplicationCode);
                foreach (DataRow dr in dt.Rows)
                {
                    lblAppDate.Text = dr["AppliedDate"].ToString();
                    lblApplicationNo.Text = dr["ApplicationCode"].ToString();
                    lblAppName.Text = dr["Name"].ToString();
                    lblFName.Text = dr["FatherName"].ToString();
                    lblMobileNo.Text = dr["MobileNo"].ToString();
                    lblSchemeName.Text = dr["SchemeName"].ToString();
                }
            }
            else
            {
                Response.Redirect("~/Applicant/ApplicantDashboard.aspx");
            }
        }

    }

   
}