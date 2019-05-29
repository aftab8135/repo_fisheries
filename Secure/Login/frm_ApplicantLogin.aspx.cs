using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Secure_Login_frm_ApplicantLogin : System.Web.UI.Page
{
    protected void Page_Init(object sender, EventArgs e)
    {
        Session.Clear();
        Session.Abandon();

        Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
    }

    [System.Web.Services.WebMethod]
    public static string[] ApplicantLogins(ApplicantRegistration objUserMaster)
    {
        DBLayer db = new DBLayer();

        int k = db.ApplicantExist(objUserMaster.UserName, objUserMaster.Password);
        if (k == 0)
        {
            string description = "Invalid" + "," + "0";
            string[] a = description.Split(',');
            return a;
        }
        else if (k == 2)
        {
            string description = "NotActive" + "," + "0";
            string[] a = description.Split(',');
            return a;
        }
        else
        {
            Secure_Login_frm_ApplicantLogin sl = new Secure_Login_frm_ApplicantLogin();

            string[] a = sl.getApplicantDetail(objUserMaster.UserName, objUserMaster.Password);
            return a;
        }
    }

    public string[] getApplicantDetail(string uname, string pwd)
    {
        DBLayer db = new DBLayer();
        DataTable dt = new DataTable();

        dt = db.GetApplicantUserMaster(uname, pwd);
        string[] User = { };

        if (dt.Rows.Count > 0)
        {
            Session["ApplicantKey"] = dt.Rows[0]["Registrationkey"].ToString();
            Session["ApplicantUserName"] = dt.Rows[0]["UserName"].ToString();
            Session["Applicantname"] = dt.Rows[0]["Name"].ToString();

            string strUser = dt.Rows[0]["UserName"].ToString();
            User = strUser.Split(',');
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Error occured!!.!!')", true);
        }
        return User;
    }
}